Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2U0IReP029418
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 20:18:27 -0400
Received: by mail-qk0-f194.google.com with SMTP id j73so7781576qke.6
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 17:17:41 -0700 (PDT)
Received: from localhost.localdomain (c-76-100-110-125.hsd1.md.comcast.net.
 [76.100.110.125])
 by smtp.gmail.com with ESMTPSA id i11sm5824682qtc.30.2018.03.29.17.17.30
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Mar 2018 17:17:30 -0700 (PDT)
From: Yuli Khodorkovskiy <ykhodo@gmail.com>
To: selinux@tycho.nsa.gov
Date: Thu, 29 Mar 2018 17:16:40 -0700
Message-Id: <20180330001642.2374-1-ykhodo@gmail.com>
Subject: [PATCH v3 0/2] restorecon context validation improvement
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In permissive, if a bad label is written to a file_context file,
restorecon will not verify the label before succesfully applying the
context. These patches fix validation of labels during restorecon
while not breaking current behavior of lazy validation.

Changes since V1:
- Continue using lazy validation for restorecon that was broken in V1 of
the patch.
- Add line number tracking for error messages in restorecon.

Changes since V2:
- Fix compiler error caused by unused variable in selabel_validate()

Yuli Khodorkovskiy (2):
  libselinux: verify file_contexts when using restorecon
  libselinux: echo line number of bad label in selabel_fini()

 libselinux/src/label.c                  | 7 +++----
 libselinux/src/label_backends_android.c | 2 +-
 libselinux/src/label_file.c             | 2 +-
 libselinux/src/label_file.h             | 3 ++-
 libselinux/src/label_internal.h         | 7 +++----
 libselinux/src/matchpathcon.c           | 5 ++---
 6 files changed, 12 insertions(+), 14 deletions(-)

-- 
2.14.3
