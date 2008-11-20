Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAKMfaAN032453
	for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2008 17:41:36 -0500
Received: from wf-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAKMdfUD020498
	for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2008 22:39:41 GMT
Received: by wf-out-1314.google.com with SMTP id 28so833828wff.30
        for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2008 14:41:29 -0800 (PST)
Message-ID: <cadfc0e40811201441r223561det3dd24c42066642e0@mail.gmail.com>
Date: Thu, 20 Nov 2008 16:41:29 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux Mailing List" <selinux@tycho.nsa.gov>
Subject: python execv 'self:fd use' AVC for fd to /lib64/ld-2.8.so
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm getting the following MLS constraint violation:

node=comms type=AVC msg=audit(1227219700.656:22127): avc:  denied  {
use } for  pid=30685 comm="getselection" path="/lib64/ld-2.8.so"
dev=dm-0 ino=8282255
scontext=user_u:user_r:user_securecp_t:s3:c0,c2,c11,c200.c511
tcontext=user_u:user_r:user_securecp_t:s0-s15:c0.c1023 tclass=fd

when execing a child process at a different level. I have code that
sets FD_CLOEXEC on all valid fds so I'm confused as to why this is
happening and what to do about it. Any ideas?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
