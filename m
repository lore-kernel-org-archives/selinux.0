Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4QIhiaM004239
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 14:43:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 40tX822KZ8z1pF1B
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 18:43:46 +0000 (UTC)
Received: from UPBD19PA13.eemsg.mil (unknown [192.168.18.15])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 40tX815qSvz1pF1G
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0937E56069E
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 20:42:40 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat, 26 May 2018 20:42:06 +0200
Message-Id: <20180526184213.4896-1-nicolas.iooss@m4x.org>
Subject: [PATCH 0/7] Fix some issues spotted by static analyzers
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,
As you may have noticed, I have been using clang's static analyzer for
a few months and submitted fixes for bugs that it found. There are also
many minor issues in the code (memory leaks, dead assignments, etc.)
which introduce much noise and make it harder to find real issues. For
example if a reported "dead variable assignment" is about the return
value of a function which would need to be checked and the wrong
variable is used in the check, this would be detected by the analyzer
but would be in the noise of other minor issues.

Therefore this patchset (and the ones that I would like to send in the
following weeks) is about reducing this noise.

I am starting with libsepol/src/module_to_cil.c and while cleaning up
the commits I have written in order to use clang's static analyzer, I
stumbled upon some other local commits I forgot to send, which fix more
important bugs (like a missing call to va_end(), in the last patch).
This explains why there are other files which are modified.

Here is the git shortlog:

Nicolas Iooss (7):
  libsepol: cil: silence clang analyzer false positive
  libsepol: do not leak memory if list_prepend fails
  libsepol: remove some dead assignments
  libsepol: do not call malloc with 0 byte
  libsepol: remove unused variable
  checkpolicy: destroy the class datum if it fails to initialize
  libsepol: destroy the copied va_list

 checkpolicy/module_compiler.c   |  1 +
 libsepol/cil/src/cil_tree.c     |  2 +-
 libsepol/src/kernel_to_common.c |  3 +++
 libsepol/src/module_to_cil.c    | 21 +++++++++++++--------
 4 files changed, 18 insertions(+), 9 deletions(-)

Cheers,
Nicolas

-- 
2.17.0
