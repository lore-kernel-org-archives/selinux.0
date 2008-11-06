Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA6GZig7028881
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 11:35:44 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA6GZhEm018701
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 16:35:44 GMT
Message-ID: <49131CD7.7070204@redhat.com>
Date: Thu, 06 Nov 2008 11:35:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: LC Bruzenak <lenny@MagitekLtd.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: restorecon / matchpathcon
References: <1225987455.7321.37.camel@homeserver>
In-Reply-To: <1225987455.7321.37.camel@homeserver>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

LC Bruzenak wrote:
> I see no way to recursively/silently check path context.
> 
> The matchpathcon command has a silent but no recursive option. It does
> return non-zero if something doesn't match.
> 
> The restorecon command has both recursive and don't change options but
> no silent. It does not return non-zero if there is a change to be made,
> so a redirect of stdout to /dev/null wouldn't suffice.
> 
> Is there another way/command?
> 
> Thx,
> LCB.
> 
find | xargs matchpathcon?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkTHNcACgkQrlYvE4MpobNdUACguPKVCvd8tG7bF8YIROetLbpT
GVcAoIEWXVxZW4yAdSWj4eEgsOzL4PpR
=jnXd
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
