Message-ID: <434EBBDD.6040503@diyab.net>
Date: Thu, 13 Oct 2005 15:56:13 -0400
From: Timothy <timothy@diyab.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Non-PAM Policycoreutils
References: <434EA0C1.7050706@diyab.net>	 <1129227395.13490.8.camel@moss-spartans.epoch.ncsc.mil>	 <434EB30B.4080606@diyab.net> <1129232343.13490.35.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129232343.13490.35.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Stephen Smalley wrote:

> On Thu, 2005-10-13 at 15:18 -0400, Timothy wrote:
> 
>>Fixed and tested against CVS.  New patch attached.
> 
> 
> Thanks.  Why do you need to define __USE_XOPEN?  And should that always
> be done or just in the non-PAM case, i.e. CFLAGS+=-D__USE_XOPEN in the
> else clause of the Makefiles?
> 

The crypt defined in unistd.h is only read if __USE_XOPEN is defined so
it's required or make will fail for non-pam builds because the function
authenticate_via_shadow_passwd uses crypt.  I tried to add that define
to the CFLAGS in the makefile but it does not see that it is defined for
some reason and still errors out.

Timothy,
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDTrvdSYq2KfPEK/gRA6YCAJ9lpOdS7vXxcSmLUefj0rw23ii9+gCePSfA
NKVY75SH5vCRdPQBoGRUP30=
=Y+Gp
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
