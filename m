Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89KRTrT014684
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 16:27:29 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89KQao3002665
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 20:26:36 GMT
Subject: Re: Patch to make udev/tmpfs work and changes from colin  walters
	for dbus.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Colin Walters <walters@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1094754066.28487.25.camel@nexus.verbum.private>
References: <413E1DE0.9050905@redhat.com>
	 <1094734410.2895.45.camel@moss-lions.epoch.ncsc.mil>
	 <1094754066.28487.25.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1094761584.2895.54.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Sep 2004 16:26:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That works.
Merged the original patch along with this fix.

On Thu, 2004-09-09 at 14:21, Colin Walters wrote:
> On Thu, 2004-09-09 at 08:53 -0400, James Carter wrote:
> > When I build the policy with this patch there is a conflict with two
> > type transitions.
> > 
> > Because of the alias rule:
> > typealias system_dbusd_exec_t alias dbusd_exec_t;
> > 
> > The following type transitions conflict:
> > type_transition sysadm_t dbusd_exec_t:process sysadm_dbusd_t;
> > type_transition sysadm_t system_dbusd_exec_t:process system_dbusd_t;
> > 
> > The second transition is the one used when I build the policy.  I am not
> > sure if that is the desired transition.
> 
> Hm.  Yes, we actually want the former.  Can you try this patch?
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
