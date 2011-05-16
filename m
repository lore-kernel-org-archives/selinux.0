Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4G5tZLf005288
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2011 01:55:35 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4G5tYkN012347
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2011 05:55:34 GMT
Received: by ewy8 with SMTP id 8so1312783ewy.12
        for <selinux@tycho.nsa.gov>; Sun, 15 May 2011 22:55:31 -0700 (PDT)
Message-ID: <4DD0BC4F.5000507@gmail.com>
Date: Mon, 16 May 2011 07:55:27 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Sam Gandhi <samgandhi9@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: FUSE and SELinux labeling
References: <BANLkTim-1VFJHg1BdSjbWH-6RrfMHVBx3A@mail.gmail.com>	<4DCFF2FD.6060704@gmail.com> <BANLkTinbr02afo-ZdJy4GfCGXV_ZC0tv9w@mail.gmail.com>
In-Reply-To: <BANLkTinbr02afo-ZdJy4GfCGXV_ZC0tv9w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/16/2011 02:47 AM, Sam Gandhi wrote:

> hello -o context=user_u:object_r:tmpfs_t /mn/tmp/

Try this:

http://docs.fedoraproject.org/en-US/Fedora/13/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Working_with_SELinux-Mounting_File_Systems.html

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3QvE8ACgkQMlxVo39jgT/+JwCfW1VkmtkhrFcQ+Eg4gj5OCZBZ
t/AAoLMc6fH5MNhW+IvpOzPjXrCKKygo
=h+Bm
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
