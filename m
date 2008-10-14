Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9EJ9Y7b015041
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 15:09:34 -0400
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9EJ9U41017974
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 19:09:34 GMT
Message-ID: <48F4EE5B.6060708@manicmethod.com>
Date: Tue, 14 Oct 2008 15:09:15 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Yet another man page patch
References: <48E2212A.3020004@redhat.com>
In-Reply-To: <48E2212A.3020004@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> int selinux_file_context_cmp(const security_context_t a,
> +                                    const security_context_t b);"
> +
> +.BI "int selinux_file_context_verify(const char *path, mode_t mode);"
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkjiISoACgkQrlYvE4MpobPV9gCg0KZ+rsxGsIalBS1qvbObK7bA
> 0H8Anj8FnGzOnSjnOfbk+5R4Bf2OyxW+
> =nJ7k
> -----END PGP SIGNATURE-----
>   
merged in libselinux-2.0.74


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
