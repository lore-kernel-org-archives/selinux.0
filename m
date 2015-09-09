Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t899cQHA016881
 for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2015 05:39:13 -0400
Received: by wicge5 with SMTP id ge5so147459713wic.0
 for <selinux@tycho.nsa.gov>; Wed, 09 Sep 2015 02:38:05 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by smtp.gmail.com with ESMTPSA id m4sm9239272wjb.37.2015.09.09.02.38.04
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 09 Sep 2015 02:38:04 -0700 (PDT)
Date: Wed, 9 Sep 2015 11:38:03 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: secilc: any idea why this commit causes secilc to segfault?
Message-ID: <20150909093802.GA22288@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

disclaimer: although i have thoroughly tested this commit for typo's, i
cannot completely rule out that this seqfault is caused by a typo.

The commit that causes secilc to segfault:

https://github.com/DefenSec/dssp/commit/98b8a7950fed0a8e5eea74da42ab2b407dd47ec0

secilc core:

http://filebin.ca/2F2XLRSvBEGH/core.secilc.1000.1ae5ed764f334f32bebe30bffa3b414b.20553.1441789693000000.xz

coredumpctl -1 info output:

           PID: 20553 (secilc)
                      UID: 1000 (kcinimod)
                                 GID: 1000 (kcinimod)
                                         Signal: 11 (SEGV)
                                              Timestamp: Wed 2015-09-09
                      11:08:13 CEST (13min ago)
                        Command Line: /home/kcinimod/bin/secilc
                      --policyvers=29 -v
                      /run/user/1000/dssp/sources/support/misc_patterns.cil
                      /run/user/1000/dssp/sources/support/ipc_patterns.cil
                      /run/user/1000/dssp/sources/support/file_patterns.cil
                      /run/user/1000/dssp/sources/support/class_permissionsets.cil
                      /run/user/1000/dssp/sources/standard/policy.cil
                      /run/user/1000/dssp/sources/standard/macros.cil
                      /run/user/1000/dssp/sources/standard/constraints.cil
                      /run/user/1000/dssp/sources/rbacsep/policy.cil
                      /run/user/1000/dssp/sources/rbacsep/macros.cil
                      /run/user/1000/dssp/sources/rbacsep/constraints.cil
                      /run/user/1000/dssp/sources/policy_capabilities.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/wodim/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/wodim/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/wodim/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/usersubj/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/usersubj/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/usersubj/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/unconfinedsubj/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/unconfinedsubj/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/udev/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/udev/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/udev/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/seutil/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/seutil/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/seutil/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/sctl/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/sctl/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/sctl/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/rpm/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/rpm/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/rpm/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/qemu/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/qemu/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/qemu/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/plymouth/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/plymouth/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/plymouth/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/pam/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/pam/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/pam/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/nss/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/nss/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/nss/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/netlabelctl/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/netlabelctl/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/netlabelctl/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/mount/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/mount/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/mount/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/miscfile/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/miscfile/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/miscfile/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/md/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/md/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/md/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/lvm/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/lvm/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/lvm/contexts.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/login/policy.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/login/macros.cil
                      /run/user/1000/dssp/sources/modules/contrib/system/login/contexts.cil
                      /run/user
                          Executable: /home/kcinimod/.local/bin/secilc
                           Control Group:
                      /user.slice/user-1000.slice/session-1.scope
                                Unit: session-1.scope
                                         Slice: user-1000.slice
                                                Session: 1
                                                     Owner UID: 1000
                      (kcinimod)
                             Boot ID: 1ae5ed764f334f32bebe30bffa3b414b
                                 Machine ID:
                      92c3ab10c0694da9b9c96a851603c2a5
                            Hostname: x250
                                  Coredump:
                      /var/lib/systemd/coredump/core.secilc.1000.1ae5ed764f334f32bebe30bffa3b414b.20553.1441789693000000.xz
                             Message: Process 20553 (secilc) of user
                      1000 dumped core.

                Stack trace of thread 20553:
                                #0  0x000000000041aaa3 n/a (/home/kcinimod/.local/bin/secilc)

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV7/31AAoJENAR6kfG5xmcpO4MAIpRAg7o7Nh1kU+mts626OWt
XjvTAYr9E5kSYazHdtbCyE8a2DgXu9Pdczb6REgJXmNwamoMpD3C5bx9X4WJSnxr
AsMGdHGCnsjtD5dCi2ClaCHKugHIoORJLZLI8otZlXLSUSNSruSjIn3JuKKT/mpc
myL5CkzgvVN6rsVgpijfAazc2cp/GQvES3nPjGSwpNtBdrl8zCaI5EUjFjnx36QZ
8zGrcyxye2U90s8/gBR+j3hFcTBOAf9BycCJa9GVixkArzgt4AHM0Fr/sRkLPrHN
TKRiPlcBEtVxms3PhMhaOB2L2sy3BLYlrsC3LlEGXM5y4FqAKaGS95UTPb/KIoR0
p+dXGGPqd5cdYJfsD25jRRjTfmH7Fi/ZM9cy5/5nwJpEBXvXCVH7UAinJCPfvpzJ
khgN9ZowdIJS7X9GAsz6F3jWr945uPEpr+lT3Vy1MZsOI+IVn/cnUP85Pdd+DQf6
I0IHycAbPN3LA2uJxsL/cODxQmTlmmUODi4PjoEUxQ==
=iCdD
-----END PGP SIGNATURE-----
