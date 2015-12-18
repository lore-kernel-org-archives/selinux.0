Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBIF57A6030426
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 10:05:08 -0500
Received: by mail-wm0-f52.google.com with SMTP id p187so68569980wmp.0
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 07:05:05 -0800 (PST)
Date: Fri, 18 Dec 2015 16:05:01 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Hannu Savolainen <hannu.savolainen@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>, selinux@tycho.nsa.gov
Subject: Re: security_bounded_transition fails
Message-ID: <20151218150500.GE26456@x250>
References: <B295455A1EDEE541907F53334176EF68070002FE@lhreml504-mbx>
 <20151218084603.GA26456@x250> <20151218102056.GB26456@x250>
 <20151218104500.GC26456@x250>
 <B295455A1EDEE541907F53334176EF68070003D0@lhreml504-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; x-action=pgp-signed
In-Reply-To: <B295455A1EDEE541907F53334176EF68070003D0@lhreml504-mbx>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Dec 18, 2015 at 11:27:13AM +0000, Hannu Savolainen wrote:
> Many thanks,
> 
> Adding the allow rules seem to be enough (have to verify that one more time next week). Fortunately the typebounds rule doesn't seem to be necessary since it triggered avalanche of dependency problems everywhere.
> 
> Best regards,
> 
> Hannu

Cc: selinux list

I suspect though that you eventually really need to add the typebounds
statement.

Also one thing to keep in mind is that what I said before also applies
to permissions where the bounded domain is the target. This, atleast to
me, in the beginning was a little confusing.

Example:

if you have this requirement:

allow somedomain_t child_t:processs signal;

then this is required:

allow somedomain_t { child_t parent_t }:process signal;

> -----Original Message-----
> From: Dominick Grift [mailto:dac.override@gmail.com] 
> Sent: 18 December, 2015 12:45
> To: Hannu Savolainen; selinux@tycho.nsa.gov
> Subject: Re: security_bounded_transition fails
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> On Fri, Dec 18, 2015 at 11:20:56AM +0100, Dominick Grift wrote:
> > On Fri, Dec 18, 2015 at 09:46:03AM +0100, Dominick Grift wrote:
> > > On Fri, Dec 18, 2015 at 06:12:21AM +0000, Hannu Savolainen wrote:
> > > > Hi,
> > > > 
> > > > I'm having a problem with a multithreaded application. It does lengthy  initialization in advance under relatively privileged context and then switches to a less privileged one after the moment when the actual request arrives. After that it will create a chrooted container and join all threads to a new SELinux context.
> > > > 
> > > > However the transition fails with audit message "op=security_bounded_transition result=denied oldcontext=old_context newcontext=new_context".
> > > > 
> > > > Is there any policy rule that could be used to fix this or is this just not supported?
> > > 
> > > I believe that the parent domain should have the same permissions as 
> > > the child domain (because the child is bounded to the parent).
> > > 
> > > This can be pretty painful to deal with.
> > > 
> > > For example: if the child domain should be able to bind tcp_socket 
> > > to http_port_t type port objects then so should the parent.
> > > 
> > > That one would be relatively easy to identify. There are other 
> > > instances though that are harder to spot.
> > > 
> > > Eventually, once you dealt with all the requirements, those bounded 
> > > messages should dissapear.
> > 
> > Here is one more not so straightforward example.
> > 
> > You may have a auto type transition rule in place that tells selinux 
> > that the parent should run the child's executable file with a auto 
> > type transition to the child domain.
> > 
> > That means that the child's executable file type should be a entry 
> > object to the child domain type.
> > 
> > You allowed for example:
> > 
> > allow child_t child_exec_t:file entrypoint;
> > 
> > That means that child_exec_t now also must be a entry object to the 
> > parent domain type:
> > 
> > allow parent_t child_exec_t:file entrypoint;
> > 
> > Else the transition might not work because the parent must have all 
> > the permissions that the child has.
> > 
> 
> Also you should have a type_bounds statement in place if you do not have one already:
> 
> http://selinuxproject.org/page/Bounds_Rules
> 
> > > 
> > > > 
> > > > Best regards,
> > > > 
> > > > Hannu
> > > > 
> > > > 
> > > > _______________________________________________
> > > > Selinux mailing list
> > > > Selinux@tycho.nsa.gov
> > > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> > > 
> > > --
> > > 02DFF788
> > > 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> > > https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF7
> > > 88
> > > Dominick Grift
> > 
> > --
> > 02DFF788
> > 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> > https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> > Dominick Grift
> 
> - --
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> Dominick Grift
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
> 
> iQGcBAEBCgAGBQJWc+OoAAoJENAR6kfG5xmc6foMAKJMOYO/zj8/2vjsSQo9p4Tg
> voiLu5CtyMcPdHWie7C023Y0hMn6d3Pb76FoQeC3T+MUhKvmpRTJ/Ai1UBbjE/xQ
> MJx2dxDK9h6x2/JjdCRPo4WoZVFgQEhZvHJOcq6S54sJK0M91Pl1jIyFcTBks8YS
> vrluuqrTE7T4/Sv1uV8Bd2rU3VY6Q0oFO+PQXTml1bmelUa1eHpseG5r3MTliZoD
> FWmCSqrfZUQHc2oLecyLFn4MuNS21mj1e0pzRMXXrqTvzzcNcUryzEOdvVpik04a
> gQlmD5YDIyFfY9Hbhosc5Pv0/ayu/AfZe1SjAJk6yiVNWyeRCvYbtpzhPl/Z1lhf
> CQf6Fbrzby/rrBpkh2mlBTS5sgPizPIkM/nU9dnaz6Kb9po0WZSNqREvFqkISjK6
> QVK05g7FnMwiva6Sxhc0B1y3fN7hjohgQ/uDyo3L8CxGquPMrV8NL60RM3urhHwJ
> kx5dvI4ueNk/t8F31FgQhtYfn6ccZgs737Fb9L6pmg==
> =l8j2
> -----END PGP SIGNATURE-----

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWdCCYAAoJENAR6kfG5xmcm6wL/08Jp2AuCBt+VPfhNxSB7Ugn
V3hMQvqQpa0JlVUYQXXkL1203pYFxk00Us1j7YCBoNw5EbfyzkMd4uqrBvBDqv4H
S6Q5UOR0/H1gyFPqWvM2qY6DdVBUrC7U2ss5DQCPTf+OJC65QcxewDTTYTnIRhm1
NWyPUiIE3aO5NZ1U0xo4jXW+sKoLPC6oKZo8HKI3N77tkN0BDuDmSphED4P/gez5
FF6/R049pFLEHoGAhgQvIxlx8V99ZQM2FUcHoRf0Jq7+1F5v5A5Y19sRj/ppTGLB
r2g0T0qTFHKymSQsxdMiP/mdm7YpvtMmSCMUB5xX++jWHGBoB00NnGvPjuwL6D5I
p3mV0TmUMK+c5oXJMlLQP66UKro8sG7iMSKoup8ypUbvmWdd1rdTvBIzJRUraZhn
bzUjxQGrg6fHaNX7XME+n689SgBnv48yCYZwhu7ahjcFfil6ESlGZA4E3jSX2K1f
9yloGB150R0RMzc1Xl5XMol0Mhktd1ary0FiYfPWBA==
=lhPU
-----END PGP SIGNATURE-----
