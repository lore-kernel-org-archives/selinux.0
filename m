Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2DI2h7x031926
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 14:02:43 -0400
Received: by wesp10 with SMTP id p10so24944556wes.11
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 11:02:40 -0700 (PDT)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id r14sm3781597wiv.13.2015.03.13.11.02.39
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Mar 2015 11:02:39 -0700 (PDT)
Date: Fri, 13 Mar 2015 19:02:38 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: selinux category relabel (puppet)
Message-ID: <20150313180237.GA9437@linksys-wireless-usb.network2>
References: <2409d98630af4bc39108524e04557017@VNUCITEX02.ICFI.icfconsulting.com>
 <55032105.1030903@tycho.nsa.gov>
 <103dc46dd5b34fa5a752edce40d20e01@VNUCITEX02.ICFI.icfconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <103dc46dd5b34fa5a752edce40d20e01@VNUCITEX02.ICFI.icfconsulting.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Mar 13, 2015 at 05:52:37PM +0000, Higgs, Stephen wrote:
> > On 03/13/2015 09:52 AM, Higgs, Stephen wrote:
> > > Hello all,
> > >
> > >
> > >
> > > If there is a more appropriate forum for this question please let me know:
> > >
> > >
> > >
> > > I have a system that uses confined users by default and some files are
> > > managed by a puppet server.  When I run (via run_init) the puppet
> > > startup script, I get the following avc log:
> > >
> > >
> > >
> > > avc: denied { relabelto } for pid=30707 comm="puppet" name="crl.pem"
> > > dev=dm-1 ino=527257 scontext=system_u:system_r:puppet_t:s0
> > > tcontext=system_u:object_r:puppet_var_lib_t:s0:c0.c1023 tclass=file
> > >
> > > I added "typeattribute puppet_t can_change_object_identity" and
> > > appropriate "allow" statements to the puppet_t type after reading the
> > > constraints in the targeted policy. However, it was the category
> > > "s0:c0.c1023" that was also preventing puppet from relabeling the
> > > crl.pem file.
> > >
> > > I was able to fix this by manually relabeling the file to "s0" instead
> > > of "s0:c0.c1023". My question is, how *should* I handle this so puppet
> > > can handle the relabel of the category?
> > 
> > It requires an appropriate attribute for the mcs or mls constraint that is
> > blocking access.  Which attribute depends on your policy; MCS in particular has
> > changed a lot over time in Fedora and RHEL.  What distro & version?
> > 
> 
> I'm using CentOS / RedHat 6.6, targeted reference policy 24.

I do not see how it makes sense in the first place to relabelto s0:c0.c1023, might as well keep it s0.

Any idea why puppet is trying to relabelto s0:c0.c1023? Is that specified in your puppet configuration?

Also it may not even be constraint issue in the first place ( i doubt that puppet is mcs constrained ).

maybe you just need a rule like allow puppet_t puppet_var_lib_t:file relabelto;

what does audit2hy tell you when you pipe the avc denial into it's input stream?

> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVAyY5AAoJENAR6kfG5xmcQQ4MAMw2osxY36pxWmoDyu7PD6YK
NPjYB9bSU0fErvgVTVsCcjVmTemfSzJO4LitapfZMvzK0Ppe1ArwxQcSrOC+52qf
BvMmiKVnqgwDYmsqEDJBhQqB3iQqqrdKWC0LzyjzTV9Tbop9Aarad7NXJJg3Js9u
btI0AKeaZ8vP9Sn0pJflzqaX+BjEhl0bJjYN9X6CQAWA8AsVopkZcfgpxYAuHw99
NQQxTsXABzH9aqDFdkD+EdgOBz46y9DebOePAW8w+uXuHU8S2abkPx2sVBj4YQO6
/R0kaNx1ltD/7Iq59xgig1Xq1pv1WhYCQkx8LmzAuip9UMl1b6wiBQtGjZFVMFoJ
E/CdA95GF7q3w+NcVhdrDLrKAldmRCsc3Y4j7wA4nQFna7Yys2HzOmn0yeQa224s
55/KyCN0hF39o3mo4zYlEf52wi+0cfNzTvwDpui0uR0uZwkggps8nc/Bno7ZZBLD
QSuu63MTbLCGtb1IKGZLRQAehoPBIYqeg0w6R0M1Lw==
=QarR
-----END PGP SIGNATURE-----
