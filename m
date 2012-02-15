Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1FF1F0S004491
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2012 10:01:15 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q1FF1CRS019402
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2012 15:01:13 GMT
Message-ID: <4F3BC8B4.4080605@redhat.com>
Date: Wed, 15 Feb 2012 10:01:08 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Budanov Eugene <eugene.budanov@rosalab.ru>
CC: SELinux Upstream <selinux@tycho.nsa.gov>
Subject: Re: libsemanage from fc17
References: <4F3B6787.6020300@rosalab.ru>
In-Reply-To: <4F3B6787.6020300@rosalab.ru>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/15/2012 03:06 AM, Budanov Eugene wrote:
> Hi!
> 
> I'm trying to build libsemanage, but rpm says me that 
> libsemanage-rhat.patch from libsemanage-2.1.6-2.fc17.src.rpm is
> empty.
> 
> I can get it from F16 or fresh version of this patch is exist? --- 
> Best regards, Budanov Eugene ROSA Laboratory Russia, Moscow. e-mail
> : eugene.budanov@rosalab.ru phone: +79160674716 (UTC +4)
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.

I have no idea how that got checked in.  I just built
libsemanage-2.1.6-3.fc17
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk87yLQACgkQrlYvE4MpobMdnACgypmBfk3iRItDMca36JCQHyjP
0r8AnjzJohm6ft/LmXK2xcqTI6U1oddF
=5F79
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
