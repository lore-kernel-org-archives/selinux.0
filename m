Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8F0qvLa009047
	for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2003 20:52:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8F0qomw020812
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 00:52:50 GMT
Received: from smtp.vasco.com (smtp.vasco.com [62.58.124.115])
        by jazzband.ncsc.mil  with ESMTP id h8F0qo9d020809 for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 00:52:50 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.vasco.com (Postfix) with ESMTP id A265E4B9E9
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 02:49:32 +0200 (CEST)
Received: from smtp.vasco.com ([127.0.0.1])
 by localhost (proxy.vasco.com [127.0.0.1]) (amavisd-new, port 10024)
 with SMTP id 32231-06 for <selinux@tycho.nsa.gov>;
 Mon, 15 Sep 2003 02:49:32 +0200 (CEST)
Received: from smtp.vasco.com (vasco-exch.vasco.com [192.168.1.251])
	by smtp.vasco.com (Postfix) with ESMTP id 5BA794BA0B
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 02:49:29 +0200 (CEST)
From: Jason <jna@vasco.com>
To: selinux@tycho.nsa.gov
Subject: booting selinux rh9
Date: Mon, 15 Sep 2003 21:47:32 +1000
Cc: Russell Coker <russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309152147.32147.jna@vasco.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Guys,

I have been having a great time setting up selinux the latest 2.4.21-selinux1 
version on rh9.

However, once again, I cannot get past a certain problem, at login time after 
rebooting, I try to login as root, and it says it cannot determine a security 
context for me, and do I wish to specify one. I say y (which is default), I 
type sysadm_r and type of sysadm_t (I also tried the user_r and user_t as 
well), and it responds with invalid security context, and I try again.

So I reboot into selinux single mode, and this is ok, I check the the 
selinuxfs has been mounted (of which it has) and all the directories seem to 
be there.  As a note, my context at this point is kernel_t.

Does anyone know what I might have done wrong?
I also believe that the initrd I created using the one supplied with the 
patched differences in the download from nsa creates a valid linuxrc file of 
which I have checked, but are you supposed to see the output of the initrd's 
echo statements at boot time, because I dont? ( ie : echo Loading Policy)

Cheers
and thanx in advance

Jason


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
