Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i923IrrT006783
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 23:18:53 -0400 (EDT)
Received: from wgimx01.wgint.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i923IqEZ022153
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 03:18:52 GMT
From: "Richard Simpson" <richard.simpson@wgint.com>
To: "Erich Schubert" <erich@debian.org>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: bash_profile: Permission denied
Date: Fri, 1 Oct 2004 21:21:07 -0600
Message-ID: <BJENLMGHDPAAAGKKPOFOAEFACFAA.richard.simpson@wgint.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1096670260.4161.18.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Erich Schubert
> Sent: Friday, October 01, 2004 4:38 PM
> To: Daniel J Walsh
> Cc: James R. Marcus; selinux@tycho.nsa.gov
> Subject: Re: bash_profile: Permission denied
>
>
> Hi,
>
> > The problem is probably that you are logging as staff_r and the
> > directory is sysadm_r.
>
> What is the preferred way for having login being done as staff_r, but
> still having some profile files for root/staff_r?
> (staff_r doesn't necessarily need to write them, but i'd like him to be
> able to read them. So i can at least have a macro for "newrole -r
> sysadm_r" or a bash history entry...)
>
You can give staff_r enhanced privileges, including reading root files, by
setting appropriate tunables in tunable.te. You can see what the tunables do
in staff.te.

Richard.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
