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


#include "BackEnd.hpp"






BackEnd::BackEnd(QObject *parent) : QObject(parent)
{

}

QString BackEnd::calculateHash(const BackEnd::HashType hashType){

    QCryptographicHash hash( static_cast<QCryptographicHash::Algorithm>( hashType ));


    QFile file( _currentFile );



    if( not file.open( QFile::ReadOnly ) ){
        qjsEngine(this)->throwError(tr("Error open file: ") + file.errorString() );
    }

    while(!file.atEnd())
    {

        const auto fileData = file.read( 1024 );

        hash.addData( fileData );


    }

    file.close();




    return hash.result().toHex();
}


BackEnd::HashType BackEnd::stringToHashType(const QString string){


    if(string == "MD5"){
        return MD5;
    }else if(string == "MD4"){
        return MD4;
    }
    else if(string == "SHA1"){
        return SHA1;
    }
    else if(string == "SHA224"){
        return SHA224;
    }
    else if(string == "SHA256" ){
        return SHA256;
    }
    else if( string == "SHA384"){
        return SHA384;
    }
    else if( string == "SHA512"){
        return SHA512;
    }
    else if( string == "KECCAK_224"){
        return KECCAK_224;
    }
    else if( string == "KECCAK_256"){
        return KECCAK_256;
    }
    else if( string == "KECCAK_384"){
        return KECCAK_384;
    }else if( string == "KECCAK_512"){
        return KECCAK_512;
    }


    qjsEngine(this)->throwError(tr("error hash string ") );

    return {};
}



QString BackEnd::currentFile(){
    return _currentFile;
}




