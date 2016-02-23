Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1NKOUw0020565
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 15:24:30 -0500
Received: by mail-pa0-f46.google.com with SMTP id ho8so119051871pac.2
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 12:24:21 -0800 (PST)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: nnk@google.com, jeffv@google.com, sds@tycho.nsa.gov,
 dcashman <dcashman@android.com>
Subject: [PATCH 0/2] Return error on invalid pids for procattr funcs.
Date: Tue, 23 Feb 2016 12:23:58 -0800
Message-Id: <1456259040-13721-1-git-send-email-dcashman@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: dcashman <dcashman@android.com>

The getprocattrcon functions currently do not do any validation of the supplied
pid argument.  This argument is nonsensical for negative pid values and is also
not specified for an input value of zero.  This is an error-prone convention and
should be changed.  This is evidenced by issues such as the following android
bug:

https://code.google.com/p/android/issues/detail?id=200617

dcashman (2):
  libselinux: procattr: return error on invalid pid_t input.
  libselinux: procattr: return einval for <= 0 pid args.

 libselinux/src/procattr.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
