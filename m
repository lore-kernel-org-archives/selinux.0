Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93Kl7ZL004082
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 16:47:08 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 627C456472B
 for <selinux@tycho.nsa.gov>; Mon,  3 Oct 2016 22:47:01 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] Fuzzing secilc with AFL
Date: Mon,  3 Oct 2016 22:46:54 +0200
Message-Id: <20161003204657.2635-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

Last week I started fuzzing secilc with american fuzzy lop, mainly
because I was curious of the result. I started with a small CIL policy,
for which AFL quickly found one crashing mutation (fixed by commit
c303ca910add ("libsepol/cil: Check for too many permissions in classes
and commons")).

Then I unleashed AFL on the files in secilc and it found 19 unique
crashing inputs over the week-end. I started digging through these
inputs to uncover bugs and this patchset consists in the patches I
wrote and quickly tested tonight.

If anyone is interested in running AFL too, I published my setup
(along with my custom Makefile and some other patches) on
https://github.com/fishilico/selinux (branch 'master'). I wrote
run_afl.sh (in the root of this project) as a wrapper to afl-fuzz to
make fuzzing start with "./run_afl.sh secilc".

Cheers,
Nicolas

PS: I am quite busy in the next weeks so I may be quite slow to reply
to feedbacks and to send other patches.

Nicolas Iooss (3):
  libsepol/cil: make cil_resolve_name() fail for '.'
  libsepol/cil: fix double-free in cil categories parser
  libsepol/cil: fix memory leak in __cil_fill_expr()

 libsepol/cil/src/cil_build_ast.c   | 2 ++
 libsepol/cil/src/cil_resolve_ast.c | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.10.0
