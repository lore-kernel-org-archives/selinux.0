Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA17294
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 20:14:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA09113
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 00:14:09 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by jazzswing.ncsc.mil  with ESMTP id AAA09109
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 00:14:08 GMT
Date: Wed, 17 Jul 2002 08:14:27 +0800 (PHT)
From: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: cant gain sysadm_r via ssh
In-Reply-To: <Pine.GSO.4.33.0207161306530.23767-100000@raven>
Message-ID: <Pine.LNX.4.44.0207170806270.444-100000@coffeesaur>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1





On Tue, 16 Jul 2002, Stephen Smalley wrote:

>
> You'll probably need to customize your pppd domain for this purpose, and
> define a different type for the device (ttyS?).
>
Im phasing out devfsd in my system. Thats why Im trying to access the
devices directly. I laso dont want to add permissions for accessing links
all over my policy. I thought pppd had access permissions to access ttySn
devices so I thought I give the same type to tts/n devices but I could not
find any except devtty_t.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9NLbv6r8UsQIvzXwRAoxaAJ9SOMjJQh77FTkqzZ3nf+r/rMpaswCdFhEl
DNXXuUud87r8BEtlJuuGsRI=
=ATby
-----END PGP SIGNATURE-----



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
