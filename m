Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4VDwXc6017573
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2012 09:58:33 -0400
Received: by vbbfc26 with SMTP id fc26so668401vbb.12
        for <selinux@tycho.nsa.gov>; Thu, 31 May 2012 06:58:33 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] Add SELinux policy capability for always checking packet class.
Date: Thu, 31 May 2012 09:58:29 -0400
Message-ID: <1479620.Ig8PyPEAh1@sifl>
In-Reply-To: <4FC75C0E.7040709@tresys.com>
References: <1338384128-14144-1-git-send-email-cpebenito@tresys.com> <16326289.E5RbHv6gkl@sifl> <4FC75C0E.7040709@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, May 31, 2012 07:54:54 AM Christopher J. PeBenito wrote:
> On 05/30/12 10:30, Paul Moore wrote:
> > On Wednesday, May 30, 2012 09:22:08 AM Chris PeBenito wrote:
> >> Currently the packet class in SELinux is not checked if there are no
> >> SECMARK rules in the security or mangle netfilter tables.  Some systems
> >> prefer that packets are always checked, for example, to protect the
> >> system
> >> should the netfilter rules fail to load or if the nefilter rules
> >> were maliciously flushed.
> >> 
> >> Add the always_check_packets policy capability which, when enabled,
> >> treats
> >> SECMARK as enabled, even if there are no netfilter SECMARK rules.
> > 
> > I'm against committing this patch without some matching mechanism to
> > incorporate the secmark labeling configuration in the greater SELinux
> > policy. I explained why roughly 87 times in the previous RFC email thread
> > started by Chris so I'll save us all some time and not repeat it here.
> > 
> > Ignoring my own objections for a moment and glancing at the patch, I see
> > that it is incomplete/incorrect as it does not include support for the
> > network peer labels.  See the original RFC email thread.
> 
> The question is if they should be tied to the same policy capability.  If
> so, this capability should be renamed.  If not, the patch is fine, as I can
> just as easily send a second patch.  I'm undecided if they should be tied
> together.

If you're going to do one, do them all.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
