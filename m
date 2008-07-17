Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6HFt8PS016988
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 11:55:08 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6HFt7Jn025669
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 15:55:07 GMT
Message-ID: <487F6B54.3040909@redhat.com>
Date: Thu, 17 Jul 2008 11:55:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Patch: selinux-policy: inconsistency: logging_send_syslog_msg
 is	not optional policy.
References: <1216307585.11883.17.camel@sulphur.notebook.internal>
In-Reply-To: <1216307585.11883.17.camel@sulphur.notebook.internal>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dominick Grift wrote:
> logging_send_syslog_msg is not optional policy.
> 
> 
This should never be optional.  If there are optional_policy wrappers
around logging_send_syslog_msg it should be removed.

Shouldn't all of kernel/system be required, with the exception of
unconfined?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkh/a1MACgkQrlYvE4MpobMoVwCgq+HkcpZKa6OdiZRY/O9P67ek
VZYAn25SA0hcjxgqow1K2N4wGRVVLbep
=qEJu
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
