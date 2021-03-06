#!/bin/bash -eu
# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

cd $SRC/qubes-os/linux-utils/

cd qrexec-lib

$CC $CFLAGS -c ioall.c
$CC $CFLAGS -c copy-file.c
$CC $CFLAGS -c crc32.c
$CC $CFLAGS -c pack.c
$CC $CFLAGS -c unpack.c
ar rcs libqubes-rpc-filecopy.a ioall.o copy-file.o crc32.o unpack.o pack.o

$CXX $CXXFLAGS -o $OUT/libqubes-rpc-filecopy -I. -I./fuzzer fuzzer/fuzzer.cc -lFuzzingEngine libqubes-rpc-filecopy.a

cp $SRC/*.options $OUT/

cd $SRC/qubes-os/app-linux-input-proxy
 
make -C fuzz
cp fuzz/*_fuzzer $OUT/
cp fuzz/*_seed_corpus.zip $OUT/
cp fuzz/*.options $OUT/

