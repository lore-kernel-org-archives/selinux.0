Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3SBnZRb005431
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 07:49:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3SBlNZx019638
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 11:47:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i3SBlMJv019635
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 11:47:22 GMT
Subject: Re: preserving user-set contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1083116682.3390.34.camel@nexus.verbum.private>
References: <1082752649.12608.111.camel@nexus.verbum.private>
	 <1082989812.22940.43.camel@moss-spartans.epoch.ncsc.mil>
	 <1083116682.3390.34.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1083152961.25987.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 28 Apr 2004 07:49:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-04-27 at 21:44, Colin Walters wrote:
> Well, users should still be stopped by DAC in setting xattrs on files
> they didn't own, which covers all the practical cases I can think of
> right now.

DAC isn't applied to the security namespace.  SELinux controls access to
its attributes (including an identity-based restriction on
relabelfrom/relabelto via policy/constraints).  Other attributes in the
security namespace are presently limited to CAP_SYS_ADMIN.

And relying on DAC to prevent the ability to _block_ a MAC policy from
being applied is not a good idea anyway.  At the very least, uid 0 is
troublesome.

> A much better example than the /build one I gave originally is
> httpd_user_content_t.  Users should be able to use chcon to change the
> types of specific files in their home directory to allow the webserver
> access.

That's debatable.  Many MAC policies aren't going to allow ordinary
users to relabel _anything_.  And allowing users to export arbitrary
data to the web server is not a good idea, if you want to enforce any
kind of confidentiality policy.

> Ok.  For the /build problem, we could add an option for setfiles to
> simply ignore unknown files instead of using default_t.

setfiles already skips files that have no matching specification.  But
at present, every file matches at least the /.* regex at the beginning
of types.fc.  So you can achieve the above by simply removing that
pattern (but I wouldn't recommend this).  Note that even if you do this,
you'll still want some context applied for the initial install.  So
you'll need two variants of the file_contexts configuration; one for
installation and one for runtime relabels (which isn't necessarily a bad
idea anyway).

>   For the
> httpd_user_content_t problem, we could add an attribute e.g.
> "customizable_type".  setfiles would by default not relabel that have
> this type.

And how do you control the ability to set this attribute?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
