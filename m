Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA25982
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 12:25:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA23037
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 17:24:00 GMT
Received: from prserv.net (asmtp2.prserv.net [32.97.166.52])
        by jazzband.ncsc.mil  with ESMTP id RAA23033 for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 17:24:00 GMT
Message-Id: <200211071724.RAA23033@jazzband.ncsc.mil>
Date: Thu, 7 Nov 2002 12:22:33 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: selinux <selinux@tycho.nsa.gov>
Subject: SELinux source
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again,

I have question about SELinux source.  I have downloaded the entire package for 2.4.19 (which includes Linux source).
Is this source modified for SELinux or is it the same as what I download from http://www.kernel.org? 

After extracting the compressed file, there are 2 directories.  One is LSM-2.4 and the other is SELINUX.  The LSM-2.4 tree looks
similar to what I usually download from the kernel.org site.

If it is similar, can I use "make xconfig" to configure SELinux?  (I am assuming X will work normally in SELinux).

Is the compilation process different for the source in SELINUX directory? Will "make bzImage" take care of the source in SELINUX directory?                                                                                                                

Subba Rao
sailorn@attglobal.net
2002-11-07



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
