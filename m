Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GIXLjX016605
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 14:33:21 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GIXEqE026922
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 18:33:15 GMT
Received: from localhost.localdomain (tresys-winxppro [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l7GIWxPE003268
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 14:32:59 -0400
Received: (from mgoldman@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l7GIWxT0003267
	for selinux@tycho.nsa.gov; Thu, 16 Aug 2007 14:32:59 -0400
Message-Id: <20070816183259.173579594@tresys.com>>
References: <20070816182854.469714631@tresys.com>>
Date: Thu, 16 Aug 2007 14:28:56 -0400
From: Mark Goldman <mgoldman@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [POLICYREP] [Patch 2/2] Add mls to the policy representation.
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adds objects to represent sensitivity, dominance, category and level
statements.

Add mls additions to the object representing user statements.

---
 libpolicyrep/include/policyrep/mls.hpp    |  166 	166 +	0 -	0 !
 libpolicyrep/include/policyrep/policy.hpp |    1 	1 +	0 -	0 !
 libpolicyrep/include/policyrep/user.hpp   |   18 	18 +	0 -	0 !
 libpolicyrep/src/policy_parse.y           |   87 	73 +	14 -	0 !
 libpolicyrep/src/user.cpp                 |   32 	31 +	1 -	0 !
 libpolicyrep/tests/example.te             |   17 	17 +	0 -	0 !
 libpolicyrep/tests/libpolicyrep-test.cpp  |   14 	14 +	0 -	0 !
 7 files changed, 320 insertions(+), 15 deletions(-)

--- /dev/null
+++ cpp-policyrep/libpolicyrep/include/policyrep/mls.hpp
@@ -0,0 +1,166 @@
+/* Author: Mark Goldman <mgoldman@tresys.com> */
+
+#ifndef __mls_hpp__
+#define __mls_hpp__
+
+#include <policyrep/policy_base.hpp>
+
+namespace policyrep
+{
+
+	//
+	// Sensitivity
+	//
+
+	struct SensitivityImpl;
+	class Sensitivity : public Node
+	{
+		public:
+			Sensitivity();
+			Sensitivity(const std::string& name);
+			Sensitivity(const Sensitivity& other);
+			virtual ~Sensitivity();
+			virtual void operator=(const Sensitivity& other);
+
+			template<class T>
+				Sensitivity(const std::string& name, T begin, T end)
+				{
+					init();
+					set_name(name);
+					aliases().insert(begin, end);
+				}
+
+			virtual const std::string& get_name() const;
+			virtual void set_name(const std::string& name);
+
+			virtual StringSet& aliases();
+		protected:
+			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+			void init();
+			SensitivityImpl* impl;
+	};
+	typedef boost::shared_ptr<Sensitivity> SensitivityPtr;
+
+	//
+	// Dominance
+	//
+
+	struct DominanceImpl;
+	class Dominance : public Node
+	{
+		public:
+			Dominance();
+			Dominance(const Dominance& other);
+			virtual ~Dominance();
+			virtual void operator=(const Dominance& other);
+
+			template<class T>
+				Dominance(T begin, T end)
+				{
+					init();
+					ordering().insert(ordering().begin(), begin, end);
+				}
+
+			virtual StringVector& ordering();
+		protected:
+			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+			void init();
+			DominanceImpl* impl;
+	};
+	typedef boost::shared_ptr<Dominance> DominancePtr;
+
+	//
+	// Category
+	//
+
+	struct CategoryImpl;
+	class Category : public Node
+	{
+		public:
+			Category();
+			Category(const std::string& name);
+			Category(const Category& other);
+			virtual ~Category();
+			virtual void operator=(const Category& other);
+
+			template<class T>
+				Category(const std::string& name, T begin, T end)
+				{
+					init();
+					set_name(name);
+					aliases().insert(begin, end);
+				}
+
+			virtual const std::string& get_name() const;
+			virtual void set_name(const std::string& name);
+
+			virtual StringSet& aliases();
+		protected:
+			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+			void init();
+			CategoryImpl* impl;
+	};
+	typedef boost::shared_ptr<Category> CategoryPtr;
+
+	//
+	// Level
+	//
+
+	struct LevelImpl;
+	class Level : public Node
+	{
+		public:
+			Level();
+			Level(const std::string& name);
+			Level(const Level& other);
+			virtual ~Level();
+			virtual void operator=(const Level& other);
+
+			template<class T>
+				Level(const std::string& name, T begin, T end)
+				{
+					init();
+					set_name(name);
+					categories().insert(begin, end);
+				}
+
+			virtual const std::string& get_name() const;
+			virtual void set_name(const std::string& name);
+
+			virtual StringSet& categories();
+			virtual void do_output_brief(std::ostream& o, const OutputFormatter& op) const;
+		protected:
+			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+			void init();
+			LevelImpl* impl;
+	};
+	typedef boost::shared_ptr<Level> LevelPtr;
+
+	//
+	// Range
+	//
+
+	struct RangeImpl;
+	class Range : public Node
+	{
+		public:
+			Range();
+			Range(LevelPtr low);
+			Range(LevelPtr low, LevelPtr high);
+			Range(const Range& other);
+			virtual ~Range();
+			virtual const LevelPtr& get_low()  const;
+			virtual const LevelPtr& get_high() const;
+			virtual LevelPtr& get_low();
+			virtual LevelPtr& get_high();
+			virtual void operator=(const Range& other);
+			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+		protected:
+			void init();
+			RangeImpl* impl;
+	};
+	typedef boost::shared_ptr<Range> RangePtr;
+
+} // namespace policyrep
+
+#endif
--- cpp-policyrep.orig/libpolicyrep/include/policyrep/policy.hpp
+++ cpp-policyrep/libpolicyrep/include/policyrep/policy.hpp
@@ -10,6 +10,7 @@
 #include <policyrep/conditional.hpp>
 #include <policyrep/rbac.hpp>
 #include <policyrep/user.hpp>
+#include <policyrep/mls.hpp>
 #include <policyrep/optional.hpp>
 
 namespace policyrep
--- cpp-policyrep.orig/libpolicyrep/src/policy_parse.y
+++ cpp-policyrep/libpolicyrep/src/policy_parse.y
@@ -119,6 +119,13 @@ policyrep::policy_parser::token_type
 %type <pnode> type_def
 %type <pnode> role_type_def
 %type <pnode> user_role_def
+%type <pnode> raw_level
+%type <pnode> mls_range
+%type <pnode> sensitivity_def
+%type <pnode> dominance_def
+%type <pnode> category_def
+%type <pnode> level_def
+
 %type <pnode> typealias_def
 %type <pnode> typeattribute_def
 %type <pnode> allow_def
@@ -253,6 +260,11 @@ policy_statement        : class_def
 			| role_type_def
 			/* Users */
 			| user_role_def
+			/* MLS */
+			| sensitivity_def
+			| dominance_def
+			| category_def
+			| level_def
 			/* rules */
 			| allow_def
 			| auditallow_def
@@ -284,27 +296,42 @@ av_perms_def		: CLASS IDENTIFIER LBRACE 
                         | CLASS IDENTIFIER INHERITS IDENTIFIER LBRACE identifier_list RBRACE
                           { $$ = new ObjectClass(*$2, *$4, $6->begin(), $6->end()); delete $2; delete $4; delete $6; }
 			;
-/*
 sensitivity_def		: SENSITIVITY IDENTIFIER alias_def SEMI
-			{ $$ = define_sens($2, $3); check($$); }
+			{ $$ = new Sensitivity(*$2, $3->begin(), $3->end());
+			  delete $2;
+			  delete $3;  }
 			| SENSITIVITY IDENTIFIER SEMI
-			{ $$ = define_sens($2, NULL); check($$); }
+			{ $$ = new Sensitivity(*$2);
+			  delete $2; }
 	                ;
-dominance		: DOMINANCE IDENTIFIER
-			{ NodeVector tmp = tolist($2); check(tmp); $$ = define_dominance(tmp); check($$); }
-                        | DOMINANCE LBRACE IDENTIFIER_list RBRACE
-			{ $$ = define_dominance($3); check($$); }
+dominance_def		: DOMINANCE IDENTIFIER
+			{ Dominance *d = new Dominance();
+			  d->ordering().push_back(*$2);
+			  $$ = d;
+			  delete $2; }
+                        | DOMINANCE LBRACE identifier_list RBRACE
+			{ $$ = new Dominance($3->begin(), $3->end());
+			  delete $3; }
 			;
 category_def		: CATEGORY IDENTIFIER alias_def SEMI
-			{ $$ = define_category($2, $3); check($$); }
+			{ $$ = new Category(*$2, $3->begin(), $3->end());
+			  delete $2;
+			  delete $3;  }
 			| CATEGORY IDENTIFIER SEMI
-			{ $$ = define_category($2, NULL); check($$); }
+			{ $$ = new Category(*$2);
+			  delete $2; }
 			;
 level_def		: LEVEL IDENTIFIER COLON id_comma_list SEMI
-			{ $$ = define_level(); check($$); }
+			{ 
+			  $$ = new Level(*$2, $4->begin(), $4->end());
+			  delete $2;
+			  delete $4;  }
 			| LEVEL IDENTIFIER SEMI
-			{ $$ = define_level(); check($$); }
+			{ 
+			  $$ = new Level(*$2);
+			  delete $2; }
 			;
+/*
 mlsconstraint_def	: MLSCONSTRAIN names names cexpr SEMI
 			{ $$ = define_constraint($4); check($$); }
 			;
@@ -476,11 +503,42 @@ role_type_def		: ROLE IDENTIFIER TYPES i
  			| ROLE IDENTIFIER SEMI
 			  { $$ = new Role(*$2); delete $2; }
                         ;
-user_role_def		: USER IDENTIFIER ROLES id_comma_list SEMI
-                          { $$ = new User(*$2, $4->begin(), $4->end()); delete $2; delete $4; }
+user_role_def		: USER IDENTIFIER ROLES id_comma_list LEVEL raw_level RANGE mls_range SEMI
+			  { $$ = new User(*$2, $4->begin(), $4->end());
+			    delete $2;
+			    delete $4;
+			    ((User*)$$)->set_level(LevelPtr((Level*)$6));
+			    ((User*)$$)->set_range(RangePtr((Range*)$8));
+			    // $6 and $8 are now managed by a shared ptr
+			    // don't delete them.  They will be free'd
+			    // when the final ptr is destroyed.
+			  }
+			| USER IDENTIFIER ROLES id_comma_list SEMI
+                          { $$ = new User(*$2, $4->begin(), $4->end());
+			    delete $2; 
+			    delete $4; }
  			| USER IDENTIFIER SEMI
 			  { $$ = new User(*$2); delete $2; }
                         ;
+raw_level		: IDENTIFIER COLON id_comma_list
+			  { $$ = new Level(*$1, $3->begin(), $3->end());
+			    delete $1;
+			    delete $3;
+			  }
+			| IDENTIFIER
+			  { $$ = new Level(*$1);
+			    delete $1;
+			  }
+			;
+mls_range		: raw_level DASH raw_level
+			  { $$ = new Range(LevelPtr((Level*)$1), LevelPtr((Level*)$3));
+			    // $1 and $2 become owned by Range, do not delete
+			  }
+			| raw_level
+			  { $$ = new Range(LevelPtr((Level*)$1));
+			    // $1 becomes owned by Range do not delete.
+			  }
+			;
 /*
 role_dominance		: DOMINANCE LBRACE roles RBRACE { $$ = $3; check($$); }
 			;
@@ -812,4 +870,5 @@ namespace policyrep {
 
 /* FLASK */
 
-
+/* vi:ts=8: 
+*/
--- cpp-policyrep.orig/libpolicyrep/tests/example.te
+++ cpp-policyrep/libpolicyrep/tests/example.te
@@ -34,9 +34,26 @@ role bar_r;
 bool foo true;
 
 user foo_u roles bar_r;
+user fooyou_u roles bar_r level s1 range s1:c2 - s12:c3;
+user fubu_u roles bar_r level s1 range s3 - s13:c3,c5,c12.c34;
+user footoo_u roles bar_r level s1:c3,c12.c20 range s1;
 
 user unfoo_u;
 
+sensitivity s1;
+sensitivity s2 alias whiskey;
+sensitivity s3 alias {tango foxtrot};
+
+category c1;
+category c2 alias alpha;
+category c3 alias { bravo delta };
+
+level s1 ;
+level s2:c1.c3;
+level s3:c1, c2,c3;
+
+dominance { s1 s2 s3 }
+
 if (foo) {
    allow foo bar : file read;
 }
--- cpp-policyrep.orig/libpolicyrep/tests/libpolicyrep-test.cpp
+++ cpp-policyrep/libpolicyrep/tests/libpolicyrep-test.cpp
@@ -47,7 +47,21 @@ void test()
 	UserPtr u(new User("bang"));
 	u->roles().insert("bust");
 	mod->append_child(u);
+
+	SensitivityPtr sen(new Sensitivity("s1"));
+	sen->aliases().insert("whiskey");
+	sen->aliases().insert("tango");
+	mod->append_child(sen);
  
+	CategoryPtr cat(new Category("c1"));
+	cat->aliases().insert("alpha");
+	cat->aliases().insert("delta");
+	mod->append_child(cat);
+
+	LevelPtr lev(new Level("l1"));
+	lev->categories().insert("c1");
+	mod->append_child(lev);
+
 	std::cout << "============ basic test ============" << std::endl;
         output_tree(std::cout, pol);
         
--- cpp-policyrep.orig/libpolicyrep/src/user.cpp
+++ cpp-policyrep/libpolicyrep/src/user.cpp
@@ -19,6 +19,7 @@
  */
 
 #include <policyrep/user.hpp>
+#include <policyrep/mls.hpp>
 
 namespace policyrep
 {
@@ -30,6 +31,8 @@ namespace policyrep
 	struct UserImpl
 	{
 		std::string name;
+		LevelPtr level;
+		RangePtr range;
 		StringSet roles;
 	};
 
@@ -53,7 +56,9 @@ namespace policyrep
 		*impl = *other.impl;
 	}
 
-	User::~User() { delete impl; }
+	User::~User() { 
+		delete impl;
+	}
 
 	void User::operator=(const User& other)
 	{
@@ -75,6 +80,23 @@ namespace policyrep
 		return impl->roles;
 	}
 
+	void User::set_level(LevelPtr level){
+		impl->level = level;
+	}
+
+	void User::set_range_low(LevelPtr low){
+		impl->range->get_low() = low;
+	}
+
+	void User::set_range_high(LevelPtr high){
+		impl->range->get_high() = high;
+	}
+
+	void User::set_range(RangePtr r)
+	{
+		impl->range = r;
+	}
+
 	void User::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
 		o << "user " << impl->name;
@@ -82,6 +104,14 @@ namespace policyrep
 			o << " roles ";
 			output_set_comma(o, impl->roles);
 		}
+		if(impl->level){
+			o << " level ";
+			impl->level->do_output_brief(o, op);
+		}
+		if(impl->range){
+			o << " range ";
+			impl->range->do_output(o, op);
+		}
 		o << ";";
 	}
 
--- cpp-policyrep.orig/libpolicyrep/include/policyrep/user.hpp
+++ cpp-policyrep/libpolicyrep/include/policyrep/user.hpp
@@ -4,6 +4,7 @@
 #define __user_hpp__
 
 #include <policyrep/policy_base.hpp>
+#include <policyrep/mls.hpp>
 
 namespace policyrep
 {
@@ -30,8 +31,25 @@ namespace policyrep
 					roles().insert(roles_begin, end);
 				}
 
+			template<class T>
+				User(const std::string& name, T roles_begin, T end,
+						LevelPtr& level, LevelPtr& low, LevelPtr& high)
+				{
+					init();
+					set_name(name);
+					roles().insert(roles_begin, end);
+					set_level(level);
+					set_range_low(low);
+					set_range_high(high);
+				}
+
+
 			virtual const std::string& get_name() const;
 			virtual void set_name(const std::string& name);
+			virtual void set_level(LevelPtr level);
+			virtual void set_range_low(LevelPtr low);
+			virtual void set_range_high(LevelPtr high);
+			virtual void set_range(RangePtr r);
 
 			virtual StringSet& roles();
 		protected:

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
