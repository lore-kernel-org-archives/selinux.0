Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2SCrnLu000718
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 08:53:49 -0400
Received: by mail-wm0-f52.google.com with SMTP id p65so96090178wmp.0
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 05:53:17 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id js8sm24565699wjc.37.2016.03.28.05.53.15
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Mon, 28 Mar 2016 05:53:15 -0700 (PDT)
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Subject: CIL: invalid protocol (dccp portcon)
Message-ID: <56F9293A.6090902@gmail.com>
Date: Mon, 28 Mar 2016 14:53:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


I was adding support for syslog ports, and /etc/services indicated to
me that syslog(_tls) has support for dccp protocol. So tried to add
that support in.

However when trying to specify a portcon, secilc tells me dccp is an
invalid protocol.

e.g.

(portcon "dccp" 6514 port_obj_context)

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW+Sk2AAoJECV0jlU3+UdpstQMALrcdpqAQIFTKpQ7qmg9HZUE
ybu/cMobCNWWE+bfXs8+emaQtbm46f4FIwXnXkfVzkH0tnUV3+XrUytsT4K1iYFs
nVZsNBUxNuNb2RgRugeIYtdq03tsY74G5YtIOjjYESES2kcuZTcA24XeVqSuqqlF
nFvx4iwGAzJ4hQmhCk3PVZfvked/7dDDDt6XA+csYsbnKRnoJLiE5Wxm6LzCF/4n
itImypngR8/rNs9CKdJk0GSfkPKV+llAzn+w+ZgqeVlb3HiHe9rtUqhe8JsVfyax
NWjNAXOE5/cUABVC1rofvs1gmbe2/vu6PTvvFHiA0dtJ4yWMgiM1Mwn2SSMjbclA
qrkzfPmOakHlWzBd8ZZzHpboLJZ7V/9BI9Wi9guZnmBhHBzHi9VNmXFH6v3zkebU
ETFGVpEzR3cbyrA8QuDkee2YQeI53cvKz79hP1gPzANpG3HrPnTiX4ooobhfZz+k
1Cr1tXwKfVqXKTBRha7T7Kv78Al341m/RxlNmHs4vQ==
=iix7
-----END PGP SIGNATURE-----
