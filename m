Message-Id: <20080121160230.023865480@manicmethod.com>
References: <20080121160031.792610312@manicmethod.com>
Date: Tue, 22 Jan 2008 14:43:38 -0500
From: Joshua Brindle <method@manicmethod.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com, tmiller@tresys.com
Subject: [POLICYREP] [patch 7/7] remove unused copy/init functions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This removes all copy/init functions because 1) they aren't used anymore and 2) they are dangerous to call as they blow away the old impl. The copy constructors are now used instead of copy()

---
 libpolicyrep/include/policyrep/conditional.hpp  |    2 
 libpolicyrep/include/policyrep/idset.hpp        |    3 
 libpolicyrep/include/policyrep/mls.hpp          |   13 ++-
 libpolicyrep/include/policyrep/object_class.hpp |    9 +-
 libpolicyrep/include/policyrep/optional.hpp     |    2 
 libpolicyrep/include/policyrep/policy.hpp       |    3 
 libpolicyrep/include/policyrep/policy_base.hpp  |    4 -
 libpolicyrep/include/policyrep/rbac.hpp         |    3 
 libpolicyrep/include/policyrep/rule.hpp         |    4 -
 libpolicyrep/include/policyrep/te_decl.hpp      |   14 +---
 libpolicyrep/include/policyrep/user.hpp         |    3 
 libpolicyrep/src/conditional.cpp                |   30 +-------
 libpolicyrep/src/idset.cpp                      |    7 +-
 libpolicyrep/src/mls.cpp                        |   39 ++++++-----
 libpolicyrep/src/object_class.cpp               |   41 ++++++-----
 libpolicyrep/src/optional.cpp                   |   20 +----
 libpolicyrep/src/policy.cpp                     |   30 +-------
 libpolicyrep/src/policy_base.cpp                |   38 ++--------
 libpolicyrep/src/policyrep_python.cpp           |   84 ++++++++++++------------
 libpolicyrep/src/rbac.cpp                       |    5 +
 libpolicyrep/src/rule.cpp                       |   39 ++---------
 libpolicyrep/src/te_decl.cpp                    |   71 +++++++++-----------
 22 files changed, 180 insertions(+), 284 deletions(-)

--- policyrep.new.orig/libpolicyrep/include/policyrep/conditional.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/conditional.hpp
@@ -53,7 +53,6 @@ namespace policyrep
 		virtual void set_default_value(bool v);
 		virtual bool get_default_value() const;
 	protected:
-		void copy(const CondBool& other);
 		virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
 		CondBoolImpl* impl;
 	};
@@ -115,7 +114,6 @@ namespace policyrep
 		virtual ~CondBlock();
 		virtual CondBlock& operator=(const CondBlock& other);
 	protected:
-		void copy(const CondBlock& other);
 		CondBlockImpl* impl;
 	};
 
--- policyrep.new.orig/libpolicyrep/include/policyrep/idset.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/idset.hpp
@@ -38,8 +38,9 @@ namespace policyrep
 		StringSet& ids();
 		StringSet& neg_ids();
 	protected:
-		void init();
 		IdSetImpl* impl;
+	private:
+		void init();
 	};
 
 
--- policyrep.new.orig/libpolicyrep/include/policyrep/mls.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/mls.hpp
@@ -34,8 +34,9 @@ namespace policyrep
 			virtual StringSet& aliases();
 		protected:
 			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-			void init();
 			SensitivityImpl* impl;
+		private:
+			void init();
 	};
 	typedef boost::shared_ptr<Sensitivity> SensitivityPtr;
 
@@ -62,8 +63,9 @@ namespace policyrep
 			virtual StringVector& ordering();
 		protected:
 			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-			void init();
 			DominanceImpl* impl;
+		private:
+			void init();
 	};
 	typedef boost::shared_ptr<Dominance> DominancePtr;
 
@@ -91,8 +93,9 @@ namespace policyrep
 
 			virtual StringSet& aliases();
 		protected:
-			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+		private:
 			void init();
+			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
 			CategoryImpl* impl;
 	};
 	typedef boost::shared_ptr<Category> CategoryPtr;
@@ -123,8 +126,9 @@ namespace policyrep
 			virtual void do_output_brief(std::ostream& o, const OutputFormatter& op) const;
 		protected:
 			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-			void init();
 			LevelImpl* impl;
+		private:
+			void init();
 	};
 	typedef boost::shared_ptr<Level> LevelPtr;
 
@@ -148,7 +152,6 @@ namespace policyrep
 			virtual Range& operator=(const Range& other);
 			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
 		protected:
-			void init();
 			RangeImpl* impl;
 	};
 	typedef boost::shared_ptr<Range> RangePtr;
