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

    function calculateHash(fileUrl){

        try {

            var hash =  backend.calculateHash(fileUrl);
            console.log(hash.md5);
            console.log(hash.sha512);

            md5TextField.text = hash.md5;
            sha512TextField.text = hash.sha512;

        }catch( error ){
            showError(error);
            console.log(error)

        }
    }


    FileDialog  {
        id: selectFileDialog

        onAccepted : {
            calculateHash(selectFileDialog.fileUrl);
        }

    }


    ColumnLayout {
        id: column
        anchors.fill: parent
        spacing: 4



        TextField {
            id: md5TextField
            Layout.rightMargin: 10
            Layout.leftMargin: 10
            Layout.margins: 0
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter


            placeholderText: "MD5"
            readOnly: true
        }

        TextField {
            id: sha512TextField
            Layout.rightMargin: 10
            Layout.leftMargin: 10
            Layout.margins: 0
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter


            placeholderText: "SHA512"
            readOnly: true
        }



        Button{
            id: selectFileButton

            text: qsTr("select file")
            Layout.rightMargin: 10
            Layout.leftMargin: 10
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            onClicked: {

                selectFileDialog.visible = true;

            }
        }



    }



}
