Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p34DVx3p007599
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2011 09:31:59 -0400
Received: from nm4-vm0.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p34DVvwl024003
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2011 13:31:58 GMT
Message-ID: <829837.21001.qm@web87011.mail.ird.yahoo.com>
Date: Mon, 4 Apr 2011 14:31:56 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Minor query on selabel_x(5) man page
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Under SELABEL_X_CLIENT it states that the object_name is ignored and should be set to NULL. However if selabel_lookup is called with object_name set to NULL, the application core dumps (all backends behave the same if object_name = NULL - using libselinux 2.0.98 and 2.0.101).

The actual SELinux X Windows code does not use NULL but "remote" and as the x_contexts file has:

      client  * system_u:object_r:remote_t:s0

then it will always be resolved.

Question:
Should the man page be altered to recommend using a named entry or wildcard '*' and ensure the name can be resolved in the x_contexts file

or:
Produce a patch to allow object_name to be NULL (if so should NULL be allowed globally or just in the case of SELABEL_X_CLIENT).

or error if NULL except for SELABEL_X_CLIENT .....

Richard



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
