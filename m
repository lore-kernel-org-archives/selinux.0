Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j17Moa53023827
	for <selinux@tycho.nsa.gov>; Mon, 7 Feb 2005 17:50:36 -0500 (EST)
Subject: RE: Best way to label a filesystem for another system
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Villalovos, John L" <john.l.villalovos@intel.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <60C14C611F1DDD4198D53F2F43D8CA3B036A31B3@orsmsx410>
References: <60C14C611F1DDD4198D53F2F43D8CA3B036A31B3@orsmsx410>
Content-Type: text/plain
Message-Id: <1107816234.11907.115.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 07 Feb 2005 17:43:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-07 at 17:37, Villalovos, John L wrote:
> In particular being able to generate a read-only file system which
> contains correctly labelled files.  I get the impression that if I label
> them on my host system and then use that to generate a filesystem image
> that I should run fixfiles when I first bring it up.  But this is not
> possible if I am using a read only file system.  It would be preferable
> if the host development system does NOT need to have the same SE Linux
> process as the target system.

There are two options:
1) Disable SELinux on the host development system (by changing
/etc/selinux/config and rebooting).   setfiles and the kernel will then
apply any file contexts you specify to the filesystem being created for
the embedded system.
2) Retain SELinux on the host development system, but change its policy
such that all of the desired file contexts for the embedded system are
legal in its policy.  The simplest way to do this is to use the same
policy.  An alternative is to just to add stub type definitions for all
of the necessary types to the host policy.  Could mostly be automated,
e.g. filter out the file_type declarations from the host and embedded
policy.conf files, sort and diff them, and then add the missing ones to
the host policy and rebuild it.  Then the host policy will define the
types and let you set them, even though nothing on the host (outside of
the chroot'd environment) will have those types.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
