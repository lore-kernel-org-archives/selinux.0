Message-Id: <20080121160227.534155782@manicmethod.com>
References: <20080121160031.792610312@manicmethod.com>
Date: Tue, 22 Jan 2008 14:43:35 -0500
From: Joshua Brindle <method@manicmethod.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com, tmiller@tresys.com
Subject: [POLICYREP] [patch 4/7] symbol base class
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds the symbol base class and makes all symbols (types, roles, etc) inherit from it. 

---
 libpolicyrep/include/policyrep/conditional.hpp  |    5 -
 libpolicyrep/include/policyrep/mls.hpp          |   16 +---
 libpolicyrep/include/policyrep/object_class.hpp |   10 +--
 libpolicyrep/include/policyrep/policy.hpp       |    6 -
 libpolicyrep/include/policyrep/rbac.hpp         |    6 -
 libpolicyrep/include/policyrep/symbol.hpp       |   27 ++++++++
 libpolicyrep/include/policyrep/te_decl.hpp      |   10 ---
 libpolicyrep/include/policyrep/user.hpp         |    6 -
 libpolicyrep/src/conditional.cpp                |   21 +-----
 libpolicyrep/src/mls.cpp                        |   78 ++++++++----------------
 libpolicyrep/src/object_class.cpp               |   42 ++++--------
 libpolicyrep/src/policy.cpp                     |   20 +-----
 libpolicyrep/src/rbac.cpp                       |   27 +++-----
 libpolicyrep/src/symbol.cpp                     |   71 +++++++++++++++++++++
 libpolicyrep/src/te_decl.cpp                    |   52 +++++-----------
 libpolicyrep/src/user.cpp                       |   27 +++-----
 16 files changed, 206 insertions(+), 218 deletions(-)

--- policyrep.new.orig/libpolicyrep/include/policyrep/conditional.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/conditional.hpp
@@ -4,6 +4,7 @@
 #define __conditional_hpp__
 
 #include <policyrep/policy_base.hpp>
+#include <policyrep/symbol.hpp>
 
 #include <list>
 
@@ -39,7 +40,7 @@ namespace policyrep
 	 */
 
 	struct CondBoolImpl;
