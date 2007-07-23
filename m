Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6NHwEDs032416
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 13:58:14 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6NHwD6V023593
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 17:58:13 GMT
Message-Id: <20070723175809.694859324@tresys.com>
References: <20070723173440.880072184@tresys.com>
Date: Mon, 23 Jul 2007 13:34:41 -0400
From: mgoldman@tresys.com
To: selinux@tycho.nsa.gov
Cc: jbrindle@tresys.com
Subject: [patch 1/1] Add users to libpolicyrep
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 include/policyrep/policy.hpp |    1 
 include/policyrep/user.hpp   |   46 ++++++++++++++++++++++
 src/policy_parse.y           |    8 +++
 src/user.cpp                 |   89 +++++++++++++++++++++++++++++++++++++++++++
 tests/example.te             |    4 +
 tests/libpolicyrep-test.cpp  |    4 +
 6 files changed, 152 insertions(+)
Index: cpp-policyrep/libpolicyrep/include/policyrep/user.hpp
===================================================================
--- /dev/null
+++ cpp-policyrep/libpolicyrep/include/policyrep/user.hpp
@@ -0,0 +1,46 @@
+/* Author: Mark Goldman <mgoldman@tresys.com> */
+
+#ifndef __user_hpp__
+#define __user_hpp__
+
+#include <policyrep/policy_base.hpp>
+
+namespace policyrep
+{
+
+	//
+	// User
+	//
+
+	struct UserImpl;
+	class User : public Node
+	{
+		public:
+			User();
+			User(const std::string& name);
+			User(const User& other);
+			virtual ~User();
+			virtual void operator=(const User& other);
+
+			template<class T>
+				User(const std::string& name, T roles_begin, T end)
+				{
+					init();
+					set_name(name);
+					roles().insert(roles_begin, end);
+				}
+
+			virtual const std::string& get_name() const;
+			virtual void set_name(const std::string& name);
+
+			virtual StringSet& roles();
+		protected:
+			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+			void init();
+			UserImpl* impl;
+	};
+	typedef boost::shared_ptr<User> UserPtr;
+
+} // namespace policyrep
+
+#endif
Index: cpp-policyrep/libpolicyrep/src/policy_parse.y
===================================================================
--- cpp-policyrep.orig/libpolicyrep/src/policy_parse.y
+++ cpp-policyrep/libpolicyrep/src/policy_parse.y
@@ -117,6 +117,7 @@ policyrep::policy_parser::token_type
 %type <pnode> attribute_def
 %type <pnode> type_def
 %type <pnode> role_type_def
+%type <pnode> user_role_def
 %type <pnode> typealias_def
 %type <pnode> typeattribute_def
 %type <pnode> allow_def
@@ -240,6 +241,8 @@ policy_statement        : class_def
                         | typeattribute_def
 			/* Roles */
 			| role_type_def
+			/* Users */
+			| user_role_def
 			/* rules */
 			| allow_def
 			| auditallow_def
@@ -435,6 +438,11 @@ role_type_def		: ROLE IDENTIFIER TYPES i
  			| ROLE IDENTIFIER SEMI
 			  { $$ = new Role(*$2); delete $2; }
                         ;
+user_role_def		: USER IDENTIFIER ROLES id_comma_list SEMI
+                          { $$ = new User(*$2, $4->begin(), $4->end()); delete $2; delete $4; }
+ 			| USER IDENTIFIER SEMI
+			  { $$ = new User(*$2); delete $2; }
+                        ;
 /*
 role_dominance		: DOMINANCE LBRACE roles RBRACE { $$ = $3; check($$); }
 			;
Index: cpp-policyrep/libpolicyrep/src/user.cpp
===================================================================
--- /dev/null
+++ cpp-policyrep/libpolicyrep/src/user.cpp
@@ -0,0 +1,89 @@
+/*
+ * Author : Mark Goldman <mgoldman@tresys.com>
+ *
+ * Copyright (C) 2007 Tresys Technology, LLC.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <policyrep/user.hpp>
+
+namespace policyrep
+{
+
+	//
+	// User
+	//
+
+	struct UserImpl
+	{
+		std::string name;
+		StringSet roles;
+	};
+
+	void User::init()
+	{
+		impl = new UserImpl;
+	}
+
+	User::User() { init(); }
+
+	User::User(const std::string& name)
+	{
+		init();
+		impl->name = name;
+	}
+
+	User::User(const User& other)
+		: Node()
+	{
+		init();
+		*impl = *other.impl;
+	}
+
+	User::~User() { delete impl; }
+
+	void User::operator=(const User& other)
+	{
+		*impl = *other.impl;
+	}
+
+	const std::string& User::get_name() const
+	{
+		return impl->name;
+	}
+
+	void User::set_name(const std::string& name)
+	{
+		impl->name = name;
+	}
+
+	StringSet& User::roles()
+	{
+		return impl->roles;
+	}
+
+	void User::do_output(std::ostream& o, const OutputFormatter& op) const
+	{
+		o << "user " << impl->name;
+		if (!impl->roles.empty()) {
+			o << " roles ";
+			output_set_comma(o, impl->roles);
+		}
+		o << ";";
+	}
+
+
+} // namespace policyrep
Index: cpp-policyrep/libpolicyrep/tests/example.te
===================================================================
--- cpp-policyrep.orig/libpolicyrep/tests/example.te
+++ cpp-policyrep/libpolicyrep/tests/example.te
@@ -27,6 +27,10 @@ role foo_r types user_t;
 
 role bar_r;
 
+user foo_u roles bar_r;
+
+user unfoo_u;
+
 if (foo) {
    allow foo bar : file read;
 }
Index: cpp-policyrep/libpolicyrep/tests/libpolicyrep-test.cpp
===================================================================
--- cpp-policyrep.orig/libpolicyrep/tests/libpolicyrep-test.cpp
+++ cpp-policyrep/libpolicyrep/tests/libpolicyrep-test.cpp
@@ -43,6 +43,10 @@ void test()
 	RolePtr r(new Role("foo"));
 	r->types().insert("foo");
 	mod->append_child(r);       
+
+	UserPtr u(new User("bang"));
+	u->roles().insert("bust");
+	mod->append_child(u);
  
 	std::cout << "============ basic test ============" << std::endl;
         output_tree(std::cout, pol);
Index: cpp-policyrep/libpolicyrep/include/policyrep/policy.hpp
===================================================================
--- cpp-policyrep.orig/libpolicyrep/include/policyrep/policy.hpp
+++ cpp-policyrep/libpolicyrep/include/policyrep/policy.hpp
@@ -9,6 +9,7 @@
 #include <policyrep/rule.hpp>
 #include <policyrep/conditional.hpp>
 #include <policyrep/rbac.hpp>
+#include <policyrep/user.hpp>
 
 namespace policyrep
 {

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
