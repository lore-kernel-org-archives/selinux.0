Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6IFC7dg001517
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 11:12:07 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l6IFC7so029566
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 15:12:07 GMT
Message-ID: <469E2DBD.8060102@manicmethod.com>
Date: Wed, 18 Jul 2007 11:11:57 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [POLICYREP] [PATCH 1/1] policyrep role implementation
References: <20070717172210.256077142@manicmethod.com>	 <20070717172318.422721428@manicmethod.com> <1184697723.3833.36.camel@localhost.localdomain>
In-Reply-To: <1184697723.3833.36.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> The copy operator and constructor are not properly chaining to the base
> classes (it was my mistake in the initial patch). I think you can go
> ahead and check this in and I will fix it up when I fix everything else.
>   
Following patch applied to policyrep branch:

Index: libpolicyrep/tests/example.te
===================================================================
--- libpolicyrep/tests/example.te       (revision 2495)
+++ libpolicyrep/tests/example.te       (working copy)
@@ -23,6 +23,10 @@
 
 typealias xdm_t alias { foo_t bar_t };
 
+role foo_r types user_t;
+
+role bar_r;
+
 if (foo) {
    allow foo bar : file read;
 }
Index: libpolicyrep/tests/libpolicyrep-test.cpp
===================================================================
--- libpolicyrep/tests/libpolicyrep-test.cpp    (revision 2495)
+++ libpolicyrep/tests/libpolicyrep-test.cpp    (working copy)
@@ -39,7 +39,11 @@
         t->attributes().insert("userdomain");
         
         mod->append_child(t);
-        
+
+       RolePtr r(new Role("foo"));
+       r->types().insert("foo");
+       mod->append_child(r);       
+ 
        std::cout << "============ basic test ============" << std::endl;
         output_tree(std::cout, pol);
         
Index: libpolicyrep/include/policyrep/policy.hpp
===================================================================
--- libpolicyrep/include/policyrep/policy.hpp   (revision 2495)
+++ libpolicyrep/include/policyrep/policy.hpp   (working copy)
@@ -8,6 +8,7 @@
 #include <policyrep/te_decl.hpp>
 #include <policyrep/rule.hpp>
 #include <policyrep/conditional.hpp>
+#include <policyrep/rbac.hpp>
 
 namespace policyrep
 {
Index: libpolicyrep/include/policyrep/rbac.hpp
===================================================================
--- libpolicyrep/include/policyrep/rbac.hpp     (revision 0)
+++ libpolicyrep/include/policyrep/rbac.hpp     (revision 0)
@@ -0,0 +1,46 @@
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
+       struct RoleImpl;
+        class Role : public Node
+       {
+        public:
+               Role();
+               Role(const std::string& name);
+               Role(const Role& other);
+               virtual ~Role();
+               virtual void operator=(const Role& other);
+
+               template<class T>
+                Role(const std::string& name, T types_begin, T end)
+               {
+                       init();
+                       set_name(name);
+                       types().insert(types_begin, end);
+               }
+
+                virtual const std::string& get_name() const;
+                virtual void set_name(const std::string& name);
+
+                virtual StringSet& types();
+        protected:
+                virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+               void init();
+               RoleImpl* impl;
+        };
+       typedef boost::shared_ptr<Role> RolePtr;
+
+} // namespace policyrep
+
+#endif
Index: libpolicyrep/src/rbac.cpp
===================================================================
--- libpolicyrep/src/rbac.cpp   (revision 0)
+++ libpolicyrep/src/rbac.cpp   (revision 0)
@@ -0,0 +1,89 @@
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
+#include <policyrep/rbac.hpp>
+
+namespace policyrep
+{
+
+       //
+       // Role
+       //
+
+       struct RoleImpl
+       {
+               std::string name;
+               StringSet types;
+       };
+
+       void Role::init()
+       {
+               impl = new RoleImpl;
+       }
+
+       Role::Role() { init(); }
+
+       Role::Role(const std::string& name)
+       {
+               init();
+               impl->name = name;
+       }
+
+       Role::Role(const Role& other)
+               : Node()
+       {
+               init();
+               *impl = *other.impl;
+       }
+
+       Role::~Role() { delete impl; }
+
+       void Role::operator=(const Role& other)
+       {
+               *impl = *other.impl;
+       }
+
+       const std::string& Role::get_name() const
+       {
+               return impl->name;
+       }
+
+       void Role::set_name(const std::string& name)
+       {
+               impl->name = name;
+       }
+
+       StringSet& Role::types()
+       {
+               return impl->types;
+       }
+
+       void Role::do_output(std::ostream& o, const OutputFormatter& op) const
+       {
+               o << "role " << impl->name;
+               if (!impl->types.empty()) {
+                       o << " types ";
+                       output_set_comma(o, impl->types);
+               }
+               o << ";";
+       }
+
+
+} // namespace policyrep
Index: libpolicyrep/src/policy_parse.y
===================================================================
--- libpolicyrep/src/policy_parse.y     (revision 2495)
+++ libpolicyrep/src/policy_parse.y     (working copy)
@@ -116,6 +116,7 @@
 %type <pnode> av_perms_def
 %type <pnode> attribute_def
 %type <pnode> type_def
+%type <pnode> role_type_def
 %type <pnode> typealias_def
 %type <pnode> typeattribute_def
 %type <pnode> allow_def
@@ -237,6 +238,8 @@
                        | type_def
                         | typealias_def
                         | typeattribute_def
+                       /* Roles */
+                       | role_type_def
                        /* rules */
                        | allow_def
                        | auditallow_def
@@ -427,12 +430,12 @@
 neverallow_def         : NEVERALLOW names names COLON names names  SEMI
                          { $$ = define_avrule(AVRule::NEVERALLOW, $2, $3, $5, $6, driver); }
                        ;
+role_type_def          : ROLE IDENTIFIER TYPES id_comma_list SEMI
+                          { $$ = new Role(*$2, $4->begin(), $4->end()); delete $2; delete $4; }
+                       | ROLE IDENTIFIER SEMI
+                         { $$ = new Role(*$2); delete $2; }
+                        ;
 /*
-role_type_def          : ROLE IDENTIFIER TYPES names SEMI
-                       { $$ = define_role_types(); check($$); }
-                       | ROLE IDENTIFIERSEMI
-                       { $$ = define_role_types(); check($$); }
-                        ;
 role_dominance         : DOMINANCE LBRACE roles RBRACE { $$ = $3; check($$); }
                        ;
 role_trans_def         : ROLE_TRANSITION names names IDENTIFIER SEMI




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
