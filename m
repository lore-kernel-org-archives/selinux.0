Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAEJW4Cu010753
 for <selinux@tycho.nsa.gov>; Sat, 14 Nov 2015 14:32:04 -0500
Received: by wmvv187 with SMTP id v187so124811043wmv.1
 for <selinux@tycho.nsa.gov>; Sat, 14 Nov 2015 11:30:43 -0800 (PST)
Received: from x250 ([84.245.63.179])
 by smtp.gmail.com with ESMTPSA id q6sm5580088wmd.8.2015.11.14.11.30.43
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Sat, 14 Nov 2015 11:30:43 -0800 (PST)
Date: Sat, 14 Nov 2015 20:30:41 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: the user space object manager code seems to fragile
Message-ID: <20151114193040.GB14212@x250>
References: <20151114180109.GA14212@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20151114180109.GA14212@x250>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Sat, Nov 14, 2015 at 07:01:09PM +0100, Dominick Grift wrote:
> I want to bring to your attention that the user space object manager
> functionality/code of selinux is fragile and is a challenge
> 

Okay my apologies, this particular unordered class issue i just mentioned was my
fault. I accidently declared the access vector in a non-. namespace

Still though:

- - (old known issue) dmesg does not print unknown user space access vector
  handling. so it not easy to detect

- - dbus fails (even in permissive mode) because dbus object is not
  declared and selinux is enabled

Video of me troubleshooting this issue:

https://www.youtube.com/watch?v=FK-wnweI4YM

I still believe the user space object manager handling could be improved
a great deal.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWR4vcAAoJENAR6kfG5xmcnw0MALvLVhLObPxqpROkiXHLqapP
x/sLU1te+g+uivW5D8iFWGOa9vjhxdb6AQtwOhRb1ogR+irx0FU9waoVoyPih1NE
UExWr9cmDQIGm3MxUQiQ/fDBnp7sMO9XgXAtJun0IKssog5hZnjprR72a3gXagWM
tS/LipF9oQY/sUW6/7p8XPuU/OtOcR3MnYTxmSCDBi0nEis7tvHrLmTTUq3MonxT
qacVv9ztoed3RSZxXjm30xR7xcwkapD1nKgnEOCLlKuwmCm2istgtp88HlwO/+ps
hXrFWAbFneBp8BQnMEbJ6rr9jKzoo+BKfk89hZOmnO2IJJ0YE3vr+4U9p59qsV+Y
FPloB4si8HMqM+OrRL3woNkZk00hDlrK3Bvxe88j8ynMOLV7f2hBdavgVc8fAyuJ
yaBoQbt+r6Dh9fwWEs0vjFZTqY3Hy2GGceIa7QrpFSRwEzZX2dhbFGFD4Ls8M69A
z1NLlgZrdiHyeyFrri83OUPs4PqeevTa5W7xt1lLKg==
=mPKd
-----END PGP SIGNATURE-----
