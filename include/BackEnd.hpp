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


#pragma once

#include <QObject>
#include <QUrl>
#include <QFile>
#include <QJSEngine>
#include <QDebug>

#include <QCryptographicHash>


class BackEnd : public QObject
{
    Q_OBJECT


    Q_PROPERTY(QString currentFile READ currentFile WRITE setFile )
public:


    enum HashType{
        MD5 = QCryptographicHash::Md5,
        MD4 = QCryptographicHash::Md4,
        SHA1= QCryptographicHash::Sha1,
        SHA224 = QCryptographicHash::Sha224,
        SHA256 = QCryptographicHash::Sha256,
        SHA384 = QCryptographicHash::Sha384,
        SHA512 = QCryptographicHash::Sha512,
        KECCAK_224 = QCryptographicHash::Keccak_224,
        KECCAK_256 = QCryptographicHash::Keccak_256,
        KECCAK_384 = QCryptographicHash::Keccak_384,
        KECCAK_512 = QCryptographicHash::Keccak_512

    };

    Q_ENUM(HashType)




    explicit BackEnd(QObject *parent = nullptr);


    Q_INVOKABLE
    QString calculateHash(const HashType hashType);


    Q_INVOKABLE
    HashType stringToHashType(const QString string);



    QString currentFile();

    void setFile(const QUrl &fileUrl){
    _currentFile = fileUrl.toLocalFile();
    }

signals:

private:
    QString _currentFile;

};

