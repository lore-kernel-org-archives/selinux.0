Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA19331
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2001 13:09:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA10705
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2001 17:07:18 GMT
Received: from hwembaz0021.cas.honeywell.com (hwembaz0021.cas.honeywell.com [129.239.31.124])
	by jazzswing.ncsc.mil  with ESMTP id RAA10701
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2001 17:07:16 GMT
Message-ID: <4B2A46240C7CD311830C0090279C31E301D77363@az15m09.iac.honeywell.com>
From: "White, Tom (AZ15)" <tom.white@honeywell.com>
To: selinux@tycho.nsa.gov
Subject: Problems with install
Date: Wed, 24 Oct 2001 10:15:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am trying to implement the SELinux patch on a Red Hat 7.1 box. I did the
Kernel build following the documentation on the NSA web site.  I got to step
2 in the INSTALLING section and when I do a make install in the module
directory I get the following output:

[root@warthog module]# make install
rm -f selinux_plug/include/asm selinux_plug/arch/machine
( cd selinux_plug/include ; ln -sf asm-i386 asm)
( cd selinux_plug/arch ; ln -sf i386 machine)
mkdir -p /usr/local/selinux/flask
mkdir -p /usr/local/selinux/include/linux/flask
mkdir -p /usr/local/selinux/include/asm-i386/flask
mkdir -p /usr/local/selinux/bin
( cd /usr/local/selinux/include; ln -sf asm-i386 asm)
cd selinux_plug/flask; install access_vectors security_classes initial_sids
/usr/local/selinux/flask
cd selinux_plug/include/linux/flask; install *.h
/usr/local/selinux/include/linux/flask
cd selinux_plug/include/asm/flask; install *.h
/usr/local/selinux/include/asm/flask
cd ../../lsm/include/asm; install unistd.h /usr/local/selinux/include/asm
cd selinux_plug/ss; install checkpolicy /usr/local/selinux/bin
install: cannot stat `checkpolicy': No such file or directory
make: *** [install] Error 1
[root@warthog module]#

I checked /usr/local/selinux/bin for checkpolicy to see if it was just a
permissions problem but the file does not exist. I could not find it in the
/lsm directory either.  Can someone tell me what I have screwed up? Thank
you for your time.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
