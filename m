Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA10101
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 08:37:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA17768
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 12:35:19 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id MAA17764
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 12:35:18 GMT
Date: Fri, 19 Apr 2002 14:38:00 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: initrc question and initrc+proftpd patch
Message-ID: <20020419143800.B18906@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have one question about the initrc handling in the example policy:

Why does it not do a domain transition to initrc_t when the scripts are
executed by sysadm_t (i.e. manually by the sysadmin) ?
With the example policy, the same process started at system boot or
manually later will run in different domains. I've added this line to
domains/program/initrc.te:

domain_auto_trans(sysadm_t, initrc_exec_t, initrc_t)

But please tell me if there's a reason why it's not there, and I'm dumb
and/or compromising the system's security. In order for this to work
on debian, I also added to file_contexts:

/etc/init.d(|/.*)               system_u:object_r:initrc_exec_t

The weird part is that SOME of the program.te files have a
domain_auto_trans line which serves essentially the same purpose. Does
it make sense to define this transition individually for each program
or doesn't it make more sense to drop these transitions and instead
trans to the initrc domain when the admin executes an init script?



Finally, some patches/changes to add proftpd support (using the
existing ftpd types and files):

add to domains/program/ftpd.te:
domain_auto_trans(initrc_t, ftpd_exec_t, ftpd_t)

for standalone ftp servers, such as proftpd. the current ftpd.te only
works for ftp daemons being called by inetd or tcpd.


add to file_contexts:
/etc/proftpd.conf             system_u:object_r:etc_ftp_t
/usr/sbin/proftpd             system_u:object_r:ftpd_exec_t

plus the ftpd.te line from above and proftpd should be working. the
etc_ftp_t type was added by me to types/file.te:

type etc_ftp_t, file_type, sysadmfile;

this is essentially a copy of etc_mail_t.



next time, I'll post a real diff file. my current playing-around policy
is so messed up that making a diff is not practical, sorry.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
