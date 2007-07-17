Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HF4fqi027267
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 11:04:41 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HF4eQA021296
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 15:04:40 GMT
Message-Id: <20070717150405.334131301@manicmethod.com>
References: <20070717150336.135143158@manicmethod.com>
Date: Tue, 17 Jul 2007 11:03:37 -0400
From: method@manicmethod.com
To: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: [POLICYREP] [RFC/PATCH 1/3] policy package class
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--

--- a/libpolicyrep/include/policyrep/policy_package.hpp	(revision 0)
+++ b/libpolicyrep/include/policyrep/policy_package.hpp	(revision 0)
@@ -0,0 +1,38 @@
+/* Author: Joshua Brindle <method@manicmethod.com> */
+
+#ifndef __policy_package_hpp__
+#define __policy_package_hpp__
+
+
+#include <policyrep/policy.hpp>
+
+namespace policyrep
+{
+	struct PolicyPackageImpl;
+	class PolicyPackage
+	{
+	public:
+		PolicyPackage();
+		PolicyPackage(std::string filename);
+		~PolicyPackage();
+
+		const Module get_policy_module() const;
+
+		const std::string get_file_contexts() const;
+		const std::string get_seusers() const;
+		const std::string get_user_extra() const;
+		const std::string get_netfilter_contexts() const;
+
+	protected:
+		void init();
+		int read_package(std::string filename);	
+
+	private:
+		PolicyPackageImpl* impl;
+	};
+
+	typedef boost::shared_ptr<PolicyPackage> PolicyPackagePtr;
+
+} // namespace policyrep
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
