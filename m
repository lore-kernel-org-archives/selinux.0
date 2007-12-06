Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB6EmuBd008397
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 09:48:56 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB6EmtCT019410
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 14:48:55 GMT
Message-ID: <47580BBF.2090307@redhat.com>
Date: Thu, 06 Dec 2007 09:48:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy HEAD, Debian, syslogd & setrlimit
References: <20071205141324.GA1211@bobek.pm.i.cz> <1196951315.12626.21.camel@gorn.columbia.tresys.com>
In-Reply-To: <1196951315.12626.21.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Wed, 2007-12-05 at 15:13 +0100, Václav Ovsík wrote:
>> audit(1196861341.205:26): avc:  denied  { setrlimit } for  pid=2160 comm="cron" scontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=process
>>
>> There is a content of /etc/pam.d/cron from my Debian Etch:
> [...]
>>     # Sets up user limits, please define limits for cron tasks
>>     # through /etc/security/limits.conf
>>     session    required   pam_limits.so
>>
>> /etc/security/limits.conf
>>
>> has only comment sections.
>>
>> Can be rlimit allowed or should be solved this in some other way?
> 
> I added this in distro_debian for now, so if someone does put limits, it
> will work.
> 
Seems reasonable for all distributions.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHWAu/rlYvE4MpobMRAkIFAKCB5ObRXtMutenjo3nW0uWIoGbwMwCeK3O+
CeettI1AWzS9LD/kEsU9fcs=
=WfQm
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
