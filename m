MIME-Version: 1.0
From: =?ISO-8859-1?Q?Kovacsics_R=F3bert?= <kovirobi@gmail.com>
Date: Sat, 11 Feb 2012 13:13:55 +0000
Message-ID: <CABPkNKmB6ZdGtT1Avy64sFxce1y1WqAzD73uwZTqF8ij6c4t0w@mail.gmail.com>
Subject: 
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all!

I would like to ask for assistance on compiling SELinux (particularly
policycoreutils 2.1.0)

Here is my setup:
*Linux from scratch running kernel 3.2.5
*Installed libsepol
*Installed libselinux
*Installed libsemanage
*Installed sepolgen
*Installed checkpolicy

Error on installing policycoreutils-2.1.0
Error:
make[1]: Entering directory
`/blfs-sources/selinux/policycoreutils-2.1.0/sandbox'
cc  -I/usr/include -DPACKAGE="\"policycoreutils\""   -c -o seunshare.o
seunshare.c
seunshare.c: In function ‘main’:
seunshare.c:242:21: error: ‘CLONE_NEWNS’ undeclared (first use in this function)
seunshare.c:242:21: note: each undeclared identifier is reported only
once for each function it appears in
make[1]: *** [seunshare.o] Error 1
make[1]: Leaving directory `/blfs-sources/selinux/policycoreutils-2.1.0/sandbox'
make: *** [all] Error 1

Thank you for any assistance


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
