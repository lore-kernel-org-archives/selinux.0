Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i51IITrT027615
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 14:18:29 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i522D12V023250
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 22:13:01 -0400 (EDT)
Subject: Re: Debian / SE-Linux - status report 29may2004
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040529223350.GL2851@lkcl.net>
References: <20040529223350.GL2851@lkcl.net>
Content-Type: text/plain
Message-Id: <1086113881.13325.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Jun 2004 14:18:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-05-29 at 18:33, Luke Kenneth Casson Leighton wrote:
> NSA/SELinux kernel 2.6:
> 
> 	http://www.nsa.gov/selinux/code/download5.cfm
> 	http://sf.net/projects/selinux/ (see cvs).
> 
> 	status: most of the selinux enhancements are available
> 	        upstream in 2.6, however the very latest patches
> 			are only available from the above sites.

Since we submit these changes upstream, I wouldn't worry too much about
this.  Debian kernel will pick up the changes eventually.

> debian kernel 2.6 images:
> 
> 	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=249510
> 	http://open.hands.com/~lkcl/selinux
> 
> 	status: raised only 12 days ago.  requested that se/linux
> 		    security config options be enabled in stock
> 		    Debian kernels but require selinux=1 and enforcing=1
> 			to switch it on.

Requires inverting the logic of the selinux boot parameter.  Upstream
kernel enables SELinux by default unless you specify selinux=0.  But
patched /sbin/init can disable it completely, and this is what is done
by Fedora if /etc/sysconfig/selinux specifies SELINUX=disabled (note:
/etc/sysconfig/selinux is moving to /etc/selinux/config in the new
layout).

> cron:
> 
> 	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644
> 
> 	i think this one's my favourite.
> 
> 	status: 1 year old. bit of a wing-ding and misunderstanding
> 	        over a field name, fortunately the maintainer stood
> 			his ground until the non-cron-code-experts understood
> 			the issues.  updated patch sent.


Anyone looking into using that same patch for Fedora?  We'd need to make
sure that there is indeed no change in the effective behavior.

> pam:
> 
> 	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=249499
> 
> 	status: amazingly, only 19 days old.  unless there's an
> 	        earlier one and it's already been integrated
> 			upstream.  changes are only to pam_unix, apparently.
> 	        information sought from upstream and from the
> 			maintainer.

What about adding pam_selinux?  That's more important.  pam_unix changes
are nice in terms of supporting least privilege and allowing use of a
tight policy, but not fundamental to operation.

> init:
> 
> 	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=242900
> 
> 	status: raised 50 days ago.  seeking information from
> 	        debian maintainer.

Note that the SysVinit patch is changing as part of the new design for
supporting multiple installed policies, and the new patch depends on the
changes to libselinux in CVS.

> openssh:
> 
> 	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193664
> 
> 	status: raised 1 year ago, it was discussed, and the maintainer
> 	        specifically asked for russell to push for its
> 			inclusion upstream.  message sent to openssh-dev
> 			upstream, alerting them to the patch.

Only necessary if we decide that using pam is not adequate.  There are
some known issues with using pam_selinux (see fedora selinux lists). 
Suggested solution is to split it into two pam modules and bracket the
pam stack with them to ensure proper order of invocation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
