Message-ID: <526E78AC.2080104@redhat.com>
Date: Mon, 28 Oct 2013 10:46:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>, Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: avc_has_perm() returns -1 even when SELinux is in permissive
 mode
References: <20131027144337.5b89c5a8@fornost.bigon.be>	<526E5D5C.8010505@tycho.nsa.gov> <20131028143605.02a85190@soldur.bigon.be>
In-Reply-To: <20131028143605.02a85190@soldur.bigon.be>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Maybe the solution here is to add logging messages to the function.

My opionion is that if something is wrong with SELinux, IE The labels are
wrong, the policy is wrong or the app is wrong, we should not block in
permissive mode.

Having the tool write "foobar_t is not a valid source context" would be better
then what we have now, which is a silent denial even in permissive mode.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJueKwACgkQrlYvE4MpobNU6wCeKWF79vOSxUH0PKDiuo64DbY/
EwgAoKjSD2BMe6KHIv2Smvkxwh/Ta02r
=6Agn
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
