Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HF58FV027317
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 11:05:08 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HF56bS010028
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 15:05:06 GMT
Message-Id: <20070717150443.678122397@manicmethod.com>
References: <20070717150336.135143158@manicmethod.com>
Date: Tue, 17 Jul 2007 11:03:39 -0400
From: method@manicmethod.com
To: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: [POLICYREP] [RFC/PATCH 3/3] policy package tests
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--

--- a/libpolicyrep/tests/libpolicyrep-test.cpp	(revision 2495)
+++ b/libpolicyrep/tests/libpolicyrep-test.cpp	(working copy)
@@ -20,6 +20,7 @@
 
 #include <policyrep/policy.hpp>
 #include <policyrep/parse.hpp>
+#include <policyrep/policy_package.hpp>
 
 #include <sstream>
 #include <iostream>
@@ -57,6 +58,27 @@
 
 	parsed_mod->append_children(mod->children().begin(), mod->children().end());
 
+	// policy package teddsts
+	std::cout << "============ Reading policy package ===========" << std::endl;
+
+	try {
+		PolicyPackagePtr polpackage(new PolicyPackage("policy_package/test.xar"));
+		const std::string fc = polpackage->get_file_contexts();
+		if (fc.empty())
+			std::cout << "Error, file_contexts file not in package" << std::endl;
+		const std::string su = polpackage->get_seusers();
+		if (su.empty())
+			std::cout << "Error, seusers file not in package" << std::endl;
+		const std::string ue = polpackage->get_user_extra();
+		if (ue.empty())
+			std::cout << "Error, user_extra file not in package" << std::endl;
+		const std::string nc = polpackage->get_netfilter_contexts();
+		if (nc.empty())
+			std::cout << "Error, netfilter_contexts file not in package" << std::endl;
+	} catch (const char *e) {
+		std::cout << "Exception thrown: " << e << std::endl;
+	}
+
 }
 
 int main(int argc, char **argv)
--- a/libpolicyrep/tests/Makefile	(revision 2495)
+++ b/libpolicyrep/tests/Makefile	(working copy)
@@ -12,7 +12,7 @@
 all: $(EXE)
 
 $(EXE): $(objs) $(LIBPOLICYREP)
-	g++ $(CFLAGS) $(objs) $(LIBPOLICYREP) -lboost_serialization -o $@
+	g++ $(CFLAGS) $(objs) $(LIBPOLICYREP) -lboost_serialization -lxar -o $@
 
 %.o:  %.cpp
 	g++ $(CFLAGS) -fPIC -c -o $@ $<

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
