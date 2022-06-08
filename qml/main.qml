/*
 * Copyright (c) 2022 Maxim Palshin
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */


import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.11


Window {
    width: 640
    height: 480
    visible: true
    title: "NHash"

    MessageDialog {
        id: errorMessageDialog
        title: qsTr("Error")
    }


    function showError(error){

        errorMessageDialog.text = error;
        errorMessageDialog.visible = true;

    }

    function calculateHashFromFile(fileUrl){

        try {

            var currentHash = hashComboBox.currentValue;
            var hash = -1;


            if(currentHash === "MD5"){
                hash = backend.calculateHash(fileUrl, backend.MD5);
            }else if(currentHash === "MD4"){
                hash = backend.calculateHash(fileUrl, backend.MD4);
            }
            else if(currentHash === "SHA1"){
                hash = backend.calculateHash(fileUrl, backend.SHA1);
            }
            else if(currentHash === "SHA224"){
                hash = backend.calculateHash(fileUrl, backend.SHA224);
            }
            else if(currentHash === "SHA256" ){
                hash = backend.calculateHash(fileUrl, backend.SHA256);
            }
            else if( currentHash === "SHA384"){
                hash = backend.calculateHash(fileUrl, backend.SHA384);
            }
            else if( currentHash === "SHA512"){
                hash = backend.calculateHash(fileUrl, backend.SHA512);
            }
            else if( currentHash === "KECCAK_224"){
                hash = backend.calculateHash(fileUrl, backend.KECCAK_224);
            }
            else if( currentHash === "KECCAK_256"){
                hash = backend.calculateHash(fileUrl, backend.KECCAK_256);
            }
            else if( currentHash === "KECCAK_384"){
                hash = backend.calculateHash(fileUrl, backend.KECCAK_384);
            }else if( currentHash === "KECCAK_512"){
                hash = backend.calculateHash(fileUrl, backend.KECCAK_512);
            }
            else{
                throw "Error hash type";
            }

            console.log("hash: ", hash);

            generatedHashTextField.text = hash;


        }catch( error ){
            showError(error);
            console.log(error)

        }
    }


    FileDialog  {
        id: selectFileDialog

        onAccepted : {
            calculateHashFromFile( selectFileDialog.fileUrl,  )
        }

    }


    ColumnLayout {
        id: column
        anchors.fill: parent
        spacing: -243.4

        ComboBox {
            id: hashComboBox
            Layout.margins: 15
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            model: ["MD5","MD4","SHA1","SHA224","SHA256","SHA384","SHA512","KECCAK_224","KECCAK_256","KECCAK_384","KECCAK_512"]
        }

        TextField {
            id: generatedHashTextField
            Layout.margins: 15
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            placeholderText: qsTr("Generated hash")
            readOnly: true
        }

        Button {
            id: fileOpenButton
            text: qsTr("From file")
            Layout.margins: 15
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            onClicked: {
                selectFileDialog.visible = true;
            }
        }








    }



}


