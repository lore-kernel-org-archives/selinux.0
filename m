Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i51I6grT027513
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 14:06:42 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i52I6SXL025247
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 14:06:28 -0400 (EDT)
Subject: Re: moving to /etc/security/selinux and impact on .deb build
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040529143518.GA5135@lkcl.net>
References: <20040529143518.GA5135@lkcl.net>
Content-Type: text/plain
Message-Id: <1086113159.13325.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Jun 2004 14:05:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-05-29 at 10:35, Luke Kenneth Casson Leighton wrote:
> i have noted the discussions about "new location for selinux"
> and have hoped that my confusion about /usr/share/selinux and
> /etc/selinux and now /etc/security/selinux would go away.
> 
> but this is not to be.
> 
> could someone please help clarify some things for me?
> 
> what is the purpose of /usr/share/selinux/, it containing pretty much
> the same stuff in its policy/default directory as there is in
> /etc/selinux?
> 
> why the move to /etc/security/selinux, or more specifically, from where
> can i obtain updated .diffs to recreate the .debs correctly, or if those
> are not yet available, what modifications do i need to make to the
> .diffs, myself, in order to get a working system?
> 
> at present i have only a few files in /etc/security/selinux, directories
> only in /etc/selinux, an selinux-policy-default deb package that expects
> a Makefile /etc/selinux/Makefile which is definitely not present, and
> consequently a broken system.
> 
> pointers to pre-existing docs appreciated as much as a direct answer.

I think that Russell created a layout for Debian in the absence of any
particular layout imposed by the upstream SELinux originally, since we
only originally installed a binary policy file in the root directory and
application configuration files under /etc/security.  Later, the binary
policy file was moved down under /etc/security/selinux, and the policy
sources were installed under /etc/security/selinux/src (in response to
some suggestions by Tresys, iirc).

We are in the process of migrating to an /etc/selinux layout upstream,
but the layout is not the same as what has been used in Debian.  See the
discussion started by Dan Walsh,
http://marc.theaimsgroup.com/?l=selinux&m=108552096717030&w=2.
All of the SELinux-related configuration files are being brought under
one root (rather than having some directly in /etc/security vs. some
under /etc/security/selinux), and support for multiple policies is being
added.

Changes to libselinux and policy to support the new layout are available
in the sourceforge CVS, although things are still in flux.  You will
also need an updated SysVinit selinux patch that uses the new libselinux
function to obtain the path to the binary policy file, as multiple such
files may be installed simultaneously under the new scheme.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
