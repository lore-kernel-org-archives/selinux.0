Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5IERioU021964
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 10:27:46 -0400
To: selinux@tycho.nsa.gov
Cc: refpolicy@oss.tresys.com
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <f7dcc921-6206-37cf-2843-451a5d56a1b7@debian.org>
Date: Mon, 18 Jun 2018 16:27:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: sepolgen-ifgen fails with current refpolicy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

With the current refpolicy when running sepolgen-ifgen I get the 
following (fatal) error:

/usr/share/selinux/refpolicy/include/support/obj_perm_sets.spt: Syntax error on line 157 ` [type=TICK]
error parsing headers
error parsing file /usr/share/selinux/refpolicy/include/support/obj_perm_sets.spt: could not parse text: "/usr/share/selinux/refpolicy/include/support/obj_perm_sets.spt: Syntax error on line 157 ` [type=TICK]"

The line in question in obj_perm_sets.spt is:

define(`mmap_file_perms',`{ getattr open map read execute ioctl } refpolicywarn(`mmap_file_perms is deprecated, please use mmap_exec_file_perms instead')') # deprecated 20171213

sepolgen-ifgen is not happy with the embedded "refpolicywarn" apparently.

Regards,

Laurent Bigonville