--- policyrep.new.orig/libpolicyrep/include/policyrep/object_class.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/object_class.hpp
@@ -34,9 +34,9 @@ namespace policyrep
 
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		void init();
-		void copy(const CommonPerms& other);
 		CommonPermsImpl* impl;
+	private:
+		void init();
         };
 	typedef boost::shared_ptr<CommonPerms> CommonPermsPtr;
 
@@ -71,13 +71,12 @@ namespace policyrep
 
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		void init();
-		void copy(const ObjectClass& other);
         	ObjectClassImpl* impl;
+	private:
+		void init();
         };
 	typedef boost::shared_ptr<ObjectClass> ObjectClassPtr;
 
-
 } // namespace policyrep
 
 #endif
--- policyrep.new.orig/libpolicyrep/include/policyrep/optional.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/optional.hpp
@@ -21,7 +21,6 @@ namespace policyrep
 		virtual ~OptionalBlock();
 		virtual OptionalBlock& operator=(const OptionalBlock& other);
 	protected:
-		void copy(const OptionalBlock& other);
 		OptionalBlockImpl* impl;
 	};
 	typedef boost::shared_ptr<OptionalBlock> OptionalBlockPtr;
@@ -37,7 +36,6 @@ namespace policyrep
 		
 	protected:
 		virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		void copy(const OptionalBranch& other);
 		OptionalBranchImpl* impl;
 	};
 
--- policyrep.new.orig/libpolicyrep/include/policyrep/policy_base.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/policy_base.hpp
@@ -132,7 +132,6 @@ namespace policyrep {
         protected:
 		virtual void output_indentation(std::ostream& o, const OutputFormatter& op) const;
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		void copy(const Node& other);
 		NodeImpl* node_impl;
                 static const int VISITED = 1;
         };
@@ -197,7 +196,6 @@ namespace policyrep {
 
 		virtual bool ignore_indent() const;
         protected:
-		void copy(const Parent& other);
 		ParentImpl* parent_impl;   
         };
 	typedef boost::shared_ptr<Parent> ParentPtr;
@@ -235,7 +233,6 @@ namespace policyrep {
 		virtual void set_false(PolicyBranchPtr branch);
 		virtual bool ignore_indent() const;
 	protected:
-		void copy(const PolicyBlock& other);
 		PolicyBlockImpl* block_impl;
 	};
 
@@ -255,7 +252,6 @@ namespace policyrep {
 		virtual void set_isfalse(bool v);
 		virtual bool get_isfalse() const;
 	protected:
-		void copy(const PolicyBranch& other);
 		PolicyBranchImpl* branch_impl;
 	};
 
--- policyrep.new.orig/libpolicyrep/include/policyrep/policy.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/policy.hpp
@@ -34,7 +34,6 @@ namespace policyrep
 		virtual void set_mls(bool val);
 		virtual bool ignore_indent() const;
 	protected:
-		void copy(const Policy& other);
 		PolicyImpl* impl;
 	};
 	typedef boost::shared_ptr<Policy> PolicyPtr;
@@ -60,7 +59,6 @@ namespace policyrep
 
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		void copy(const Module& other);
 		ModuleImpl* impl;
         };
 	typedef boost::shared_ptr<Module> ModulePtr;
@@ -81,7 +79,6 @@ namespace policyrep
 
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		void copy(const InitialSid& other);
 		InitialSidImpl* impl;
         };
 	typedef boost::shared_ptr<InitialSid> InitialSidPtr;
--- policyrep.new.orig/libpolicyrep/include/policyrep/rbac.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/rbac.hpp
@@ -34,8 +34,9 @@ namespace policyrep
                 virtual StringSet& types();
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		void init();
 		RoleImpl* impl;
+	private:
+		void init();
         };
 	typedef boost::shared_ptr<Role> RolePtr;
 
--- policyrep.new.orig/libpolicyrep/include/policyrep/rule.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/rule.hpp
@@ -33,8 +33,6 @@ namespace policyrep
 
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-                void init();
-		void copy(const AVRule& other);
                 AVRuleImpl* impl;
         };
 
@@ -63,8 +61,6 @@ namespace policyrep
 
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-                void init();
-		void copy(const TypeRule& other);
                 TypeRuleImpl* impl;		
 	};
 
--- policyrep.new.orig/libpolicyrep/include/policyrep/te_decl.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/te_decl.hpp
@@ -45,9 +45,9 @@ namespace policyrep
                 virtual StringSet& attributes();
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		void init();
-		virtual void copy(const Type& other);
 		TypeImpl* impl;
+	private:
+		void init();
         };
 	typedef boost::shared_ptr<Type> TypePtr;
 
