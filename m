Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBTFVvxn024217
	for <selinux@tycho.nsa.gov>; Mon, 29 Dec 2008 10:31:58 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBTFVuEH013849
	for <selinux@tycho.nsa.gov>; Mon, 29 Dec 2008 15:31:57 GMT
Message-ID: <4958ED67.70807@redhat.com>
Date: Mon, 29 Dec 2008 10:31:51 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: xing li <lixing.1006@gmail.com>
CC: domg472 g472 <domg472@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Where can i find the source code of Userspace Packages with modifications
 for SELinux?
References: <707f057d0812270525t1f6fa095i9ace0cc6e4d3bd6e@mail.gmail.com>	 <5aebb9fb0812270551g49c21fdm9bc7dd156182cf53@mail.gmail.com> <707f057d0812282312r19e324a8y4ace684ed1646812@mail.gmail.com>
In-Reply-To: <707f057d0812282312r19e324a8y4ace684ed1646812@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

xing li wrote:
> I have download the upstart source code from ubuntu
> http://packages.ubuntu.com/,  (hardy)
> but i have't found the selinux relevant code in it. I am so  confused that
> how the /sbin/init invoke
> the "load_policy" function during system initialization?
> 
> 2008/12/27 domg472 g472 <domg472@gmail.com>
> 
>> Most if not everything should be upstream. so if you would want to edit
>> "cp" then you would get the source code for coreutils on the project site
>> for coreutils.
>>
>> selinux userland tools source is here:
>>
>> http://userspace.selinuxproject.org/trac/browser/policycoreutils
>>
> 
It doesn't,  load_policy is being executed in the initrd.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklY7WcACgkQrlYvE4MpobOglACeIt0QPC5rbcKojYOxcWCsfAoD
888AoIVrOzMiCQelt4cEF16/8o4iXg1A
=J1AA
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
