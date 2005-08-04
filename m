Message-Id: <200508041435.j74EZ4jY011001@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
   James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes 
In-Reply-To: Your message of "Thu, 04 Aug 2005 17:57:50 +1000."
             <200508041757.54938.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil> <42EE3879.2050409@tresys.com> <1122908944.6573.305.camel@moss-spartans.epoch.ncsc.mil>
            <200508041757.54938.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1123166104_3070P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 04 Aug 2005 10:35:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1123166104_3070P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 Aug 2005 17:57:50 +1000, Russell Coker said:

> One thing that was idly discussed was a public build server that would use one 
> domain and several types for every package that was to be compiled.  When you 
> look at distributions such as Debian with ~10,000 packages the number 64K 
> doesn't seem so large.

10K?? I only count 1,806 in Fedora Core 4....

What percent of these packages need any special handling other than
"run as the invoking user"? FC4 has about 180 .te files in domains/programs,
so just about 10% there.  I have *no* idea if "the next 8K packages" will
sustain that 10%, or if it will be significantly lower.

In any case, yes, that could run over 64K.

--==_Exmh_1123166104_3070P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC8ieYcC3lWbTT17ARAoNiAKCRdu/xBBgYieKtF9XzjfdiD+laFwCfZNyI
LCKAO1N6V+s5GGcC8LRilUE=
=R2jJ
-----END PGP SIGNATURE-----

--==_Exmh_1123166104_3070P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
