Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1DHECRb028808
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 12:14:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1DHCiQk020856
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 17:12:45 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i1DHC4Yo020705
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 17:12:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: Patched userland packages
Date: Sat, 14 Feb 2004 04:12:05 +1100
References: <1076686854.10189.93.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1076686854.10189.93.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402140412.05834.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Feb 2004 02:40, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
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

In the long-term, yes, but I don't think that it would be a good idea to do so 
with all patches now.

procps is now done, it's in the upstream package, in Debian, and now Red Hat 
also uses the same procps.  So there's no benefit doing anything for procps.

For other patches such as coreutils I think it would be good to keep them on 
your site for the moment.  While we are still working at getting patches 
accepted upstream it makes things a little easier if you have a patch online.  
Often when I am talking to an upstream author about a patch to their code 
they prefer to see other patches for the same code.

Once Fedora is released with full SE Linux support (planned for FC2) there 
will be less need for the patches to be on the NSA site.  In some ways the 
Fedora repository can become an authoritative site for the patches.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