@@ -67,7 +67,6 @@ namespace policyrep
 
 	protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		virtual void copy(const Attribute& other);
 		AttributeImpl* impl;
 	};
 	typedef boost::shared_ptr<Attribute> AttributePtr;
@@ -99,9 +98,9 @@ namespace policyrep
                 virtual StringSet& attributes();
 	protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		void init();
-		virtual void copy(const TypeAttribute& other);
 		TypeAttributeImpl* impl;
+	private:
+		void init();
 	};
 	typedef boost::shared_ptr<TypeAttribute> TypeAttributePtr;
 
@@ -132,13 +131,12 @@ namespace policyrep
                 virtual StringSet& aliases();
         protected:
                 virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-                void init();
-		virtual void copy(const TypeAlias& other);
                 TypeAliasImpl* impl;
+	private:
+		void init();
         };
         typedef boost::shared_ptr<TypeAlias> TypeAliasPtr;
 
-
 } // namespace policyrep
 
 #endif
--- policyrep.new.orig/libpolicyrep/include/policyrep/user.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/user.hpp
@@ -52,8 +52,9 @@ namespace policyrep
 			virtual StringSet& roles();
 		protected:
 			virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-			void init();
 			UserImpl* impl;
+		private:
+			void init();
 	};
 	typedef boost::shared_ptr<User> UserPtr;
 
--- policyrep.new.orig/libpolicyrep/src/conditional.cpp
+++ policyrep.new/libpolicyrep/src/conditional.cpp
@@ -49,7 +49,7 @@ namespace policyrep
 
 	CondBool::CondBool(const CondBool& other) : Symbol(other), impl(new CondBoolImpl)
 	{
-		copy(other);
+		*impl = *other.impl;
 	}
 
 	CondBool::~CondBool()
@@ -83,12 +83,6 @@ namespace policyrep
 			o << "false;";
 	}
 
-	void CondBool::copy(const CondBool& other)
-	{
-		Node::copy(other);
-		*impl = *other.impl;
-	}
-
 	//
 	// CondOp
 	//
@@ -181,7 +175,6 @@ namespace policyrep
 		return o;
 	}
 
-
 	//
 	// CondBlock
 	//
@@ -204,9 +197,9 @@ namespace policyrep
 		append_child(else_);
 	}
 
-	CondBlock::CondBlock(const CondBlock& other) : PolicyBlock(), impl(new CondBlockImpl)
+	CondBlock::CondBlock(const CondBlock& other) : PolicyBlock(other), impl(new CondBlockImpl)
 	{
-		copy(other);
+		*impl = *other.impl;
 	}
 
 	CondBlock::~CondBlock()
@@ -221,13 +214,6 @@ namespace policyrep
 		return *this;
 	}
 
-	void CondBlock::copy(const CondBlock& other)
-	{
-		PolicyBlock::copy(other);
-		*impl = *other.impl;
-	}
-
-
 	//
 	// CondBranch
 	//
@@ -242,9 +228,9 @@ namespace policyrep
 
 	}
 
-	CondBranch::CondBranch(const CondBranch& other) : PolicyBranch(), impl(new CondBranchImpl)
+	CondBranch::CondBranch(const CondBranch& other) : PolicyBranch(other), impl(new CondBranchImpl)
 	{
-		copy(other);
+		*impl = *other.impl;
 	}
 
 	CondBranch::~CondBranch()
@@ -294,10 +280,4 @@ namespace policyrep
 
 	}
 
-	void CondBranch::copy(const CondBranch& other)
-	{
-		PolicyBranch::copy(other);
-		*impl = *other.impl;
-	}
-
 }
--- policyrep.new.orig/libpolicyrep/src/idset.cpp
+++ policyrep.new/libpolicyrep/src/idset.cpp
@@ -36,11 +36,14 @@ namespace policyrep
 		impl = new IdSetImpl;
 	}
 
-	IdSet::IdSet() { init(); }
+	IdSet::IdSet()
+	{
+		impl = new IdSetImpl;
+	}
 
 	IdSet::IdSet(const IdSet& other)
 	{
-		init();
+		impl = new IdSetImpl;
 		*impl = *other.impl;
 	}
 
--- policyrep.new.orig/libpolicyrep/src/mls.cpp
+++ policyrep.new/libpolicyrep/src/mls.cpp
@@ -56,11 +56,15 @@ namespace policyrep
 		*impl = *other.impl;
 	}
 
-	Sensitivity::~Sensitivity() { delete impl; }
+	Sensitivity::~Sensitivity()
+	{
+		delete impl;
+	}
 
-	void Sensitivity::operator=(const Sensitivity& other)
+	Sensitivity& Sensitivity::operator=(const Sensitivity& other)
 	{
 		*impl = *other.impl;
+		return *this;
 	}
 
 	StringSet& Sensitivity::aliases()
