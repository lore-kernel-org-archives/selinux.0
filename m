Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3MGcpFl031987
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 12:38:51 -0400
Received: from mail-qy0-f113.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3MGcpuk010852
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 16:38:51 GMT
Received: by qyk11 with SMTP id 11so119120qyk.32
        for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 09:38:49 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 22 Apr 2009 09:38:48 -0700
Message-ID: <dd18b0c30904220938y781d0009y7c2229aa28952c2e@mail.gmail.com>
Subject: runcon cant really run(constraint issue?)
From: Justin Mattock <justinmattock@gmail.com>
To: tresys <refpolicy@oss.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

looking into using runcon
it seems I'm confronted with an
avc, that just keeps showing up:
allow staff_t user_t:process { siginh rlimitinh transition noatsecure };
(even after adding this to the policy).

What I'm doing is this:
runcon name:user_r:user_t:s0-s0:c0.c255 firefox
the initial role I'm in is staff_r(transitioning to user_r for
firefox to run in)

Does this seem like the right thing to do,
or do I need to use newrole -r *
for something like firefox?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
