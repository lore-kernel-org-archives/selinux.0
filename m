Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j23JtiDo018192
	for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2005 14:55:44 -0500 (EST)
Received: from turing-police.cirt.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j23JppSm000942
	for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2005 19:51:51 GMT
Message-Id: <200503031951.j23JpeQQ006501@turing-police.cc.vt.edu>
To: Michael Halcrow <mike@halcrow.us>
Cc: Serge Hallyn <serge.hallyn@gmail.com>, selinux@tycho.nsa.gov,
   todd glassey <todd.glassey@worldnet.att.net>
Subject: Re: Fwd: Compromise of SHA1 and SElinux 
In-Reply-To: Your message of "Thu, 03 Mar 2005 08:40:09 CST."
             <20050303144008.GA25681@halcrow.us>
From: Valdis.Kletnieks@vt.edu
References: <1109400342.4581.25.camel@cobra.ivg2.net> <20050227104528.GC28871@lkcl.net> <00d501c51cf1$651072c0$010aff0a@gw> <200502272139.j1RLdo28027659@turing-police.cc.vt.edu> <46ce702f05030305344dbdc83a@mail.gmail.com>
            <20050303144008.GA25681@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109879500_5032P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 03 Mar 2005 14:51:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1109879500_5032P
Content-Type: text/plain; charset=us-ascii

On Thu, 03 Mar 2005 08:40:09 CST, Michael Halcrow said:

> > From: Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu>

> > Now the guys who wrote the BSD Seclevel LSM *do* need to look at
> > upgrading, as that beast *does* use SHA1 for something.
> 
> The BSD Secure Levels module can accept a SHA1-hash of a passphrase
> when it initializes.  It then hashes a plaintext passphrase that is
> later passed in to produce a SHA1 hash, which is compared against the
> SHA1 hash originally sent to the module; a match reduces the secure
> level.

> From what I have read, this attack's scope is:  Given m, you can find
> m' in 2^69 operations, such that H{m} = H{m'}.

> If an attacker is ``given m'' in the first place, well, you're already
> screwed.  I do not see how this attack could apply to BSD Secure
> Levels.

OK... I'll consider it "looked at".. ;)  In some applications, the "given m"
is accessible to the attacker (for instance, in a digital signature on a file).
If inside seclvl (and any userspace helpers) the original SHA1 hash is never
anyplace an attacker has access to without it being "game over" anyhow(*), then
there's no real issue. I didn't feel qualified to trace the dataflow through,
figured I'd leave that to somebody who understood it better...

(*) Sometimes it's shoot-self-in-foot time - I've seen more than one box where the
admin set a Grub password that used MD5 - but /boot/grub/grub.conf was mode 644,
and the password was easily brute-forced.... ;)


--==_Exmh_1109879500_5032P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCJ2rLcC3lWbTT17ARAphyAKCEI5+5LF37SNIUhuov9cP4jeq8zACgq8ef
4zErZPnOFSUR977Hif8CSfI=
=XAfY
-----END PGP SIGNATURE-----

--==_Exmh_1109879500_5032P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
