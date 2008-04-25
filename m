Message-ID: <481230EB.2000805@redhat.com>
Date: Fri, 25 Apr 2008 15:28:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: audit2allow -R
References: <1209146062.26761.173.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1209146062.26761.173.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> Per the man page, audit2allow -R is supposed to be the default.
> And the code says:
>         parser.add_option("-R", "--reference", action="store_true", dest="refpolicy",
>                           default=True, help="generate refpolicy style output")
> 
> which seems to confirm that.  But running audit2allow w/o -R does not
> generate interface calls.
> 
> On the next line, we have the opposite option:
>         parser.add_option("-N", "--noreference", action="store_false", dest="refpolicy",
>                           default=False, help="do not generate refpolicy style output")
> 
> I'm wondering if the default= value there is clobbering the prior one
> and needs to get updated too if we actually want this to be the default.
> 
> But before we do that, do we truly want to make it the default?  How
> confident are we in the interface matching?
> 
> 
I do not think we want it the default.  I have seen several times where
it gives back some bizarre interface.   Usually because we don't have a
good match.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgSMOsACgkQrlYvE4MpobOwFACePYYg9A03oDQ2M00Ia/0fm6ma
PbYAn2HWo8KZyGpsKqPhj8/p/9mdCOUt
=Mi40
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