-	class CondBool : public Node
+	class CondBool : public Symbol
 	{
 	public:
 		CondBool();
@@ -48,8 +49,6 @@ namespace policyrep
 		virtual ~CondBool();
 		virtual void operator=(const CondBool& other);
 
-		virtual void set_name(const std::string& name);
-		virtual const std::string& get_name() const;
 
 		virtual void set_default_value(bool v);
 		virtual bool get_default_value() const;
--- policyrep.new.orig/libpolicyrep/include/policyrep/mls.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/mls.hpp
@@ -4,6 +4,7 @@
 #define __mls_hpp__
 
 #include <policyrep/policy_base.hpp>
+#include <policyrep/symbol.hpp>
 
 namespace policyrep
 {
@@ -13,7 +14,7 @@ namespace policyrep
 	//
 
 	struct SensitivityImpl;
-	class Sensitivity : public Node
+	class Sensitivity : public Symbol
 	{
 		public:
 			Sensitivity();
@@ -30,9 +31,6 @@ namespace policyrep
 					aliases().insert(begin, end);
 				}
 
-			virtual const std::string& get_name() const;
-			virtual void set_name(const std::string& name);
-
 			virtual StringSet& aliases();
 		protected:
 			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
@@ -74,7 +72,7 @@ namespace policyrep
 	//
 
 	struct CategoryImpl;
-	class Category : public Node
+	class Category : public Symbol
 	{
 		public:
 			Category();
@@ -91,9 +89,6 @@ namespace policyrep
 					aliases().insert(begin, end);
 				}
 
-			virtual const std::string& get_name() const;
-			virtual void set_name(const std::string& name);
-
 			virtual StringSet& aliases();
 		protected:
 			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
@@ -107,7 +102,7 @@ namespace policyrep
 	//
 
 	struct LevelImpl;
-	class Level : public Node
+	class Level : public Symbol
 	{
 		public:
 			Level();
@@ -124,9 +119,6 @@ namespace policyrep
 					categories().insert(begin, end);
 				}
 
-			virtual const std::string& get_name() const;
-			virtual void set_name(const std::string& name);
-
 			virtual StringSet& categories();
 			virtual void do_output_brief(std::ostream& o, const OutputFormatter& op) const;
 		protected:
--- policyrep.new.orig/libpolicyrep/include/policyrep/object_class.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/object_class.hpp
@@ -4,6 +4,7 @@
 #define __object_class_hpp__
 
 #include <policyrep/policy_base.hpp>
+#include <policyrep/symbol.hpp>
 
 namespace policyrep
 {
@@ -13,7 +14,7 @@ namespace policyrep
         //
 
         struct CommonPermsImpl;
-        class CommonPerms : public Node
+	class CommonPerms : public Symbol
         {
         public:
                 CommonPerms();
@@ -29,8 +30,6 @@ namespace policyrep
 			perms().insert(perms_begin, perms_end);
 		}
 
-                virtual const std::string& get_name() const;
-                virtual void set_name(const std::string& name);
                 virtual StringSet& perms();
 
         protected:
@@ -46,10 +45,11 @@ namespace policyrep
         //
 
         struct ObjectClassImpl;
-        class ObjectClass : public Node
+	class ObjectClass : public Symbol
         {
         public:
                 ObjectClass();
+		ObjectClass(const std::string& name);
                 ObjectClass(const std::string& name, const std::string& commons);
 		ObjectClass(const ObjectClass& other);
                 virtual ~ObjectClass();
@@ -65,8 +65,6 @@ namespace policyrep
 			perms().insert(perms_begin, perms_end);
 		}
 
-                virtual const std::string& get_name() const;
-                virtual void set_name(const std::string& name);
                 virtual StringSet& perms();
                 virtual const std::string& get_common_perms() const;
                 virtual void set_common_perms(const std::string& name);
--- policyrep.new.orig/libpolicyrep/include/policyrep/policy.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/policy.hpp
@@ -12,6 +12,7 @@
 #include <policyrep/user.hpp>
 #include <policyrep/mls.hpp>
 #include <policyrep/optional.hpp>
+#include <policyrep/symbol.hpp>
 
 namespace policyrep
 {
@@ -69,7 +70,7 @@ namespace policyrep
 	//
 
 	struct InitialSidImpl;
-        class InitialSid : public Node
+        class InitialSid : public Symbol
         {
         public:
                 InitialSid();
@@ -78,9 +79,6 @@ namespace policyrep
                 virtual ~InitialSid();
 		virtual void operator=(const InitialSid& other);
 
-                virtual const std::string& get_name() const;
-                virtual void set_name(const std::string& name);
-
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
 		void copy(const InitialSid& other);
--- policyrep.new.orig/libpolicyrep/include/policyrep/rbac.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/rbac.hpp
@@ -4,6 +4,7 @@
 #define __role_hpp__
 
 #include <policyrep/policy_base.hpp>
+#include <policyrep/symbol.hpp>
 
 namespace policyrep
 {
@@ -13,7 +14,7 @@ namespace policyrep
         //
 
 	struct RoleImpl;
-        class Role : public Node
+	class Role : public Symbol
 	{
         public:
 		Role();
@@ -30,9 +31,6 @@ namespace policyrep
 			types().insert(types_begin, end);
 		}
 
-                virtual const std::string& get_name() const;
-                virtual void set_name(const std::string& name);
-
                 virtual StringSet& types();
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
--- /dev/null
+++ policyrep.new/libpolicyrep/include/policyrep/symbol.hpp
@@ -0,0 +1,27 @@
+/* Author: Jeremy A. Mowery <jmowery@tresys.com> */
+
+#ifndef __symbol_hpp__
+#define __symbol_hpp__
+
+#include <policyrep/policy_base.hpp>
+
+namespace policyrep
+{
+	struct SymbolImpl;
+	class Symbol : public Node
+	{
+	public:
+		typedef boost::shared_ptr<Symbol> Ptr;
+		Symbol();
+		Symbol(const std::string & name);
+		Symbol(const Symbol & other);
+		virtual ~Symbol();
+		const std::string & get_name() const;
+		std::string& set_name(const std::string & name);
+		virtual Symbol & operator=(const Symbol & other);
+	private:
+		SymbolImpl * _symbol_impl;
+	};
+}
+
+#endif /* __symbol_hpp__ */
--- policyrep.new.orig/libpolicyrep/include/policyrep/te_decl.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/te_decl.hpp
@@ -4,6 +4,7 @@
 #define __te_decl_hpp__
 
 #include <policyrep/policy_base.hpp>
+#include <policyrep/symbol.hpp>
 
 namespace policyrep
 {
@@ -13,7 +14,7 @@ namespace policyrep
         //
 
 	struct TypeImpl;
-        class Type : public Node
+	class Type : public Symbol
 	{
         public:
 		Type();
@@ -40,9 +41,6 @@ namespace policyrep
 			aliases().insert(aliases_begin, aliases_end);
 		}
 
-                virtual const std::string& get_name() const;
-                virtual void set_name(const std::string& name);
-
                 virtual StringSet& aliases();
                 virtual StringSet& attributes();
         protected:
@@ -58,7 +56,7 @@ namespace policyrep
 	//
 
 	struct AttributeImpl;
-	class Attribute : public Node
+	class Attribute : public Symbol
         {
 	public:
 		Attribute();
@@ -67,8 +65,6 @@ namespace policyrep
 		virtual ~Attribute();
 		virtual void operator=(const Attribute& other);
 
-		virtual const std::string& get_name() const;
-		virtual void set_name(const std::string& name);
 	protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
 		virtual void copy(const Attribute& other);
--- policyrep.new.orig/libpolicyrep/include/policyrep/user.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/user.hpp
@@ -5,6 +5,7 @@
 
 #include <policyrep/policy_base.hpp>
 #include <policyrep/mls.hpp>
+#include <policyrep/symbol.hpp>
 
 namespace policyrep
 {
@@ -14,7 +15,7 @@ namespace policyrep
 	//
 
 	struct UserImpl;
-	class User : public Node
+	class User : public Symbol
 	{
 		public:
 			User();
@@ -43,9 +44,6 @@ namespace policyrep
 					set_range_high(high);
 				}
 
-
-			virtual const std::string& get_name() const;
-			virtual void set_name(const std::string& name);
 			virtual void set_level(LevelPtr level);
 			virtual void set_range_low(LevelPtr low);
 			virtual void set_range_high(LevelPtr high);
--- policyrep.new.orig/libpolicyrep/src/conditional.cpp
+++ policyrep.new/libpolicyrep/src/conditional.cpp
@@ -33,23 +33,21 @@ namespace policyrep
 
 	struct CondBoolImpl
 	{
-		std::string name;
 		bool default_value;
 	};
 
-	CondBool::CondBool() : impl(new CondBoolImpl)
+	CondBool::CondBool() : Symbol(), impl(new CondBoolImpl)
 	{
 
 	}
 
 	CondBool::CondBool(const std::string& name, bool v)
-		: impl(new CondBoolImpl)
+	:Symbol(name), impl(new CondBoolImpl)
 	{
-		impl->name = name;
 		impl->default_value = v;
 	}
 
-	CondBool::CondBool(const CondBool& other) : Node(), impl(new CondBoolImpl)
+	CondBool::CondBool(const CondBool& other) : Symbol(other), impl(new CondBoolImpl)
 	{
 		copy(other);
 	}
@@ -61,19 +59,10 @@ namespace policyrep
 
 	void CondBool::operator=(const CondBool& other)
 	{
+		Symbol::operator=(other);
 		copy(other);
 	}
 
-	void CondBool::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
-	const std::string& CondBool::get_name() const
-	{
-		return impl->name;
-	}
-
 	void CondBool::set_default_value(bool v)
 	{
 		impl->default_value = v;
@@ -86,7 +75,7 @@ namespace policyrep
 
 	void CondBool::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << "bool " << impl->name << " ";
+		o << "bool " << get_name() << " ";
 		if (impl->default_value)
 			o << "true;";
 		else
--- policyrep.new.orig/libpolicyrep/src/mls.cpp
+++ policyrep.new/libpolicyrep/src/mls.cpp
@@ -29,7 +29,6 @@ namespace policyrep
 
 	struct SensitivityImpl
 	{
-		std::string name;
 		StringSet aliases;
 	};
 
@@ -38,18 +37,22 @@ namespace policyrep
 		impl = new SensitivityImpl;
 	}
 
-	Sensitivity::Sensitivity() { init(); }
+	Sensitivity::Sensitivity()
+	:Symbol()
+	{
+		impl = new SensitivityImpl;
+	}
 
 	Sensitivity::Sensitivity(const std::string& name)
+	:Symbol(name)
 	{
-		init();
-		impl->name = name;
+		impl = new SensitivityImpl;
 	}
 
 	Sensitivity::Sensitivity(const Sensitivity& other)
-		: Node()
+	:Symbol(other)
 	{
-		init();
+		impl = new SensitivityImpl;
 		*impl = *other.impl;
 	}
 
@@ -60,16 +63,6 @@ namespace policyrep
 		*impl = *other.impl;
 	}
 
-	const std::string& Sensitivity::get_name() const
-	{
-		return impl->name;
-	}
-
-	void Sensitivity::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
 	StringSet& Sensitivity::aliases()
 	{
 		return impl->aliases;
@@ -77,7 +70,7 @@ namespace policyrep
 
 	void Sensitivity::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << "sensitivity " << impl->name;
+		o << "sensitivity " << get_name();
 		if (!impl->aliases.empty()) {
 			o << " alias ";
 			bracket_output_container(o, impl->aliases.begin(),
@@ -137,7 +130,6 @@ namespace policyrep
 
 	struct CategoryImpl
 	{
-		std::string name;
 		StringSet aliases;
 	};
 
@@ -146,16 +138,20 @@ namespace policyrep
 		impl = new CategoryImpl;
 	}
 
-	Category::Category() { init(); }
+	Category::Category()
+	:Symbol()
+	{
+		impl = new CategoryImpl;
+	}
 
 	Category::Category(const std::string& name)
+	:Symbol(name)
 	{
-		init();
-		impl->name = name;
+		impl = new CategoryImpl;
 	}
 
 	Category::Category(const Category& other)
-		: Node()
+	:Symbol(other)
 	{
 		init();
 		*impl = *other.impl;
@@ -168,16 +164,6 @@ namespace policyrep
 		*impl = *other.impl;
 	}
 
-	const std::string& Category::get_name() const
-	{
-		return impl->name;
-	}
-
-	void Category::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
 	StringSet& Category::aliases()
 	{
 		return impl->aliases;
@@ -185,7 +171,7 @@ namespace policyrep
 
 	void Category::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << "category " << impl->name;
+		o << "category " << get_name();
 		if (!impl->aliases.empty()) {
 			o << " alias ";
 			bracket_output_container(o, impl->aliases.begin(),
@@ -209,18 +195,22 @@ namespace policyrep
 		impl = new LevelImpl;
 	}
 
-	Level::Level() { init(); }
+	Level::Level()
+	:Symbol()
+	{
+		impl = new LevelImpl;
+	}
 
 	Level::Level(const std::string& name)
+	:Symbol(name)
 	{
-		init();
-		impl->name = name;
+		impl = new LevelImpl;
 	}
 
 	Level::Level(const Level& other)
-		: Node()
+	:Symbol(other)
 	{
-		init();
+		impl = new LevelImpl;
 		*impl = *other.impl;
 	}
 
@@ -233,16 +223,6 @@ namespace policyrep
 		*impl = *other.impl;
 	}
 
-	const std::string& Level::get_name() const
-	{
-		return impl->name;
-	}
-
-	void Level::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
 	StringSet& Level::categories()
 	{
 		return impl->categories;
@@ -250,7 +230,7 @@ namespace policyrep
 
 	void Level::do_output_brief(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << impl->name;
+		o << get_name();
 		if (!impl->categories.empty()) {
 			o << ":";
 			bracket_output_container(o, impl->categories.begin(),
--- /dev/null
+++ policyrep.new/libpolicyrep/src/symbol.cpp
@@ -0,0 +1,71 @@
+/*
+ * Author : Jeremy A. Mowery <jmowery@tresys.com>
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
+#include <policyrep/symbol.hpp>
+
+namespace policyrep
+{
+	struct SymbolImpl
+	{
+		std::string name;
+	};
+
+	Symbol::Symbol()
+	:Node()
+	{
+		_symbol_impl = new SymbolImpl;
+	}
+
+	Symbol::Symbol(const std::string & name)
+	:Node()
+	{
+		_symbol_impl = new SymbolImpl;
+		_symbol_impl->name = name;
+	}
+
+	Symbol::Symbol(const Symbol & other)
+	:Node(other)
+	{
+		_symbol_impl = new SymbolImpl;
+		*_symbol_impl = *other._symbol_impl;
+	}
+
+	Symbol::~Symbol()
+	{
+		delete _symbol_impl;
+	}
+
+	const std::string & Symbol::get_name() const
+	{
+		return _symbol_impl->name;
+	}
+
+	std::string& Symbol::set_name(const std::string & name)
+	{
+		return _symbol_impl->name = name;
+	}
+
+	Symbol & Symbol::operator=(const Symbol & other)
+	{
+		Node::operator=(other);
+		*_symbol_impl = *other._symbol_impl;
+		return *this;
+	}
+}
--- policyrep.new.orig/libpolicyrep/src/object_class.cpp
+++ policyrep.new/libpolicyrep/src/object_class.cpp
@@ -28,7 +28,6 @@ namespace policyrep {
 
 	struct CommonPermsImpl
 	{
-		std::string name;
 		StringSet perms;
 	};
 
@@ -37,10 +36,10 @@ namespace policyrep {
 	CommonPerms::CommonPerms() { init(); }
 
 	CommonPerms::CommonPerms(const CommonPerms& other)
-		: Node()
+	:Symbol(other)
 	{
-		init();
-		copy(other);
+		impl = new CommonPermsImpl;
+		*impl = *other.impl;
 	}
 
 	CommonPerms::~CommonPerms()
@@ -53,16 +52,6 @@ namespace policyrep {
 		copy(other);
 	}
 
-	const std::string& CommonPerms::get_name() const
-	{
-		return impl->name;
-	}
-
-	void CommonPerms::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
 	StringSet& CommonPerms::perms()
 	{
 		return impl->perms;
@@ -70,7 +59,7 @@ namespace policyrep {
 
 	void CommonPerms::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << "common " << impl->name << " ";
+		o << "common " << get_name() << " ";
 		output_set_space(o, impl->perms);
 	}
 
@@ -86,7 +75,6 @@ namespace policyrep {
 
 	struct ObjectClassImpl
 	{
-		std::string name;
 		StringSet perms;
 		std::string common_perms;
 	};
@@ -95,15 +83,21 @@ namespace policyrep {
 
 	ObjectClass::ObjectClass() { init(); }
 
+	ObjectClass::ObjectClass(const std::string &name)
+	:Symbol(name)
+	{
+		impl = new ObjectClassImpl;
+	}
+
 	ObjectClass::ObjectClass(const std::string& name, const std::string& commons)
+	:Symbol(name)
 	{
 		init();
-		set_name(name);
 		set_common_perms(commons);
 	}
 
 	ObjectClass::ObjectClass(const ObjectClass& other)
-		: Node()
+	:Symbol(other)
 	{
 		init();
 		copy(other);
@@ -119,16 +113,6 @@ namespace policyrep {
 		copy(other);
 	}
 
-	const std::string& ObjectClass::get_name() const
-	{
-		return impl->name;
-	}
-
-	void ObjectClass::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
 	StringSet& ObjectClass::perms()
 	{
 		return impl->perms;
@@ -146,7 +130,7 @@ namespace policyrep {
 
 	void ObjectClass::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << "class " << impl->name;
+		o << "class " << get_name();
 		if (impl->common_perms != "")
 			o << " inherits " << impl->common_perms;
 		if (!impl->perms.empty()) {
--- policyrep.new.orig/libpolicyrep/src/policy.cpp
+++ policyrep.new/libpolicyrep/src/policy.cpp
@@ -148,20 +148,18 @@ namespace policyrep
 
 	struct InitialSidImpl
 	{
-		std::string name;
 	};
 
 	InitialSid::InitialSid()
-		: impl(new InitialSidImpl) { }
+		:Symbol(), impl(new InitialSidImpl) { }
 
 	InitialSid::InitialSid(const std::string& name)
-		: impl(new InitialSidImpl)
+		:Symbol(name), impl(new InitialSidImpl)
 	{
-		impl->name = name;
 	}
 
 	InitialSid::InitialSid(const InitialSid& other)
-		: Node(), impl(new InitialSidImpl)
+		: Symbol(other), impl(new InitialSidImpl)
 	{
 		copy(other);
 	}
@@ -173,19 +171,9 @@ namespace policyrep
 		copy(other);
 	}
 
-	const std::string& InitialSid::get_name() const
-	{
-		return impl->name;
-	}
-
-	void InitialSid::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
 	void InitialSid::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << "sid " << impl->name;
+		o << "sid " << get_name();
 	}
 
 	void InitialSid::copy(const InitialSid& other)
--- policyrep.new.orig/libpolicyrep/src/rbac.cpp
+++ policyrep.new/libpolicyrep/src/rbac.cpp
@@ -29,7 +29,6 @@ namespace policyrep
 
 	struct RoleImpl
 	{
-		std::string name;
 		StringSet types;
 	};
 
@@ -38,18 +37,22 @@ namespace policyrep
 		impl = new RoleImpl;
 	}
 
-	Role::Role() { init(); }
+	Role::Role()
+	:Symbol()
+	{
+		impl = new RoleImpl;
+	}
 
 	Role::Role(const std::string& name)
+	:Symbol(name)
 	{
-		init();
-		impl->name = name;
+		impl = new RoleImpl;
 	}
 
 	Role::Role(const Role& other)
-		: Node()
+	:Symbol(other)
 	{
-		init();
+		impl = new RoleImpl;
 		*impl = *other.impl;
 	}
 
@@ -60,16 +63,6 @@ namespace policyrep
 		*impl = *other.impl;
 	}
 
-	const std::string& Role::get_name() const
-	{
-		return impl->name;
-	}
-
-	void Role::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
 	StringSet& Role::types()
 	{
 		return impl->types;
@@ -77,7 +70,7 @@ namespace policyrep
 
 	void Role::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << "role " << impl->name;
+		o << "role " << get_name();
 		if (!impl->types.empty()) {
 			o << " types ";
 			output_set_comma(o, impl->types);
--- policyrep.new.orig/libpolicyrep/src/te_decl.cpp
+++ policyrep.new/libpolicyrep/src/te_decl.cpp
@@ -31,7 +31,6 @@ namespace policyrep
 
 	struct TypeImpl
 	{
-		std::string name;
 		StringSet attributes;
 		StringSet aliases;
 	};
@@ -41,19 +40,23 @@ namespace policyrep
 		impl = new TypeImpl;
 	}
 
-	Type::Type() { init(); }
+	Type::Type()
+	:Symbol()
+	{
+		impl = new TypeImpl;
+	}
 
 	Type::Type(const std::string& name)
+	:Symbol(name)
 	{
-		init();
-		impl->name = name;
+		impl = new TypeImpl;
 	}
 
 	Type::Type(const Type& other)
-		: Node()
+	:Symbol(other)
 	{
-		init();
-		copy(other);
+		impl = new TypeImpl;
+		*impl = *other.impl;
 	}
 
 	Type::~Type() { delete impl; }
@@ -63,16 +66,6 @@ namespace policyrep
 		copy(other);
 	}
 
-	const std::string& Type::get_name() const
-	{
-		return impl->name;
-	}
-
-	void Type::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
 	StringSet& Type::aliases()
 	{
 		return impl->aliases;
@@ -85,7 +78,7 @@ namespace policyrep
 
 	void Type::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << "type " << impl->name;
+		o << "type " << get_name();
 		if (!impl->aliases.empty()) {
 			o << " alias ";
 			output_set_space(o, impl->aliases);
@@ -109,15 +102,16 @@ namespace policyrep
 
 	struct AttributeImpl
 	{
-		std::string name;
 	};
 
-	Attribute::Attribute() : impl(new AttributeImpl) { }
+	Attribute::Attribute()
+	:Symbol(), impl(new AttributeImpl)
+	{
+	}
 
 	Attribute::Attribute(const std::string& name)
-		: impl(new AttributeImpl)
+	:Symbol(name), impl(new AttributeImpl)
 	{
-		impl->name = name;
 	}
 
 	Attribute::~Attribute()
@@ -126,7 +120,7 @@ namespace policyrep
 	}
 
 	Attribute::Attribute(const Attribute& other)
-		: Node(), impl(new AttributeImpl)
+	:Symbol(other), impl(new AttributeImpl)
 	{
 		copy(other);
 	}
@@ -136,19 +130,9 @@ namespace policyrep
 		copy(other);
 	}
 
-	const std::string& Attribute::get_name() const
-	{
-		return impl->name;
-	}
-
-	void Attribute::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
 	void Attribute::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << "attribute " << impl->name << ";";
+		o << "attribute " << get_name() << ";";
 	}
 
 	void Attribute::copy(const Attribute& other)
--- policyrep.new.orig/libpolicyrep/src/user.cpp
+++ policyrep.new/libpolicyrep/src/user.cpp
@@ -30,7 +30,6 @@ namespace policyrep
 
 	struct UserImpl
 	{
-		std::string name;
 		LevelPtr level;
 		RangePtr range;
 		StringSet roles;
@@ -41,18 +40,22 @@ namespace policyrep
 		impl = new UserImpl;
 	}
 
-	User::User() { init(); }
+	User::User()
+	:Symbol()
+	{
+		impl = new UserImpl;
+	}
 
 	User::User(const std::string& name)
+	:Symbol(name)
 	{
-		init();
-		impl->name = name;
+		impl = new UserImpl;
 	}
 
 	User::User(const User& other)
-		: Node()
+	:Symbol(other)
 	{
-		init();
+		impl = new UserImpl;
 		*impl = *other.impl;
 	}
 
@@ -65,16 +68,6 @@ namespace policyrep
 		*impl = *other.impl;
 	}
 
-	const std::string& User::get_name() const
-	{
-		return impl->name;
-	}
-
-	void User::set_name(const std::string& name)
-	{
-		impl->name = name;
-	}
-
 	StringSet& User::roles()
 	{
 		return impl->roles;
@@ -99,7 +92,7 @@ namespace policyrep
 
 	void User::do_output(std::ostream& o, const OutputFormatter& op) const
 	{
-		o << "user " << impl->name;
+		o << "user " << get_name();
 		if (!impl->roles.empty()) {
 			o << " roles ";
 			output_set_comma(o, impl->roles);

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
