Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BDLXBI028263
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 09:21:33 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7BDLWPn024333
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 13:21:32 GMT
Subject: Re: [patch 17/35] brctl policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: david@hardeman.nu, selinux@tycho.nsa.gov
In-Reply-To: <489B10B7.1030206@redhat.com>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123737.432616785@hardeman.nu>
	 <1218116869.5345.18.camel@gorn.columbia.tresys.com>
	 <489B10B7.1030206@redhat.com>
Content-Type: text/plain
Date: Mon, 11 Aug 2008 09:20:36 -0400
Message-Id: <1218460836.16773.9.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-08-07 at 11:11 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> >> plain text document attachment (policy_modules_admin_brctl.patch)
> >> One minor change
> > 
> > I need justification for this change.
> > 
> >> Index: refpolicy/policy/modules/admin/brctl.te
> >> ===================================================================
> >> --- refpolicy.orig/policy/modules/admin/brctl.te	2008-08-03 16:47:00.000000000 +0200
> >> +++ refpolicy/policy/modules/admin/brctl.te	2008-08-03 18:01:42.000000000 +0200
> >> @@ -33,6 +33,8 @@
> >>  
> >>  files_read_etc_files(brctl_t)
> >>  
> >> +term_use_console(brctl_t)
> >> +
> >>  libs_use_ld_so(brctl_t)
> >>  libs_use_shared_libs(brctl_t)
> >>  
> >>
> I believe this comes from libvirt or qemu interacting with the console.

Sounds like this should be dontaudited instead.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
