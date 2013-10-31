Message-ID: <5272A126.7020401@redhat.com>
Date: Thu, 31 Oct 2013 14:27:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
References: <52715E75.5000005@redhat.com> <1383177270.23834.37.camel@localhost>
In-Reply-To: <1383177270.23834.37.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/30/2013 07:54 PM, Colin Walters wrote:
> On Wed, 2013-10-30 at 15:31 -0400, Daniel J Walsh wrote:
> 
>> Here is a patch I have been fooling around with which would read a
>> policy.29 file if it was compressed with xz.
> 
> Hm, it's kind of ugly to attempt to open the policy with LZMA and only if
> that returns (any kind of error) fails fall back to the old code. Wouldn't
> it be better to say check whether or not it starts with a new magic number,
> like the kernel policydb_read() function does?
> 
> In other words have:
> 
> [New 32 bit magic number] [Compressed policy]
> 
> 
Yes I was first considering doing this, but went with the easy hack to get the
discussion going, and give me some numbers on speed of loading policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJyoSYACgkQrlYvE4MpobOK0wCgo0ybL6GQgf6e1JpoXRDwWdlh
JWkAn2UXnk55QusMCSmvU7t7/VhSVxF+
=jzi8
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
