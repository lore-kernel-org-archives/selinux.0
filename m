Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1G1m3Rb007864
	for <selinux@tycho.nsa.gov>; Sun, 15 Feb 2004 20:48:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1G1m3c3013312
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2004 01:48:03 GMT
Received: from smtp013.mail.yahoo.com (smtp013.mail.yahoo.com [216.136.173.57])
        by jazzband.ncsc.mil  with SMTP id i1G1m2R0013309 for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2004 01:48:02 GMT
Date: Sun, 15 Feb 2004 19:47:40 -0600
Subject: Re: Policy configuration question
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: selinux@tycho.nsa.gov
To: Colin Walters <walters@verbum.org>
From: Ignacio Tripodi <ignaciot@unt.edu>
In-Reply-To: <1076888807.5934.0.camel@nexus.verbum.private>
Message-Id: <1B26BF5E-6022-11D8-BD7E-000393013D1A@unt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thank you Colin, apparently I forgot to apply that patch because it 
works now.

Ignacio


On Sunday, February 15, 2004, at 05:46 PM, Colin Walters wrote:

> On Sun, 2004-02-15 at 12:58, Ignacio Tripodi wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> I'm trying to tune up the policy because I'm getting many "avc: 
>> denied"
>> log entries for almost every single command I try to run. The source
>> context seems to be the same (system_u:system_r:local_login_t),
>
> Did you add pam_selinux.so to your login and sshd PAM configuration
> files?
>
> <signature.asc>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFAMCFBwGqh0xtlFYsRAjHdAJsEGm1Ai1VeQwJGrwif7NESf2bjYgCdGK4k
Ft396wMgUKV2zy+M/U/jDwU=
=oZ/a
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
