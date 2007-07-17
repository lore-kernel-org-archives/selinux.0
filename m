Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HHNKvT008563
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 13:23:20 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HHNJFN015079
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 17:23:19 GMT
Message-Id: <20070717172318.422721428@manicmethod.com>
References: <20070717172210.256077142@manicmethod.com>
Date: Tue, 17 Jul 2007 13:22:11 -0400
From: Joshua Brindle <method@manicmethod.com>
To: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [POLICYREP] [PATCH 1/1] policyrep role implementation
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>

---
 libpolicyrep/include/policyrep/policy.hpp |    1 
 libpolicyrep/include/policyrep/role.hpp   |   45 ++++++++++++++++
 libpolicyrep/src/policy_parse.y           |   13 ++--
 libpolicyrep/src/role.cpp                 |   82 ++++++++++++++++++++++++++++++
 libpolicyrep/tests/example.te             |    4 +
 libpolicyrep/tests/libpolicyrep-test.cpp  |    6 +-
 6 files changed, 144 insertions(+), 7 deletions(-)

--- policyrep-roles.orig/libpolicyrep/include/policyrep/policy.hpp
+++ policyrep-roles/libpolicyrep/include/policyrep/policy.hpp
@@ -8,6 +8,7 @@
 #include <policyrep/te_decl.hpp>
 #include <policyrep/rule.hpp>
 #include <policyrep/conditional.hpp>
+#include <policyrep/role.hpp>
 
 namespace policyrep
 {
--- /dev/null
+++ policyrep-roles/libpolicyrep/include/policyrep/role.hpp
@@ -0,0 +1,45 @@
+/* Author: Joshua Brindle <jbrindle@tresys.com> */
+
+#ifndef __role_hpp__
+#define __role_hpp__
+
+#include <policyrep/policy_base.hpp>
+
+namespace policyrep
+{
+
+        //
+        // Role
+        //
+
+	struct RoleImpl;
+        class Role : public Node
+	{
+        public:
+		Role();
+		Role(const std::string& name);
+		virtual ~Role();
+		virtual void operator=(const Role& other);
+
+		template<class T>
+                Role(const std::string& name, T types_begin, T end)
+		{
+			init();
+			set_name(name);
+			types().insert(types_begin, end);
+		}
+
+                virtual const std::string& get_name() const;
+                virtual void set_name(const std::string& name);
+
+                virtual StringSet& types();
+        protected:
+                virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+		void init();
+		RoleImpl* impl;
+        };
+	typedef boost::shared_ptr<Role> RolePtr;
+
+} // namespace policyrep
+
+#endif
--- policyrep-roles.orig/libpolicyrep/src/policy_parse.y
+++ policyrep-roles/libpolicyrep/src/policy_parse.y
@@ -116,6 +116,7 @@ policyrep::policy_parser::token_type
 %type <pnode> av_perms_def
 %type <pnode> attribute_def
 %type <pnode> type_def
+%type <pnode> role_type_def
 %type <pnode> typealias_def
 %type <pnode> typeattribute_def
 %type <pnode> allow_def
@@ -237,6 +238,8 @@ policy_statement        : class_def
 			| type_def
                         | typealias_def
                         | typeattribute_def
+			/* Roles */
+			| role_type_def
 			/* rules */
 			| allow_def
 			| auditallow_def
@@ -427,10 +430,10 @@ dontaudit_def		: DONTAUDIT names names C
 neverallow_def		: NEVERALLOW names names COLON names names  SEMI
 			  { $$ = define_avrule(AVRule::NEVERALLOW, $2, $3, $5, $6, driver); }
 		        ;
-role_type_def		: ROLE IDENTIFIER TYPES names SEMI
-			{ $$ = define_role_types(); check($$); }
- 			| ROLE IDENTIFIER
- 			{ $$ = define_role_types(); check($$); }
+role_type_def		: ROLE IDENTIFIER TYPES id_comma_list SEMI
+                          { $$ = new Role(*$2, $4->begin(), $4->end()); delete $2; delete $4; }
+ 			| ROLE IDENTIFIER SEMI
+			  { $$ = new Role(*$2); delete $2; }
                         ;
 /*
 role_dominance		: DOMINANCE LBRACE roles RBRACE { $$ = $3; check($$); }
@@ -441,13 +444,11 @@ role_trans_def		: ROLE_TRANSITION names 
 role_allow_def		: ALLOW names names SEMI
 			{ $$ = define_role_allow(); check($$); }
 			;
-*/
 roles			: role_def
 			{ $$ = $1; check($$); }
 			| roles role_def
 			{ $$ = merge_roles_dom($1, $2); check($$); }
 			;
-/*
 role_def		: ROLE IDENTIFIER_push SEMI
                         { $$ = define_role_dom(NULL); check($$); }
 			| ROLE IDENTIFIER_push LBRACE roles RBRACE
--- /dev/null
+++ policyrep-roles/libpolicyrep/src/role.cpp
@@ -0,0 +1,82 @@
+/*
+ * Author : Joshua Brindle <jbrindle@tresys.com>
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
+#include <policyrep/role.hpp>
+
+namespace policyrep
+{
+
+	//
+	// Role
+	//
+
+	struct RoleImpl
+	{
+		std::string name;
+		StringSet types;
+	};
+
+	void Role::init()
+	{
+		impl = new RoleImpl;
+	}
+
+	Role::Role() { init(); }
+
+	Role::Role(const std::string& name)
+	{
+		init();
+		impl->name = name;
+	}
+
+	Role::~Role() { delete impl; }
+
+	void Role::operator=(const Role& other)
+	{
+		*impl = *other.impl;
+	}
+
+	const std::string& Role::get_name() const
+	{
+		return impl->name;
+	}
+
+	void Role::set_name(const std::string& name)
+	{
+		impl->name = name;
+	}
+
+	StringSet& Role::types()
+	{
+		return impl->types;
+	}
+
+	void Role::do_output(std::ostream& o, const OutputFormatter& op) const
+	{
+		o << "role " << impl->name;
+		if (!impl->types.empty()) {
+			o << " types ";
+			output_set_comma(o, impl->types);
+		}
+		o << ";";
+	}
+
+
+} // namespace policyrep
--- policyrep-roles.orig/libpolicyrep/tests/example.te
+++ policyrep-roles/libpolicyrep/tests/example.te
@@ -23,6 +23,10 @@ typeattribute xdm_t sysdomain, xdomain;
 
 typealias xdm_t alias { foo_t bar_t };
 
+role foo_r types user_t;
+
+role bar_r;
+
 if (foo) {
    allow foo bar : file read;
 }
--- policyrep-roles.orig/libpolicyrep/tests/libpolicyrep-test.cpp
+++ policyrep-roles/libpolicyrep/tests/libpolicyrep-test.cpp
@@ -39,7 +39,11 @@ void test()
         t->attributes().insert("userdomain");
         
         mod->append_child(t);
-        
+
+	RolePtr r(new Role("foo"));
+	r->types().insert("foo");
+	mod->append_child(r);       
+ 
 	std::cout << "============ basic test ============" << std::endl;
         output_tree(std::cout, pol);
         

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
