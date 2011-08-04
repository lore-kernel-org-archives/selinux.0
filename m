Message-ID: <4E3ACBA0.2050603@redhat.com>
Date: Thu, 04 Aug 2011 12:41:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 040/155] policycoreutils: setfiles: use glob to handle
 ~ and
References: <4E39B710.3090709@redhat.com> <1312469991.20973.55.camel@moss-pluto>
In-Reply-To: <1312469991.20973.55.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/04/2011 10:59 AM, Stephen Smalley wrote:
> On Wed, 2011-08-03 at 17:01 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> 
>> This patch looks good to me. acked.
> 
> I don't quite understand why this isn't handled by the shell before
> it ever reaches setfiles.
> 

I believe setfiles and restorcon can take input of files

- -f filename

Also piping routines could give you a file spec that is not expanded.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk46y5cACgkQrlYvE4MpobOnWgCgrEV21FV2f0jz0EJSSMW6gUnA
DwcAni9HXgzGzQkOQ7ayVawEng26sFby
=3Y46
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
