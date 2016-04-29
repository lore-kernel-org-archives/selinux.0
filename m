Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3TH47Qm014309
 for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2016 13:04:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id e201so6284702wme.2
 for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2016 10:04:08 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id cf6sm15701311wjc.12.2016.04.29.10.04.06
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Fri, 29 Apr 2016 10:04:06 -0700 (PDT)
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Subject: userspace object managers get confused if an update changes object
 classes and access vectors
Message-ID: <d7fef34c-0b38-63f3-4a37-464930a03806@gmail.com>
Date: Fri, 29 Apr 2016 19:04:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


I have mentioned this before (probably a few times), and i am not sure
if this issue is actually what i think it is but i will once again
mention this issue i observed many times.

Excuse me if i am wrong here.

https://bugzilla.redhat.com/show_bug.cgi?id=1331668

https://github.com/fedora-selinux/selinux-policy/commit/971e97a2b8cbcc14
3fc82badfaaf7900b4760399

When you change (user space?) access vectors then user space object
managers get confused and stop working. This is now becoming an issue
since core components are object managers (systemd/dbus)

So basically there is no way for distributions to add/remove access
vectors without breaking the running system.

The only solution is immediately switch to permissive mode and to
reboot the system after such an update. And you might not even be able
to cleanly shutdown due to these confused components

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXI5QBAAoJECV0jlU3+UdpK6gMAI5Z411M+tp+x9H9N1tSFNdU
MRbVLJG1McRNSHzZfYSf1YcxEX3q4Qnewzn+470WtCskdDiRiQlUnGgdxC53UdYr
0mxci47agkbcUkm5533xGIfhdv2oNDD/0G6dVKSX09ioy2OF1Gc4piQ0FdcXLbBK
CxvbF1YYRFsinN1avjIbshDrsHsBfOaQxKULLOgnHHDml2jwna2twWw5SGvUtiq2
YeOo+k74MVn9+JCOUPbbrmmPortdgWFuxaAwKNurcahlwms74HHLL+2knRJ5u6R1
jLLGuGlX0zEM/8aA7CKM8xEk8JP/ZmYxcsIeXC+L1u04oK4/fWZ63YhleQcYcj+L
GNAg7pLcNltkbGioLWZZdJCcM7M9mO/O9gNe0PowKK9znQPVzx4yxEHTG1ks+jEy
1+l0V/ggXSuqFcD6TaxG07VKH27MuAJxtECvdZ5Rdtl5C9qrz93PRr+Hr1GKO3v7
Ip6k1PQi96aq8wQQUv8O+tGm85T7uBcZltdzLL1ysg==
=GfNX
-----END PGP SIGNATURE-----
