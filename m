Subject: [RELEASE] Setools 1.2.1
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-pjNsITs1cTYtfhx/6odP"
Message-Id: <1076103449.4398.20.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 06 Feb 2004 16:37:29 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-pjNsITs1cTYtfhx/6odP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Setools version 1.2.1 has been released. You can download it here:

http://www.tresys.com/selinux/

I have also attached a patch that will update the 1.2 release. This is a
minor update to fix a parse error when attributes are used as part of a
role declaration.

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134

--=-pjNsITs1cTYtfhx/6odP
Content-Disposition: attachment; filename=setools-1.2-to-1.2.1.patch
Content-Type: text/x-patch; name=setools-1.2-to-1.2.1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ruN -x Attic setools-1.2/apol/apol_help.txt setools-1.2.1/apol/apol_help.txt
--- setools-1.2/apol/apol_help.txt	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/apol/apol_help.txt	2004-02-06 16:16:01.000000000 -0500
@@ -1,6 +1,6 @@
 SELinux Policy Analysis Tool Help File
 apol, version 1.2
-February 04, 2004
+February 06, 2004
 selinux@tresys.com
 
 This file contains basic help information for using apol, version 1.2 
diff -ruN -x Attic setools-1.2/apol/dta_help.txt setools-1.2.1/apol/dta_help.txt
--- setools-1.2/apol/dta_help.txt	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/apol/dta_help.txt	2004-02-06 16:16:01.000000000 -0500
@@ -1,6 +1,6 @@
 AN OVERVIEW OF DOMAIN TRANSITION ANALYSIS
 apol, version 1.2
-February 04, 2004
+February 06, 2004
 selinux@tresys.com
 
 A key feature of Type Enforcement (TE) security is the ability to 
diff -ruN -x Attic setools-1.2/apol/iflow_help.txt setools-1.2.1/apol/iflow_help.txt
--- setools-1.2/apol/iflow_help.txt	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/apol/iflow_help.txt	2004-02-06 16:16:01.000000000 -0500
@@ -1,6 +1,6 @@
 AN OVERVIEW OF INFORMATION FLOW ANALYSIS
 apol, version 1.2
-February 04, 2004
+February 06, 2004
 selinux@tresys.com
 
 
diff -ruN -x Attic setools-1.2/ChangeLog-setools setools-1.2.1/ChangeLog-setools
--- setools-1.2/ChangeLog-setools	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/ChangeLog-setools	2004-02-06 16:16:01.000000000 -0500
@@ -1,6 +1,14 @@
 CHANGE LOG, SE Linux TOOLS (setools)
 
 ========================================================
+February 6, 2004 Version 1.2.1
+
+Libapol:
+	Fixed parse error when using attributes in role
+	declarations.
+
+
+========================================================
 February 4, 2004 Version 1.2
 
 Apol:    
@@ -29,6 +37,27 @@
 	Added support for parsing and storing initial SIDs.
 
 ========================================================
+December 30, 2003 Version 1.1.1
+ 
+libapol:
+        fixed memory leakage on information flow analysis
+ 
+seaudit:
+        fixed to properly compile with ISO C90 standards.
+ 
+libseaudit:
+        fixed to properly compile with ISO C90 standards.
+ 
+seuser:
+        fixed build process to properly build with no GUI.
+        fixed help for 'seuser -X'
+        removed default_context and cron_context in seuser.conf
+ 
+secmds:
+        fixed seinfo to display version information
+
+
+========================================================
 December 18, 2003 Version 1.1
 
 Apol:	
diff -ruN -x Attic setools-1.2/INSTALL setools-1.2.1/INSTALL
--- setools-1.2/INSTALL	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/INSTALL	2004-02-06 16:16:01.000000000 -0500
@@ -1,8 +1,8 @@
-SELinux Tools (setools), version 1.2
+SELinux Tools (setools), version 1.2.1
 by Tresys Technology, LLC
 (selinux@tresys.com, www.tresys.com/selinux)
 
-February 04, 2004
+February 06, 2004
 
 BUILDING AND INSTALLING NOTES AND WARNINGS
 
