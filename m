Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2NFS08l002404
 for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2016 11:28:00 -0400
Received: by mail-wm0-f45.google.com with SMTP id p65so29199764wmp.0
 for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2016 08:27:53 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id u202sm22836879wmd.24.2016.03.23.08.27.51
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 23 Mar 2016 08:27:51 -0700 (PDT)
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Subject: does it make sense that dac_override get's checked before
 dac_read_search?
Message-ID: <56F2B5F7.9050406@gmail.com>
Date: Wed, 23 Mar 2016 16:27:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


A long time ago Eric Paris hinted that the policy WRT dac_override
could probably be cleaned up.

I suspect that most of the the time dac_override is not needed (too
coarse). Instead dac_read_search would be sufficient for the common
scenario where root processes traverse locations where it doesn't have
DAC permissions to traverse.

The problem is that dac_override seems to be checked first. but
dac_override , if i understand it, is broader than dac_read_search

so why is dac_read_search not checked before dac_override?

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW8rXyAAoJECV0jlU3+Udpn0cL/RLXUaoUX2RB4xXu38V1iUZV
bLBufRWG3IND7j+AvaSt7ARCgkaSrZpoVDbxhwqKQGmjU1fkbUIBAOug/9jNeLIK
ZjMeey4xZPEC908jfVtaJK6V8nldW/DiDhoH/6maXdd53Ta0+p1v5i8aw8zXgkyD
PQoAUHamZnyz51s+HCsW8NsGUYkepwmoZ5bBUkmjwcqOtpIXa47NDviiKzEeF4R+
Tsbim70zTgMEMrjVRqB+5GkIVSI1NKEAkER5JCPMeDsM5u075wkPX7ZWS37fKg9f
4CGLWjNoeokAkRI/rRBVTNDFEmxEIBzv93JYjkCxtqxOG8a39I5dT2FgiGyu4VQf
Rxi+DpQgKIQDB9qJgO3iOJYlPvihozxTc6X9mwzkfSbLG2fqQ8VPrl8v6A12zCTZ
BiMZhIFZUwF3x9GNMAizq2mMZsVMslxXkoExH/+Eyb3IEx7Wsy9z9/eYS0ES74e7
KQEODr5Otp6joiwObkPJX9THXn6C+SC8fYA5hUofVA==
=SCuN
-----END PGP SIGNATURE-----
