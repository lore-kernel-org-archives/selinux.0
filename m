Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0ONFwdv006914
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 18:15:58 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0ONFvgt007902
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 23:15:58 GMT
Message-ID: <47991C20.40303@redhat.com>
Date: Thu, 24 Jan 2008 18:15:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: /var
References: <dd18b0c30801241300h268ede8ate8ede4a6999e8223@mail.gmail.com>
In-Reply-To: <dd18b0c30801241300h268ede8ate8ede4a6999e8223@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Justin Mattock wrote:
> Hello im testing out mcs refpolicy, and seem to have
> inode_doinit_with_dentry context_to_sid(system_u:object_r:var_run_t:s0-s15:
> c0.c255) returned 22 for dev=sda1
> ino=1425411 show up in dmesg, I have restorcon -R /var and this message
> still shows up. ("I dont know where the s0-s15 came from; maybee my user
> file?")
> any info would be appreciated.
> Thanks;
>                --Justin P. Mattock
> 
MCS only support one sensitivity s0

so:c0.c255 should work
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeZHCAACgkQrlYvE4MpobPBSACffyrDjeUnEXSw3B04JYZHo5W0
qUIAoK/15O/f9b+WQIbsUMqyVmkcJFWi
=6rhU
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
