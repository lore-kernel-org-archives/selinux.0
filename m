Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1DHQ7Rb028911
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 12:26:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1DHQ6Oi007176
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 17:26:06 GMT
Received: from home.nightdaughter.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id i1DHPqWW007145 for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 17:26:06 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by home.nightdaughter.de (Postfix) with SMTP id 96A8517003A
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 18:39:11 +0100 (CET)
Date: Fri, 13 Feb 2004 18:31:16 +0100
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: Re: Patched userland packages
Message-ID: <20040213173116.GB3966@hydra.joerghoh.de>
References: <1076686854.10189.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1076686854.10189.93.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Feb 13, 2004 at 10:40:55AM -0500, Stephen Smalley wrote:
> Hi,
> 
> As the SELinux userland patches have been ported to many distributions
> by various people, and most of the real activity in further maintaining
> and developing them has migrated to those people, we'd like to drop them
> from our site in the future and drop down to only providing the latest
> SELinux kernel patch and the new SELinux userland packages (e.g.
> checkpolicy, libselinux, policycoreutils, policy, selinux-doc, plus the
> contributed setools and slat packages and any new packages that we
> develop or patch in the future that are not yet available in distro
> packages or upstream).  We could then just provide pointers to the
> appropriate locations for the patched userland components for various
> distributions in the selinux-doc README.  Does this sound reasonable?

I think you can remove the patches, which are already contained in the
upstream packages. People, who get the patch into the upstream package,
can notify you, and you can then remove the patch from the repository.

But until then please keep all patches in the sf-repository. It's easier
to get these patches from sf than to extract them from distribution
packages.

I'll try to send some patches to their upstream and ask if they could be
integrated.

Joerg

-- 
Fachbegriffe der Informatik (Nr 320): Softwarewartung
- Flags putzen, Strukturen nachrichten und Variablen mit Öl auffüllen. 
	Hans Bonfigt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
