Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2VIIQDo027503
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 13:18:27 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2VIH5iv028129
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 18:17:06 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j2VIH5B9021338
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 13:17:06 -0500 (EST)
Subject: Mozilla Denials Question
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 31 Mar 2005 13:23:16 -0500
Message-Id: <1112293396.12948.45.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok, why does it do that? 

audit(1112171413.328:1286470): avc:  denied  { read } for  pid=2095
exe=/usr/lib/firefox-1.0.2/firefox-bin name=lokkit dev=dm-0 ino=1032605
scontext=phantom:staff_r:staff_mozilla_t
tcontext=system_u:object_r:sbin_t tclass=file
audit(1112171417.018:1304950): avc:  denied  { read } for  pid=2095
exe=/usr/lib/firefox-1.0.2/firefox-bin name=rsync dev=dm-0 ino=1032829
scontext=phantom:staff_r:staff_mozilla_t
tcontext=system_u:object_r:rsync_exec_t tclass=file

... 500 more times for every executable in /usr/bin and /usr/sbin
after attempting to add a plugin handler.

It's already a browsing app, which means we don't audit
read:dir and getattr:file and some more things, but
read:file dontaudit seems like too much.

Why does it want to read the files?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
