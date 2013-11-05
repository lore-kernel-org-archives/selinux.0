Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA5F5Y1S002030
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2013 10:05:34 -0500
Message-ID: <52790935.2040006@redhat.com>
Date: Tue, 05 Nov 2013 10:05:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, selinux@tycho.nsa.gov
Subject: Re: No module named policycoreutils.default_encoding_utf8 ?
References: <20131104220022.GA6511@siphos.be>
In-Reply-To: <20131104220022.GA6511@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/04/2013 05:00 PM, Sven Vermeulen wrote:
> Hi all,
> 
> In policycoreutils-2.2.1/semanage/semanage, the first import is:
> 
> """ import policycoreutils.default_encoding_utf8 """
> 
Yes this is for internationlization but we should just remove it.  As I port
to python3 it will no longer be necessary.

This patch switches python2 to always use unicode, which is the default for
python3.

> On my system (Python 2.7) this fails with:
> 
> Traceback (most recent call last): File "/usr/sbin/semanage-python2.7",
> line 26, in <module> import policycoreutils.default_encoding_utf8 
> ImportError: No module named policycoreutils.default_encoding_utf8
> 
> Is this specific for a particular Python version?
> 
> I commented it out and most other things work just fine (I only have a
> small issue with audit2allow not wanting to generate refpolicy-style
> modules even though the interface_info file is - I think - up2date and is
> being read by audit2allow).
> 
> Wkr, Sven Vermeulen
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJ5CTUACgkQrlYvE4MpobPP5ACfUEiGrG1iXAB9410oDNv6d4v4
/zoAnRb8BcSM841DDCz5/epKGrxteq5C
=H0mM
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
