Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1DHY3Rb028975
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 12:34:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1DHY2Oi007873
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 17:34:02 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1DHY1WW007870 for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 17:34:01 GMT
Subject: Re: Patched userland packages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040213173116.GB3966@hydra.joerghoh.de>
References: <1076686854.10189.93.camel@moss-spartans.epoch.ncsc.mil>
	 <20040213173116.GB3966@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1076693636.10189.143.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 13 Feb 2004 12:33:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-13 at 12:31, Joerg Hoh wrote:
> I think you can remove the patches, which are already contained in the
> upstream packages. People, who get the patch into the upstream package,
> can notify you, and you can then remove the patch from the repository.
> 
> But until then please keep all patches in the sf-repository. It's easier
> to get these patches from sf than to extract them from distribution
> packages.
> 
> I'll try to send some patches to their upstream and ask if they could be
> integrated.

If you are going to do that, then you might want to pull the patches
from the latest SRPMs from Dan's site
(ftp://people.redhat.com/dwalsh/SELinux/srpms), as the patches and SRPMS
in the sourceforge repository are not current.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
