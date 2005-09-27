Message-Id: <200509270008.j8R08YYs019016@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] semanage-functionality 0/17
Date: Mon, 26 Sep 2005 20:08:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following 17 patches add new functionality for libsemanage including
what is designed to be a stable api for clients. They should apply to the
current NSA cvs repository after the semanage-reorg patch set.

These patches represent in process development and have been lightly tested.
There are likely bugs and I expect further changes, but think that the code
is sufficiently complete to merge for coordination with other ongoing
development. There is a patch to libsepol that I will send after this patch
set that is required to make the new libsemanage compile.

Please apply.

Thanks,

Karl



------
Karl MacMillan
Tresys Technology
http://www.tresys.com 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
