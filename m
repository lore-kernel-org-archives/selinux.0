Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FHrnWt027173
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 13:53:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9FHrf0p006259
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 17:53:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9FHrer7006253
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 17:53:40 GMT
Subject: Re: avc_toggle and avc_enforcing
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kerry Thompson <kerry@crypt.gen.nz>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz>
References: <3F8BE8E5.9050006@ipen.br>
	 <1066145242.5054.213.camel@moss-spartans.epoch.ncsc.mil>
	 <2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz>
Content-Type: text/plain
Message-Id: <1066240413.7399.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 13:53:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-14 at 17:21, Kerry Thompson wrote:
> Speaking of which, I'd like to assemble a quick list of userland ( or more
> accurately, adminland ) changes between the current release and the
> previous non-/selinux release to update the documentation I've got, like
> the U-FAQ. The ones I've noticed so far :

There is a summary of changes at the beginning of the selinux-doc README
and there is a longer discussion of porting issues in the selinux-doc
PORTING file.

> - avc_enforcing, avc_toggle replaced by /selinux/enforcing
> - id command requires -c to display context

Not on my systems.  id should display the context after the uid, gid,
and groups information without any options.  id -c displays just the
context.  Perhaps this is a defect in the port of the coreutils selinux
patch to your distribution?

> - ps command uses -Z to display context

ps and ls still support the long options, but -Z was also taken as a
short option for consistency with TrustedBSD.  Also, ps already has -Z
reserved for MAC, so this is a reasonable use of it.  It appears that -z
(lowercase) is also already reserved by ps for MAC, so we should likely
support it as well.

> - initrd now mandatory

Preferred, but it is possible to replace or modify /sbin/init instead.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
