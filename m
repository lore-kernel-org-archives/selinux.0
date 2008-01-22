Message-Id: <20080121160228.354469219@manicmethod.com>
References: <20080121160031.792610312@manicmethod.com>
Date: Tue, 22 Jan 2008 14:43:36 -0500
From: Joshua Brindle <method@manicmethod.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com, tmiller@tresys.com
Subject: [POLICYREP] [patch 5/7] fix operator= calls to return pointer
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

foo = bar is expected to return a pointer to the object being set, fix all classes to do this

---
 libpolicyrep/include/policyrep/conditional.hpp  |    8 +++---
 libpolicyrep/include/policyrep/idset.hpp        |    2 -
 libpolicyrep/include/policyrep/mls.hpp          |   10 ++++----
 libpolicyrep/include/policyrep/object_class.hpp |    4 +--
 libpolicyrep/include/policyrep/optional.hpp     |    4 +--
 libpolicyrep/include/policyrep/parse.hpp        |    2 -
 libpolicyrep/include/policyrep/policy.hpp       |    6 ++--
 libpolicyrep/include/policyrep/policy_base.hpp  |   12 ++++-----
 libpolicyrep/include/policyrep/rbac.hpp         |    2 -
 libpolicyrep/include/policyrep/rule.hpp         |    4 +--
 libpolicyrep/include/policyrep/te_decl.hpp      |    8 +++---
 libpolicyrep/include/policyrep/user.hpp         |    2 -
 libpolicyrep/src/conditional.cpp                |   20 ++++++++++------
 libpolicyrep/src/idset.cpp                      |    3 +-
 libpolicyrep/src/mls.cpp                        |   12 ++++++---
 libpolicyrep/src/object_class.cpp               |   10 ++++----
 libpolicyrep/src/optional.cpp                   |   12 ++++++---
 libpolicyrep/src/parse.cpp                      |    3 +-
 libpolicyrep/src/policy.cpp                     |   18 +++++++++-----
 libpolicyrep/src/policy_base.cpp                |   29 +++++++++++++++---------
 libpolicyrep/src/rbac.cpp                       |    4 ++-
 libpolicyrep/src/rule.cpp                       |   12 ++++++---
 libpolicyrep/src/te_decl.cpp                    |   17 +++++++++-----
 libpolicyrep/src/user.cpp                       |    3 +-
 24 files changed, 126 insertions(+), 81 deletions(-)

--- policyrep.new.orig/libpolicyrep/include/policyrep/conditional.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/conditional.hpp
@@ -47,7 +47,7 @@ namespace policyrep
 		CondBool(const std::string& name, bool v);
 		CondBool(const CondBool& other);
 		virtual ~CondBool();
-		virtual void operator=(const CondBool& other);
+		virtual CondBool& operator=(const CondBool& other);
 
 
 		virtual void set_default_value(bool v);
@@ -75,7 +75,7 @@ namespace policyrep
 		CondOp(Op op);
 		CondOp(const CondOp& other);
 		virtual ~CondOp();
-		virtual void operator=(const CondOp& other);
+		virtual CondOp& operator=(const CondOp& other);
 
 		virtual void set_op(Op op);
 		virtual Op get_op() const;
@@ -113,7 +113,7 @@ namespace policyrep
 		CondBlock(CondBranchPtr if_, CondBranchPtr else_);
 		CondBlock(const CondBlock& other);
 		virtual ~CondBlock();
-		virtual void operator=(const CondBlock& other);
+		virtual CondBlock& operator=(const CondBlock& other);
 	protected:
 		void copy(const CondBlock& other);
 		CondBlockImpl* impl;
@@ -130,7 +130,7 @@ namespace policyrep
 		CondBranch();
 		CondBranch(const CondBranch& other);
 		virtual ~CondBranch();
-		virtual void operator=(const CondBranch& other);
+		virtual CondBranch& operator=(const CondBranch& other);
 
 		virtual CondExpr& expr();
 	protected:
