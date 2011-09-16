Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GEPriY020205
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 10:25:53 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8GEPpej019528
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 14:25:52 GMT
Message-ID: <4E735C69.9090903@redhat.com>
Date: Fri, 16 Sep 2011 10:25:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 51/67] libsepol: Preserve tunables when required by semodule
References: <4E7257FE.6070703@redhat.com> <1316148900.2364.33.camel@vortex>
In-Reply-To: <1316148900.2364.33.camel@vortex>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/16/2011 12:55 AM, Guido Trentalancia wrote:
> On Thu, 2011-09-15 at 15:54 -0400, Daniel J Walsh wrote:
>> From f2a839faa71dac0bc575615bfe0aafca94a00892 Mon Sep 17 00:00:00
>> 2001 From: Harry Ciao <qingtao.cao@windriver.com> Date: Thu, 1
>> Sep 2011 11:29:47 +0800 Subject: [PATCH 51/67] libsepol: Preserve
>> tunables when required by semodule program.
>> 
>> If the "-P/--preserve_tunables" option is set for the semodule 
>> program, the preserve_tunables flag in sepol_handle_t would be
>> set, then all tunables would be treated as booleans by having
>> their TUNABLE flag bit cleared, resulting in all tunables if-else
>> conditionals preserved for raw policy.
>> 
>> Note, such option would invalidate the logic to double-check if 
>> tunables ever mix with booleans in one expression, so skip the
>> call to assert() when this option is passed.
>> 
>> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com> 
>> Signed-off-by: Eric Paris <eparis@redhat.com> --- 
>> libsepol/src/expand.c |   36
>> ++++++++++++++++++++++++------------ 1 files changed, 24
>> insertions(+), 12 deletions(-)
> 
> Hello Dan.
> 
> The new option seems not fully enabled yet by parsing the option
> and setting the preserve_tunables flag appropriately in main().
> 
> Is it going to be enabled elsewhere ?
> 
> Guido
> 

I actually have not started to play with this stuff yet, I am still
concerned about the audit2why being able to figure out which
boolean/tunable would be able to allow the access.  I am fine with it
for people who do not care about this technology and just want smaller
policy.  Meaning I am not sure what we are missing.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5zXGUACgkQrlYvE4MpobPf8gCfZAfBBZ32jOxz+fMxZ5d3GgcP
RL8An1tuvX6Q2FayFvAJ1jGkbITU3Dpu
=cfic
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
