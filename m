Message-ID: <a5e2b64d0812232358u19f442dfwd27da7f0978a508c@mail.gmail.com>
Date: Wed, 24 Dec 2008 16:58:43 +0900
From: Tim <timasyk@gmail.com>
To: "SELinux mailing list" <SELinux@tycho.nsa.gov>
Subject: Alternative location of policy files
Cc: timasyk@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,

I was wondering, how can I change default location of SELinux policy
from /etc/selinux/_policyname_ to some other path?
What source codes should be modified for that?

The reason to do that are:
- I want to work with loadable policy modules --> that requires
/etc/selinux/_policyname_ directory to be writable.
- limitation of my filesystem having /etc directory (it is read-only filesystem)
- unfortunately, I can not mount /etc into some other writable filesystem

Kindest regards,
Tim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
