Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6M2xFHa018107
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2003 22:59:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6M2wAFB007832
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 02:58:10 GMT
Received: from zaphod.crypt.gen.nz (203-79-74-204.adsl.paradise.net.nz [203.79.74.204])
	by jazzswing.ncsc.mil  with ESMTP id h6M2w9GD007829
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 02:58:10 GMT
Message-ID: <2689.202.27.185.71.1058842752.squirrel@www.crypt.gen.nz>
Date: Tue, 22 Jul 2003 14:59:12 +1200 (NZST)
Subject: RE: make quickinstall redhat9 problem
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: <sreese@prcdigital.com>
In-Reply-To: <000101c34ff6$558b0870$6601a8c0@inspiron>
References: <20030722020704.78395.qmail@a.mx.rapturesecurity.com>
        <000101c34ff6$558b0870$6601a8c0@inspiron>
Cc: <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Reese said:
> installing tk and tcl was the trick thanks for the help now I get to
> figure out where I went wrong with the kernel complile =)
>
> VFS: cannot open root device "Label=/"

Change your bootloader ( /boot/grub/grub.conf for GRUB ) to use
root=/dev/hda1 or wherever your root is rather than using Label=/

Kerry


-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
