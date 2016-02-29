Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1TKFe22015530
 for <selinux@tycho.nsa.gov>; Mon, 29 Feb 2016 15:15:40 -0500
Received: by mail-wm0-f51.google.com with SMTP id l68so5018295wml.0
 for <selinux@tycho.nsa.gov>; Mon, 29 Feb 2016 11:14:09 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id k4sm17708368wmc.12.2016.02.29.11.14.04
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Mon, 29 Feb 2016 11:14:04 -0800 (PST)
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Subject: should setfscreatecon be able to override auto type transition rules?
Message-ID: <56D4987B.2030001@gmail.com>
Date: Mon, 29 Feb 2016 20:14:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I encountered this today and it got me thinking. Should this be happenin
g?

I would think that a auto type transition rule should always take
precedence, and that setfscreatecon should only be honored if there is
nothing in policy overriding it.

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW1Jh2AAoJECV0jlU3+UdpRAoL/RYFDoPGp7uXHIMa0mew15aj
DcRHiT9M5V7Zzl2Cokr8YFpzR7VD8KIrxu29hVvACv7jza/oJJTGrxRh8MscOHGz
sZDGR43HoaOMMUJVZYIX7jYEfg0zr0lcZnEeBqYWQVoG/HFcyNQWZk/ncffIZmen
8u8QCTLkLk3PIcZuK13YPZ+V56OY07nYtOSH9pIJ03Gm5hy1BSZxkuz8DNhnLpKo
e24syQS91qb35sHvZOETrv7q9OY9W3O6nr5yTefGUTe98eMPgYcPDE8s0i3XBfXZ
tQQW7FdD3SKbCW440RD1V8VaWTZb+fmh2jLO4DlVS0l2IwvIFpt9Tqfz0217QWIJ
O5dUK1p9LN8DhYAfPAQSUs6dtECVxhzMYbKXP27f449B6XuBwQSODVIr9KEgm6Nm
SUkEwggWlAOoNJ/HlOuoOuJZSefXvvdUt09pXY5eoUcejx6Dj243D4eoU7ZogLVB
Y8AzY3xoBg7xhk3beEd1TXTphI3pdSyieN5Z49o2Zw==
=vgkv
-----END PGP SIGNATURE-----
