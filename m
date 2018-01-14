Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0EKKIeG007914
 for <selinux@tycho.nsa.gov>; Sun, 14 Jan 2018 15:20:22 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 3zKSXN15cdzrMHR
 for <selinux@tycho.nsa.gov>; Sun, 14 Jan 2018 20:20:20 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 3zKSXM6q7PzrMHQ
 for <selinux@tycho.nsa.gov>; Sun, 14 Jan 2018 20:20:19 +0000 (UTC)
Received: by mail-qt0-f179.google.com with SMTP id s3so11951385qtb.10
 for <selinux@tycho.nsa.gov>; Sun, 14 Jan 2018 12:20:18 -0800 (PST)
Received: from [192.168.1.190] ([69.140.143.28])
 by smtp.gmail.com with ESMTPSA id i31sm16584940qtb.34.2018.01.14.12.20.17
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jan 2018 12:20:17 -0800 (PST)
To: SELinux <selinux@tycho.nsa.gov>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <3ea25ec6-0b51-5617-5a3d-075ebd639745@ieee.org>
Date: Sun, 14 Jan 2018 15:20:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: SETools source policy support will be dropped
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've been doing some reworking of SETools' policy representation 
library.  I'm planning to remove SETools' support for loading source 
policies (policy.conf).

There are reasons to do this; first, the SETools code includes a portion 
of the compiler toolchain to do the compiling in memory.  Removing that 
will reduce the maintenance burden for keeping that code in sync and 
also reduce the SETools code size.  It will also ensure that there are 
no errors introduced by SETools' compilation of the policy sources. 
Additionally, it should break the SETools static linking requirement, so 
SETools doesn't need to be recompiled every time a new libsepol is released.

I don't think this will impact many, but let me know if this is a severe 
problem.

-- 
Chris PeBenito
