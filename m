Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAUGnfpT031695
 for <selinux@tycho.nsa.gov>; Mon, 30 Nov 2015 11:49:41 -0500
Received: by wmww144 with SMTP id w144so145751388wmw.0
 for <selinux@tycho.nsa.gov>; Mon, 30 Nov 2015 08:49:36 -0800 (PST)
Received: from x250 ([84.245.63.179])
 by smtp.gmail.com with ESMTPSA id 186sm22296025wmv.9.2015.11.30.08.49.35
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Mon, 30 Nov 2015 08:49:35 -0800 (PST)
Date: Mon, 30 Nov 2015 17:49:33 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: redhats influence is hurting SELinux in GNU/Linux
Message-ID: <20151130164932.GA3693@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I am frustrated.

Redhats' influence is hurting SELinux in gnu/linux.

Redhat does not value integrity in the Desktop. First they
basically destroyed the meaning of confined users by basically not
embracing least privilege. They managed to push some of that upstream,
forcing me to go my own way since integrity in the desktop is
important to me, and refpolicy could not provide me with a useful base
due to redhat influenced policy that creeped in.

Now they are taking the SELinux object manager out of systemd --user.

This means that eventually we cannot control which processes can
start/stop/status/signal which processes in the desktop (thus we are stuck with an all
or nothing situation)

I tried to stop this but no one came to help. They lack vision, and only
think about their own well being. Other distro's will be forced to go
the redhat way, unless they fight this. Which is near impossible when it
comes to systemd since that is redhat owned.

https://github.com/systemd/systemd/pull/2053

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWXH4YAAoJENAR6kfG5xmcGUIMAIPanszs7X7DBXPQdZ2IjzWp
laB75N7D0mnMhXy0wf/d4Y2cStdGZrOnAyhDodMKCdZr22Gmu3qJLY5IIDv87dFg
6GYeN1EnHEboTXIlO8hDNR0GbPwAw8PAKssn01yiIZN/w+J5thRbShitLyT7rupZ
VnVXYWvWGxbeOwz7QEss3iehmUQjCaawO4BIgULW2tlacofwc5KgMlpKa/vSSMd9
7Rd4GhcDSjZdipzO10QI7gB6fc7jX8ToHkm6r0yeFs1SA0NdMeE5+oktWiej5ADg
VMJQIiRAmpoi1CF4UO+hDzeaQ3DVxmzJKHwgPlCqdopUm9t1xKhSaa87uJS4YDHo
xBNC9Ra10BuUTVMlr81EAOIf+taCjydMx/5IoX/Nq/OxK6tFEEL6GDsqT3a45ySM
vvwbr1RvOpgqp/eltkdMiOmQuqqxhre3aEjaNktWBPf+vMSOJqBX+k945tFlkqiw
g8APDrpMNhFZ8b1MvxjisVefS9pRew37eYFzaaC/bA==
=JsJZ
-----END PGP SIGNATURE-----
