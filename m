Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9UHVOR0017263
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 12:31:24 -0500
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9UHUaZZ002006
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 17:30:36 GMT
Received: by ug-out-1314.google.com with SMTP id 75so1237916ugb
        for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 09:31:24 -0800 (PST)
Message-ID: <e294b46e0610300931w25367ca4nc8f914dc4277e8ab@mail.gmail.com>
Date: Mon, 30 Oct 2006 17:31:23 +0000
From: "Bradley Chapman" <kakadu@gmail.com>
To: selinux@tycho.nsa.gov
Subject: A good place to start?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just finished installing a new Debian system and decided to put
SELinux onto it. After getting the programs installed, the kernel
recompiled, the filesystem relabeled and the policy reloaded, I now
have a few questions I want to ask about what to do next:

- how do I allow domain transitions from user_r to sysadm_r? I keep
getting the "user_u:sysadm_r:sysadm_t is not a valid context" error,
even though /etc/selinux/refpolicy-strict/users/local.users AND
/etc/selinux/refpolicy-strict/src/policy/config/local.users contain
the following line:

user user roles { user_r sysadm_r };

- where should I start editing policy files to remove the various avc:
denied errors I get when starting the machine? At the moment, there
are quite a few - most of which occur in the
system_u:system_r:initrc_t context. Should I begin there?

- out of the various GUI-based policy editors out there, which ones
are good for SELinux newbies?

TIA,

Brad
-- 
CONTROL YOUR TABS: https://addons.mozilla.org/extensions/158

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
