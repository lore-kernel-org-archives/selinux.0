Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EKDhWt021277
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 16:13:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9EKDa0p015229
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 20:13:36 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9EKDar7015226
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 20:13:36 GMT
Subject: Re: [Fwd: Re: trusted vs untrusted packages]
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1066162046.27911.47.camel@chris.pebenito.net>
References: <1066162046.27911.47.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1066162420.5054.395.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Oct 2003 16:13:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-14 at 16:07, Chris PeBenito wrote:
> > I would think that some sort of trusted-path execution setup would be
> > better.  I don't know much about TPE, but this sounds like one situation
> > that it would be good for.  Then you could set it to not do domain
> > transitions on untrusted stuff, and also require that sysadm_t only
> > execute trusted stuff.  The status as trusted or untrusted could be
> > handled by another xattr.  Then it also would not get overridden by a
> > relabel.  But I'm getting ahead of myself, since there is no TPE in
> > SELinux. </brainstorm>
> > 
> > Might there one day be TPE in SELinux, or is that beyond its scope?

Use type enforcement instead.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
