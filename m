Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i881OnrT000750
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 21:24:49 -0400 (EDT)
Received: from georgia.yamato.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i881Okll003982
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 01:24:47 GMT
Received: from e19f2n15.jp.ibm.com (d19relay01.sagamino.japan.ibm.com [9.189.5.43])
	by georgia.yamato.ibm.com (8.11.6p2-20030922/8.11.1) with ESMTP id i881OV4150774
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 10:24:31 +0900
Received: from D19ML102.sagamino.japan.ibm.com (d19av04.sagamino.japan.ibm.com [9.189.5.112])
	by e19f2n15.jp.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i881OUF8166090
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 10:24:31 +0900
In-Reply-To: <200409071747.i87HkxJ6012464@mms-r00.iijmio.jp>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: PAM in suse9.1 (Re: SuSE 9.1 SELinux)
From: Takuya Mishina <TMISHINA@jp.ibm.com>
Message-ID: <OF0DD26E97.7776F6AA-ON49256F08.007DAD0E-49256F09.0007B661@jp.ibm.com>
Date: Wed, 8 Sep 2004 10:24:25 +0900
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,


I don't know the difference of pam_unix.so and pam_unix2.so, but in my 
test, it seems no problem using pam_unix.so instead of pam_unix2.so.
( cat /etc/pam.d/newrole | sed 's/pam_unix/pam_unix2/' > 
/etc/pam.d/newrole.new )

the best may be the combination use of pam_unix2.so and unix_chkpwd, but 
to be enable SELinux with SuSE 9.1, the easiest way is to setuid 
/usr/bin/newrole or to patch pam_unix.so and use it.


I'll report again if something happens on suse (esp. policy).


---
Takuya MISHINA
IBM Research, Tokyo Research Laboratory



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
