Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAEI1JVA006267
 for <selinux@tycho.nsa.gov>; Sat, 14 Nov 2015 13:01:19 -0500
Received: by wmec201 with SMTP id c201so69791089wme.1
 for <selinux@tycho.nsa.gov>; Sat, 14 Nov 2015 10:01:12 -0800 (PST)
Received: from x250 ([84.245.63.179])
 by smtp.gmail.com with ESMTPSA id t126sm9826985wmd.18.2015.11.14.10.01.11
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Sat, 14 Nov 2015 10:01:11 -0800 (PST)
Date: Sat, 14 Nov 2015 19:01:10 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: the user space object manager code seems to fragile
Message-ID: <20151114180109.GA14212@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I want to bring to your attention that the user space object manager
functionality/code of selinux is fragile and is a challenge

Why now? Now fundamental components of GNU/Linux are user space
object managers (systemd) and some other components that were already
user space object managers for years became fundamental components in
GNU/Linux (dbus)

Some small fragments from a systemd.conf youtube video

https://www.youtube.com/watch?v=kUWvSXEHMhU&feature=youtu.be&t=580
https://www.youtube.com/watch?v=kUWvSXEHMhU&feature=youtu.be&t=1137

I already have been experiencing strange behavior with user space
object managers many times.

For example, on one system i have, it works inconsistently (i have to boot
the system multiple times to get the systemd and/or dbus user space
object manager to work)

Just today i hit another such issue when i tested the CIL unordered
class functionality

It seems to work fine in some cases, and in other cases it doesnt work at
all (even in permissive mode!?)

The access vectors are in the policy but for some reason the components
are confused.

To reproduce: install a fedora23 minimal server, add yourself to the
wheel group and run this script:

https://raw.githubusercontent.com/DefenSec/selinux-rpm-spec/master/scripts/dsspbase23

what it does is it installs my dssp policy with only the base. since the
dbus access vector was relocated from base to dbus.cil it is not present
in the this policy.

The policy denies unknown access vectors by default, thus i added
the dbus access vector declaration to the base.cil addon module (a
separate module to make the sole process context "unconfined")

The access vector ends up in the policy however, dbus gets confused
for some reason, and since for example firewalld wants dbus, that fails
and systemd freezes ( i suppose that may be some kind of security
feature ).

The user space object manager code should be made more robust, and/or it
should be better documented because clearly developers have a very hard
time using it properly.

The decision to support user space object managers was made long ago, but
in my view it was never really carefully thought out, or received the
attention it deserves.

The fact that we only just now support unordered access vector
declarations proves the above point I believe.

It is a fundamental requirement for this functionality.

Thank you for reading

(p.s. this is not about unordered access vectors, that was just one
example. this is about libselinux/user space object managers)

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWR3bgAAoJENAR6kfG5xmcyIkMAMOTkUy2HOG6BmS+bhNv5YBV
s43WbqT74tQChazb7ISlKpqerRdjoiPQIS/LCSkanq3kVce6XYWn4ridYAFjmiXF
ds0Y5mlFeZUQtgzqVWIqMO2IrisdlBzV4w0xuJKwcanTmOCHZFLbz5kMJPqdoMHm
BvV4IAJWX8vLIEL8kdsynNgto7N2W0jV/bNIOUmZM4ltUaeiLvpQdPXXboEDQ04x
dxj4BLAEcJnvskLrnjgrhWXS/ILsN+pKGPha//Aa1TYG7OlGDK1W6WPt5y0/gJ1t
Hx2fTTT/bGHD4fJb96/IFnkDk1YVRsu4m801vqY7/MrITbh/yfj3XzqqkEKHBgBv
JwSXEZgX9I6Eg4F8buJn1R3IbMH04PtjplfZqYbKWXlikQfAacUCyrtqbOQtNHHs
j+SDhv9m+awbk0K2m2FJ2NwjnDfNd7WaTTK4Tw2FOutm+sgUrwIfro1t/Kah2ATC
Xt9XvAI4hQeNSyE5b6KlTs0hOuFsj8JUekFNo0AAng==
=XNSa
-----END PGP SIGNATURE-----