diff -ruN -x Attic setools-1.2/INSTALL-RPM setools-1.2.1/INSTALL-RPM
--- setools-1.2/INSTALL-RPM	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/INSTALL-RPM	2004-02-06 16:16:01.000000000 -0500
@@ -1,8 +1,8 @@
-SELinux Tools (setools), version 1.2
+SELinux Tools (setools), version 1.2.1
 by Tresys Technology, LLC
 (selinux@tresys.com, www.tresys.com/selinux)
 
-February 04, 2004
+February 06, 2004
 
 INSTALLATION NOTES FOR RPM
 
diff -ruN -x Attic setools-1.2/KNOWN-BUGS setools-1.2.1/KNOWN-BUGS
--- setools-1.2/KNOWN-BUGS	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/KNOWN-BUGS	2004-02-06 16:16:01.000000000 -0500
@@ -1,8 +1,8 @@
-SELinux Tools (setools), version 1.2
+SELinux Tools (setools), version 1.2.1
 by Tresys Technology, LLC
 (selinux@tresys.com, www.tresys.com/selinux)
 
-February 04, 2004
+February 06, 2004
 
 
 CURRENT BUGS AND ISSUES
diff -ruN -x Attic setools-1.2/libapol/apolicy_parse.y setools-1.2.1/libapol/apolicy_parse.y
--- setools-1.2/libapol/apolicy_parse.y	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/libapol/apolicy_parse.y	2004-02-06 16:16:01.000000000 -0500
@@ -1596,7 +1596,7 @@
 static int define_role_types(void)
 {
 	char *id, *or_name;
-	int role_idx, idx, rt;
+	int i, role_idx, idx, idx_type, num_types, *types, rt;
 
 	if (pass == 1 || (pass == 2 && !(parse_policy->opts & POLOPT_ROLES))) {
 		while ((id = queue_remove(id_queue))) 
@@ -1643,20 +1643,36 @@
 			return -1;
 		}
 	}
-	else 
+	else {
 		/* get rid of the role name if it alrady exists */
 		free(id);
+	}
 		
 	while ((id = queue_remove(id_queue))) {
-		idx = get_type_idx(id, parse_policy);
+		idx = get_type_or_attrib_idx(id, &idx_type, parse_policy);
 		if(idx < 0) {
 			sprintf(errormsg, "Invalid type name (%s) in role definition", id);
 			yyerror(errormsg);
 			return -1;
 		}
-		rt = add_type_to_role(idx, role_idx, parse_policy);
-		if(rt != 0)
-			return rt;
+		if (idx_type == IDX_TYPE) {
+			rt = add_type_to_role(idx, role_idx, parse_policy);
+			if(rt != 0)
+				return rt;
+		} else {
+			rt = get_attrib_types(idx, &num_types, &types, parse_policy);
+			if (rt != 0)
+				return rt;
+			for (i = 0; i < num_types; i++) {
+				rt = add_type_to_role(types[i], role_idx, parse_policy);
+				if(rt != 0) { 
+					free(types);
+					return rt;
+				}
+				
+			}
+			free(types);
+		}
 		free(id);	
 	}
 
diff -ruN -x Attic setools-1.2/libapol/policy.c setools-1.2.1/libapol/policy.c
--- setools-1.2/libapol/policy.c	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/libapol/policy.c	2004-02-06 16:16:01.000000000 -0500
@@ -1870,7 +1870,7 @@
 	new_role->num_types = 0;
 	new_role->types = NULL;
 	policy->num_roles++;
-	return 0;
+	return policy->num_roles - 1;
 }
 
 /* determine whether a role contains a given type (by idx) */
diff -ruN -x Attic setools-1.2/libapol/VERSION setools-1.2.1/libapol/VERSION
--- setools-1.2/libapol/VERSION	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/libapol/VERSION	2004-02-06 16:16:01.000000000 -0500
@@ -1 +1 @@
-1.2
+1.2.1
diff -ruN -x Attic setools-1.2/README setools-1.2.1/README
--- setools-1.2/README	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/README	2004-02-06 16:16:01.000000000 -0500
@@ -1,8 +1,8 @@
-SELinux Tools (setools), version 1.2
+SELinux Tools (setools), version 1.2.1
 by Tresys Technology, LLC
 (selinux@tresys.com, www.tresys.com/selinux)
 
