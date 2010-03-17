Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2H14RNh007136
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2010 21:04:27 -0400
Received: from mail-iw0-f193.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2H151AO026301
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 01:05:01 GMT
Received: by iwn31 with SMTP id 31so443975iwn.30
        for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2010 18:04:25 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 16 Mar 2010 18:04:25 -0700
Message-ID: <dd18b0c31003161804i5275304cl13256077080946c4@mail.gmail.com>
Subject: new: loads of audit messgs
From: Justin Mattock <justinmattock@gmail.com>
To: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

this is new:
(log message is showing loads of these,but I don't see this getting in
the way of anything).

 type=1107 audit(1268786484.482:3): user pid=1277 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
msg=''
[    8.482858] type=1107 audit(1268786484.482:4): user pid=1277 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
msg=''
[    8.514268] type=1107 audit(1268786484.514:5): user pid=1277 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
msg=''
[    8.514803] type=1107 audit(1268786484.514:6): user pid=1277 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
msg=''
[    8.515396] type=1107 audit(1268786484.515:7): user pid=1277 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
msg=''
[    8.515891] type=1107 audit(1268786484.515:8): user pid=1277 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
msg=''

I'll have a look tomorrow to see if this is kernel, and/or policy
only change I did was update libc,kernel(add ima integrity)
and add fcron/logrotate with pam support.

any ideas?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
