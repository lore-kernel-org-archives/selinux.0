Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h74FitHa017426
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 11:44:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h74FheFB021294
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 15:43:41 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h74FheGD021289
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 15:43:40 GMT
Subject: Re: SELinux-2.6-PPC
From: Chris PeBenito <pebenito@gentoo.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1060003910.4298.47.camel@moss-spartans.epoch.ncsc.mil>
References: <1059955240.2997.75.camel@chris.pebenito.net>
	 <1060003910.4298.47.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1060011891.2997.156.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 04 Aug 2003 10:44:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-08-04 at 08:31, Stephen Smalley wrote:
> Yes, we plan on continuing to provide these as individual packages.
> I expect that you can use Colin Walter's Debian packages as a starting
> point for Gentoo packages.  Caveat:  Due to the migration to xattr and
> the reduction in support for genfs_contexts, you'll need to implement
> file labeling support if you want to use certain filesystem types (e.g.
> reiser, devfs).

What exactly do you mean by a reduction of genfs_contexts support?  I
didn't see any mention of this in the docs (perhaps I missed it), but I
did notice that genfs_contexts is a lot slimmer than the old policy.  I
do have devfs in mind, as its used in Gentoo.  As for reiser I would
think that for it to work it would just need the appropriate xattr
support in the kernel (and fix the policy makefile to run setfiles on it
during a relabel).


-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
