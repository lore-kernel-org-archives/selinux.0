Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iABKrbIi007544
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2004 15:53:38 -0500 (EST)
Received: from oe-im2.bizmailsrvcs.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iABKq9q2029777
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2004 20:52:09 GMT
Subject: Re: How come security_get_boolean_pending returns true when a
	boolean is on.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <419373C8.8050701@redhat.com>
References: <419373C8.8050701@redhat.com>
Content-Type: text/plain
Date: Thu, 11 Nov 2004 15:53:42 -0500
Message-Id: <1100206422.28882.15.camel@selinux>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-11 at 09:14 -0500, Daniel J Walsh wrote:
> getsebool -a
> mozilla_writehome --> active: 1 pending: 1
> named_write_master_zones --> active: 0 pending: 0
> nfs_export_all_ro --> active: 0 pending: 0
> nfs_export_all_rw --> active: 0 pending: 0
> read_default_t --> active: 1 pending: 1
> run_ssh_inetd --> active: 0 pending: 0
> secure_mode --> active: 0 pending: 0
> spamassasin_can_network --> active: 0 pending: 0
> ssh_sysadm_login --> active: 1 pending: 1
> staff_read_sysadm_file --> active: 1 pending: 1

The active and pending should be the same unless someone is intending to
change it, but hasn't committed the changes.  So in this example:

> Shouldn't this be
> staff_read_sysadm_file --> active: 1 pending: 0

this would mean that someone has done a
security_set_boolean("staff_read_sysadm_file",0), but hasn't done a
security_commit_booleans() yet.  After you commit it, the bool will be
active 0, pending 0.  Then subsequent commits will not change the value
since the pending is the same as the active.  If active and pending were
always opposite, you'd be toggling all of the booleans on every
security_commit_booleans().

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
