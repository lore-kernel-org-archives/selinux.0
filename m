Subject: Re: strange pam_selinux behavior
To: Daniel J Walsh <dwalsh@redhat.com>, Miroslav Grepl <mgrepl@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <56F2D938.8030909@gmail.com> <56F2E136.6090304@gmail.com>
 <56F2E276.9070702@gmail.com> <56F2E999.1070904@tycho.nsa.gov>
 <56F2E9F0.7040905@gmail.com> <56F2F163.5060309@gmail.com>
 <56F3E833.4090504@redhat.com> <56F3EA88.1020703@gmail.com>
 <56F3EBEF.7050808@redhat.com> <56F3FA39.6080003@gmail.com>
 <56F4512A.8080507@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56F45386.9020000@gmail.com>
Date: Thu, 24 Mar 2016 21:52:22 +0100
MIME-Version: 1.0
In-Reply-To: <56F4512A.8080507@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/24/2016 09:42 PM, Daniel J Walsh wrote:
> 


>> 
> I think this check is checking contains.
> 
> class context { translate contains }
> 
> 
> 
> The idea was you could run a system that only went up to Secret
> level, then if a user attempted to login as TopSecret he would be
> blocked.  I think that is what this check is all about.
> 
> 
> 

Thanks, this fixed it!

However, i suspect though that all this stuff is broken. because like
i said i have been using mcstransd since recently and noticed that it
was not checking that access vector at all.

sds found some code in the mcstransd repository that indicates that it
is still is used. Maybe then something is broken? would be nice of
someone could confirm whether anything is actually checking this
access vector or not.

Also this unconditional dependency on a user space access vector is
kind of dubious to me. Would it be possible to do without it?

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW9FOBAAoJECV0jlU3+UdpPs4L/3yMMsragSJkF/rLTurmDH0F
+pSJY7f5hsvIt41I2nO1UE3XywIx1r7DtSBUenW3VO86ZwUfTAGcqOj2P2YzGRJy
Y7ZDDwVKXR0kKgqJrvPTTiWGRbYR4GX+mwa0OsS6mpnr8oJHA554zAqEcP77xWE+
EvmsObrYFrTRTIbhaK+qG96nRiSthxrZT/mAPz3aPlfOQ4EmVCsOwvepRQg6XbsF
XQArapj1gRiNFkXHvYrPeNjkUaflETZWoZTnuIBtBHLP5giSRGiwUqKkC9+tDoyJ
A15NuAWZCMD1PkVg8L9dyr4J8fahoK00WnoqqjdOnWDOPymjixW7HM2JvleigG85
vCDoqYYDdJi/2G6R8vJucNQzGS8eagi5zvuR2+nltm7/pSgn2ZyHY6IZwvjv0csS
m6asoTIOPoX7HhIZX78KR2ZijrhsLyd63TFc38YnnDDML81Gwg/7DS+SAthX6wzO
dXVCIIUIHQmIa/lVnYj/p57gw5qWfSo1+qldlUdxng==
=nVaV
-----END PGP SIGNATURE-----
