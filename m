Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0JEc3RV032631
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 09:38:03 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0JEZA0N029243
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 14:35:10 GMT
Message-ID: <49749041.70400@redhat.com>
Date: Mon, 19 Jan 2009 09:37:53 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Martin Orr <martin@martinorr.name>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Customizable types
References: <4971140D.9090400@martinorr.name>
In-Reply-To: <4971140D.9090400@martinorr.name>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Martin Orr wrote:
> What is the purpose of customizable types?  In particular, it is not clear
> to me why the semantics are "don't relabel from a customizable type" rather
> than "don't relabel to a customizable type".
> 
> Secondly, so far as I can see types are only marked as customizable when
> built into the base module.  Is this intentional?
> 
> Best wishes,
> 
customizable_types was an old concept that we do not even implement in
Fedora any longer.  The customizable_types file is empty.  The idea was
that users would choose a directory to share files via http and they
would label it httpd_sys_content_t, later a autorelabel would be
triggered and the files would get relabeled.  constomizable_types
entries would not get relabelled.  The problem with this is that it did
not scale and mislabeled files would never get fixed if they were
customizable_types.  With the introduction of semanage fcontext it
became fairly easy for the administrator to customize the labeling of
the file system and eliminated the need for customizable types.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkl0kEEACgkQrlYvE4MpobOdbQCdF8upX4NiBR+6OHMkSH7D9k9T
7i4AoNmrNgVco6zB3InlU/HNuQsGPsHw
=RhCh
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
