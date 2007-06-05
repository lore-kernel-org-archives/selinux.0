Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l55EquKc001100
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 10:52:56 -0400
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l55Eqs9Y012685
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 14:52:55 GMT
Received: from [192.168.0.6] (82-45-252-239.cable.ubr02.camd.blueyonder.co.uk [82.45.252.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTP id 3074A43B0C
	for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2007 14:07:10 +0100 (BST)
Message-ID: <466578C5.9070602@nagafix.co.uk>
Date: Tue, 05 Jun 2007 15:52:53 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: upgrading to modular policy
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi list,

I am finally getting around to upgrading some custom modules to the
modular policy and I have encountered a few issues:
* How do I find the new equivalent for macros which have been renamed?
ie: file_type_auto_trans, domain_auto_trans, append_logdir_domain,
general_domain_access, etc...
* trying to load one of the modules gives:
libsepol.permission_copy_callback: Module local depends on permission
dccp_recv in class node, not satisfied
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed!

Thanks
Antoine

PS: running gentoo selinux 2006.1 profile
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZXjFGK2zHPGK1rsRCnd9AJ947LsFxODgvjMN47sVRtcOhdvwSQCdE2mv
GGZEGPnoFml1RIYY+BxuExw=
=6GHU
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
