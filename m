Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA25186
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 10:17:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA25871
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 14:17:17 GMT
Received: from rospo1.bbn.com (rospo1.bbn.com [192.233.49.145])
	by jazzband.ncsc.mil  with ESMTP id OAA25867
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 14:17:16 GMT
Received: from sahad1 (ros-dun052-156.bbn.com [192.233.52.156])
	by rospo1.bbn.com (8.9.1a/8.9.1) with SMTP id KAA13177
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 10:05:28 -0400 (EDT)
Message-ID: <002401c10301$be07aff0$9c34e9c0@sahad1>
From: "Pranav Saha" <psaha@bbn.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.30.0107021131100.4791-100000@linux16.zdv.uni-tuebingen.de>
Subject: Re: checkpolicy fails
Date: Mon, 2 Jul 2001 10:17:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes - I tried installing SELinux on a RH 7.0 machine on Friday and got a
very similar checkpolicy error (below).  I did not get this checkpolicy
error when trying the install on a RH6.1 build (which still has it's own
unresolved issues...)  Please advise.


This is the error I got back:
m4 -s security_classes initial_sids access_vectors  init.te rbac users
constraints  initial_sid_contexts fs_contexts net_contexts > initpolicy.conf
../kernel/security/checkpolicy -o initpolicy initpolicy.conf
../kernel/security/checkpolicy:  loading policy configuration from
initpolicy.conf

error in the statement ending on line 1054 (token ';'): unknown class
filesystem used in rule

../kernel/security/checkpolicy:  error(s) encountered while parsing
configuration
make: *** [initpolicy] Error 1


Thanks!
Pranav Saha


----- Original Message -----
From: "Jan Petranek" <jan.petranek@student.uni-tuebingen.de>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Sent: Monday, July 02, 2001 5:41 AM
Subject: checkpolicy fails


> But as I tried to do the
> make initinstall
> it ended up saying the initpolicy.conf contained errors. Well, the
> initpolicy.conf seems sane to me (I didn't change a thing), so probably
> the error lies in checkpolicy. Here are the last lines of make
> initinstall:
>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
