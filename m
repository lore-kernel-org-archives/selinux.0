Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1JKmk5R027278
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 15:48:46 -0500
Received: by mail-wg0-f47.google.com with SMTP id x12so9555277wgg.6
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 12:48:43 -0800 (PST)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id hd5sm35786211wib.21.2015.02.19.12.48.43
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 19 Feb 2015 12:48:43 -0800 (PST)
Date: Thu, 19 Feb 2015 21:48:41 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: MCS error
Message-ID: <20150219204841.GA1649@linksys-wireless-usb.network2>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20150219193337.GC12937@tracyreed.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, Feb 19, 2015 at 11:33:37AM -0800, Tracy Reed wrote:
> On Thu, Feb 19, 2015 at 07:40:48AM PST, Dominick Grift spake thusly:
> > The MCS implementation has been changed a bit over the years on the policy side.
> 
> Is there a RHEL 6 version of the link I pasted below with up to date info?
> Lack of documentation and frequent changes rendering documentation obsolete
> combined with the inherent complexity of something like this are the main
> issues holding back SELinux adoption.
> 
> > Back in the earlier day's MCS was enforced on all proceses in redhat distro's by default
> 
> Yeah...I actually had it working in a test setup in RHEL 5 but never got it
> deployed widely. Now we are trying to redo it with RHEl 6 and running into
> issues.
> 
> > Nowaday's that is no longer the case, and you need to opt-in for it by associating the mcs_constrained_type type attribute with the type of the process to constrain.
> > 
> > In rhel6 this attribute name does not exist i suspect. It was renamed to aforementioned later.
> > 
> > A seinfo -a | grep mcs might reveal the type attribute used for the same in RHEL6. (i think its something with trusted or untrusted, dunno for sure)
> 
> I don't follow this part... The seinfo output is:
> 
> # seinfo -a | grep mcs
> mcssetcats
> mcswriteall
> mcskillall
> mcsreadall
> mcsnetwrite
> mcsuntrustedproc
> mcsptraceall
> 
> How do these type attributes relate to MCS?

The mcstrustedproc type attribute makes a specified domain type mcs constrained.

You can associate the attribute with a domain with the type_attribute statement:

type_attribute type attribute

so something like this (where the type associated with the app to constrain is "bla_t"

sudo yum install selinux-policy-devel

cat >> mytest.te <<EOF
policy_module(mytest, 1.0,0)
gen_require(` type bla_t; attribute mcsuntrustedproc; ')
type_attribute bla_t mcsuntrustedproc;
EOF

make -f /usr/share/selinux/devel/Makefile mytest.pp

sudo semodule -i mytest.pp

> 
> -- 
> Tracy Reed



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

iQGcBAEBCgAGBQJU5kwkAAoJENAR6kfG5xmcrwMMAMrUlM9elnpcPcJ2TvQgesNz
Zfg1RjnjUXiQdkSOWWcv1Kfw8Nwt9ZbGVlReD6o4OuTtIBI5MJ+QlsquFn8N9SGm
GP/pnEGWI2QnVbEWaR0wBwX1Z8mLiaCBS68VG2Zwq9+SNRnIp3TYQxN72N5HigHa
I0oIXNDeRENbTDebSCHd/0pTKlOBMGx+RJPPRiA4lCDRz++VQ7Fbl+8f9TM+1Apa
Q3dxaolczTfhxiVd/CJkoDu0J7DxvUqTxjAqH/8+3Vu+XPsYWRxIWeoTpgdfWVSa
fqvYVZy/OpHx+LrR/NW9x3fmuKDCZZs4FRudcgXawADdyg8P0yTclpST6F3vaSJu
BqTSzV++vPwLUoMEwDty8mi40FeLS27JE3Y1gFTTQGxYohGoM+kefDe6+c3c1uEJ
nlwPpHVOrvM07TFoANOH8ZneNNxguE6WmdetCBQoHDfhUi0saqeb5NBhYt0Q4bmN
l1fhBsckrpbXKVlsLXDv7YlZUOnvPIDWovkp4B5lXg==
=qW3j
-----END PGP SIGNATURE-----