--- policyrep.new.orig/libpolicyrep/include/policyrep/idset.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/idset.hpp
@@ -16,7 +16,7 @@ namespace policyrep
 		IdSet();
 		IdSet(const IdSet& other);
 		~IdSet();
-		void operator=(const IdSet& other);
+		IdSet& operator=(const IdSet& other);
 
 		void set_compl(bool val);
 		bool get_compl() const;
--- policyrep.new.orig/libpolicyrep/include/policyrep/mls.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/mls.hpp
@@ -21,7 +21,7 @@ namespace policyrep
 			Sensitivity(const std::string& name);
 			Sensitivity(const Sensitivity& other);
 			virtual ~Sensitivity();
-			virtual void operator=(const Sensitivity& other);
+			virtual Sensitivity& operator=(const Sensitivity& other);
 
 			template<class T>
 				Sensitivity(const std::string& name, T begin, T end)
@@ -50,7 +50,7 @@ namespace policyrep
 			Dominance();
 			Dominance(const Dominance& other);
 			virtual ~Dominance();
-			virtual void operator=(const Dominance& other);
+			virtual Dominance& operator=(const Dominance& other);
 
 			template<class T>
 				Dominance(T begin, T end)
@@ -79,7 +79,7 @@ namespace policyrep
 			Category(const std::string& name);
 			Category(const Category& other);
 			virtual ~Category();
-			virtual void operator=(const Category& other);
+			virtual Category& operator=(const Category& other);
 
 			template<class T>
 				Category(const std::string& name, T begin, T end)
@@ -109,7 +109,7 @@ namespace policyrep
 			Level(const std::string& name);
 			Level(const Level& other);
 			virtual ~Level();
-			virtual void operator=(const Level& other);
+			virtual Level& operator=(const Level& other);
 
 			template<class T>
 				Level(const std::string& name, T begin, T end)
@@ -145,7 +145,7 @@ namespace policyrep
 			virtual const LevelPtr& get_high() const;
 			virtual LevelPtr& get_low();
 			virtual LevelPtr& get_high();
-			virtual void operator=(const Range& other);
+			virtual Range& operator=(const Range& other);
 			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
 		protected:
 			void init();
--- policyrep.new.orig/libpolicyrep/include/policyrep/object_class.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/object_class.hpp
@@ -20,7 +20,7 @@ namespace policyrep
                 CommonPerms();
                 CommonPerms(const CommonPerms& other);
                 virtual ~CommonPerms();
-                virtual void operator=(const CommonPerms& other);
+		virtual CommonPerms& operator=(const CommonPerms& other);
 
 		template<class T>
                 CommonPerms(const std::string& name, T perms_begin, T perms_end)
@@ -53,7 +53,7 @@ namespace policyrep
                 ObjectClass(const std::string& name, const std::string& commons);
 		ObjectClass(const ObjectClass& other);
                 virtual ~ObjectClass();
