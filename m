Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4LHnERb028857
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 13:49:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4LHnBAT000899
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 17:49:12 GMT
Message-Id: <200405211749.i4LHnA2f025443@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: K Vikram <vikramatiitkdotacdotin@yahoo.com>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Loadable Policy Modules and a Generic MAC Policy Language 
In-Reply-To: Your message of "Fri, 21 May 2004 08:37:22 EDT."
             <1085143042.2789.12.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <20040521035145.81148.qmail@web41013.mail.yahoo.com>
            <1085143042.2789.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-795893628P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 21 May 2004 13:49:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-795893628P
Content-Type: text/plain; charset=us-ascii

On Fri, 21 May 2004 08:37:22 EDT, Stephen Smalley said:
> On Thu, 2004-05-20 at 23:51, K Vikram wrote:
>> Other than kernel code, relevant patches to userspace programs such as
>> login, init, setfiles, etc. and loadable kernel modules for Biba, BLP
>> and Lipner models are also included. These patches were required to
>> fully implement and use the above mechanisms. 
> This seems worrisome.  The SELinux/Flask architecture was designed to
> support policy flexibility, so further patching of those programs
> shouldn't be necessary, aside from allowing selection of new fields in
> pam_selinux.  Most applications should be fine, as the security context
> is already encapsulated.

Could K Vikram explain what pieces needed to be added in userspace
to support Biba, BLP, and Lipner (or actually, what additional info/etc
needed to be dealt with)?  Or was the MLS support what he was looking for?

--==_Exmh_-795893628P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFArkEWcC3lWbTT17ARAmwSAKCYGWxWgIIJi8an8wl6OkpuuQrQXwCbBI77
S9tpTxOQ1nz0KuGDsCl+0IA=
=Hx/A
-----END PGP SIGNATURE-----

--==_Exmh_-795893628P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