@@ -93,12 +97,16 @@ namespace policyrep
 		impl = new DominanceImpl;
 	}
 
-	Dominance::Dominance() { init(); }
+	Dominance::Dominance()
+	:Node()
+	{
+		impl = new DominanceImpl;
+	}
 
 	Dominance::Dominance(const Dominance& other)
-		: Node()
+	:Node(other)
 	{
-		init();
+		impl = new DominanceImpl;
 		*impl = *other.impl;
 	}
 
@@ -158,7 +166,10 @@ namespace policyrep
 		*impl = *other.impl;
 	}
 
-	Category::~Category() { delete impl; }
+	Category::~Category()
+	{
+		delete impl;
+	}
 
 	Category& Category::operator=(const Category& other)
 	{
@@ -260,26 +271,26 @@ namespace policyrep
 
 	Range::Range()
 	{
-		init();
+		impl = new RangeImpl;
 	}
 
 	Range::Range(LevelPtr low)
 	{
-		init();
+		impl = new RangeImpl;
 		impl->low = low;
 	}
 
 	Range::Range(LevelPtr low, LevelPtr high)
 	{
-		init();
+		impl = new RangeImpl;
 		impl->low = low;
 		impl->high = high;
 	}
 
 	Range::Range(const Range& other)
-		: Node()
+	:Node(other)
 	{
-		init();
+		impl = new RangeImpl;
 		*impl = *(other.impl);
 	}
 
@@ -323,10 +334,4 @@ namespace policyrep
 		}
 	}
 
-	void Range::init()
-	{
-		impl = new RangeImpl;
-	}
-
-
 } // namespace policyrep
--- policyrep.new.orig/libpolicyrep/src/object_class.cpp
+++ policyrep.new/libpolicyrep/src/object_class.cpp
@@ -31,9 +31,15 @@ namespace policyrep {
 		StringSet perms;
 	};
 
-	void CommonPerms::init() { impl = new CommonPermsImpl; }
+	void CommonPerms::init()
+	{
+		impl = new CommonPermsImpl;
+	}
 
-	CommonPerms::CommonPerms() { init(); }
+	CommonPerms::CommonPerms()
+	{
+		impl = new CommonPermsImpl;
+	}
 
 	CommonPerms::CommonPerms(const CommonPerms& other)
 	:Symbol(other)
@@ -49,6 +55,7 @@ namespace policyrep {
 
 	CommonPerms& CommonPerms::operator=(const CommonPerms& other)
 	{
+		Symbol::operator=(other);
 		*impl = *other.impl;
 		return *this;
 	}
@@ -64,12 +71,6 @@ namespace policyrep {
 		output_set_space(o, impl->perms);
 	}
 
-	void CommonPerms::copy(const CommonPerms& other)
-	{
-		Node::copy(other);
-		*impl = *other.impl;
-	}
-
 	//
 	// ObjectClass
 	//
@@ -80,9 +81,15 @@ namespace policyrep {
 		std::string common_perms;
 	};
 
-	void ObjectClass::init() { impl = new ObjectClassImpl; }
+	void ObjectClass::init()
+	{
+		impl = new ObjectClassImpl;
+	}
 
-	ObjectClass::ObjectClass() { init(); }
+	ObjectClass::ObjectClass()
+	{
+		impl = new ObjectClassImpl;
+	}
 
 	ObjectClass::ObjectClass(const std::string &name)
 	:Symbol(name)
@@ -93,15 +100,15 @@ namespace policyrep {
 	ObjectClass::ObjectClass(const std::string& name, const std::string& commons)
 	:Symbol(name)
 	{
-		init();
+		impl = new ObjectClassImpl;
 		set_common_perms(commons);
 	}
 
 	ObjectClass::ObjectClass(const ObjectClass& other)
 	:Symbol(other)
 	{
-		init();
-		copy(other);
+		impl = new ObjectClassImpl;
+		*impl = *other.impl;
 	}
 
 	ObjectClass::~ObjectClass()
@@ -111,6 +118,7 @@ namespace policyrep {
 
 	ObjectClass& ObjectClass::operator=(const ObjectClass& other)
 	{
+		Symbol::operator=(other);
 		*impl = *other.impl;
 		return *this;
 	}
@@ -141,11 +149,4 @@ namespace policyrep {
 		}
 	}
 
-	void ObjectClass::copy(const ObjectClass& other)
-	{
-		Node::copy(other);
-		*impl = *other.impl;
-	}
-
-
 } // namespace policyrep
--- policyrep.new.orig/libpolicyrep/src/optional.cpp
+++ policyrep.new/libpolicyrep/src/optional.cpp
@@ -30,9 +30,9 @@ namespace policyrep
 
 	}
 
