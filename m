Message-ID: <4A122FF0.3010609@tycho.nsa.gov>
Date: Tue, 19 May 2009 00:05:04 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>
Subject: Minor issue with reading selinuxfs booleans.
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Recent versions of coreutils have bumped the read buffer size from 4K to
32K in several of the utilities.

This means that "cat /selinux/booleans/xserver_object_manager" no longer
works, it returns "Invalid argument" on F11.  getsebool works fine.

sel_read_bool has a check for "count > PAGE_SIZE" that doesn't seem to
be present in the other read functions.  Maybe it could be removed?

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
