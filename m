Subject: [Fwd: excessively verbose policy]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>,
        Chad Sellers <csellers@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 09:26:15 -0500
Message-Id: <1203690375.2804.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that this concern is legitimate, although I understand the
motivation for the current approach.

-------- Forwarded Message --------
From: Bill Nottingham <notting@redhat.com>
To: fedora-selinux-list@redhat.com
Subject: excessively verbose policy
Date: Thu, 21 Feb 2008 18:23:21 -0500

I was writing policy today, and I couldn't help notice a lot of
repetitiveness in our policy:

	libs_use_ld_so(...)
	libs_use_shared_libs(...)

These are needed by, well, everything. Can't they be assumed-unless-denied?

Similarly, 99% of confined apps need:

	miscfiles_read_localization()
	files_read_etc_files(.)
        pipes & stream sockets

Is there a way to streamline policy so there is a lot less
repetition?

Bill

--
fedora-selinux-list mailing list
fedora-selinux-list@redhat.com
https://www.redhat.com/mailman/listinfo/fedora-selinux-list
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
