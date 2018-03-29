Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2T3eMdD011820
 for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2018 23:40:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 40BVrM2syPzJ3dt
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 03:40:19 +0000 (UTC)
Received: from UPBD19PA13.eemsg.mil (unknown [192.168.18.15])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 40BVrM1RqXzJ3dZ
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 03:40:19 +0000 (UTC)
Received: by mail-qt0-f194.google.com with SMTP id j26so4898410qtl.11
 for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2018 20:40:18 -0700 (PDT)
Received: from localhost.localdomain (c-76-100-110-125.hsd1.md.comcast.net.
 [76.100.110.125])
 by smtp.gmail.com with ESMTPSA id b10sm3745189qtg.78.2018.03.28.20.40.16
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 28 Mar 2018 20:40:17 -0700 (PDT)
From: Yuli Khodorkovskiy <ykhodo@gmail.com>
To: selinux@tycho.nsa.gov
Date: Wed, 28 Mar 2018 20:40:01 -0700
Message-Id: <20180329034003.2231-1-ykhodo@gmail.com>
Subject: [PATCH v2 0/2] restorecon context validation improvement
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In permissive, if a bad label is written to a file_context file,
restorecon will not verify the label before succesfully applying the
context. These patches fix validation of labels during restorecon
while not breaking current behavior of lazy validation.

Yuli Khodorkovskiy (2):
  libselinux: verify file_contexts when using restorecon
  libselinux: echo line number of bad label in selabel_fini()

 libselinux/src/label.c          | 4 ++--
 libselinux/src/label_file.h     | 1 +
 libselinux/src/label_internal.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.14.3
