Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5EGwgxX015329
 for <selinux@tycho.nsa.gov>; Sat, 14 Jun 2014 12:58:42 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so2246951wib.5
 for <selinux@tycho.nsa.gov>; Sat, 14 Jun 2014 09:58:43 -0700 (PDT)
Received: from eversmanni.localdomain (183.222.74.86.rev.sfr.net.
 [86.74.222.183])
 by mx.google.com with ESMTPSA id r9sm3687567wia.17.2014.06.14.09.58.41
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Jun 2014 09:58:42 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] Bug fixes for libsemanage/src/pywrap-test.py
Date: Sat, 14 Jun 2014 18:58:24 +0200
Message-Id: <1402765106-7397-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

While working on porting to Python scripts in sepolgen and
policycoreutils to Python 3, I found libsemanage/src/pywrap-test.py.
As this script is written in Python 2, I tried to make it compatible
with Python 3 too.  However there are at least two problems:

* The current script bugs when asked to perform all tests in verbose
mode. Here are two patches to fix the script.  Can you review and
apply them?

* The file indentation mixes tabs and spaces.  Python 2 understands
such a thing but Python 3 only supports indenting with tabs or spaces
but not both.  How should the scripts be indented?

Nicolas Iooss (2):
  libsemanage: fix src/pywrap-test.py -v -F
  libsemanage: use semanage_bool_get_value to print a boolean

 libsemanage/src/pywrap-test.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.0.0