-	OptionalBlock::OptionalBlock(const OptionalBlock& other) : PolicyBlock()
+	OptionalBlock::OptionalBlock(const OptionalBlock& other) : PolicyBlock(other)
 	{
-		copy(other);
+		*impl = *other.impl;
 	}
 
 	OptionalBlock::OptionalBlock(OptionalBranchPtr true_)
@@ -59,12 +59,6 @@ namespace policyrep
 		return *this;
 	}
 
-	void OptionalBlock::copy(const OptionalBlock& other)
-	{
-		PolicyBlock::copy(other);
-		*impl = *other.impl;
-	}
-
 	struct OptionalBranchImpl { };
 
 	OptionalBranch::OptionalBranch() : impl(new OptionalBranchImpl)
@@ -73,9 +67,9 @@ namespace policyrep
 	}
 
 	OptionalBranch::OptionalBranch(const OptionalBranch& other)
-		: PolicyBranch(), impl(new OptionalBranchImpl)
+		: PolicyBranch(other), impl(new OptionalBranchImpl)
 	{
-		copy(other);
+		*impl = *other.impl;
 	}
 
 	OptionalBranch::~OptionalBranch()
@@ -103,10 +97,4 @@ namespace policyrep
 		}
 	}
 
-	void OptionalBranch::copy(const OptionalBranch& other)
-	{
-		PolicyBranch::copy(other);
-	}
-
-
 } 
--- policyrep.new.orig/libpolicyrep/src/policy_base.cpp
+++ policyrep.new/libpolicyrep/src/policy_base.cpp
@@ -200,7 +200,7 @@ namespace policyrep
 	Node::Node(const Node& other)
 		: node_impl(new NodeImpl)
 	{
-		copy(other);
+		*node_impl = *other.node_impl;
 	}
 
 	Node::~Node()
@@ -292,11 +292,6 @@ namespace policyrep
 		}
 	}
 
-	void Node::copy(const Node& other)
-	{
-		*node_impl = *other.node_impl;
-	}
-
 	//
 	// TreeIterator
 	//
@@ -440,10 +435,10 @@ namespace policyrep
 		: parent_impl(new ParentImpl) { }
 
 	Parent::Parent(const Parent& other)
-		: Node()
+	:Node(other)
 	{
 		parent_impl = new ParentImpl;
-		copy(other);
+		*parent_impl = *other.parent_impl;
 	}
 
 	Parent::~Parent()
@@ -507,12 +502,6 @@ namespace policyrep
 
 	}
 
-	void Parent::copy(const Parent& other)
-	{
-		Node::copy(other);
-		*parent_impl = *other.parent_impl;
-	}
-
 	//
 	// PolicyBlock
 	//
@@ -535,9 +524,9 @@ namespace policyrep
 		append_child(false_);
 	}
 
-	PolicyBlock::PolicyBlock(const PolicyBlock& other) : Parent(), block_impl(new PolicyBlockImpl)
+	PolicyBlock::PolicyBlock(const PolicyBlock& other) : Parent(other), block_impl(new PolicyBlockImpl)
 	{
-		copy(other);
+		*block_impl = *other.block_impl;
 	}
 
 	PolicyBlock::~PolicyBlock()
@@ -628,12 +617,6 @@ namespace policyrep
 		return true;
 	}
 
-	void PolicyBlock::copy(const PolicyBlock& other)
-	{
-		Parent::copy(other);
-		*block_impl = *other.block_impl;
-	}
-	
 
 	//
 	// PolicyBranch
@@ -649,9 +632,9 @@ namespace policyrep
 
 	}
 
-	PolicyBranch::PolicyBranch(const PolicyBranch& other) : Parent(), branch_impl(new PolicyBranchImpl)
+	PolicyBranch::PolicyBranch(const PolicyBranch& other) : Parent(other), branch_impl(new PolicyBranchImpl)
 	{
-		copy(other);
+		*branch_impl = *other.branch_impl;
 	}
 
 	PolicyBranch::~PolicyBranch()
@@ -676,11 +659,4 @@ namespace policyrep
 		return branch_impl->isfalse;
 	}
 
-	void PolicyBranch::copy(const PolicyBranch& other)
-	{
-		Parent::copy(other);
-		*branch_impl = *other.branch_impl;
-	}
-
-
 } // namespace policyrep
--- policyrep.new.orig/libpolicyrep/src/policy.cpp
+++ policyrep.new/libpolicyrep/src/policy.cpp
@@ -40,9 +40,9 @@ namespace policyrep
 		: impl(new PolicyImpl(mls)) { }
 
 	Policy::Policy(const Policy& other)