-		virtual void operator=(const ObjectClass& other);
+		virtual ObjectClass& operator=(const ObjectClass& other);
 
 		template<class T>
                 ObjectClass(std::string name, std::string commons,
--- policyrep.new.orig/libpolicyrep/include/policyrep/optional.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/optional.hpp
@@ -19,7 +19,7 @@ namespace policyrep
 		OptionalBlock(OptionalBranchPtr true_);
 		OptionalBlock(OptionalBranchPtr true_, OptionalBranchPtr false_);
 		virtual ~OptionalBlock();
-		virtual void operator=(const OptionalBlock& other);
+		virtual OptionalBlock& operator=(const OptionalBlock& other);
 	protected:
 		void copy(const OptionalBlock& other);
 		OptionalBlockImpl* impl;
@@ -33,7 +33,7 @@ namespace policyrep
 		OptionalBranch();
 		OptionalBranch(const OptionalBranch& other);
 		virtual ~OptionalBranch();
-		virtual void operator=(const OptionalBranch& other);
+		virtual OptionalBranch& operator=(const OptionalBranch& other);
 		
 	protected:
 		virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
--- policyrep.new.orig/libpolicyrep/include/policyrep/parse.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/parse.hpp
@@ -18,7 +18,7 @@ namespace policyrep {
 		Parser();
 		Parser(const Parser& other);
 		virtual ~Parser();
-		virtual void operator=(const Parser& other);
+		virtual Parser& operator=(const Parser& other);
 
 		// Parser
 		virtual ModulePtr parse(const std::string& f);
--- policyrep.new.orig/libpolicyrep/include/policyrep/policy.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/policy.hpp
@@ -28,7 +28,7 @@ namespace policyrep
 		Policy(bool mls=false);
 		Policy(const Policy& other);
 		virtual ~Policy();
-		virtual void operator=(const Policy& other);
+		virtual Policy& operator=(const Policy& other);
 
 		virtual bool get_mls() const;
 		virtual void set_mls(bool val);
@@ -50,7 +50,7 @@ namespace policyrep
                 Module(const std::string& name, const std::string& version);
 		Module(const Module& other);
                 virtual ~Module();
-		virtual void operator=(const Module& other);
+		virtual Module& operator=(const Module& other);
 
                 virtual const std::string& get_name() const;
                 virtual void set_name(const std::string& name);
@@ -77,7 +77,7 @@ namespace policyrep
                 InitialSid(const std::string& name);
 		InitialSid(const InitialSid& other);
                 virtual ~InitialSid();
-		virtual void operator=(const InitialSid& other);
+		virtual InitialSid& operator=(const InitialSid& other);
 
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
--- policyrep.new.orig/libpolicyrep/include/policyrep/policy_base.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/policy_base.hpp
@@ -82,7 +82,7 @@ namespace policyrep {
 		OutputFormatter();
 		OutputFormatter(const OutputFormatter& other);
 		~OutputFormatter();
-		void operator=(const OutputFormatter& other);
+		OutputFormatter& operator=(const OutputFormatter& other);
 
 		OutputFormatter& operator()(const Node& n, bool end=false);
 		OutputFormatter& operator()(NodePtr n, bool end=false);
@@ -117,7 +117,7 @@ namespace policyrep {
                 Node();
 		Node(const Node& other);
                 virtual ~Node();
-		virtual void operator=(const Node& other);
+		virtual Node& operator=(const Node& other);
                 
                 virtual void set_parent(Parent* p);
                 virtual Parent* get_parent() const;
@@ -153,7 +153,7 @@ namespace policyrep {
 		explicit TreeIterator(Parent* n, enum Strategy strategy=POSTORDER);
 		TreeIterator(const TreeIterator& other);
 		virtual ~TreeIterator();
-                void operator=(const TreeIterator& other);
+                TreeIterator& operator=(const TreeIterator& other);
                 bool get_visited() const;
         private:
                 friend class boost::iterator_core_access;
@@ -177,7 +177,7 @@ namespace policyrep {
 		Parent();
 		Parent(const Parent& other);
 		virtual ~Parent();
-		virtual void operator=(const Parent& other);
+		virtual Parent& operator=(const Parent& other);
                 typedef TreeIterator iterator;                
 
                 virtual void append_child(NodePtr Node);
@@ -223,7 +223,7 @@ namespace policyrep {
 		PolicyBlock(PolicyBranchPtr true_, PolicyBranchPtr false_);
 		PolicyBlock(const PolicyBlock& other);
 		virtual ~PolicyBlock();
-		virtual void operator=(const PolicyBlock& other);
+		virtual PolicyBlock& operator=(const PolicyBlock& other);
 
 		virtual void append_child(PolicyBranchPtr node);
 
@@ -250,7 +250,7 @@ namespace policyrep {
 		PolicyBranch();
 		PolicyBranch(const PolicyBranch& other);
 		virtual ~PolicyBranch();
-		virtual void operator=(const PolicyBranch& other);
+		virtual PolicyBranch& operator=(const PolicyBranch& other);
 
 		virtual void set_isfalse(bool v);
 		virtual bool get_isfalse() const;
--- policyrep.new.orig/libpolicyrep/include/policyrep/rbac.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/rbac.hpp
@@ -21,7 +21,7 @@ namespace policyrep
 		Role(const std::string& name);
 		Role(const Role& other);
 		virtual ~Role();
-		virtual void operator=(const Role& other);
+		virtual Role& operator=(const Role& other);
 
 		template<class T>
                 Role(const std::string& name, T types_begin, T end)
--- policyrep.new.orig/libpolicyrep/include/policyrep/rule.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/rule.hpp
@@ -21,7 +21,7 @@ namespace policyrep
                 AVRule(Type type=ALLOW);
                 AVRule(const AVRule& other);
                 virtual ~AVRule();
-                virtual void operator=(const AVRule& other);
+                virtual AVRule& operator=(const AVRule& other);
 
 		virtual void set_type(Type type);
 		virtual Type get_type() const;
@@ -50,7 +50,7 @@ namespace policyrep
 		TypeRule(Type type=TRANSITION);
 		TypeRule(const TypeRule& other);
 		virtual ~TypeRule();
-		virtual void operator=(const TypeRule& other);
+		virtual TypeRule& operator=(const TypeRule& other);
 
 		virtual void set_type(Type type);
 		virtual Type get_type() const;
--- policyrep.new.orig/libpolicyrep/include/policyrep/te_decl.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/te_decl.hpp
@@ -21,7 +21,7 @@ namespace policyrep
 		Type(const std::string& name);
 		Type(const Type& other);
 		virtual ~Type();
-		virtual void operator=(const Type& other);
+		virtual Type& operator=(const Type& other);
 
 		template<class T>
                 Type(const std::string& name, T attrs_begin, T end)
@@ -63,7 +63,7 @@ namespace policyrep
 		Attribute(const std::string& name);
 		Attribute(const Attribute& other);
 		virtual ~Attribute();
-		virtual void operator=(const Attribute& other);
+		virtual Attribute& operator=(const Attribute& other);
 
 	protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
@@ -83,7 +83,7 @@ namespace policyrep
 		TypeAttribute();
 		TypeAttribute(const TypeAttribute& other);
 		virtual ~TypeAttribute();
-		virtual void operator=(const TypeAttribute& other);
+		virtual TypeAttribute& operator=(const TypeAttribute& other);
 
 		template<class T>
 		TypeAttribute(const std::string& name, T attrs_begin,
@@ -116,7 +116,7 @@ namespace policyrep
                 TypeAlias();
                 TypeAlias(const TypeAlias& other);
                 virtual ~TypeAlias();
-                virtual void operator=(const TypeAlias& other);
+		virtual TypeAlias& operator=(const TypeAlias& other);
 
                 template<class T>
                 TypeAlias(const std::string& name, T attrs_begin,
--- policyrep.new.orig/libpolicyrep/include/policyrep/user.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/user.hpp
@@ -22,7 +22,7 @@ namespace policyrep
 			User(const std::string& name);
 			User(const User& other);
 			virtual ~User();
-			virtual void operator=(const User& other);
+			virtual User& operator=(const User& other);
 
 			template<class T>
 				User(const std::string& name, T roles_begin, T end)
--- policyrep.new.orig/libpolicyrep/src/idset.cpp
+++ policyrep.new/libpolicyrep/src/idset.cpp
@@ -45,9 +45,10 @@ namespace policyrep
 
 	IdSet::~IdSet() { delete impl; }
 
-	void IdSet::operator=(const IdSet& other)
+	IdSet& IdSet::operator=(const IdSet& other)
 	{
 		*impl = *other.impl;
+		return *this;
 	}
 
 	void IdSet::set_compl(bool val)
--- policyrep.new.orig/libpolicyrep/src/policy.cpp
+++ policyrep.new/libpolicyrep/src/policy.cpp
@@ -47,9 +47,11 @@ namespace policyrep
 
 	Policy::~Policy() { delete impl; }
 
-	void Policy::operator=(const Policy& other)
+	Policy& Policy::operator=(const Policy& other)
 	{
-		copy(other);
+		Parent::operator=(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	bool Policy::get_mls() const
@@ -98,9 +100,11 @@ namespace policyrep
 
 	Module::~Module() { delete impl; }
 
-	void Module::operator=(const Module& other)
+	Module& Module::operator=(const Module& other)
 	{
-		copy(other);
+		Parent::operator=(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	const std::string& Module::get_name() const
@@ -166,9 +170,11 @@ namespace policyrep
 
 	InitialSid::~InitialSid() { delete impl; }
 
-	void InitialSid::operator=(const InitialSid& other)
+	InitialSid& InitialSid::operator=(const InitialSid& other)
 	{
-		copy(other);
+		Symbol::operator=(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	void InitialSid::do_output(std::ostream& o, const OutputFormatter& op) const
--- policyrep.new.orig/libpolicyrep/src/conditional.cpp
+++ policyrep.new/libpolicyrep/src/conditional.cpp
@@ -57,10 +57,11 @@ namespace policyrep
 		delete impl;
 	}
 
-	void CondBool::operator=(const CondBool& other)
+	CondBool& CondBool::operator=(const CondBool& other)
 	{
 		Symbol::operator=(other);
-		copy(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	void CondBool::set_default_value(bool v)
@@ -125,9 +126,10 @@ namespace policyrep
 		delete impl;
 	}
 
-	void CondOp::operator=(const CondOp& other)
+	CondOp& CondOp::operator=(const CondOp& other)
 	{
 		*impl = *other.impl;
+		return *this;
 	}
 
 	void CondOp::set_bool(const std::string& b)
@@ -212,9 +214,11 @@ namespace policyrep
 		delete impl;
 	}
 
-	void CondBlock::operator=(const CondBlock& other)
+	CondBlock& CondBlock::operator=(const CondBlock& other)
 	{
-		copy(other);
+		PolicyBlock::operator=(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	void CondBlock::copy(const CondBlock& other)
@@ -248,9 +252,11 @@ namespace policyrep
 		delete impl;
 	}
 
-	void CondBranch::operator=(const CondBranch& other)
+	CondBranch& CondBranch::operator=(const CondBranch& other)
 	{
-		copy(other);
+		PolicyBranch::operator=(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	CondExpr& CondBranch::expr()
--- policyrep.new.orig/libpolicyrep/src/mls.cpp
+++ policyrep.new/libpolicyrep/src/mls.cpp
@@ -104,9 +104,10 @@ namespace policyrep
 
 	Dominance::~Dominance() { delete impl; }
 
-	void Dominance::operator=(const Dominance& other)
+	Dominance& Dominance::operator=(const Dominance& other)
 	{
 		*impl = *other.impl;
+		return *this;
 	}
 
 	StringVector& Dominance::ordering()
@@ -159,9 +160,10 @@ namespace policyrep
 
 	Category::~Category() { delete impl; }
 
-	void Category::operator=(const Category& other)
+	Category& Category::operator=(const Category& other)
 	{
 		*impl = *other.impl;
+		return *this;
 	}
 
 	StringSet& Category::aliases()
@@ -218,9 +220,10 @@ namespace policyrep
 		delete impl;
 	}
 
-	void Level::operator=(const Level& other)
+	Level& Level::operator=(const Level& other)
 	{
 		*impl = *other.impl;
+		return *this;
 	}
 
 	StringSet& Level::categories()
@@ -285,9 +288,10 @@ namespace policyrep
 		delete impl;
 	}
 
-	void Range::operator=(const Range& other)
+	Range& Range::operator=(const Range& other)
 	{
 		*impl = *(other.impl);
+		return *this;
 	}
 
 	const LevelPtr& Range::get_low(void) const
--- policyrep.new.orig/libpolicyrep/src/object_class.cpp
+++ policyrep.new/libpolicyrep/src/object_class.cpp
@@ -47,9 +47,10 @@ namespace policyrep {
 		delete impl;
 	}
 
-	void CommonPerms::operator=(const CommonPerms& other)
+	CommonPerms& CommonPerms::operator=(const CommonPerms& other)
 	{
-		copy(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	StringSet& CommonPerms::perms()
@@ -108,9 +109,10 @@ namespace policyrep {
 		delete impl;
 	}
 
-	void ObjectClass::operator=(const ObjectClass& other)
+	ObjectClass& ObjectClass::operator=(const ObjectClass& other)
 	{
-		copy(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	StringSet& ObjectClass::perms()
--- policyrep.new.orig/libpolicyrep/src/optional.cpp
+++ policyrep.new/libpolicyrep/src/optional.cpp
@@ -52,9 +52,11 @@ namespace policyrep
 		delete impl;
 	}
 
-	void OptionalBlock::operator=(const OptionalBlock& other)
+	OptionalBlock& OptionalBlock::operator=(const OptionalBlock& other)
 	{
-		copy(other);
+		PolicyBlock::operator=(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	void OptionalBlock::copy(const OptionalBlock& other)
@@ -81,9 +83,11 @@ namespace policyrep
 		delete impl;
 	}
 
-	void OptionalBranch::operator=(const OptionalBranch& other)
+	OptionalBranch& OptionalBranch::operator=(const OptionalBranch& other)
 	{
-		copy(other);
+		PolicyBranch::operator=(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	void OptionalBranch::do_output(std::ostream& o, const OutputFormatter& op) const
--- policyrep.new.orig/libpolicyrep/src/parse.cpp
+++ policyrep.new/libpolicyrep/src/parse.cpp
@@ -46,9 +46,10 @@ namespace policyrep {
 
 	Parser::~Parser() { delete impl; }
 
-	void Parser::operator=(const Parser& other)
+	Parser& Parser::operator=(const Parser& other)
 	{
 		*impl = *other.impl;
+		return *this;
 	}
 
 	ModulePtr Parser::parse(const std::string& f)
--- policyrep.new.orig/libpolicyrep/src/policy_base.cpp
+++ policyrep.new/libpolicyrep/src/policy_base.cpp
@@ -99,9 +99,10 @@ namespace policyrep
 		delete impl;
 	}
 
-	void OutputFormatter::operator=(const OutputFormatter& other)
+	OutputFormatter& OutputFormatter::operator=(const OutputFormatter& other)
 	{
 		*impl = *other.impl;
+		return *this;
 	}
 
 	OutputFormatter& OutputFormatter::operator()(const Node& n, bool end)
@@ -207,10 +208,11 @@ namespace policyrep
 		delete node_impl;
 	}
 
-	void Node::operator=(const Node& other)
+	Node& Node::operator=(const Node& other)
 	{
 		std::cout << "node" << std::endl;
-		copy(other);
+		*node_impl = *other.node_impl;
+		return *this;
 	}
 
 	void Node::set_parent(Parent* parent)
@@ -342,9 +344,10 @@ namespace policyrep
 		delete impl;
 	}
 
-	void TreeIterator::operator=(const TreeIterator& other)
+	TreeIterator& TreeIterator::operator=(const TreeIterator& other)
 	{
 		*impl = *other.impl;
+		return *this;
 	}
 
 	bool TreeIterator::get_visited() const
@@ -448,9 +451,11 @@ namespace policyrep
 		delete parent_impl;
 	}
 
-	void Parent::operator=(const Parent& other)
+	Parent& Parent::operator=(const Parent& other)
 	{
-		copy(other);
+		Node::operator=(other);
+		*parent_impl = *other.parent_impl;
+		return *this;
 	}
 
 	void Parent::make_child(NodePtr node)
@@ -540,9 +545,11 @@ namespace policyrep
 		delete block_impl;
 	}
 
-	void PolicyBlock::operator=(const PolicyBlock& other)
+	PolicyBlock& PolicyBlock::operator=(const PolicyBlock& other)
 	{
-		copy(other);
+		Parent::operator=(other);
+		*block_impl = *other.block_impl;
+		return *this;
 	}
 
 	void PolicyBlock::append_child(PolicyBranchPtr node)
@@ -652,9 +659,11 @@ namespace policyrep
 		delete branch_impl;
 	}
 
-	void PolicyBranch::operator=(const PolicyBranch& other)
+	PolicyBranch& PolicyBranch::operator=(const PolicyBranch& other)
 	{
-		copy(other);
+		Parent::operator=(other);
+		*branch_impl = *other.branch_impl;
+		return *this;
 	}
 
 	void PolicyBranch::set_isfalse(bool v)
--- policyrep.new.orig/libpolicyrep/src/rbac.cpp
+++ policyrep.new/libpolicyrep/src/rbac.cpp
@@ -58,9 +58,11 @@ namespace policyrep
 
 	Role::~Role() { delete impl; }
 
-	void Role::operator=(const Role& other)
+	Role& Role::operator=(const Role& other)
 	{
+		Symbol::operator=(other);
 		*impl = *other.impl;
+		return *this;
 	}
 
 	StringSet& Role::types()
--- policyrep.new.orig/libpolicyrep/src/rule.cpp
+++ policyrep.new/libpolicyrep/src/rule.cpp
@@ -59,9 +59,11 @@ namespace policyrep
                 delete impl;
         }
 
-        void AVRule::operator=(const AVRule& other)
+	AVRule& AVRule::operator=(const AVRule& other)
         {
-		copy(other);
+		Node::operator=(other);
+		*impl = *other.impl;
+		return *this;
         }
 
 	void AVRule::set_type(AVRule::Type type)
@@ -170,9 +172,11 @@ namespace policyrep
                 delete impl;
         }
 
-        void TypeRule::operator=(const TypeRule& other)
+	TypeRule& TypeRule::operator=(const TypeRule& other)
         {
-		copy(other);
+		Node::operator=(other);
+		*impl = *other.impl;
+		return *this;
         }
 
 	void TypeRule::set_type(TypeRule::Type type)
--- policyrep.new.orig/libpolicyrep/src/te_decl.cpp
+++ policyrep.new/libpolicyrep/src/te_decl.cpp
@@ -61,9 +61,11 @@ namespace policyrep
 
 	Type::~Type() { delete impl; }
 
-	void Type::operator=(const Type& other)
+	Type& Type::operator=(const Type& other)
 	{
-		copy(other);
+		Symbol::operator=(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	StringSet& Type::aliases()
@@ -163,9 +165,10 @@ namespace policyrep
 
 	TypeAttribute::~TypeAttribute() { delete impl; }
 
-	void TypeAttribute::operator=(const TypeAttribute& other)
+	TypeAttribute& TypeAttribute::operator=(const TypeAttribute& other)
 	{
-		copy(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	const std::string& TypeAttribute::get_name() const
@@ -224,9 +227,11 @@ namespace policyrep
                 delete impl;
         }
 
-        void TypeAlias::operator=(const TypeAlias& other)
+	TypeAlias& TypeAlias::operator=(const TypeAlias& other)
         {
-		copy(other);
+		Node::operator=(other);
+		*impl = *other.impl;
+		return *this;
         }
 
         const std::string& TypeAlias::get_name() const
--- policyrep.new.orig/libpolicyrep/src/user.cpp
+++ policyrep.new/libpolicyrep/src/user.cpp
@@ -63,9 +63,10 @@ namespace policyrep
 		delete impl;
 	}
 
-	void User::operator=(const User& other)
+	User& User::operator=(const User& other)
 	{
 		*impl = *other.impl;
+		return *this;
 	}
 
 	StringSet& User::roles()

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
