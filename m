Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1DHn9Rb029145
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 12:49:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1DHn8Oi009110
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 17:49:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1DHn8WW009107 for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 17:49:08 GMT
Subject: Re: Patched userland packages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200402140412.05834.russell@coker.com.au>
References: <1076686854.10189.93.camel@moss-spartans.epoch.ncsc.mil>
	 <200402140412.05834.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1076694533.10189.160.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 13 Feb 2004 12:48:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-13 at 12:12, Russell Coker wrote:
> For other patches such as coreutils I think it would be good to keep them on 
> your site for the moment.  While we are still working at getting patches 
> accepted upstream it makes things a little easier if you have a patch online.  
> Often when I am talking to an upstream author about a patch to their code 
> they prefer to see other patches for the same code.
> 
> Once Fedora is released with full SE Linux support (planned for FC2) there 
> will be less need for the patches to be on the NSA site.  In some ways the 
> Fedora repository can become an authoritative site for the patches.

I suppose we could continue to carry a core set of patches and SRPMs for
the most critical components for reference, e.g. SysVinit (initial
policy load), pam (pam_selinux module and pwdb changes), util-linux,
openssh, vixie-cron, coreutils, shadow-utils and star.  But these will
just be the same as the ones from Dan's site
(ftp://people.redhat.com/dwalsh/SELinux/srpms), so I'm not sure what
value is added by having them on nsa.gov.  Dan essentially took over
maintenance starting with the port to the 2.6 SELinux API.

Regardless of what is decided there, it would likely be a good idea to
add pointers to the appropriate locations for the patched userland
components for the various distributions to the selinux-doc README.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
