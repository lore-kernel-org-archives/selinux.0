Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA19729
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 10:24:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA24254
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 15:24:20 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA24249
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 15:24:19 GMT
Date: Wed, 14 Feb 2001 10:23:05 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Redhat 7
In-Reply-To: <Pine.SOL.3.95.1010214095204.5716F-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.SOL.3.95.1010214101506.5716G-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


By the way, you'll find an example of a domain that is
allowed to directly access the disk devices in
policy/domains/program/fsadm.te.  The fsadm_t domain
is currently used for fsck and swapon.  You can put
other programs into the domain by labeling them
system_u:object_r:fsadm_exec_t in policy/file_contexts.
You may want to use this existing domain for hdparm.  
For mount, you will probably want a new domain that
includes the fsadm_t permissions but also includes
some additional permissions related to mounting
that are currently granted to initrc_t directly, e.g.

allow mount_t fs_type:filesystem mount_fs_perms;
allow mount_t file_t:dir mounton;

Adding a new domain for each privileged program 
would allow for the greatest use of least privilege,
but it is also very difficult to manage.  So you want
to balance between providing least privilege and
keeping a manageable number of distinct domains.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