-		: Parent(), impl(new PolicyImpl)
+		: Parent(other), impl(new PolicyImpl)
 	{
-		copy(other);
+		*impl = *other.impl;
 	}
 
 	Policy::~Policy() { delete impl; }
@@ -69,12 +69,6 @@ namespace policyrep
 		return true;
 	}
 
-	void Policy::copy(const Policy& other)
-	{
-		Parent::copy(other);
-		*impl = *other.impl;
-	}
-
 	//
 	// Module
 	//
@@ -93,9 +87,9 @@ namespace policyrep
 		: impl(new ModuleImpl(name, version)) { }
 
 	Module::Module(const Module& other)
-		: Parent(), impl(new ModuleImpl)
+		: Parent(other), impl(new ModuleImpl)
 	{
-		copy(other);
+		*impl = *other.impl;
 	}
 
 	Module::~Module() { delete impl; }
@@ -139,13 +133,6 @@ namespace policyrep
 		return true;
 	}
 
-	void Module::copy(const Module& other)
-	{
-		Parent::copy(other);
-		*impl = *other.impl;
-	}
-
-
 	//
 	// InitialSid
 	//
@@ -165,7 +152,7 @@ namespace policyrep
 	InitialSid::InitialSid(const InitialSid& other)
 		: Symbol(other), impl(new InitialSidImpl)
 	{
-		copy(other);
+		*impl = *other.impl;
 	}
 
 	InitialSid::~InitialSid() { delete impl; }
@@ -182,11 +169,4 @@ namespace policyrep
 		o << "sid " << get_name();
 	}
 
-	void InitialSid::copy(const InitialSid& other)
-	{
-		Node::copy(other);
-		*impl = *other.impl;
-	}
-
-
 } // namespace Policyrep
--- policyrep.new.orig/libpolicyrep/src/policyrep_python.cpp
+++ policyrep.new/libpolicyrep/src/policyrep_python.cpp
@@ -58,10 +58,10 @@ BOOST_PYTHON_MODULE(policyrep)
 	//
 
         class_<Node>("Node")
-		.add_property("parent",
-			      make_function(&Node::get_parent,
-					    return_value_policy<reference_existing_object>()),
-			      &Node::set_parent)
+// 		.add_property("parent",
+// 			      make_function(&Node::get_parent,
+// 					    return_value_policy<reference_existing_object>()),
+// 			      &Node::set_parent)
                 .add_property("visited", &Node::get_visited, &Node::set_visited)
                 .def("__str__", &Node::to_string)
                 .def("to_string_end", &Node::to_string_end)
@@ -99,20 +99,20 @@ BOOST_PYTHON_MODULE(policyrep)
 
 
         class_<Module, bases<Parent> >("Module")
-		.add_property("name",
-			      make_function(&Module::get_name,
-					    return_value_policy<copy_const_reference>()),
-			      &Module::set_name)
-		.add_property("version", make_function(&Module::get_version,
-						       return_value_policy<copy_const_reference>()),
-			      &Module::set_version)
+// 		.add_property("name",
+// 			      make_function(&Module::get_name,
+// 					    return_value_policy<copy_const_reference>()),
+// 			      &Module::set_name)
+// 		.add_property("version", make_function(&Module::get_version,
+// 						       return_value_policy<copy_const_reference>()),
+// 			      &Module::set_version)
                 ;
 	register_ptr_to_python<ModulePtr>();
 
 	class_<InitialSid, bases<Node> >("InitialSid")
-		.add_property("name", make_function(&InitialSid::get_name,
-						    return_value_policy<reference_existing_object>()),
-			      &InitialSid::set_name)
+// 		.add_property("name", make_function(&InitialSid::get_name,
+// 						    return_value_policy<reference_existing_object>()),
+// 			      &InitialSid::set_name)
 		;
 	register_ptr_to_python<InitialSidPtr>();
 
@@ -121,10 +121,10 @@ BOOST_PYTHON_MODULE(policyrep)
 	//
 
         class_<Type, bases<Node> >("Type")
