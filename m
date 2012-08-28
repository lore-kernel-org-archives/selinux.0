Message-ID: <503CA8A4.50802@redhat.com>
Date: Tue, 28 Aug 2012 07:16:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Gaurav Kumar <gk@pivotalsecurity.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: selinux context_new return value question
References: <CAFUy1TzNKNWDACcXtBn05-CMkxyZzGNTQGNHyjt+XFPAoUQ-3Q@mail.gmail.com> <CAFUy1TwvBNP9UBTK39DRWg5LNnf6tA2UJYuBpPP548oK0GrZxg@mail.gmail.com>
In-Reply-To: <CAFUy1TwvBNP9UBTK39DRWg5LNnf6tA2UJYuBpPP548oK0GrZxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/28/2012 05:09 AM, Gaurav Kumar wrote:
> According to http://linux.die.net/man/3/context_new, "On success, zero is
> returned" but none of the functions mentioned return 0. They are all
> returning const char * or void. Can someone please clarify in which case 0
> will be returned? In other words, how can I find out if call to context_new
> succeeded?
> 
> Thanks, Gaurav
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
> 
It is a bug.  NULL (0) actually would be the error code.  Since context_new is
basically doing a malloc of a new structure.

I will fix the code in Fedora and work to get it upstream.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlA8qKQACgkQrlYvE4MpobOp5wCfVOA4K7/MyqeLLWx2rN/9IQIH
VpUAoI2D8wB0NPHif03SMHYdRSkRuQGD
=as8V
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
