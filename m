Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7K821rT002221
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 04:02:01 -0400 (EDT)
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7K81J4v026838
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 08:01:19 GMT
Date: Fri, 20 Aug 2004 10:01:56 +0200
From: Stefan SF <stefan@sf-net.com>
To: Colin Walters <walters@verbum.org>
Cc: Stefan SF <stefan@sf-net.com>, selinux@tycho.nsa.gov
Subject: Re: policy for scponly - need help
Message-ID: <20040820080156.GA8602@crux.sternplastic>
References: <20040819173620.GA8543@crux.localdomain> <1092967183.29540.30.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
In-Reply-To: <1092967183.29540.30.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> scponly seems similar to rssh.  You may want to try my rssh policy:
> http://verbum.org/files/rssh_macros.te
> http://verbum.org/files/rssh.te
> http://verbum.org/files/rssh.fc

Hmm I can't make head or tail of this. I think the scponly-problem is another one. Because you don't have to transit or anything else in the rssh-policy (user -> role).

> It would likely be sufficient to just add a regexp for scponly to
> rssh.fc.

For what? I think this is not a problem of correct labeling.

> Hmmm, odd.  Are you logging in as root?

No, the program is only to /usr/sbin installed because it uses some functions which are only to priviliged peoples related, I think.


I've created policies all the time ;-) but nothing right was coming out! I've still the same problem, that I can't allow the user_t capabilities, without edeting the uesr.te files! It would be great, if I only have to edit the scponly-policy-files. I think all permissions for the program should go there.

Here is on of my tries:

# domains/program/scponly.te
type scponly_t, domain, privowner;
type scponly_exec_t, file_type, exec_type, sysadmfile;

domain_auto_trans(user_t, scponly_exec_t, scponly_t)
domain_auto_trans(sysadm_t, scponly_exec_t, scponly_t)

role user_r types scponly_t;
role sysadm_r types scponly_t;

ifdef(`ssh.te',`
allow sshd_t scponly_exec_t:file { getattr execute read };
allow user_t scponly_exec_t:file { entrypoint };
')

ifdef(`user.te',`
allow user_t:capability { dac_override dac_read_search };
domain_auto_trans(user_t, scponly_exec_t, scponly_$1_t);
')


I thought with a domain_auto_trans the problem should get fixed, but the output from avc is still the same.

audit(1092988519.353:0): avc:  denied  { dac_override } for  pid=7088 exe=/usr/sbin/scponlyc capability=1 scontext=test:user_r:user_t tcontext=trade:user_r:user_t tclass=capability
audit(1092988519.353:0): avc:  denied  { dac_read_search } for  pid=7088 exe=/usr/sbin/scponlyc capability=2 scontext=test:user_r:user_t tcontext=trade:user_r:user_t tclass=capability


Any hints, tipps or related policy-files would be great! ;-)


ciao, Stefan

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJa/0UEn3BeoPvtwRApWaAJ9/dIZOnUDQ+y0BO8CLgk+5kfARVgCfTuKx
wuHOdxY1ESCDdp9zrc0PA2g=
=VOYs
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
