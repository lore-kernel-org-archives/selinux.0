Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TJZeXZ011109
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 15:35:40 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TJZasx021626
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 19:35:37 GMT
Subject: Re: [patch] give userspace_objmgr access to default_context_t
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Colin Walters <walters@verbum.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1098556843.8447.30.camel@x-infinity.verbum.private>
References: <1098556843.8447.30.camel@x-infinity.verbum.private>
Content-Type: text/plain
Message-Id: <1099078466.12321.98.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 15:34:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Sat, 2004-10-23 at 14:40, Colin Walters wrote:
> Hi,
> 
> Most userspace object managers (e.g. D-BUS) will need access to default
> contexts files.  I think these used to just be selinux_config_t but seem
> to have switched recently.
> 
> I noticed two domains, updfstab and udev are both likely candidates for
> the userspace_objmgr attribute, since they have this:
> 
> domains/program/updfstab.te:r_dir_file(updfstab_t, { selinux_config_t file_context_t default_context_t } )
> 
> Right now neither of them get security decisions, but it doesn't seem
> unlikely in the future.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
