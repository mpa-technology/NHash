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

    FileDialog  {
        id: selectFileDialog

        onAccepted : {
            calculateHashFromFile( selectFileDialog.fileUrl );
        }

    }


    function showError(error){

        errorMessageDialog.text = error.toString();
        errorMessageDialog.visible = true;

    }


    function calculateHash(){
        try{
            var currentHash = hashComboBox.currentValue;
            var hashType = backend.stringToHashType(currentHash)
            var hash = backend.calculateHash( hashType );

            console.log("hash "+ currentHash + " : ", hash);

            generatedHashTextField.text = hash;


        }catch( error ){
            showError(error);
            console.log(error)

        }
    }

    function calculateHashFromFile(fileUrl){


        backend.currentFile = fileUrl;
        calculateHash();

    }

    function reCalculateHash(){

        if( backend.currentFile.length !== 0 ){
            calculateHash();
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
            onActivated: {
                reCalculateHash();
            }
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


