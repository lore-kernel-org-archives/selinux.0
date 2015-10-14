Date: Wed, 14 Oct 2015 16:11:02 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014141101.GB5222@x250>
References: <20151014133408.GA5222@x250>
 <561E5EF4.9080606@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <561E5EF4.9080606@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Oct 14, 2015 at 09:56:04AM -0400, Stephen Smalley wrote:
> On 10/14/2015 09:34 AM, Dominick Grift wrote:
> >
> >I had some issue that just confused me (to say the least) It seems that
> >I have now solved this.
> >
> >There were two policy.X files in my /etc/selinux/SELINUXTYPE/policy dir,
> >on 29 an one 30. The 29 seemingly had a bug in it.
> >
> >It seems that load_policy (or its libselinux equivalent) defaults to
> >the lowest policy available (29 instead of 30 in this case)
> >
> >Why is that?
> >
> >I fixed the issue by removing the policy.29 file (i think at least)
> 
> What policy versions were supported by your kernel (cat
> /sys/fs/selinux/policyvers) and by your libsepol (checkpolicy -V)?

/sys/fs/selinux/policyvers says: version 30, and checkpolicy says: 29 (compatibility range 29-15)

That is weird because i have the latest libsepol installed (atleast
pretty recent):

# rpm -qa {libsepol*,libselinux*}
libselinux-utils-2.4-9999.git5aeb4c3.fc24.x86_64
libselinux-2.4-9999.git5aeb4c3.fc24.x86_64
libsepol-2.4-9999.git5aeb4c3.fc24.x86_64

> 
> load_policy will try to use the highest policy version that is supported by
> the kernel or by your libsepol.  If supported by the kernel, it can just
> load the file directly.  Otherwise, it can use libsepol to downgrade the
> policy to the highest version supported by the kernel and then load the
> result.  If the version is not supported by either the kernel or your
> libsepol, then it cannot be loaded and it will fall back to an older
> version.
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWHmJyAAoJENAR6kfG5xmc4pYMAJ7Hw4aM4fVblCPTugdRru9m
OGWGS7Qk0i6EhuS49PsDOto/d40eU7nErcMNKCMozsvEpE9W9Jzmt5VsYSBGWz13
OdoQe9zKT2aPaBRWS14zAEJJxhKSdy9jPj81fuhYRyt1qAT+py7btT/0cAczh2Q6
rlUtnsC9b+0pf2Aqr66uBHMkcAUwTZs2qSBs5SATuIyt/E3bFPB82VMZKAyWTlw8
AHrzVWrr/L2yaVAynMW/XNu7swpMqvSh2vHTKXOgaFEzgMqYkKfGHPAhTR6TWET1
9fsiQhWwWmHmiGanFMdy4r3PpNPHlDyekckb8tZK5DKJyJk9tkMh03+7HuIyUSqh
zffsU8+eDXpnxp22Mz24qo1BIHIY8X0WKb8KXCwycBPEIw1x56JQw68+sLroT54z
DUJLAV9E1GQz0VKoMn+ADvOwtP4FUHSD1i0SKTcAIZ/TEAhhY2MdDcVCrbnC6kFA
NoS3AR9sk68IVeyaO2NdQwT8y9MzkfrsrECRG8I4SQ==
=Z/35
-----END PGP SIGNATURE-----
