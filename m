Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBI8kDvb002032
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 03:46:13 -0500
Received: by mail-wm0-f42.google.com with SMTP id l126so54395246wml.0
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 00:46:09 -0800 (PST)
Date: Fri, 18 Dec 2015 09:46:04 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Hannu Savolainen <hannu.savolainen@huawei.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: security_bounded_transition fails
Message-ID: <20151218084603.GA26456@x250>
References: <B295455A1EDEE541907F53334176EF68070002FE@lhreml504-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; x-action=pgp-signed
In-Reply-To: <B295455A1EDEE541907F53334176EF68070002FE@lhreml504-mbx>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Dec 18, 2015 at 06:12:21AM +0000, Hannu Savolainen wrote:
> Hi,
> 
> I'm having a problem with a multithreaded application. It does lengthy  initialization in advance under relatively privileged context and then switches to a less privileged one after the moment when the actual request arrives. After that it will create a chrooted container and join all threads to a new SELinux context.
> 
> However the transition fails with audit message "op=security_bounded_transition result=denied oldcontext=old_context newcontext=new_context".
> 
> Is there any policy rule that could be used to fix this or is this just not supported?

I believe that the parent domain should have the same permissions as the child
domain (because the child is bounded to the parent).

This can be pretty painful to deal with.

For example: if the child domain should be able to bind tcp_socket to
http_port_t type port objects then so should the parent.

That one would be relatively easy to identify. There are other
instances though that are harder to spot.

Eventually, once you dealt with all the requirements, those bounded
messages should dissapear.

> 
> Best regards,
> 
> Hannu
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

iQGcBAEBCgAGBQJWc8fHAAoJENAR6kfG5xmcNIYL/0QwzDxZvDbwNZTSVK/9mtYx
ODf2f2YON6DED/3hrX1bFvC/5Gho3j5Wobp/Muh25kRRPP+49JN0FmtePIClWNVE
4Jp971AMwHF2XvYjwH4876rXIyjEfj0s2yA4f3ULB1XbPKg3go8Pwj1EHeb0k9qw
uXEODV1a/5IFoDZ2p76rieQCpdSgu0L8tWr2YOJWb8iKY1hG7FPjwLqxRma8jNrv
7vX9q+Vmb1b+06jX2ooqJ1z4tB8LruqWImxqIGUCcNvqKCAIhDyByqLprVZfA7S7
9Hvrqed1xxXSpv5Lq84ycm85Ny2S60vvaJz32lqe7nEQPC/ep2O40j3/USqqSPpS
8sVwRNAWowE2OCJ7ePRPig6kFuH5nN4/Xvb9yZr3/o26eIhqMhFEmN5dzBywSSan
YLsgOWj8FNoterdFGZaiE8r+wKGXZ3ua5zwqlOX/BOIHOKkLnUSwQcDdUgUTipEn
r8keY7+tjOIEIQftNon3rVvzCeQcTaJfheZj0mEQOA==
=m57I
-----END PGP SIGNATURE-----