-February 04, 2004
+February 06, 2004
 
 OVERVIEW
 
diff -ruN -x Attic setools-1.2/seaudit/seaudit_help.txt setools-1.2.1/seaudit/seaudit_help.txt
--- setools-1.2/seaudit/seaudit_help.txt	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/seaudit/seaudit_help.txt	2004-02-06 16:16:01.000000000 -0500
@@ -1,6 +1,6 @@
 Audit Log Analysis Tool for Security Enhanced Linux
 seaudit, version 1.1
-February 04, 2004
+February 06, 2004
 selinux@tresys.com
 
 Overview:  
diff -ruN -x Attic setools-1.2/sepct/customize.tcl setools-1.2.1/sepct/customize.tcl
--- setools-1.2/sepct/customize.tcl	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/sepct/customize.tcl	2004-02-06 16:16:01.000000000 -0500
@@ -683,7 +683,7 @@
 	    	# Need to update the status bar if the current selection is the current module
 		if { $raisedPage == $Sepct_Customize::te_tabID && [$list_b selection get] == $module } {
 			set curr_TE_file $target_Path
-	    		Sepct::update_fileStatus $curr_TE_file 1
+	    		Sepct::update_fileStatus $curr_TE_file 0
 	    	} 
     	}
     	
diff -ruN -x Attic setools-1.2/sepct/sepcut_help.txt setools-1.2.1/sepct/sepcut_help.txt
--- setools-1.2/sepct/sepcut_help.txt	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/sepct/sepcut_help.txt	2004-02-06 16:16:01.000000000 -0500
@@ -1,6 +1,6 @@
 SE Linux Policy Customization and Editing Tool Help File
 sepcut, version 0.3.5
-February 04, 2004
+February 06, 2004
 selinux@tresys.com
 
 
diff -ruN -x Attic setools-1.2/sepct/top.tcl setools-1.2.1/sepct/top.tcl
--- setools-1.2/sepct/top.tcl	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/sepct/top.tcl	2004-02-06 16:16:01.000000000 -0500
@@ -1808,8 +1808,9 @@
 		set pos [Sepct_db::get_pos $fn]
 		if { $pos == "" } {
 			puts stderr "update_fileStatus: Error getting position info for $fn" 
-		}
-	    	Sepct::update_positionStatus $pos
+		} else {
+	    		Sepct::update_positionStatus $pos
+	    	}
 	}
     	return 0
 }
diff -ruN -x Attic setools-1.2/setools.spec setools-1.2.1/setools.spec
--- setools-1.2/setools.spec	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/setools.spec	2004-02-06 16:16:01.000000000 -0500
@@ -1,10 +1,10 @@
 Summary: SELinux tools for managing policy
 Name: setools
-Version: 1.2
+Version: 1.2.1
 Release: 1
 License: GPL
 Group: System Environment/Base
-Source: http://www.tresys.com/Downloads/selinux-tools/setools-1.2.tgz
+Source: http://www.tresys.com/Downloads/selinux-tools/setools-1.2.1.tgz
 Prefix: %{_prefix}
 BuildRoot: %{_tmppath}/%{name}-buildroot
 BuildRequires: perl, tcl, policycoreutils
diff -ruN -x Attic setools-1.2/seuser/seuser_help.txt setools-1.2.1/seuser/seuser_help.txt
--- setools-1.2/seuser/seuser_help.txt	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/seuser/seuser_help.txt	2004-02-06 16:16:01.000000000 -0500
@@ -1,7 +1,7 @@
 
 SELinux User Manager Help File
 seuser, Version 0.5.5
-February 04, 2004
+February 06, 2004
 selinux@tresys.com
 ----------------------------------
 
diff -ruN -x Attic setools-1.2/VERSION setools-1.2.1/VERSION
--- setools-1.2/VERSION	2004-02-05 15:31:37.000000000 -0500
+++ setools-1.2.1/VERSION	2004-02-06 16:16:01.000000000 -0500
@@ -1 +1 @@
-1.2
+1.2.1

--=-pjNsITs1cTYtfhx/6odP--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
