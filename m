Received: from jazzband.ncsc.mil ([144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h94Cf4Wt000390
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 08:41:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h94BeX7d019390
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 11:40:33 GMT
Received: from markus.schuldei.com (petrus.schuldei.org [81.27.1.16])
        by jazzband.ncsc.mil  with ESMTP id h94BeWRn019384 for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 11:40:32 GMT
Date: Sat, 4 Oct 2003 13:40:20 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: Updated Release
Message-ID: <20031004114020.GA7845@markus.schuldei.org>
References: <1065114741.27477.3042.camel@moss-huskies> <20031003064750.GA4555@markus.schuldei.org> <1065188703.4080.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1065188703.4080.114.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@epoch.ncsc.mil) [031003 15:45]:
> On Fri, 2003-10-03 at 02:47, Andreas Schuldei wrote:
> > * Howard Holm (hdholm@epoch.ncsc.mil) [031002 21:37]:
> > > The
> > > star package has been added.
> > 
> > is that the tar which was enhanced for backing up selinux
> > attributes?
> 
> It is not the patched tar program from the old SELinux.
> Instead, it is a patched form of Joerg Schilling's star(1) archiver.  He
> has incorporated the EA support into the upstream star, so we are able
> to leverage that support for storing the SELinux attributes in the
> archive, but there is a small SELinux-specific patch to use the SELinux
> API to create extracted files immediately with their SELinux security
> context (rather than having to set the security context _after_ creating
> the file), since the xattr API does not support that functionality.

you mention the xattr api. can this tar be uses to restore
systems or parts of a system, bridging the 2.4 -> 2.6 switch? Or
is it only good for the version of selinux the backup was created
with?

i did not find the rpm (or srpm or tar) file for star on the
download page. what is the url to it?

and who has a backup script, switching from admin to backup
context, and backing up stuff?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
