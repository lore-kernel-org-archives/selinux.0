Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6EKC3Pp004934
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 16:12:03 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6EKC22j029247
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 20:12:02 GMT
Message-ID: <487BB30B.6080402@redhat.com>
Date: Mon, 14 Jul 2008 16:11:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: selinux@tycho.nsa.gov
Subject: Re: ping and the /tmp directory
References: <0794F277152EF94AA637E3AECF5CB70F010A9C12@blums0042.bluelnk.net>
In-Reply-To: <0794F277152EF94AA637E3AECF5CB70F010A9C12@blums0042.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Clarkson, Mike R (US SSA) wrote:
> Does the ping utility normally read/write to the /tmp directory?
> 
> I've got a domain that uses ping in the ping_t domain, using the
> netutils_domtrans_ping interface, and I'm getting the following from
> audit2allow:
> 
> allow ping_t tmp_t:file { read write getattr ioctl };
> 
> Thanks
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
These situations are almost always leaked file descriptor.  The tool
that is domtrans  to ping is leaking or one of it's parents.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkh7swsACgkQrlYvE4MpobO0pACfSmDU4n1MlqbG28u/8J6Rj7v2
WWQAoM00W2onH9YGrd+8j3Rfw+IgcGzC
=QYQe
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
