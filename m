Message-Id: <20070726144755.020785372@manicmethod.com>
References: <20070726144535.573371598@manicmethod.com>
Date: Thu, 26 Jul 2007 10:45:36 -0400
From: method@manicmethod.com
To: kmacmillan@mentalrootkit.com, selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Subject: [POLICYREP] [PATCHv2 1/3] policy package class
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--

---
 libpolicyrep/include/policyrep/policy_package.hpp |   67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

--- /dev/null
+++ policyrep-policy_package/libpolicyrep/include/policyrep/policy_package.hpp
@@ -0,0 +1,67 @@
+/* Author: Joshua Brindle <method@manicmethod.com> */
+
+#ifndef __policy_package_hpp__
+#define __policy_package_hpp__
+
+#include <policyrep/policy.hpp>
+
+namespace policyrep {
+	struct PolicyPackageImpl;
+	class PolicyPackage {
+	      public:
+		PolicyPackage();
+		virtual ~ PolicyPackage();
+
+		virtual Module & get_policy_module() const;
+		virtual void set_policy_module(Module & module);
+
+		virtual char *get_file_contexts() const;
+		virtual void set_file_contexts(char *fc);
+		virtual char *get_seusers() const;
+		virtual void set_seusers(char *su);
+		virtual char *get_user_extra() const;
+		virtual void set_user_extra(char *ue);
+		virtual char *get_netfilter_contexts() const;
+		virtual void set_netfilter_contexts(char *nf);
+
+		virtual void read(char *filename);
+		// PolicyPackage.write does not currently work pending
+		// a bug fix in xar
+		virtual void write(char *filename);
+
+	      protected:
+		void init();
+		PolicyPackageImpl *impl;
+
+	};
+
+	// This is a simple archival class that allows a dumb packager 
+	// e.g., semodule_package to simply set the pathnames for each
+	// file in the policy package and call create_archive.
+	struct PolicyPackageArchiveImpl;
+	class PolicyPackageArchive {
+	      public:
+		PolicyPackageArchive();
+		virtual ~ PolicyPackageArchive();
+
+		virtual void set_mod_file(char *mod);
+		virtual char *get_mod_file() const;
+		virtual void set_fc_file(char *fc);
+		virtual char *get_fc_file() const;
+		virtual void set_seusers_file(char *su);
+		virtual char *get_seusers_file() const;
+		virtual void set_user_extra_file(char *ue);
+		virtual char *get_user_extra_file() const;
+		virtual void set_nc_file(char *nf);
+		virtual char *get_nc_file() const;
+
+		virtual void create_archive(char *filename);
+
+	      protected:
+		void init();
+		PolicyPackageArchiveImpl *impl;
+
+	};
+
+}				// namespace policyrep
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
