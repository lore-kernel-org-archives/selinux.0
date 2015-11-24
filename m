Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAOJBebD025010
 for <selinux@tycho.nsa.gov>; Tue, 24 Nov 2015 14:11:40 -0500
Message-ID: <DUB128-W116CD2BD4AFE8BA94BEB989C060@phx.gbl>
From: David Binderman <dcb314@hotmail.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: libsepol bug report
Date: Tue, 24 Nov 2015 19:11:17 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello there,

./cil/src/cil_tree.c:1279:36: warning: duplicated 'if' condition [-Wduplicated-cond]

Source code is

            if (filecon->context_str != NULL) {
                cil_log(CIL_INFO, " %s", filecon->context_str);
            } else if (filecon->context != NULL) {
                cil_tree_print_context(filecon->context);
            } else if (filecon->context_str != NULL) {
                cil_log(CIL_INFO, " %s", filecon->context_str);
            }

Two mentions of filecon->context_str. Suggest code rework.

Regards

David Binderman

 		 	   		  
