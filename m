Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3QBS8h3022956
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 07:28:08 -0400
Received: by mail-wm0-f46.google.com with SMTP id n3so3096441wmn.0
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 04:28:03 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id jo6sm28390538wjb.48.2016.04.26.04.28.00
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Tue, 26 Apr 2016 04:28:01 -0700 (PDT)
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Subject: trying to understand a cronie issue anno 2008
Message-ID: <017f000a-3ecc-1e01-514f-a6106cfca8b9@gmail.com>
Date: Tue, 26 Apr 2016 13:28:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


I am trying to understand an issue

https://bugzilla.redhat.com/show_bug.cgi?id=426704#c20

"Suggestion:  load_user() to pass NULL if pw is NULL, and change
get_security_context() to handle a NULL name by directly calling
get_default_context() on "system_u" rather than calling
getseuserbyname at all. Then we don't need a system_u entry in seusers."

Is the suggestion above about hard coding "system_u"?

Also about:

"Then we don't need a system_u entry in seusers."

We seem to have the above anyway, even with the system_u hard coded.
Wondering whether it was left in for some other reason?

Cronie refuses to run in an environment where system_u is not
available when system_u is hard coded like that (i believe):

https://git.fedorahosted.org/cgit/cronie.git/commit/?id=e5280235809844f5
4d5956ec281472b63dcfc3f4

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXH1C7AAoJECV0jlU3+UdpE7kMAK2pbticmAvp5FKELXOoO+hX
eP0CvSFMHa34upu2AH4FJeJIv3JgJagLbBtRLPjJ9otRZbq6zh7HIPUJ9ltk+SI6
QwBAxr0/DDUhKNRU01v1A6S/FFAyt7m+YUZ1YUI7UHgFDkH0ox0F+XLuzwH8WbGy
YI1S+DONV46gW55GluBO7N7th44kunpAZ0slU4GpLzjfz+ScS0Y6GG/Fdnnb0hTz
M1/UeOi0bEqvUjJhTpvUiy5yu/xDPVhZ36cuBOG9hbTuBO7CIJvc0EnxXYBBIyPw
bwvPxUTumUTOsHSUFVJ9s61MCIZwzOngwIYPK9qs3EivgWC5Xg3jzOsVlxjBRMWZ
JVT1hO3gq0V9OqkmOFYH0hd0E9Q/bhqlXlOXXp89S2BJfhIUjtqq3tWbayO5wVMg
aUSyobadvn2XF35jt+gPXfoiTO0SC8VXJ905V5M9KNv0lKlu0wpo7/oQ3YUrO82/
GIwZhZAoYsT0afXNbZPYfzi2MpZUzTK4xzlyJlJFvQ==
=6/EC
-----END PGP SIGNATURE-----