-		.add_property("name",
-			      make_function(&Type::get_name,
-					    return_value_policy<copy_const_reference>()),
-			      &Type::set_name)
+// 		.add_property("name",
+// 			      make_function(&Type::get_name,
+// 					    return_value_policy<copy_const_reference>()),
+// 			      &Type::set_name)
                 .add_property("aliases"
                         , make_function(
                                 &Type::aliases,
@@ -139,18 +139,18 @@ BOOST_PYTHON_MODULE(policyrep)
 	register_ptr_to_python<TypePtr>();
 
 	class_<Attribute, bases<Node> >("Attribute")
-		.add_property("name",
-			      make_function(&Attribute::get_name,
-					    return_value_policy<copy_const_reference>()),
-			      &Attribute::set_name)
+// 		.add_property("name",
+// 			      make_function(&Attribute::get_name,
+// 					    return_value_policy<copy_const_reference>()),
+// 			      &Attribute::set_name)
 		;
 	register_ptr_to_python<AttributePtr>();
 
 	class_<TypeAttribute, bases<Node> >("TypeAttribute")
-		.add_property("name",
-			      make_function(&TypeAttribute::get_name,
-					    return_value_policy<copy_const_reference>()),
-			      &TypeAttribute::set_name)
+// 		.add_property("name",
+// 			      make_function(&TypeAttribute::get_name,
+// 					    return_value_policy<copy_const_reference>()),
+// 			      &TypeAttribute::set_name)
 		.add_property("attributes",
 			      make_function(&TypeAttribute::attributes,
 					    return_value_policy<reference_existing_object>()))
@@ -158,10 +158,10 @@ BOOST_PYTHON_MODULE(policyrep)
 	register_ptr_to_python<TypeAttributePtr>();
 
 	class_<TypeAlias, bases<Node> >("TypeAlias")
-		.add_property("name",
-			      make_function(&TypeAlias::get_name,
-					    return_value_policy<copy_const_reference>()),
-			      &TypeAlias::set_name)
+// 		.add_property("name",
+// 			      make_function(&TypeAlias::get_name,
+// 					    return_value_policy<copy_const_reference>()),
+// 			      &TypeAlias::set_name)
 		.add_property("aliases",
 			      make_function(&TypeAlias::aliases,
 					    return_value_policy<reference_existing_object>()))
@@ -176,10 +176,10 @@ BOOST_PYTHON_MODULE(policyrep)
 	//
 
 	class_<CommonPerms, bases<Node> >("CommonPerms")
-		.add_property("name",
-			      make_function(&CommonPerms::get_name,
-					    return_value_policy<copy_const_reference>()),
-			      &CommonPerms::set_name)
+// 		.add_property("name",
+// 			      make_function(&CommonPerms::get_name,
+// 					    return_value_policy<copy_const_reference>()),
+// 			      &CommonPerms::set_name)
 		.add_property("perms",
 			      make_function(&CommonPerms::perms,
 					    return_value_policy<reference_existing_object>()))
@@ -187,14 +187,14 @@ BOOST_PYTHON_MODULE(policyrep)
 	register_ptr_to_python<CommonPermsPtr>();
 
 	class_<ObjectClass, bases<Node> >("ObjectClass")
-		.add_property("name",
-			      make_function(&ObjectClass::get_name,
-					    return_value_policy<copy_const_reference>()),
-			      &ObjectClass::set_name)
-		.add_property("common_perms",
-			      make_function(&ObjectClass::get_common_perms,
-					    return_value_policy<copy_const_reference>()),
-			      &ObjectClass::set_common_perms)
+// 		.add_property("name",
+// 			      make_function(&ObjectClass::get_name,
+// 					    return_value_policy<copy_const_reference>()),
+// 			      &ObjectClass::set_name)
+// 		.add_property("common_perms",
+// 			      make_function(&ObjectClass::get_common_perms,
+// 					    return_value_policy<copy_const_reference>()),
+// 			      &ObjectClass::set_common_perms)
 		.add_property("perms",
 			      make_function(&ObjectClass::perms,
 					    return_value_policy<reference_existing_object>()))
--- policyrep.new.orig/libpolicyrep/src/rbac.cpp
+++ policyrep.new/libpolicyrep/src/rbac.cpp
@@ -56,7 +56,10 @@ namespace policyrep
 		*impl = *other.impl;
 	}
 
-	Role::~Role() { delete impl; }
+	Role::~Role()
+	{
+		delete impl;
+	}
 
 	Role& Role::operator=(const Role& other)
 	{
--- policyrep.new.orig/libpolicyrep/src/rule.cpp
+++ policyrep.new/libpolicyrep/src/rule.cpp
@@ -36,22 +36,17 @@ namespace policyrep
                 IdSet perms;
         };
 
-        void AVRule::init()
-        {
-                impl = new AVRuleImpl;
-        }
-
         AVRule::AVRule(Type type)
         {
-                init();
+		impl = new AVRuleImpl;
                 impl->type = type;
         }
 
         AVRule::AVRule(const AVRule& other)
-                : Node()
+	:Node(other)
         {
-                init();
-		copy(other);
+		impl = new AVRuleImpl;
+		*impl = *other.impl;
         }
 
         AVRule::~AVRule()
@@ -130,12 +125,6 @@ namespace policyrep
 
 	}
 
-	void AVRule::copy(const AVRule& other)
-	{
-		Node::copy(other);
-		*impl = *other.impl;
-	}
-
 	//
         // TypeRule
         //
