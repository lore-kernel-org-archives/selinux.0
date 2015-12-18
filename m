Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBIAL5v2008660
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 05:21:07 -0500
Received: by mail-wm0-f41.google.com with SMTP id p187so58576121wmp.0
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 02:21:00 -0800 (PST)
Date: Fri, 18 Dec 2015 11:20:57 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Hannu Savolainen <hannu.savolainen@huawei.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: security_bounded_transition fails
Message-ID: <20151218102056.GB26456@x250>
References: <B295455A1EDEE541907F53334176EF68070002FE@lhreml504-mbx>
 <20151218084603.GA26456@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; x-action=pgp-signed
In-Reply-To: <20151218084603.GA26456@x250>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Dec 18, 2015 at 09:46:03AM +0100, Dominick Grift wrote:
> On Fri, Dec 18, 2015 at 06:12:21AM +0000, Hannu Savolainen wrote:
> > Hi,
> > 
> > I'm having a problem with a multithreaded application. It does lengthy  initialization in advance under relatively privileged context and then switches to a less privileged one after the moment when the actual request arrives. After that it will create a chrooted container and join all threads to a new SELinux context.
> > 
> > However the transition fails with audit message "op=security_bounded_transition result=denied oldcontext=old_context newcontext=new_context".
> > 
> > Is there any policy rule that could be used to fix this or is this just not supported?
> 
> I believe that the parent domain should have the same permissions as the child
> domain (because the child is bounded to the parent).
> 
> This can be pretty painful to deal with.
> 
> For example: if the child domain should be able to bind tcp_socket to
> http_port_t type port objects then so should the parent.
> 
> That one would be relatively easy to identify. There are other
> instances though that are harder to spot.
> 
> Eventually, once you dealt with all the requirements, those bounded
> messages should dissapear.

Here is one more not so straightforward example.

You may have a auto type transition rule in place that tells selinux that the
parent should run the child's executable file with a auto type
transition to the child domain.

That means that the child's executable file type should be a entry
object to the child domain type.

You allowed for example:

allow child_t child_exec_t:file entrypoint;

That means that child_exec_t now also must be a entry object to the
parent domain type:

allow parent_t child_exec_t:file entrypoint;

Else the transition might not work because the parent must have all the
permissions that the child has.

> 
> > 
> > Best regards,
> > 
> > Hannu
> > 
> > 
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> -- 
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> Dominick Grift

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWc94EAAoJENAR6kfG5xmcLD8L/0M4k0o66EvwUNdDpGasV71j
f74DgZpBaJnrIWqGIBG6TwNy7ZPqbuFn931jds5GLc40lLXRRl4f2E/yBtfrrmzH
O0lcTzWK4HUKrYULQY0pg8uBUV9E2EDs4umi603bXfarzB8Aio4PhooRIIOaOBBS
vdSfqQER6FcYGdHtoFFsdvcAYNhLLLbH6q0LcHtYym3zQ02Fmmv1NJroQOaV08wr
sA6LI97nmLt285YnRODm/AJwTj21FUsSKcntDRFX99doy09EGOeEjv7vU9tZPaze
nxtsSEEYqjjGQAOE9NWXcGDFwBWw4udgNvYH5S88XZvhhto9w8BDF2x+czPTX6MC
32h4qTI3wkZ8GTaws2AsghupA521cHs6Uhh4S1qen5shywzBOQJroNJiM/FhzvnC
m7IGK4EwvBty2cRld/yforBKsSRiwsvVgsarPJQfEKmO+3W4ivLCZyB5ucRYxqiI
69DpQ7NeNyJ3bSQswWpCnPj8MNwMQIkTFjjDGVO7cg==
=YeKh
-----END PGP SIGNATURE-----
