Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA23626
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 18:28:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA21736
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 22:26:59 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id WAA21732 for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 22:26:58 GMT
Date: Mon, 22 Apr 2002 18:27:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
In-Reply-To: <20020422220826.EF5F645C95@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204221825010.5657-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 23 Apr 2002, Russell Coker wrote:

> Also I added devfs_t to the following line:
> allow bootloader_t { etc_t device_t devfs_t }:dir r_dir_perms;

There is one other potential issue.  If an administrator directly edits
/etc/lilo.conf, it will revert to etc_t (and become inaccessible to lilo
unless it is then relabeled by the administrator).  Is there any strong
reason to maintain a separate type on this file?  It is problematic to
keep it in a separate type from other /etc files, since it may be directly
modified by the administrator and it doesn't live in its own separate
subdirectory.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