@@ -149,22 +138,17 @@ namespace policyrep
 		std::string target;
         };
 
-        void TypeRule::init()
-        {
-                impl = new TypeRuleImpl;
-        }
-
         TypeRule::TypeRule(Type type)
         {
-                init();
+		impl = new TypeRuleImpl;
                 impl->type = type;
         }
 
         TypeRule::TypeRule(const TypeRule& other)
-                : Node()
+	:Node(other)
         {
-                init();
-		copy(other);
+		impl = new TypeRuleImpl;
+		*impl = *other.impl;
         }
 
         TypeRule::~TypeRule()
@@ -241,11 +225,4 @@ namespace policyrep
 
 	}
 
-	void TypeRule::copy(const TypeRule& other)
-	{
-		Node::copy(other);
-		*impl = *other.impl;
-	}
-
-
 } // namespace policyrep
--- policyrep.new.orig/libpolicyrep/src/te_decl.cpp
+++ policyrep.new/libpolicyrep/src/te_decl.cpp
@@ -59,7 +59,10 @@ namespace policyrep
 		*impl = *other.impl;
 	}
 
-	Type::~Type() { delete impl; }
+	Type::~Type()
+	{
+		delete impl;
+	}
 
 	Type& Type::operator=(const Type& other)
 	{
@@ -92,12 +95,6 @@ namespace policyrep
 		o << ";";
 	}
 
-	void Type::copy(const Type& other)
-	{
-		Node::copy(other);
-		*impl = *other.impl;
-	}
-
 	//
 	// Attribute
 	//
@@ -124,12 +121,14 @@ namespace policyrep
 	Attribute::Attribute(const Attribute& other)
 	:Symbol(other), impl(new AttributeImpl)
 	{
-		copy(other);
+		*impl = *other.impl;
 	}
 
-	void Attribute::operator=(const Attribute& other)
+	Attribute& Attribute::operator=(const Attribute& other)
 	{
-		copy(other);
+		Symbol::operator=(other);
+		*impl = *other.impl;
+		return *this;
 	}
 
 	void Attribute::do_output(std::ostream& o, const OutputFormatter& op) const
@@ -137,12 +136,6 @@ namespace policyrep
 		o << "attribute " << get_name() << ";";
 	}
 
-	void Attribute::copy(const Attribute& other)
-	{
-		Node::copy(other);
-		*impl = *other.impl;
-	}
-
 	//
 	// TypeAttribute
 	//
@@ -153,20 +146,31 @@ namespace policyrep
 		StringSet attributes;
 	};
 
-	void TypeAttribute::init() { impl = new TypeAttributeImpl; }
+	void TypeAttribute::init()
+	{
+		impl = new TypeAttributeImpl;
+	}
 
-	TypeAttribute::TypeAttribute() { init(); }
+	TypeAttribute::TypeAttribute()
+	{
+		impl = new TypeAttributeImpl;
+	}
 
 	TypeAttribute::TypeAttribute(const TypeAttribute& other)
-		: Node()
+	:Node(other)
 	{
-		copy(other);
+		impl = new TypeAttributeImpl;
+		*impl = *other.impl;
 	}
 
-	TypeAttribute::~TypeAttribute() { delete impl; }
+	TypeAttribute::~TypeAttribute()
+	{
+		delete impl;
+	}
 
 	TypeAttribute& TypeAttribute::operator=(const TypeAttribute& other)
 	{
+		Node::operator=(other);
 		*impl = *other.impl;
 		return *this;
 	}
@@ -193,12 +197,6 @@ namespace policyrep
 		o << ";";
 	}
 
-	void TypeAttribute::copy(const TypeAttribute& other)
-	{
-		Node::copy(other);
-		*impl = *other.impl;
-	}
-
         //
         // TypeAlias
         //
@@ -209,17 +207,21 @@ namespace policyrep
                 StringSet aliases;
         };
 
-        void TypeAlias::init() { impl = new TypeAliasImpl; }
+	void TypeAlias::init()
+	{
+		impl = new TypeAliasImpl;
+	}
 
         TypeAlias::TypeAlias()
         {
-                init();
+		impl = new TypeAliasImpl;
         }
 
         TypeAlias::TypeAlias(const TypeAlias& other)
-                : Node()
+	:Node(other)
         {
-		copy(other);
+		impl = new TypeAliasImpl;
+		*impl = *other.impl;
         }
 
         TypeAlias::~TypeAlias()
@@ -256,11 +258,4 @@ namespace policyrep
                 o << ";";
         }
 
-	void TypeAlias::copy(const TypeAlias& other)
-	{
-		Node::copy(other);
-		*impl = *other.impl;
-	}
-
-
 } // namespace policyrep

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
