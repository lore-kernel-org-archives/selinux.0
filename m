Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0BCfXmV023289
 for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2017 07:41:33 -0500
Received: by mail-wj0-f193.google.com with SMTP id kp2so90651072wjc.0
 for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2017 04:41:28 -0800 (PST)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH] restorecon manpage: link back to fixfiles
Date: Wed, 11 Jan 2017 12:41:10 +0000
Message-Id: <20170111124110.5721-2-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170111124110.5721-1-alan.christopher.jenkins@gmail.com>
References: <20170111124110.5721-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

fixfiles links to restorecon.  However if you start with restorecon
"restore file(s) default SELinux security contexts", you can easily
miss the fixfiles script.  fixfiles is more generally useful than
`restorecon -R`.   For example `restorecon -R /` is not as good as
`fixfiles restore`, because the restorecon command will try to relabel
`/sys` and fail noisily.

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 policycoreutils/setfiles/restorecon.8 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index b00bf4e..bd27113 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -214,6 +214,7 @@ The program was written by Dan Walsh <dwalsh@redhat.com>.
 
 .SH "SEE ALSO"
 .BR setfiles (8),
+.BR fixfiles (8),
 .BR load_policy (8),
 .BR checkpolicy (8),
 .BR customizable_types (5)
-- 
2.9.3
