Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5SEO11b006276
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 10:24:01 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5SENwUw001038
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 14:23:59 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l5SENxlJ026145
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 10:23:59 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l5SENwfE031711
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 10:23:58 -0400
Received: from localhost.localdomain (vpn-14-244.rdu.redhat.com [10.11.14.244])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l5SENvY6032707
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 10:23:57 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] Initial policyrep patch v2
Message-Id: <f71c0f396608e6e362ed.1183040619@localhost.localdomain>
Date: Thu, 28 Jun 2007 10:23:39 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Initial patch to create a new policyrep branch using C++. This patch includes basic classes for
representing policy (Node and Parent), a few policy objects, a bison parser, a boost::python
binding, and basic test infrastructure.

Includes updates based on comments from James Antill.

* * *

Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
---

diff -r f7c0c0ec9d61 -r f71c0f396608 Makefile
--- a/Makefile	Thu Jun 28 10:11:06 2007 -0400
+++ b/Makefile	Thu Jun 28 10:11:17 2007 -0400
@@ -1,4 +1,4 @@ SUBDIRS=libsepol libselinux libsemanage 
-SUBDIRS=libsepol libselinux libsemanage sepolgen checkpolicy policycoreutils # policy
+SUBDIRS=libsepol libselinux libsemanage libpolicyrep sepolgen checkpolicy policycoreutils # policy
 PYSUBDIRS=libselinux libsemanage
 
 ifeq ($(DEBUG),1)
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/Makefile
--- a/libpolicyrep/Makefile	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/Makefile	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,22 @@
+all: 
+	$(MAKE) -C src 
+
+install: 
+	$(MAKE) -C include install
+	$(MAKE) -C src install
+
+relabel:
+	$(MAKE) -C src relabel
+
+clean:
+	$(MAKE) -C src clean
+	$(MAKE) -C tests clean
+
+indent:
+	$(MAKE) -C src $@
+	$(MAKE) -C include $@
+	$(MAKE) -C utils $@
+
+test: all
+	$(MAKE) -C tests test
+
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/include/Makefile
--- a/libpolicyrep/include/Makefile	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/include/Makefile	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,10 @@
+# Installation directories.
+PREFIX ?= $(DESTDIR)/usr
+INCDIR ?= $(PREFIX)/include/policyrep
+
+install:
+	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
+	install -m 644 $(wildcard policyrep/*.hpp) $(INCDIR)
+
+indent:
+	../../scripts/Lindent $(wildcard policyrep/*.hpp)
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/include/policyrep/idset.hpp
--- a/libpolicyrep/include/policyrep/idset.hpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/include/policyrep/idset.hpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,33 @@
+/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __idset_hpp__
+#define __idset_hpp__
+
+#include <policyrep/policy_base.hpp>
+
+#include <set>
+
+namespace policyrep
+{
+	struct IdSetImpl;
+	class IdSet
+	{
+	public:
+		IdSet();
+		IdSet(const IdSet& other);
+		~IdSet();
+		void operator=(const IdSet& other);
+
+		void set_compl(bool val);
+		bool get_compl() const;
+
+		StringSet& ids();
+	protected:
+		void init();
+		IdSetImpl* impl;
+	};
+
+
+} // namespace policyrep
+
+#endif
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/include/policyrep/object_class.hpp
--- a/libpolicyrep/include/policyrep/object_class.hpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/include/policyrep/object_class.hpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,83 @@
+/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __object_class_hpp__
+#define __object_class_hpp__
+
+#include <policyrep/policy_base.hpp>
+
+namespace policyrep
+{
+
+        //
+        // CommonPerms
+        //
+
+        struct CommonPermsImpl;
+        class CommonPerms : public Node
+        {
+        public:
+                CommonPerms();
+                CommonPerms(const CommonPerms& other);
+                virtual ~CommonPerms();
+                virtual void operator=(const CommonPerms& other);
+
+		template<class T>
+                CommonPerms(const std::string& name, T perms_begin, T perms_end)
+		{
+			init();
+			set_name(name);
+			perms().insert(perms_begin, perms_end);
+		}
+
+                const std::string& get_name() const;
+                void set_name(const std::string& name);
+                StringSet& perms();
+
+                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+        protected:
+		void init();
+		CommonPermsImpl* impl;
+        };
+	typedef boost::shared_ptr<CommonPerms> CommonPermsPtr;
+
+        //
+        // ObjectClass
+        //
+
+        struct ObjectClassImpl;
+        class ObjectClass : public Node
+        {
+        public:
+                ObjectClass();
+                ObjectClass(const std::string& name, const std::string& commons);
+		ObjectClass(const ObjectClass& other);
+                virtual ~ObjectClass();
+		virtual void operator=(const ObjectClass& other);
+
+		template<class T>
+                ObjectClass(std::string name, std::string commons,
+			    T perms_begin, T perms_end)
+		{
+			init();
+			set_name(name);
+			set_common_perms(commons);
+			perms().insert(perms_begin, perms_end);
+		}
+
+                const std::string& get_name() const;
+                void set_name(const std::string& name);
+                StringSet& perms();
+                const std::string& get_common_perms() const;
+                void set_common_perms(const std::string& name);
+
+                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+        protected:
+		void init();
+        	ObjectClassImpl* impl;
+        };
+	typedef boost::shared_ptr<ObjectClass> ObjectClassPtr;
+
+
+} // namespace policyrep
+
+#endif
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/include/policyrep/parse.hpp
--- a/libpolicyrep/include/policyrep/parse.hpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/include/policyrep/parse.hpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,47 @@
+// Author Karl MacMillan <kmacmillan@mentalrootkit.com>
+
+#ifndef __parse_hpp__
+#define __parse_hpp__
+
+#include <policyrep/policy.hpp>
+
+#include <string>
+
+namespace policyrep {
+
+	class location;
+
+	struct ParserImpl;
+	class Parser
+	{
+	public:
+		Parser();
+		Parser(const Parser& other);
+		virtual ~Parser();
+		virtual void operator=(const Parser& other);
+
+		// Parser
+		virtual ModulePtr parse(const std::string& f);
+
+                std::string& get_filename() const;
+                Module& get_module();
+
+		void set_trace_scanning(bool val);
+		bool get_trace_scanning() const;
+
+		void set_trace_parsing(bool val);
+		bool get_trace_parsing() const;
+
+                // error handling
+                virtual void error(const policyrep::location& l, const std::string& m);
+                virtual void error(const std::string& m);
+	protected:
+		// scanner
+		void scan_begin();
+		void scan_end();
+
+		ParserImpl* impl;
+	};
+}
+
+#endif
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/include/policyrep/policy.hpp
--- a/libpolicyrep/include/policyrep/policy.hpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/include/policyrep/policy.hpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,85 @@
+/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __policy_hpp__
+#define __policy_hpp__
+
+#include <policyrep/policy_base.hpp>
+#include <policyrep/object_class.hpp>
+#include <policyrep/te_decl.hpp>
+#include <policyrep/rule.hpp>
+
+namespace policyrep
+{
+
+	//
+	// Policy
+	//
+
+	struct PolicyImpl;
+	class Policy : public Parent
+	{
+	public:
+		Policy(bool mls=false);
+		Policy(const Policy& other);
+		virtual ~Policy();
+		virtual void operator=(const Policy& other);
+
+		bool get_mls() const;
+		void set_mls(bool val);
+                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+	protected:
+		PolicyImpl* impl;
+	};
+	typedef boost::shared_ptr<Policy> PolicyPtr;
+
+	//
+	// Module
+	//
+	struct ModuleImpl;
+        class Module : public Parent
+	{
+        public:
+		Module();
+                Module(const std::string& name, const std::string& version);
+		Module(const Module& other);
+                virtual ~Module();
+		virtual void operator=(const Module& other);
+
+                const std::string& get_name() const;
+                void set_name(const std::string& name);
+                const std::string& get_version() const;
+                void set_version(const std::string& version);
+
+                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+        protected:
+		ModuleImpl* impl;
+        };
+	typedef boost::shared_ptr<Module> ModulePtr;
+
+
+	//
+	// InitialSid
+	//
+
+	struct InitialSidImpl;
+        class InitialSid : public Node
+        {
+        public:
+                InitialSid();
+                InitialSid(const std::string& name);
+		InitialSid(const InitialSid& other);
+                virtual ~InitialSid();
+		virtual void operator=(const InitialSid& other);
+
+                const std::string& get_name() const;
+                void set_name(const std::string& name);
+
+                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+        protected:
+		InitialSidImpl* impl;
+        };
+	typedef boost::shared_ptr<InitialSid> InitialSidPtr;
+
+}
+
+#endif
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/include/policyrep/policy_base.hpp
--- a/libpolicyrep/include/policyrep/policy_base.hpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/include/policyrep/policy_base.hpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,135 @@
+/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __policy_base_hpp__
+#define __policy_base_hpp__
+
+#include <vector>
+#include <set>
+#include <string>
+
+#include <boost/shared_ptr.hpp>
+#include <boost/iterator/iterator_facade.hpp>
+
+namespace policyrep {
+
+	// Forward declarations
+        class Node;
+        typedef boost::shared_ptr<Node> NodePtr;
+
+        class Parent;
+        typedef boost::shared_ptr<Parent> ParentPtr;
+        
+	// Convenience typedefs
+        typedef std::vector<NodePtr> NodeVector;
+        typedef boost::shared_ptr<NodeVector> NodeVectorPtr;
+        
+        typedef std::set<std::string> StringSet;
+        typedef boost::shared_ptr<StringSet> StringSetPtr;
+        
+        typedef std::vector<std::string> StringVector;
+        typedef boost::shared_ptr<StringVector> StringVectorPtr;
+
+	// Output (string output)
+	enum OutputStyle { DEFAULT_OUTPUT, DEBUG_OUTPUT };
+        std::ostream& operator<<(std::ostream& o, const Node& n);
+
+        void output_set_space(std::ostream& o, const StringSet& set);
+        void output_set_comma(std::ostream& o, const StringSet& set);
+
+        class OutputFormat {
+        public:
+                OutputFormat(const Node &n, bool end=false, enum OutputStyle style=DEFAULT_OUTPUT);
+                friend std::ostream& operator<<(std::ostream& o, const OutputFormat& op);
+        private:
+                const Node& m_n;
+                bool m_end;
+                enum OutputStyle m_style;
+        };
+
+	//
+	// NODE
+	//
+
+	struct NodeImpl;
+	class Node {
+        public:
+                Node();
+		Node(const Node& other);
+                virtual ~Node();
+		void operator=(const Node& other);
+                
+                void set_parent(Parent& p);
+                Parent& get_parent() const;
+                
+                bool get_visited() const;
+                void set_visited(bool val);
+                
+                friend std::ostream& operator<<(std::ostream& o, const Node& n);
+                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+                virtual void output_end(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+                virtual void output_end_brace(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+                std::string to_string() const;
+                std::string to_string_end() const;
+        protected:
+		NodeImpl* node_impl;
+                static const int VISITED = 1;
+        };
+        
+        //
+	// TreeIterator
+	//
+	
+	struct TreeIteratorImpl;
+        class TreeIterator
+                : public boost::iterator_facade<TreeIterator, Node,
+                                                boost::forward_traversal_tag>
+        {
+        public:
+                enum Strategy { POSTORDER, PREORDER, HYBRID };
+                TreeIterator(enum Strategy strategy=POSTORDER);
+		explicit TreeIterator(Node& n, enum Strategy strategy=POSTORDER);
+		TreeIterator(const TreeIterator& other);
+		virtual ~TreeIterator();
+                void operator=(const TreeIterator& other);
+                bool get_visited() const;
+        private:
+                friend class boost::iterator_core_access;
+                void increment();
+                void increment_preorder();
+                void increment_postorder();
+                bool equal(const TreeIterator& other) const;
+                Node& dereference() const;
+                
+		TreeIteratorImpl* impl;
+        };
+        
+	//
+	// Parent
+	//
+	
+	struct ParentImpl;
+        class Parent : public Node {
+        public:
+		Parent();
+		Parent(const Parent& other);
+		virtual ~Parent();
+		void operator=(const Parent& other);
+                typedef TreeIterator iterator;                
+                virtual void append_child(NodePtr Node);
+                virtual NodeVector& children();
+                
+                iterator begin(enum TreeIterator::Strategy strategy=TreeIterator::POSTORDER);
+                iterator end();
+        protected:
+		ParentImpl* parent_impl;   
+        };
+	typedef boost::shared_ptr<Parent> ParentPtr;
+
+        void output_tree(std::ostream& o, Parent& p,
+			 enum OutputStyle style=DEFAULT_OUTPUT);
+
+
+
+} // namespace policyrep
+
+#endif
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/include/policyrep/rule.hpp
--- a/libpolicyrep/include/policyrep/rule.hpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/include/policyrep/rule.hpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,42 @@
+/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __rule_hpp__
+#define __rule_hpp__
+
+#include <policyrep/policy_base.hpp>
+#include <policyrep/idset.hpp>
+
+namespace policyrep
+{
+
+        //
+        // AVRule
+        //
+
+        struct AVRuleImpl;
+        class AVRule : public Node
+        {
+        public:
+                enum Type { ALLOW, AUDITDENY, AUDITALLOW, DONTAUDIT, NEVERALLOW };
+                AVRule(Type type=ALLOW);
+                AVRule(const AVRule& other);
+                ~AVRule();
+                virtual void operator=(const AVRule& other);
+
+		void set_type(Type type);
+		Type get_type() const;
+
+                IdSet& src_types();
+                IdSet& tgt_types();
+                StringSet& classes();
+                IdSet& perms();
+
+                virtual void output(std::ostream& o, enum OutputStyle style) const;
+        protected:
+                void init();
+                AVRuleImpl* impl;
+        };
+
+} // namepsace policyrep
+
+#endif
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/include/policyrep/te_decl.hpp
--- a/libpolicyrep/include/policyrep/te_decl.hpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/include/policyrep/te_decl.hpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,144 @@
+/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __te_decl_hpp__
+#define __te_decl_hpp__
+
+#include <policyrep/policy_base.hpp>
+
+namespace policyrep
+{
+
+        //
+        // Type
+        //
+
+	struct TypeImpl;
+        class Type : public Node
+	{
+        public:
+		Type();
+		Type(const std::string& name);
+		Type(const Type& other);
+		virtual ~Type();
+		virtual void operator=(const Type& other);
+
+		template<class T>
+                Type(const std::string& name, T attrs_begin, T end)
+		{
+			init();
+			set_name(name);
+			attributes().insert(attrs_begin, end);
+		}
+
+		template<class T, class U>
+                Type(const std::string name, T attrs_begin, T end,
+		     U aliases_begin, U aliases_end)
+		{
+			init();
+			set_name(name);
+			attributes().insert(attrs_begin, end);
+			aliases().insert(aliases_begin, aliases_end);
+		}
+
+                const std::string& get_name() const;
+                void set_name(const std::string& name);
+
+                StringSet& aliases();
+                StringSet& attributes();
+                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+        protected:
+		void init();
+		TypeImpl* impl;
+        };
+	typedef boost::shared_ptr<Type> TypePtr;
+
+	//
+	// Attribute
+	//
+
+	struct AttributeImpl;
+	class Attribute : public Node
+        {
+	public:
+		Attribute();
+		Attribute(const std::string& name);
+		Attribute(const Attribute& other);
+		~Attribute();
+		virtual void operator=(const Attribute& other);
+
+		const std::string& get_name() const;
+		void set_name(const std::string& name);
+		virtual void output(std::ostream& o, enum OutputStyle style) const;
+	protected:
+		AttributeImpl* impl;
+	};
+	typedef boost::shared_ptr<Attribute> AttributePtr;
+
+	//
+	// TypeAttribute
+	//
+
+	struct TypeAttributeImpl;
+	class TypeAttribute : public Node
+        {
+	public:
+		TypeAttribute();
+		TypeAttribute(const TypeAttribute& other);
+		~TypeAttribute();
+		virtual void operator=(const TypeAttribute& other);
+
+		template<class T>
+		TypeAttribute(const std::string& name, T attrs_begin,
+			      T attrs_end)
+		{
+			init();
+                        set_name(name);
+			attributes().insert(attrs_begin, attrs_end);
+		}
+
+		const std::string& get_name() const;
+		void set_name(const std::string& name);
+                StringSet& attributes();
+		virtual void output(std::ostream& o, enum OutputStyle style) const;
+	protected:
+		void init();
+		TypeAttributeImpl* impl;
+	};
+	typedef boost::shared_ptr<TypeAttribute> TypeAttributePtr;
+
+        //
+        // TypeAlias
+        //
+
+        struct TypeAliasImpl;
+        class TypeAlias : public Node
+        {
+        public:
+                TypeAlias();
+                TypeAlias(const TypeAlias& other);
+                ~TypeAlias();
+                virtual void operator=(const TypeAlias& other);
+
+                template<class T>
+                TypeAlias(const std::string& name, T attrs_begin,
+                              T attrs_end)
+                {
+                        init();
+                        set_name(name);
+                        aliases().insert(attrs_begin, attrs_end);
+                }
+
+                const std::string& get_name() const;
+                void set_name(const std::string& name);
+                StringSet& aliases();
+                virtual void output(std::ostream& o, enum OutputStyle style) const;
+        protected:
+                void init();
+                TypeAliasImpl* impl;
+        };
+        typedef boost::shared_ptr<TypeAlias> TypeAliasPtr;
+
+
+} // namespace policyrep
+
+#endif
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/Makefile
--- a/libpolicyrep/src/Makefile	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/Makefile	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,76 @@
+# Installation directories.
+PREFIX ?= $(DESTDIR)/usr
+LIBDIR ?= $(PREFIX)/lib
+SHLIBDIR ?= $(DESTDIR)/lib
+
+PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % sys.version_info[0:2]')
+PYINC ?= /usr/include/$(PYLIBVER)
+PYLIB ?= /usr/lib/$(PYLIBVER)
+PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
+PYTHONCPP=policyrep_python.cpp
+PYTHONLOBJ=policyrep_python.lo
+PYTHONSO=policyrep.so
+
+LIBVERSION = 1
+
+PARSERGENERATED=policy_parse.cpp policy_parse.hpp policy_scan.cpp stack.hh position.hh scanner-file.cpp location.hh
+PARSEROBJS=policy_parse.o policy_scan.o
+PARSERLOBJS=policy_parse.lo policy_scan.lo
+
+LIBA=libpolicyrep.a 
+TARGET=libpolicyrep.so
+LIBSO=$(TARGET).$(LIBVERSION)
+OBJS= $(PARSEROBJS) $(patsubst %.cpp,%.o,$(filter-out $(PYTHONCPP), $(wildcard *.cpp)))
+LOBJS= $(PARSERLOBJS) $(patsubst %.cpp,%.lo,$(filter-out $(PYTHONCPP), $(wildcard *.cpp)))
+CFLAGS ?= -g -Wall -W -Wmissing-format-attribute -Wno-unused-parameter
+override CFLAGS += -I. -I../include -D_GNU_SOURCE
+LDFLAGS += -lboost_serialization
+
+all: $(LIBA) $(LIBSO) $(PYTHONSO)
+
+$(LIBA):  $(OBJS)
+	$(AR) rcs $@ $^
+	ranlib $@
+
+$(LIBSO): $(LOBJS)
+	g++ $(LDFLAGS) -shared -o $@ $^ -Wl,-soname,$(LIBSO)
+	ln -sf $@ $(TARGET) 
+
+$(PYTHONSO): $(PYTHONLOBJ)
+	g++ $(LDFLAGS) -lboost_python -shared -o $@ $< $(LOBJS) -Wl,-soname,$@
+
+$(PYTHONLOBJ): $(PYTHONCPP)
+	g++ $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
+
+%.o:  %.cpp
+	g++ $(CFLAGS) -fPIC -c -o $@ $<
+
+%.lo:  %.cpp
+	g++ $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
+
+policy_parse.cpp: policy_parse.y
+	bison -o policy_parse.cpp -p policyrep -d policy_parse.y
+
+policy_scan.cpp: policy_scan.l policy_parse.cpp
+	flex policy_scan.l
+
+install: all install-pywrap
+	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
+	install -m 644 $(LIBA) $(LIBDIR)
+	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
+	install -m 755 $(LIBSO) $(SHLIBDIR)
+	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+
+install-pywrap:
+	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d $(PYTHONLIBDIR)/site-packages
+	install -m 755 $(PYTHONSO) $(PYTHONLIBDIR)/site-packages
+
+relabel:
+	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
+
+clean: 
+	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) $(PYTHONSO) $(PYTHONLOBJ) $(PARSERGENERATED)
+
+indent:
+	../../scripts/Lindent $(wildcard *.cpp)
+
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/idset.cpp
--- a/libpolicyrep/src/idset.cpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/idset.cpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,67 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
+#include <policyrep/idset.hpp>
+
+namespace policyrep
+{
+
+	struct IdSetImpl
+	{
+		StringSet ids;
+		bool compliment;
+	};
+
+	void IdSet::init()
+	{
+		impl = new IdSetImpl;
+	}
+
+	IdSet::IdSet() { init(); }
+
+	IdSet::IdSet(const IdSet& other)
+	{
+		init();
+		*impl = *other.impl;
+	}
+
+	IdSet::~IdSet() { delete impl; }
+
+	void IdSet::operator=(const IdSet& other)
+	{
+		*impl = *other.impl;
+	}
+
+	void IdSet::set_compl(bool val)
+	{
+		impl->compliment = val;
+	}
+
+	bool IdSet::get_compl() const
+	{
+		return impl->compliment;
+	}
+
+	StringSet& IdSet::ids()
+	{
+		return impl->ids;
+	}
+
+} // namespace policyre
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/object_class.cpp
--- a/libpolicyrep/src/object_class.cpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/object_class.cpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,157 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
+#include <policyrep/object_class.hpp>
+
+namespace policyrep {
+
+	//
+	// CommonPerms
+	//
+
+	struct CommonPermsImpl
+	{
+		std::string name;
+		StringSet perms;
+	};
+
+	void CommonPerms::init() { impl = new CommonPermsImpl; }
+
+	CommonPerms::CommonPerms() { init(); }
+
+	CommonPerms::CommonPerms(const CommonPerms& other)
+		: Node()
+	{
+		init();
+		*impl = *other.impl;
+	}
+
+	CommonPerms::~CommonPerms()
+	{
+		delete impl;
+	}
+
+	void CommonPerms::operator=(const CommonPerms& other)
+	{
+		*impl = *other.impl;
+	}
+
+	const std::string& CommonPerms::get_name() const
+	{
+		return impl->name;
+	}
+
+	void CommonPerms::set_name(const std::string& name)
+	{
+		impl->name = name;
+	}
+
+	StringSet& CommonPerms::perms()
+	{
+		return impl->perms;
+	}
+
+	void CommonPerms::output(std::ostream& o, enum OutputStyle style) const
+	{
+		if (style == DEBUG_OUTPUT)
+			o << "[CommonPerms " << this << "]";
+		o << "common " << impl->name << " ";
+		output_set_space(o, impl->perms);
+	}
+
+	//
+	// ObjectClass
+	//
+
+	struct ObjectClassImpl
+	{
+		std::string name;
+		StringSet perms;
+		std::string common_perms;
+	};
+
+	void ObjectClass::init() { impl = new ObjectClassImpl; }
+
+	ObjectClass::ObjectClass() { init(); }
+
+	ObjectClass::ObjectClass(const std::string& name, const std::string& commons)
+	{
+		init();
+		set_name(name);
+		set_common_perms(commons);
+	}
+
+	ObjectClass::ObjectClass(const ObjectClass& other)
+		: Node()
+	{
+		init();
+		*impl = *other.impl;
+	}
+
+	ObjectClass::~ObjectClass()
+	{
+		delete impl;
+	}
+
+	void ObjectClass::operator=(const ObjectClass& other)
+	{
+		*impl = *other.impl;
+	}
+
+	const std::string& ObjectClass::get_name() const
+	{
+		return impl->name;
+	}
+
+	void ObjectClass::set_name(const std::string& name)
+	{
+		impl->name = name;
+	}
+
+	StringSet& ObjectClass::perms()
+	{
+		return impl->perms;
+	}
+
+	const std::string& ObjectClass::get_common_perms() const
+	{
+		return impl->common_perms;
+	}
+
+	void ObjectClass::set_common_perms(const std::string& name)
+	{
+		impl->common_perms = name;
+	}
+
+	void ObjectClass::output(std::ostream& o, enum OutputStyle style) const
+	{
+		if (style == DEBUG_OUTPUT)
+			o << "[ObjectClass " << this << "]";
+		o << "class " << impl->name;
+		if (impl->common_perms != "")
+			o << " inherits " << impl->common_perms;
+		if (!impl->perms.empty()) {
+			o << " ";
+			output_set_space(o, impl->perms);
+		}
+	}
+
+
+} // namespace policyrep
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/parse.cpp
--- a/libpolicyrep/src/parse.cpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/parse.cpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,107 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
+#include <policyrep/parse.hpp>
+#include <policyrep/policy.hpp>
+
+#include "policy_parse.hpp"
+
+namespace policyrep {
+
+
+	struct ParserImpl
+	{
+                ParserImpl() : trace_scanning(false), trace_parsing(false) { }
+		std::string filename;
+		ModulePtr module;
+		bool trace_scanning;
+		bool trace_parsing;
+	};
+
+	Parser::Parser()
+		: impl(new ParserImpl) { }
+
+	Parser::Parser(const Parser& other)
+		: impl(new ParserImpl)
+	{
+		*impl = *other.impl;
+	}
+
+	Parser::~Parser() { delete impl; }
+
+	void Parser::operator=(const Parser& other)
+	{
+		*impl = *other.impl;
+	}
+
+	ModulePtr Parser::parse(const std::string& f)
+	{
+		impl->module = ModulePtr(new Module);
+		impl->filename = f;
+		scan_begin();
+		policy_parser p(*this);
+		p.set_debug_level(impl->trace_parsing);
+		p.parse();
+		scan_end();
+
+		return impl->module;
+	}
+
+        std::string& Parser::get_filename() const
+        {
+                return impl->filename;
+        }
+
+        Module& Parser::get_module()
+        {
+                return *impl->module;
+        }
+
+	void Parser::set_trace_scanning(bool val)
+        {
+                impl->trace_scanning = val;
+        }
+
+	bool Parser::get_trace_scanning() const
+        {
+                return impl->trace_scanning;
+        }
+
+	void Parser::set_trace_parsing(bool val)
+        {
+                impl->trace_parsing = val;
+        }
+
+        bool Parser::get_trace_parsing() const
+        {
+                return impl->trace_parsing;
+        }
+
+	void Parser::error(const policyrep::location& l, const std::string& m)
+	{
+		std::cerr << l << ": " << m << std::endl;
+	}
+
+	void Parser::error(const std::string& m)
+	{
+		std::cerr << m << std::endl;
+	}
+
+} // namespace policyrep
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/policy.cpp
--- a/libpolicyrep/src/policy.cpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/policy.cpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,178 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
+#include <policyrep/policy.hpp>
+
+
+namespace policyrep
+{
+
+
+        //
+        // Policy
+        //
+
+	struct PolicyImpl
+	{
+		PolicyImpl(bool m=false) : mls(m) { }
+		bool mls;
+	};
+
+
+	Policy::Policy(bool mls)
+		: impl(new PolicyImpl(mls)) { }
+
+	Policy::Policy(const Policy& other)
+		: Parent()
+	{
+		impl = new PolicyImpl;
+		*impl = *other.impl;
+	}
+
+	Policy::~Policy() { delete impl; }
+
+	void Policy::operator=(const Policy& other)
+	{
+		*impl = *other.impl;
+	}
+
+	bool Policy::get_mls() const
+	{
+		return impl->mls;
+	}
+
+	void Policy::set_mls(bool val)
+	{
+		impl->mls = val;
+	}
+
+	void Policy::output(std::ostream& o, enum OutputStyle style) const
+	{
+		if (style == DEBUG_OUTPUT)
+			o << "[Policy " << this << "]";
+	}
+
+	//
+	// Module
+	//
+
+	struct ModuleImpl
+	{
+		ModuleImpl() { }
+		ModuleImpl(const std::string& n, const std::string& v) : name(n), version(v) { }
+		std::string name;
+		std::string version;
+	};
+
+	Module::Module() : impl(new ModuleImpl) { }
+
+	Module::Module(const std::string& name, const std::string& version)
+		: impl(new ModuleImpl(name, version)) { }
+
+	Module::Module(const Module& other)
+		: Parent(), impl(new ModuleImpl)
+	{
+		*impl = *other.impl;
+	}
+
+	Module::~Module() { delete impl; }
+
+	void Module::operator=(const Module& other)
+	{
+		*impl = *other.impl;
+	}
+
+	const std::string& Module::get_name() const
+	{
+		return impl->name;
+	}
+
+	void Module::set_name(const std::string& name)
+	{
+		impl->name = name;
+	}
+
+	const std::string& Module::get_version() const
+	{
+		return impl->version;
+	}
+
+	void Module::set_version(const std::string& version)
+	{
+		impl->version = version;
+	}
+
+	void Module::output(std::ostream& o, enum OutputStyle style) const
+	{
+		if (style == DEBUG_OUTPUT)
+			o << "[MODULE " << this << "]";
+		o << "module " << impl->name << " " << impl->version << ";";
+	}
+
+	//
+	// InitialSid
+	//
+
+	struct InitialSidImpl
+	{
+		std::string name;
+	};
+
+	InitialSid::InitialSid()
+		: impl(new InitialSidImpl) { }
+
+	InitialSid::InitialSid(const std::string& name)
+		: impl(new InitialSidImpl)
+	{
+		impl->name = name;
+	}
+
+	InitialSid::InitialSid(const InitialSid& other)
+		: Node(), impl(new InitialSidImpl)
+	{
+		*impl = *other.impl;
+	}
+
+	InitialSid::~InitialSid() { delete impl; }
+
+	void InitialSid::operator=(const InitialSid& other)
+	{
+		*impl = *other.impl;
+	}
+
+	const std::string& InitialSid::get_name() const
+	{
+		return impl->name;
+	}
+
+	void InitialSid::set_name(const std::string& name)
+	{
+		impl->name = name;
+	}
+
+	void InitialSid::output(std::ostream& o, enum OutputStyle style) const
+	{
+		if (style == DEBUG_OUTPUT)
+			o << "[InitialSid " << this << "]";
+		o << "sid " << impl->name;
+	}
+
+
+} // namespace Policyrep
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/policy_base.cpp
--- a/libpolicyrep/src/policy_base.cpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/policy_base.cpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,365 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
+#include <policyrep/policy_base.hpp>
+
+#include <iostream>
+#include <algorithm>
+#include <fstream>
+#include <sstream>
+
+namespace policyrep
+{
+
+	//
+	// Output
+	//
+
+	void output_set_space(std::ostream& o, const StringSet& set)
+	{
+		if (set.size() > 1)
+			o << "{ ";
+		StringSet::const_iterator i;
+		bool first = true;
+		for (i = set.begin(); i != set.end(); ++i) {
+			if (first)
+				first = false;
+			else
+				o << " ";
+			o << *i;
+		}
+		if (set.size() > 1)
+			o << " }";
+	}
+
+	void output_set_comma(std::ostream& o, const StringSet& set)
+	{
+		StringSet::const_iterator i;
+		bool first = true;
+		for (i = set.begin(); i != set.end(); ++i) {
+			if (first)
+				first = false;
+			else
+				o << ", ";
+			o << *i;
+		}
+	}
+
+	std::ostream& operator<<(std::ostream& o, const Node& n)
+	{
+		n.output(o);
+		return o;
+	}
+
+	OutputFormat::OutputFormat(const Node &n, bool end, enum OutputStyle style)
+		: m_n(n), m_end(end), m_style(style) { }
+
+	std::ostream& operator<<(std::ostream& o, const OutputFormat& op)
+	{
+		if (op.m_end)
+			op.m_n.output_end(o, op.m_style);
+		else
+			op.m_n.output(o, op.m_style);
+		return o;
+	}
+
+	//
+	// Node
+	//
+
+	struct NodeImpl {
+		Parent* parent;
+		uint32_t flags;
+	};
+
+
+	Node::Node()
+	{
+		node_impl = new NodeImpl;
+	}
+
+	Node::Node(const Node& other)
+	{
+		node_impl = new NodeImpl;
+		*node_impl = *other.node_impl;
+	}
+
+	Node::~Node()
+	{
+		delete node_impl;
+	}
+
+	void Node::operator=(const Node& other)
+	{
+		*node_impl = *other.node_impl;
+	}
+
+	void Node::set_parent(Parent& parent)
+	{
+		node_impl->parent = &parent;
+	}
+
+	Parent& Node::get_parent() const
+	{
+		return *node_impl->parent;
+	}
+
+	bool Node::get_visited() const
+	{
+		return node_impl->flags & VISITED;
+	}
+
+	void Node::set_visited(bool val)
+	{
+		if (val)
+			node_impl->flags |= VISITED;
+		else
+			node_impl->flags &= ~VISITED;
+	}
+
+	void Node::output(std::ostream& o, enum OutputStyle style) const
+	{
+		if (style == DEBUG_OUTPUT)
+			o << "[Node " << this << "]";
+	}
+
+	void Node::output_end(std::ostream& o, enum OutputStyle style) const
+	{
+		switch (style) {
+		case DEFAULT_OUTPUT:
+			break;
+		case DEBUG_OUTPUT:
+			o << "[END " << typeid(this).name() << " " << this << "]";
+		};
+	}
+
+	void Node::output_end_brace(std::ostream& o, enum OutputStyle style) const
+	{
+		switch (style) {
+		case DEFAULT_OUTPUT:
+			o << "}";
+			break;
+		case DEBUG_OUTPUT:
+			o << "} [" << typeid(this).name() << " " << this << "]";
+		};
+	}
+
+	std::string Node::to_string() const
+	{
+		std::stringstream s;
+		s << *this;
+		return s.str();
+	}
+
+	std::string Node::to_string_end() const
+	{
+		std::stringstream s;
+		s << OutputFormat(*this, true, DEFAULT_OUTPUT);
+		return s.str();
+	}
+
+	const int Node::VISITED;
+
+	//
+	// TreeIterator
+	//
+
+	struct TreeIteratorImpl
+	{
+		TreeIteratorImpl(Node* c = 0, enum TreeIterator::Strategy strategy = TreeIterator::POSTORDER)
+			: strategy(strategy), cur(c) { }
+		TreeIterator::Strategy strategy;
+		std::vector<Node*> stack;
+		Node* cur;
+		bool visited;
+	};
+
+	TreeIterator::TreeIterator(enum Strategy strategy)
+		: impl(new TreeIteratorImpl(0, strategy)) { }
+
+	TreeIterator::TreeIterator(Node& n, enum Strategy strategy)
+		: impl(new TreeIteratorImpl(&n, strategy))
+	{
+		n.set_visited(false);
+		impl->stack.push_back(&n);
+		increment();
+	}
+
+	TreeIterator::TreeIterator(const TreeIterator& other)
+	{
+		impl = new TreeIteratorImpl;
+		*impl = *other.impl;
+	}
+
+	TreeIterator::~TreeIterator()
+	{
+		delete impl;
+	}
+
+	void TreeIterator::operator=(const TreeIterator& other)
+	{
+		*impl = *other.impl;
+	}
+
+	bool TreeIterator::get_visited() const
+	{
+		return impl->visited;
+	}
+
+	void TreeIterator::increment()
+	{
+		switch (impl->strategy) {
+		case POSTORDER:
+			this->increment_postorder();
+			break;
+		case PREORDER:
+		case HYBRID:
+			this->increment_preorder();
+			break;
+		};
+	}
+
+	void TreeIterator::increment_preorder()
+	{
+		if (impl->stack.empty()) {
+			impl->cur = NULL;
+			return;
+		}
+		impl->cur = impl->stack.back();
+		impl->visited = impl->cur->get_visited();
+		impl->stack.pop_back();
+
+		Parent* p = dynamic_cast<Parent*>(impl->cur);
+		if (p and !p->get_visited()) {
+			if (impl->strategy == HYBRID) {
+				p->set_visited(true);
+				impl->stack.push_back(impl->cur);
+			}
+			NodeVector::reverse_iterator i;
+			for (i = p->children().rbegin(); i != p->children().rend(); ++i) {
+				(*i)->set_visited(false);
+				impl->stack.push_back(i->get());
+			}
+		}
+	}
+
+	void TreeIterator::increment_postorder()
+	{
+		while (1) {
+			if (impl->stack.empty()) {
+				impl->cur = NULL;
+				return;
+			}
+			Node* n = impl->stack.back();
+			impl->stack.pop_back();
+
+			Parent* p = dynamic_cast<Parent*>(n);
+			if (n->get_visited() || p == 0) {
+				impl->cur = n;
+				break;
+			} else {
+				p->set_visited(true);
+				impl->stack.push_back(n);
+				NodeVector::reverse_iterator i;
+				for (i = p->children().rbegin(); i != p->children().rend(); ++i) {
+					(*i)->set_visited(false);
+					impl->stack.push_back(i->get());
+				}
+			}
+		}
+	}
+
+	bool TreeIterator::equal(const TreeIterator& other) const
+	{
+		return impl->cur == other.impl->cur;
+	}
+
+	Node& TreeIterator::dereference() const
+	{
+		return *impl->cur;
+	}
+
+	//
+	// Parent
+	//
+
+
+	struct ParentImpl {
+		NodeVector children;
+		template <class Archive>
+		void serialize(Archive& ar, unsigned int file_version)
+			{
+				ar & children;
+			}
+	};
+
+	Parent::Parent()
+		: parent_impl(new ParentImpl) { }
+
+	Parent::Parent(const Parent& other)
+		: Node()
+	{
+		parent_impl = new ParentImpl;
+		*parent_impl = *other.parent_impl;
+	}
+
+	Parent::~Parent()
+	{
+		delete parent_impl;
+	}
+
+	void Parent::operator=(const Parent& other)
+	{
+		*parent_impl = *other.parent_impl;
+	}
+
+	void Parent::append_child(NodePtr node)
+	{
+		parent_impl->children.push_back(node);
+		node->set_parent(*this);
+	}
+
+	NodeVector& Parent::children()
+	{
+		return parent_impl->children;
+	}
+
+	Parent::iterator Parent::begin(enum TreeIterator::Strategy strategy)
+	{
+		return TreeIterator(*this, strategy);
+	}
+
+	Parent::iterator Parent::end()
+	{
+		return TreeIterator();
+	}
+
+	void output_tree(std::ostream& o, Parent& p,
+			 enum OutputStyle style)
+	{
+		Parent::iterator i, end;
+		end = p.end();
+		for (i = p.begin(TreeIterator::HYBRID); i != end; ++i) {
+			o << OutputFormat(*i, i.get_visited(), style) << "\n";
+		}
+		o << std::flush;
+	}
+
+} // namespace policyrep
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/policy_internal.hpp
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/libpolicyrep/src/policy_internal.hpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,1 @@
+
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/policy_parse.y
--- a/libpolicyrep/src/policy_parse.y	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/policy_parse.y	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,708 @@
+
+/*
+ * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ */
+
+/*
+ * Updated: Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *      Rework the grammar to pass objects rather than relying
+ *      on globals. General grammar improvements and removal
+ *      of ordering constraints. Conversion to C++.
+ *
+ * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ *
+ *	Support for enhanced MLS infrastructure.
+ *
+ * Updated: David Caplan, <dac@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Updated: Joshua Brindle <jbrindle@tresys.com>
+ *	    Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *          Jason Tang     <jtang@tresys.com>
+ *
+ *	Added support for binary policy modules
+ *
+ * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
+ * Copyright (C) 2003 - 2005 Tresys Technology, LLC
+ * Copyright (C) 2007 Red Hat Inc.
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+/* FLASK */
+
+// Use the C++ skeleton
+%skeleton "lalr1.cc"
+%name-prefix="policyrep"
+%define "parser_class_name" "policy_parser"
+
+%{
+
+#include <policyrep/policy.hpp>
+
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+namespace policyrep {
+
+	class Parser;
+
+	AVRule* define_avrule(AVRule::Type type, IdSet* src_types,
+			      IdSet* tgt_types, IdSet* classes,
+			      IdSet* perms, Parser& driver);
+
+}
+
+%}
+
+%parse-param { Parser& driver }
+%lex-param { Parser& driver }
+
+%locations
+%initial-action
+{
+	@$.begin.filename = @$.end.filename = &driver.get_filename();
+};
+
+%debug
+%error-verbose
+
+%union {
+	int val;
+	uint32_t uint;
+	unsigned long num;
+	std::string* id;
+	NodeVector* list;
+	StringVector* strings;
+	IdSet* ids;
+	Node* pnode;
+}
+
+%{
+#include <policyrep/parse.hpp>
+
+policyrep::policy_parser::token_type
+	policyreplex(policyrep::policy_parser::semantic_type* yyval,
+	      policyrep::policy_parser::location_type* yylloc,
+	      policyrep::Parser& driver);
+
+%}
+
+%type <val> policy module_def
+
+%type <id> sub_identifier version_identifier asterisk tilde
+
+%type <list> policy_statements
+
+%type <strings> identifier_list nested_id_list nested_id_element
+%type <strings> id_comma_list nested_id_set
+%type <strings> alias_def
+%type <strings> attr_list
+%type <ids> names
+
+%type <pnode> policy_statement
+%type <pnode> class_def
+%type <pnode> initial_sid_def
+%type <pnode> common_perms_def
+%type <pnode> av_perms_def
+%type <pnode> attribute_def
+%type <pnode> type_def
+%type <pnode> typealias_def
+%type <pnode> typeattribute_def
+%type <pnode> allow_def
+%type <pnode> auditallow_def
+%type <pnode> auditdeny_def
+%type <pnode> dontaudit_def
+%type <pnode> neverallow_def
+
+
+%token END 0
+%token <id> PATH
+%token CLONE
+%token COMMON
+%token CLASS
+%token CONSTRAIN
+%token VALIDATETRANS
+%token INHERITS
+%token SID
+%token ROLE
+%token ROLES
+%token TYPEALIAS
+%token TYPEATTRIBUTE
+%token TYPE
+%token TYPES
+%token ALIAS
+%token ATTRIBUTE
+%token BOOL
+%token IF
+%token ELSE
+%token TYPE_TRANSITION
+%token TYPE_MEMBER
+%token TYPE_CHANGE
+%token ROLE_TRANSITION
+%token RANGE_TRANSITION
+%token SENSITIVITY
+%token DOMINANCE
+%token DOM DOMBY INCOMP
+%token CATEGORY
+%token LEVEL
+%token RANGE
+%token MLSCONSTRAIN
+%token MLSVALIDATETRANS
+%token USER
+%token NEVERALLOW
+%token ALLOW
+%token AUDITALLOW
+%token AUDITDENY
+%token DONTAUDIT
+%token SOURCE
+%token TARGET
+%token SAMEUSER
+%token FSCON PORTCON NETIFCON NODECON
+%token FSUSEXATTR FSUSETASK FSUSETRANS
+%token GENFSCON
+%token U1 U2 U3 R1 R2 R3 T1 T2 T3 L1 L2 H1 H2
+%token NOT AND OR XOR
+%token CTRUE CFALSE
+%token <id> IDENTIFIER
+%token NUMBER
+%token EQUALS
+%token NOTEQUAL
+%token COMMA
+%token SEMI
+%token COLON
+%token LPAREN
+%token RPAREN
+%token LBRACE
+%token RBRACE
+%token RBRACKET
+%token LBRACKET
+%token DASH
+%token PERIOD
+%token IPV6_ADDR
+%token MODULE
+%token REQUIRE OPTIONAL
+%token <id> VERSION_IDENTIFIER
+%token <id> TILDE
+%token <id> ASTERISK
+
+%left OR
+%left XOR
+%left AND
+%right NOT
+%left EQUALS NOTEQUAL
+
+//%printer { debug_stream() << *$$; }
+//%destructor { delete $$; }
+
+%%
+policy			: policy_statements
+                          { driver.get_module().children().insert(driver.get_module().children().end(), $1->begin(), $1->end()); delete $1}
+			| module_def policy_statements
+                          { driver.get_module().children().insert(driver.get_module().children().end(), $2->begin(), $2->end()); delete $2; }
+                        ;
+module_def              : MODULE IDENTIFIER version_identifier SEMI
+			  { driver.get_module().set_name(*$2); driver.get_module().set_version(*$3); delete $2; delete $3; }
+                        ;
+policy_statements       : policy_statement
+			  { $$ = new NodeVector(1, NodePtr($1)); }
+			| policy_statement policy_statements
+			  { $2->insert($2->begin(), NodePtr($1)); $$ = $2; }
+			;
+policy_statement        : class_def
+			| initial_sid_def
+			| common_perms_def
+                        | av_perms_def
+			/* TE decl */
+			| attribute_def
+			| type_def
+                        | typealias_def
+                        | typeattribute_def
+			/* rules */
+			| allow_def
+			| auditallow_def
+			| auditdeny_def
+			| dontaudit_def
+			| neverallow_def
+			;
+class_def		: CLASS IDENTIFIER
+			  { $$ = new ObjectClass(*$2, ""); delete $2; }
+			;
+initial_sid_def		: SID IDENTIFIER
+                          { $$ = new InitialSid(*$2); delete $2; }
+			;
+common_perms_def	: COMMON IDENTIFIER LBRACE identifier_list RBRACE
+                          { $$ = new CommonPerms(*$2, $4->begin(), $4->end()); delete $2; delete $4; }
+			;
+av_perms_def		: CLASS IDENTIFIER LBRACE identifier_list RBRACE
+                          { $$ = new ObjectClass(*$2, "", $4->begin(), $4->end()); delete $2; delete $4; }
+                        | CLASS IDENTIFIER INHERITS IDENTIFIER
+                          { $$ = new ObjectClass(*$2, *$4); delete $2; delete $4; }
+                        | CLASS IDENTIFIER INHERITS IDENTIFIER LBRACE identifier_list RBRACE
+                          { $$ = new ObjectClass(*$2, *$4, $6->begin(), $6->end()); delete $2; delete $4; delete $6; }
+			;
+/*
+sensitivity_def		: SENSITIVITY IDENTIFIER alias_def SEMI
+			{ $$ = define_sens($2, $3); check($$); }
+			| SENSITIVITY IDENTIFIER SEMI
+			{ $$ = define_sens($2, NULL); check($$); }
+	                ;
+dominance		: DOMINANCE IDENTIFIER
+			{ NodeVector tmp = tolist($2); check(tmp); $$ = define_dominance(tmp); check($$); }
+                        | DOMINANCE LBRACE IDENTIFIER_list RBRACE
+			{ $$ = define_dominance($3); check($$); }
+			;
+category_def		: CATEGORY IDENTIFIER alias_def SEMI
+			{ $$ = define_category($2, $3); check($$); }
+			| CATEGORY IDENTIFIER SEMI
+			{ $$ = define_category($2, NULL); check($$); }
+			;
+level_def		: LEVEL IDENTIFIER COLON id_comma_list SEMI
+			{ $$ = define_level(); check($$); }
+			| LEVEL IDENTIFIER SEMI
+			{ $$ = define_level(); check($$); }
+			;
+mlsconstraint_def	: MLSCONSTRAIN names names cexpr SEMI
+			{ $$ = define_constraint($4); check($$); }
+			;
+mlsvalidatetrans_def	: MLSVALIDATETRANS names cexpr SEMI
+			{ $$ = define_validatetrans($3); check($$); }
+			;
+*/
+
+attribute_def           : ATTRIBUTE IDENTIFIER SEMI
+			  { $$ = new Attribute(*$2); delete $2; }
+                        ;
+
+alias_def		: ALIAS nested_id_set { $$ = $2; }
+			| ALIAS IDENTIFIER { $$ = new StringVector(1, *$2); delete $2; }
+			;
+attr_list               : COMMA id_comma_list
+			  { $$ = $2; }
+			;
+type_def		: TYPE IDENTIFIER SEMI
+			  { $$ = new Type(*$2); delete $2; }
+			| TYPE IDENTIFIER alias_def attr_list SEMI
+                          { $$ = new Type(*$2, $4->begin(), $4->end(), $3->begin(), $3->end()); delete $2; delete $3; delete $4; }
+	                | TYPE IDENTIFIER attr_list SEMI
+                          { $$ = new Type(*$2, $3->begin(), $3->end()); delete $2; delete $3; }
+			| TYPE IDENTIFIER alias_def SEMI
+			  { Type* x = new Type(*$2); x->aliases().insert($3->begin(), $3->end()); $$ = x; delete $2; delete $3; }
+    			;
+typealias_def           : TYPEALIAS IDENTIFIER alias_def SEMI
+			{ $$ = new TypeAlias(*$2, $3->begin(), $3->end()); delete $2; delete $3; }
+			;
+typeattribute_def	: TYPEATTRIBUTE IDENTIFIER id_comma_list SEMI
+			  { $$ = new TypeAttribute(*$2, $3->begin(), $3->end()); delete $2; delete $3; }
+			;
+/*
+bool_def                : BOOL IDENTIFIER bool_val SEMI
+                        { $$ = define_bool(); check($$); }
+                        ;
+bool_val                : CTRUE
+ 			{ if (insert_id("T",0)) return -1; }
+                        | CFALSE
+			{ if (insert_id("F",0)) return -1; }
+                        ;
+cond_stmt_def           : IF cond_expr LBRACE cond_pol_list RBRACE cond_else
+                        { $$ = define_conditional($2, $4, $6); check($$); }
+                        ;
+cond_else		: ELSE LBRACE cond_pol_list RBRACE
+			{ $$ = $3; check($$); }
+			| { $$ = empty_list(); check($$); }
+			;
+cond_expr               : LPAREN cond_expr RPAREN
+			{ $$ = $2; check($$); }
+			| NOT cond_expr
+			{ $$ = define_cond_expr(COND_NOT, $2, 0); check($$); }
+			| cond_expr AND cond_expr
+			{ $$ = define_cond_expr(COND_AND, $1, $3); check($$); }
+			| cond_expr OR cond_expr
+			{ $$ = define_cond_expr(COND_OR, $1, $3); check($$); }
+			| cond_expr XOR cond_expr
+			{ $$ = define_cond_expr(COND_XOR, $1, $3); check($$); }
+			| cond_expr EQUALS cond_expr
+			{ $$ = define_cond_expr(COND_EQ, $1, $3); check($$); }
+			| cond_expr NOTEQUAL cond_expr
+			{ $$ = define_cond_expr(COND_NEQ, $1, $3); check($$); }
+			| IDENTIFIER
+                        { $$ = define_cond_expr(COND_BOOL,0, 0); check($$); }
+			;
+cond_pol_list           : cond_rule_def { $$ = $1; check($$); }
+			| cond_pol_list cond_rule_def { $$ = collect(2, $1, $2); check($$); }
+			;
+cond_rule_def           : transition_def { $$ = tolist($1); check($$); }
+                        | te_avtab_def { $$ = tolist($1); check($$); }
+			| require_block { $$ = empty_list(); check($$); }
+                        ;
+require_block           : REQUIRE LBRACE require_list RBRACE { $$ = define_require_block($3); check($$); }
+                        ;
+require_list            : require_list require_decl { $$ = collect(2, $1, $2); check($$); }
+                        | require_decl { $$ = $1; check($$); }
+                        ;
+require_decl            : require_class { $$ = tolist($1); check($$); }
+                        | require_decl_def { $$ = tolist($1); check($$); }
+                        ;
+require_class           : CLASS IDENTIFIER names SEMI { $$ = define_require_class(); check($$); }
+                        ;
+require_decl_def        : ROLE id_comma_list SEMI { $$ = define_require_role(); check($$); }
+			| TYPE id_comma_list SEMI { $$ = define_require_type(); check($$); }
+                        | ATTRIBUTE id_comma_list SEMI { $$ = define_require_attribute(); check($$); }
+                        | USER id_comma_list SEMI { $$ = define_require_user(); check($$); }
+                        | BOOL id_comma_list SEMI { $$ = define_require_bool(); check($$); }
+                        | SENSITIVITY id_comma_list SEMI { $$ = define_require_sensitivity(); check($$); }
+                        | CATEGORY id_comma_list SEMI { $$ = define_require_category(); check($$); }
+                        ;
+optional_block          : OPTIONAL LBRACE policy_statements RBRACE optional_else
+                        { $$ = define_optional_block($3, $5); check($$); }
+                        ;
+optional_else           : ELSE LBRACE policy_statements RBRACE { $$ = $3; check($$); }
+                        | { $$ = empty_list(); check($$); }
+                        ;
+transition_def		: TYPE_TRANSITION names names COLON names IDENTIFIER SEMI
+                        { $$ = define_compute_type(AVRULE_TRANSITION); check($$); }
+                        | TYPE_MEMBER names names COLON names IDENTIFIER SEMI
+                        { $$ = define_compute_type(AVRULE_MEMBER); check($$); }
+                        | TYPE_CHANGE names names COLON names IDENTIFIER SEMI
+                        { $$ = define_compute_type(AVRULE_CHANGE); check($$); }
+    			;
+range_trans_def		: RANGE_TRANSITION names names mls_range_def SEMI
+			{ $$ = define_range_trans(0); check($$); }
+			| RANGE_TRANSITION names names COLON names mls_range_def SEMI
+			{ $$ = define_range_trans(1); check($$); }
+			;
+te_avtab_def		: allow_def
+			| auditallow_def
+			| auditdeny_def
+			| dontaudit_def
+			| neverallow_def
+			;
+*/
+allow_def		: ALLOW names names COLON names names  SEMI
+			  { $$ = define_avrule(AVRule::ALLOW, $2, $3, $5, $6, driver); }
+		        ;
+auditallow_def		: AUDITALLOW names names COLON names names SEMI
+			  { $$ = define_avrule(AVRule::AUDITALLOW, $2, $3, $5, $6, driver); }
+		        ;
+auditdeny_def		: AUDITDENY names names COLON names names SEMI
+			  { $$ = define_avrule(AVRule::AUDITDENY, $2, $3, $5, $6, driver); }
+		        ;
+dontaudit_def		: DONTAUDIT names names COLON names names SEMI
+			  { $$ = define_avrule(AVRule::DONTAUDIT, $2, $3, $5, $6, driver); }
+		        ;
+neverallow_def		: NEVERALLOW names names COLON names names  SEMI
+			  { $$ = define_avrule(AVRule::NEVERALLOW, $2, $3, $5, $6, driver); }
+		        ;
+/*
+role_type_def		: ROLE IDENTIFIER TYPES names SEMI
+			{ $$ = define_role_types(); check($$); }
+ 			| ROLE IDENTIFIERSEMI
+ 			{ $$ = define_role_types(); check($$); }
+                        ;
+role_dominance		: DOMINANCE LBRACE roles RBRACE { $$ = $3; check($$); }
+			;
+role_trans_def		: ROLE_TRANSITION names names IDENTIFIER SEMI
+			{ $$ = define_role_trans(); check($$); }
+			;
+role_allow_def		: ALLOW names names SEMI
+			{ $$ = define_role_allow(); check($$); }
+			;
+roles			: role_def
+			{ $$ = $1; check($$); }
+			| roles role_def
+			{ $$ = merge_roles_dom($1, $2); check($$); }
+			;
+role_def		: ROLE IDENTIFIER_push SEMI
+                        { $$ = define_role_dom(NULL); check($$); }
+			| ROLE IDENTIFIER_push LBRACE roles RBRACE
+                        { $$ = define_role_dom($4); check($$); }
+			;
+constraint_decl		: constraint_def
+			| validatetrans_def
+			;
+constraint_def		: CONSTRAIN names names cexpr SEMI
+			{ $$ = define_constraint($4); check($$); }
+			;
+validatetrans_def	: VALIDATETRANS names cexpr SEMI
+			{ $$ = define_validatetrans($3); check($$); }
+			;
+cexpr			: LPAREN cexpr RPAREN
+			{ $$ = $2; }
+			| NOT cexpr
+			{ $$ = define_cexpr(CEXPR_NOT, $2, 0);
+			  if ($$ == 0) return -1; }
+			| cexpr AND cexpr
+			{ $$ = define_cexpr(CEXPR_AND, $1, $3);
+			  if ($$ == 0) return -1; }
+			| cexpr OR cexpr
+			{ $$ = define_cexpr(CEXPR_OR, $1, $3);
+			  if ($$ == 0) return -1; }
+			| cexpr_prim
+			{ $$ = $1; }
+			;
+cexpr_prim		: U1 op U2
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_USER, $2);
+			  if ($$ == 0) return -1; }
+			| R1 role_mls_op R2
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_ROLE, $2);
+			  if ($$ == 0) return -1; }
+			| T1 op T2
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_TYPE, $2);
+			  if ($$ == 0) return -1; }
+			| U1 op { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_USER, $2);
+			  if ($$ == 0) return -1; }
+			| U2 op { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_USER | CEXPR_TARGET), $2);
+			  if ($$ == 0) return -1; }
+			| U3 op { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_USER | CEXPR_XTARGET), $2);
+			  if ($$ == 0) return -1; }
+			| R1 op { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_ROLE, $2);
+			  if ($$ == 0) return -1; }
+			| R2 op { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_ROLE | CEXPR_TARGET), $2);
+			  if ($$ == 0) return -1; }
+			| R3 op { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_ROLE | CEXPR_XTARGET), $2);
+			  if ($$ == 0) return -1; }
+			| T1 op { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_TYPE, $2);
+			  if ($$ == 0) return -1; }
+			| T2 op { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_TYPE | CEXPR_TARGET), $2);
+			  if ($$ == 0) return -1; }
+			| T3 op { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_TYPE | CEXPR_XTARGET), $2);
+			  if ($$ == 0) return -1; }
+			| SAMEUSER
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_USER, CEXPR_EQ);
+			  if ($$ == 0) return -1; }
+			| SOURCE ROLE { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_ROLE, CEXPR_EQ);
+			  if ($$ == 0) return -1; }
+			| TARGET ROLE { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_ROLE | CEXPR_TARGET), CEXPR_EQ);
+			  if ($$ == 0) return -1; }
+			| ROLE role_mls_op
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_ROLE, $2);
+			  if ($$ == 0) return -1; }
+			| SOURCE TYPE { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_TYPE, CEXPR_EQ);
+			  if ($$ == 0) return -1; }
+			| TARGET TYPE { if (insert_separator(1)) return -1; } names_push
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_TYPE | CEXPR_TARGET), CEXPR_EQ);
+			  if ($$ == 0) return -1; }
+			| L1 role_mls_op L2
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_L1L2, $2);
+			  if ($$ == 0) return -1; }
+			| L1 role_mls_op H2
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_L1H2, $2);
+			  if ($$ == 0) return -1; }
+			| H1 role_mls_op L2
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_H1L2, $2);
+			  if ($$ == 0) return -1; }
+			| H1 role_mls_op H2
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_H1H2, $2);
+			  if ($$ == 0) return -1; }
+			| L1 role_mls_op H1
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_L1H1, $2);
+			  if ($$ == 0) return -1; }
+			| L2 role_mls_op H2
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_L2H2, $2);
+			  if ($$ == 0) return -1; }
+			;
+op			: EQUALS
+			{ $$ = CEXPR_EQ; }
+			| NOTEQUAL
+			{ $$ = CEXPR_NEQ; }
+			;
+role_mls_op		: op
+			{ $$ = $1; }
+			| DOM
+			{ $$ = CEXPR_DOM; }
+			| DOMBY
+			{ $$ = CEXPR_DOMBY; }
+			| INCOMP
+			{ $$ = CEXPR_INCOMP; }
+			;
+user_def		: USER IDENTIFIER ROLES names opt_mls_user SEMI
+	                { $$ = define_user(); check($$); }
+			;
+opt_mls_user		: LEVEL mls_level_def RANGE mls_range_def
+			|
+			;
+initial_sid_context_def	: SID IDENTIFIER security_context_def
+			{ $$ = define_initial_sid_context(); check($$); }
+			;
+fs_context_def		: FSCON number number security_context_def security_context_def
+			{ $$ = define_fs_context($2,$3); check($$); }
+			;
+port_context_def	: PORTCON IDENTIFIER number security_context_def
+			{ $$ = define_port_context($3,$3); check($$); }
+			| PORTCON IDENTIFIER number DASH number security_context_def
+			{ $$ = define_port_context($3,$5); check($$); }
+			;
+netif_context_def	: NETIFCON IDENTIFIER security_context_def security_context_def
+			{ $$ = define_netif_context(); }
+			;
+node_context_def	: NODECON ipv4_addr_def ipv4_addr_def security_context_def
+			{ $$ = define_ipv4_node_context($2,$3); check($$); }
+			| NODECON ipv6_addr ipv6_addr security_context_def
+			{ $$ = define_ipv6_node_context(); check($$); }
+			;
+fs_use_def              : FSUSEXATTR IDENTIFIER security_context_def SEMI
+                        { $$ = define_fs_use(SECURITY_FS_USE_XATTR); check($$); }
+                        | FSUSETASK IDENTIFIER security_context_def SEMI
+                        { $$ = define_fs_use(SECURITY_FS_USE_TASK); check($$); }
+                        | FSUSETRANS IDENTIFIER security_context_def SEMI
+                        { $$ = define_fs_use(SECURITY_FS_USE_TRANS); check($$); }
+                        ;
+genfs_context_def	: GENFSCON IDENTIFIER path DASH IDENTIFIER security_context_def
+			{ $$ = define_genfs_context(1); check($$); }
+			| GENFSCON IDENTIFIER path DASH DASH {insert_id("-", 0);} security_context_def
+			{ $$ = define_genfs_context(1); check($$); }
+                        | GENFSCON IDENTIFIER path security_context_def
+			{ $$ = define_genfs_context(0); check($$); }
+			;
+ipv4_addr_def		: number PERIOD number PERIOD number PERIOD number
+			{
+			  uint32_t addr;
+	  		  unsigned char *p = ((unsigned char *)&addr);
+
+			  p[0] = $1 & 0xff;
+			  p[1] = $3 & 0xff;
+			  p[2] = $5 & 0xff;
+			  p[3] = $7 & 0xff;
+			  $$ = addr;
+			}
+    			;
+security_context_def	: IDENTIFIER COLON IDENTIFIER COLON IDENTIFIER opt_mls_range_def
+	                ;
+opt_mls_range_def	: COLON mls_range_def
+			|
+			;
+mls_range_def		: mls_level_def DASH mls_level_def
+			{if (insert_separator(0)) return -1;}
+	                | mls_level_def
+			{if (insert_separator(0)) return -1;}
+	                ;
+mls_level_def		: IDENTIFIER COLON id_comma_list
+			{if (insert_separator(0)) return -1;}
+	                | IDENTIFIER
+			{if (insert_separator(0)) return -1;}
+	                ;
+*/
+id_comma_list           : IDENTIFIER { $$ = new StringVector(1, *$1); delete $1; }
+			| id_comma_list COMMA IDENTIFIER
+                        { $1->push_back(*$3); $$ = $1; delete $3; }
+			;
+tilde			: TILDE { $$ = $<id>1; }
+			;
+asterisk		: ASTERISK { $$ = $<id>1; }
+			;
+names           	: IDENTIFIER { $$ = new IdSet(); $$->ids().insert(*$1); delete $1; }
+			| nested_id_set
+			  { $$ = new IdSet(); $$->ids().insert($1->begin(), $1->end()); delete $1; }
+			| asterisk { $$ = new IdSet(); $$->ids().insert(*$1); delete $1; }
+			| tilde IDENTIFIER
+			  { $$ = new IdSet(); $$->ids().insert(*$1); $$->set_compl(true); delete $1; }
+			| tilde nested_id_set
+                        { $$ = new IdSet();
+                          $$->ids().insert($2->begin(), $2->end());
+			  $$->set_compl(true);
+                          delete $1; delete $2; }
+			| IDENTIFIER sub_identifier
+			{ $$ = new IdSet(); $$->ids().insert(*$1); $$->ids().insert(*$2); delete $1; delete $2; }
+			;
+/*
+tilde_push              : tilde
+                        { if (insert_id("~", 1)) return -1; }
+			;
+asterisk_push           : asterisk
+                        { if (insert_id("*", 1)) return -1; }
+			;
+names_push		: identifier_push
+			| LBRACE identifier_list_push RBRACE
+			| asterisk_push
+			| tilde_push identifier_push
+			| tilde_push LBRACE identifier_list_push RBRACE
+			;
+identifier_list_push	: IDENTIFIER { $$ = StringVectorPtr(new StringVector($1)); }
+			| IDENTIFIER_list_push IDENTIFIER
+                        { $1->insert($1->end(), $2->rbegin(), $->rend()); $$ = $1; }
+			;
+*/
+identifier_list		: IDENTIFIER { $$ = new StringVector(1, *$1); delete $1; }
+			| identifier_list IDENTIFIER
+                        { $1->push_back(*$2); $$ = $1; delete $2; }
+			;
+nested_id_set           : LBRACE nested_id_list RBRACE { $$ = $2; }
+                        ;
+nested_id_list          : nested_id_element
+			| nested_id_list nested_id_element
+                        { $1->insert($1->end(), $2->begin(), $2->end()); $$ = $1; delete $2; }
+                        ;
+nested_id_element       : IDENTIFIER { $$ = new StringVector(1, *$1); delete $1; }
+			| sub_identifier { $$ = new StringVector(1, *$1); delete $1; }
+			| nested_id_set
+                        ;
+version_identifier      : VERSION_IDENTIFIER { $$ = $<id>1; }
+                        ;
+sub_identifier          : DASH IDENTIFIER { $$ = new std::string("-"); *$$ += *$2 }
+			;
+/*
+number			: NUMBER
+			{ $$ = strtoul(yytext,NULL,0); }
+			;
+ipv6_addr		: IPV6_ADDR
+			{ if (insert_id(yytext,0)) return -1; }
+			;
+version_identifier      : VERSION_IDENTIFIER
+                        ;
+*/
+%%
+
+namespace policyrep {
+
+	void policy_parser::error(const policy_parser::location_type& l,
+				  const std::string& m)
+	{
+		driver.error(l, m);
+	}
+
+	
+	AVRule* define_avrule(AVRule::Type type, IdSet* src_types,
+			      IdSet* tgt_types, IdSet* classes,
+			      IdSet* perms, Parser& driver)
+	{
+		AVRule* x = new AVRule(type);
+		
+		x->src_types().ids().insert(src_types->ids().begin(), src_types->ids().end());
+		x->src_types().set_compl(src_types->get_compl());
+		delete src_types;
+
+		x->tgt_types().ids().insert(tgt_types->ids().begin(), tgt_types->ids().end());
+		x->tgt_types().set_compl(tgt_types->get_compl());
+		delete tgt_types;
+
+		if (classes->get_compl())
+			driver.error("compliment not allowed in class list");
+		x->classes().insert(classes->ids().begin(), classes->ids().end());
+		delete classes;
+
+		x->perms().ids().insert(perms->ids().begin(), perms->ids().end());
+		x->perms().set_compl(perms->get_compl());
+		delete perms;
+
+		return x;
+	}
+
+} // namespace policyrep
+
+/* FLASK */
+
+
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/policy_scan.l
--- a/libpolicyrep/src/policy_scan.l	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/policy_scan.l	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,275 @@
+
+/*
+ * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ */
+
+/* Updated: Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *      Converted to C++
+ *
+ * Updated: David Caplan, <dac@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ *          Jason Tang    <jtang@tresys.com>
+ *
+ *	Added support for binary policy modules
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
+ * Copyright (C) 2003-5 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+/* FLASK */
+
+%{
+#include "policy_parse.hpp"
+#include <policyrep/parse.hpp>
+
+#include <stdexcept>
+#include <string>
+
+static int is_valid_identifier(char *id);
+
+#define YY_DECL						\
+	policyrep::policy_parser::token_type			\
+		policyreplex(policyrep::policy_parser::semantic_type* yylval,	\
+		      policyrep::policy_parser::location_type* yylloc,	\
+		      policyrep::Parser& driver)
+
+#define yyterminate() return token::END
+
+%}
+
+%option noyywrap nounput batch debug
+%option outfile="policy_scan.cpp" header-file="scanner-file.cpp"
+
+%array
+letter  [A-Za-z]
+digit   [0-9]
+hexval	[0-9A-Fa-f]
+version [0-9]+(\.[A-Za-z0-9_.]*)?
+
+%{
+typedef policyrep::policy_parser::token token;
+#define YY_USER_ACTION yylloc->columns(yyleng);
+%}
+
+%%
+
+%{
+	yylloc->step();
+%}
+
+\n.*				{ yylloc->lines(yyleng); yylloc->step(); yyless(1); }
+
+CLONE |
+clone				{ return token::CLONE; }
+COMMON |
+common				{ return token::COMMON; }
+CLASS |
+class				{ return token::CLASS; }
+CONSTRAIN |
+constrain			{ return token::CONSTRAIN; }
+VALIDATETRANS |
+validatetrans			{ return token::VALIDATETRANS; }
+INHERITS |
+inherits			{ return token::INHERITS; }
+SID |
+sid				{ return token::SID; }
+ROLE |
+role				{ return token::ROLE; }
+ROLES |
+roles				{ return token::ROLES; }
+TYPES |
+types				{ return token::TYPES; }
+TYPEALIAS |
+typealias			{ return token::TYPEALIAS; }
+TYPEATTRIBUTE |
+typeattribute			{ return token::TYPEATTRIBUTE; }
+TYPE |
+type				{ return token::TYPE; }
+BOOL |
+bool                            { return token::BOOL; }
+IF |
+if				{ return token::IF; }
+ELSE |
+else				{ return token::ELSE; }
+ALIAS |
+alias				{ return token::ALIAS; }
+ATTRIBUTE |
+attribute			{ return token::ATTRIBUTE; }
+TYPE_TRANSITION |
+type_transition			{ return token::TYPE_TRANSITION; }
+TYPE_MEMBER |
+type_member			{ return token::TYPE_MEMBER; }
+TYPE_CHANGE |
+type_change			{ return token::TYPE_CHANGE; }
+ROLE_TRANSITION |
+role_transition			{ return token::ROLE_TRANSITION; }
+RANGE_TRANSITION |
+range_transition		{ return token::RANGE_TRANSITION; }
+SENSITIVITY |
+sensitivity			{ return token::SENSITIVITY; }
+DOMINANCE |
+dominance			{ return token::DOMINANCE; }
+CATEGORY |
+category			{ return token::CATEGORY; }
+LEVEL |
+level				{ return token::LEVEL; }
+RANGE |
+range				{ return token::RANGE; }
+MLSCONSTRAIN |
+mlsconstrain			{ return token::MLSCONSTRAIN; }
+MLSVALIDATETRANS |
+mlsvalidatetrans		{ return token::MLSVALIDATETRANS; }
+USER |
+user				{ return token::USER; }
+NEVERALLOW |
+neverallow		        { return token::NEVERALLOW; }
+ALLOW |
+allow			        { return token::ALLOW; }
+AUDITALLOW |
+auditallow		        { return token::AUDITALLOW; }
+AUDITDENY |
+auditdeny		        { return token::AUDITDENY; }
+DONTAUDIT |
+dontaudit                       { return token::DONTAUDIT; }
+SOURCE |
+source			        { return token::SOURCE; }
+TARGET |
+target			        { return token::TARGET; }
+SAMEUSER |
+sameuser			{ return token::SAMEUSER;}
+module|MODULE                   { return token::MODULE; }
+require|REQUIRE                 { return token::REQUIRE; }
+optional|OPTIONAL               { return token::OPTIONAL; }
+OR |
+or     			        { return token::OR;}
+AND |
+and				{ return token::AND;}
+NOT |
+not				{ return token::NOT;}
+xor |
+XOR                             { return token::XOR; }
+eq |
+EQ				{ return token::EQUALS;}
+true |
+TRUE                            { return token::CTRUE; }
+false |
+FALSE                           { return token::CFALSE; }
+dom |
+DOM				{ return token::DOM;}
+domby |
+DOMBY				{ return token::DOMBY;}
+INCOMP |
+incomp				{ return token::INCOMP;}
+fscon |
+FSCON                           { return token::FSCON;}
+portcon |
+PORTCON				{ return token::PORTCON;}
+netifcon |
+NETIFCON			{ return token::NETIFCON;}
+nodecon |
+NODECON				{ return token::NODECON;}
+fs_use_xattr |
+FS_USE_XATTR			{ return token::FSUSEXATTR;}
+fs_use_task |
+FS_USE_TASK                     { return token::FSUSETASK;}
+fs_use_trans |
+FS_USE_TRANS                    { return token::FSUSETRANS;}
+genfscon |
+GENFSCON                        { return token::GENFSCON;}
+r1 |
+R1				{ return token::R1; }
+r2 |
+R2				{ return token::R2; }
+r3 |
+R3				{ return token::R3; }
+u1 |
+U1				{ return token::U1; }
+u2 |
+U2				{ return token::U2; }
+u3 |
+U3				{ return token::U3; }
+t1 |
+T1				{ return token::T1; }
+t2 |
+T2				{ return token::T2; }
+t3 |
+T3				{ return token::T3; }
+l1 |
+L1				{ return token::L1; }
+l2 |
+L2				{ return token::L2; }
+h1 |
+H1				{ return token::H1; }
+h2 |
+H2				{ return token::H2; }
+"/"({letter}|{digit}|_|"."|"-"|"/")*	{ yylval->id = new std::string(yytext); return token::PATH; }
+{letter}({letter}|{digit}|_|"."|"-")*	{ if (is_valid_identifier(yytext)) {
+		                                yylval->id = new std::string(yytext);
+						return token::IDENTIFIER;
+	                                  } else {
+					  	REJECT;
+	                                  }
+					}
+{digit}{digit}*                 { yylval->num = strtoul(yytext, NULL, 0); return token::NUMBER; }
+{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|":"|".")*	{ yylval->id = new std::string(yytext);
+                                                          return token::IPV6_ADDR; }
+{version}/([ \t\f]*;)           { yylval->id = new std::string(yytext); return token::VERSION_IDENTIFIER; }
+#line[ ]1[ ]\"[^\n]*\"		{ yylloc->lines(1); }
+#line[ ]{digit}{digit}*		{ yylloc->lines(atoi(yytext+6)-1); }
+#[^\n]*                         { yylloc->lines(yyleng); yylloc->step(); }
+[ \t\f]+			{ }
+"==" 				{ return token::EQUALS; }
+"!="				{ return token::NOTEQUAL; }
+"&&"				{ return token::AND; }
+"||"				{ return token::OR; }
+"!"				{ return token::NOT; }
+"^"                             { return token::XOR; }
+","				{ return token::COMMA; }
+":"				{ return token::COLON; }
+";"				{ return token::SEMI; }
+"("				{ return token::LPAREN; }
+")"				{ return token::RPAREN; }
+"{"				{ return token::LBRACE; }
+"}"				{ return token::RBRACE; }
+"["				{ return token::LBRACKET; }
+"-"				{ return token::DASH; }
+"."				{ return token::PERIOD; }
+"]"				{ return token::RBRACKET; }
+"~"                             { return token::TILDE; }
+"*"				{ return token::ASTERISK; }
+.                               { driver.error(*yylloc, "unrecognized character"); }
+%%
+
+static int is_valid_identifier(char *id) {
+        if ((strrchr(id, '.')) != NULL) {
+                if (strstr(id, "..") != NULL) {
+                        /* identifier has consecutive '.' */
+                        return 0;
+                }
+		if (id[strlen(id) - 1] == '.') {
+			/* identifier ends in '.' */
+			return 0;
+		}
+        }
+        return 1;
+}
+
+// implementation from parse.hpp
+void policyrep::Parser::scan_begin()
+{
+	yy_flex_debug = get_trace_scanning();
+	if (!(yyin = fopen(get_filename().c_str(), "r"))) {
+		error(std::string("cannot open ") + get_filename());
+		throw std::invalid_argument("cannot open: " + get_filename());
+	}
+}
+
+void policyrep::Parser::scan_end()
+{
+	fclose(yyin);
+}
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/policyrep_python.cpp
--- a/libpolicyrep/src/policyrep_python.cpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/policyrep_python.cpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,250 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
+#include <sstream>
+
+#include <policyrep/policy.hpp>
+#include <policyrep/parse.hpp>
+
+using namespace policyrep;
+
+#include <boost/python.hpp>
+#include <boost/python/suite/indexing/vector_indexing_suite.hpp>
+#include <boost/python/register_ptr_to_python.hpp>
+
+using namespace boost::python;
+
+void set_insert(StringSet &s, const char* c) { s.insert(c); }
+
+void set_erase(StringSet &s, const char* c) { s.erase(c); }
+
+std::string set_to_string(const StringSet &s) {
+        std::stringstream ss;
+        ss << "StringSet([";
+        bool first = true;
+        for (StringSet::const_iterator i = s.begin(); i != s.end(); ++i) {
+                if (first)
+                        first = false;
+                else
+                        ss << ", ";
+                ss << "'" << *i << "'";
+        }
+        ss << "])";
+        return ss.str();
+}
+
+BOOST_PYTHON_MODULE(policyrep)
+{
+
+	//
+	// policy_base.hpp
+	//
+
+        class_<Node>("Node")
+		.add_property("parent",
+			      make_function(&Node::get_parent,
+					    return_value_policy<reference_existing_object>()),
+			      &Node::set_parent)
+                .add_property("visited", &Node::get_visited, &Node::set_visited)
+                .def("__str__", &Node::to_string)
+                .def("to_string_end", &Node::to_string_end)
+                ;
+	register_ptr_to_python<NodePtr>();
+
+        class_<NodeVector>("NodeVector")
+                .def(vector_indexing_suite<NodeVector, true>())
+                ;
+
+        class_<Parent, bases<Node> >("Parent")
+                .def("append_child", &Parent::append_child)
+                .def("children", &Parent::children,
+		     return_value_policy<reference_existing_object>())
+                ;
+
+	register_ptr_to_python<ParentPtr>();
+
+        class_<StringSet>("StringSet")
+                .def("add", &set_insert)
+                .def("discard", &set_erase)
+                .def("__str__", &set_to_string)
+                .def("__repr__", &set_to_string)
+                .def("__iter__", range(&StringSet::begin, &StringSet::end))
+                ;
+
+	//
+	// policy.hpp
+	//
+
+        class_<Policy, bases<Parent> >("Policy")
+                .add_property("mls", &Policy::get_mls, &Policy::set_mls)
+                ;
+	register_ptr_to_python<PolicyPtr>();
+
+
+        class_<Module, bases<Parent> >("Module")
+		.add_property("name",
+			      make_function(&Module::get_name,
+					    return_value_policy<copy_const_reference>()),
+			      &Module::set_name)
+		.add_property("version", make_function(&Module::get_version,
+						       return_value_policy<copy_const_reference>()),
+			      &Module::set_version)
+                ;
+	register_ptr_to_python<ModulePtr>();
+
+	class_<InitialSid, bases<Node> >("InitialSid")
+		.add_property("name", make_function(&InitialSid::get_name,
+						    return_value_policy<reference_existing_object>()),
+			      &InitialSid::set_name)
+		;
+	register_ptr_to_python<InitialSidPtr>();
+
+	//
+	// te_decl.hpp
+	//
+
+        class_<Type, bases<Node> >("Type")
+		.add_property("name",
+			      make_function(&Type::get_name,
+					    return_value_policy<copy_const_reference>()),
+			      &Type::set_name)
+                .add_property("aliases"
+                        , make_function(
+                                &Type::aliases,
+				return_value_policy<reference_existing_object>()
+                         ))
+                .add_property("attributes"
+                        , make_function(
+                                &Type::attributes,
+				return_value_policy<reference_existing_object>()
+                         ))
+                ;
+	register_ptr_to_python<TypePtr>();
+
+	class_<Attribute, bases<Node> >("Attribute")
+		.add_property("name",
+			      make_function(&Attribute::get_name,
+					    return_value_policy<copy_const_reference>()),
+			      &Attribute::set_name)
+		;
+	register_ptr_to_python<AttributePtr>();
+
+	class_<TypeAttribute, bases<Node> >("TypeAttribute")
+		.add_property("name",
+			      make_function(&TypeAttribute::get_name,
+					    return_value_policy<copy_const_reference>()),
+			      &TypeAttribute::set_name)
+		.add_property("attributes",
+			      make_function(&TypeAttribute::attributes,
+					    return_value_policy<reference_existing_object>()))
+		;
+	register_ptr_to_python<TypeAttributePtr>();
+
+	class_<TypeAlias, bases<Node> >("TypeAlias")
+		.add_property("name",
+			      make_function(&TypeAlias::get_name,
+					    return_value_policy<copy_const_reference>()),
+			      &TypeAlias::set_name)
+		.add_property("aliases",
+			      make_function(&TypeAlias::aliases,
+					    return_value_policy<reference_existing_object>()))
+		;
+	register_ptr_to_python<TypeAliasPtr>();
+	
+					    
+
+
+	//
+	// object_class.hpp
+	//
+
+	class_<CommonPerms, bases<Node> >("CommonPerms")
+		.add_property("name",
+			      make_function(&CommonPerms::get_name,
+					    return_value_policy<copy_const_reference>()),
+			      &CommonPerms::set_name)
+		.add_property("perms",
+			      make_function(&CommonPerms::perms,
+					    return_value_policy<reference_existing_object>()))
+		;
+	register_ptr_to_python<CommonPermsPtr>();
+
+	class_<ObjectClass, bases<Node> >("ObjectClass")
+		.add_property("name",
+			      make_function(&ObjectClass::get_name,
+					    return_value_policy<copy_const_reference>()),
+			      &ObjectClass::set_name)
+		.add_property("common_perms",
+			      make_function(&ObjectClass::get_common_perms,
+					    return_value_policy<copy_const_reference>()),
+			      &ObjectClass::set_common_perms)
+		.add_property("perms",
+			      make_function(&ObjectClass::perms,
+					    return_value_policy<reference_existing_object>()))
+		;
+	register_ptr_to_python<ObjectClassPtr>();
+
+	//
+	// idset.hpp
+	//
+
+	class_<IdSet>("IdSet")
+		.add_property("compl", &IdSet::get_compl, &IdSet::set_compl)
+		.add_property("ids",
+			      make_function(&IdSet::ids,
+					    return_value_policy<reference_existing_object>()))
+		;
+
+	//
+	// rule.hpp
+	//
+
+	class_<AVRule, bases<Node> >("AVRule")
+		.add_property("type", &AVRule::get_type, &AVRule::set_type)
+		.add_property("src_types",
+			      make_function(&AVRule::src_types,
+					    return_value_policy<reference_existing_object>()))
+		.add_property("tgt_types",
+			      make_function(&AVRule::tgt_types,
+					    return_value_policy<reference_existing_object>()))
+		.add_property("classes",
+			      make_function(&AVRule::classes,
+					    return_value_policy<reference_existing_object>()))
+		.add_property("perms",
+			      make_function(&AVRule::perms,
+					    return_value_policy<reference_existing_object>()))
+		;
+
+	enum_<AVRule::Type>("Type")
+		.value("ALLOW", AVRule::ALLOW)
+		.value("AUDITALLOW", AVRule::AUDITALLOW)
+		.value("AUDITDENY", AVRule::AUDITDENY)
+		.value("DONTAUDIT", AVRule::DONTAUDIT)
+		.value("NEVERALLOW", AVRule::NEVERALLOW)
+		;
+
+	//
+	// Parse
+	//
+
+	class_<Parser>("Parser")
+		.def("parse", &Parser::parse)
+		;
+}
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/rule.cpp
--- a/libpolicyrep/src/rule.cpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/rule.cpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,131 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
+#include <policyrep/rule.hpp>
+
+namespace policyrep
+{
+
+        //
+        // AVRule
+        //
+
+        struct AVRuleImpl
+        {
+		AVRule::Type type;
+                IdSet src_types;
+                IdSet tgt_types;
+                StringSet classes;
+                IdSet perms;
+        };
+
+        void AVRule::init()
+        {
+                impl = new AVRuleImpl;
+        }
+
+        AVRule::AVRule(Type type)
+        {
+                init();
+                impl->type = type;
+        }
+
+        AVRule::AVRule(const AVRule& other)
+                : Node()
+        {
+                init();
+                *impl = *other.impl;
+        }
+
+        AVRule::~AVRule()
+        {
+                delete impl;
+        }
+
+        void AVRule::operator=(const AVRule& other)
+        {
+                *impl = *other.impl;
+        }
+
+	void AVRule::set_type(AVRule::Type type)
+	{
+		impl->type = type;
+	}
+
+	AVRule::Type AVRule::get_type() const
+	{
+		return impl->type;
+	}
+
+        IdSet& AVRule::src_types()
+        {
+                return impl->src_types;
+        }
+
+        IdSet& AVRule::tgt_types()
+        {
+                return impl->tgt_types;
+        }
+
+        StringSet& AVRule::classes()
+        {
+                return impl->classes;
+        }
+
+        IdSet& AVRule::perms()
+        {
+                return impl->perms;
+        }
+
+	void AVRule::output(std::ostream& o, enum OutputStyle style) const
+	{
+		switch(impl->type) {
+		case ALLOW:
+			o << "allow ";
+			break;
+		case AUDITALLOW:
+			o << "auditallow ";
+			break;
+		case AUDITDENY:
+			o << "auditdeny ";
+			break;
+		case DONTAUDIT:
+			o << "dontaudit ";
+			break;
+		case NEVERALLOW:
+			o << "neverallow ";
+			break;
+		};
+
+		output_set_space(o, impl->src_types.ids());
+		o << " ";
+
+		output_set_space(o, impl->tgt_types.ids());
+		o << ":";
+
+		output_set_space(o, impl->classes);
+		o << " ";
+
+		output_set_space(o, impl->perms.ids());
+		o << ";";
+	}
+
+
+} // namespace policyrep
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/src/te_decl.cpp
--- a/libpolicyrep/src/te_decl.cpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/src/te_decl.cpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,255 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
+#include <policyrep/te_decl.hpp>
+
+namespace policyrep
+{
+
+	//
+	// Type
+	//
+
+	struct TypeImpl
+	{
+		std::string name;
+		StringSet attributes;
+		StringSet aliases;
+	};
+
+	void Type::init()
+	{
+		impl = new TypeImpl;
+	}
+
+	Type::Type() { init(); }
+
+	Type::Type(const std::string& name)
+	{
+		init();
+		impl->name = name;
+	}
+
+	Type::Type(const Type& other)
+		: Node()
+	{
+		init();
+		*impl = *other.impl;
+	}
+
+	Type::~Type() { delete impl; }
+
+	void Type::operator=(const Type& other)
+	{
+		*impl = *other.impl;
+	}
+
+	const std::string& Type::get_name() const
+	{
+		return impl->name;
+	}
+
+	void Type::set_name(const std::string& name)
+	{
+		impl->name = name;
+	}
+
+	StringSet& Type::aliases()
+	{
+		return impl->aliases;
+	}
+
+	StringSet& Type::attributes()
+	{
+		return impl->attributes;
+	}
+
+	void Type::output(std::ostream& o, enum OutputStyle style) const
+	{
+		if (style == DEBUG_OUTPUT)
+			o << "[TYPE " << this << "]";
+
+		o << "type " << impl->name;
+		if (!impl->aliases.empty()) {
+			o << " alias ";
+			output_set_space(o, impl->aliases);
+		}
+		if (!impl->attributes.empty()) {
+			o << ", ";
+			output_set_comma(o, impl->attributes);
+		}
+		o << ";";
+	}
+
+
+	//
+	// Attribute
+	//
+
+	struct AttributeImpl
+	{
+		std::string name;
+	};
+
+	Attribute::Attribute() : impl(new AttributeImpl) { }
+
+	Attribute::Attribute(const std::string& name)
+		: impl(new AttributeImpl)
+	{
+		impl->name = name;
+	}
+
+	Attribute::~Attribute()
+	{
+		delete impl;
+	}
+
+	Attribute::Attribute(const Attribute& other)
+		: Node(), impl(new AttributeImpl)
+	{
+		*impl = *other.impl;
+	}
+
+	void Attribute::operator=(const Attribute& other)
+	{
+		*impl = *other.impl;
+	}
+
+	const std::string& Attribute::get_name() const
+	{
+		return impl->name;
+	}
+
+	void Attribute::set_name(const std::string& name)
+	{
+		impl->name = name;
+	}
+
+	void Attribute::output(std::ostream& o, enum OutputStyle style) const
+	{
+		o << "attribute " << impl->name << ";";
+	}
+
+	//
+	// TypeAttribute
+	//
+
+	struct TypeAttributeImpl
+	{
+		std::string name;
+		StringSet attributes;
+	};
+
+	void TypeAttribute::init() { impl = new TypeAttributeImpl; }
+
+	TypeAttribute::TypeAttribute() { init(); }
+
+	TypeAttribute::TypeAttribute(const TypeAttribute& other)
+		: Node()
+	{
+		*impl = *other.impl;
+	}
+
+	TypeAttribute::~TypeAttribute() { delete impl; }
+
+	void TypeAttribute::operator=(const TypeAttribute& other)
+	{
+		*impl = *other.impl;
+	}
+
+	const std::string& TypeAttribute::get_name() const
+	{
+		return impl->name;
+	}
+
+	void TypeAttribute::set_name(const std::string& name)
+	{
+		impl->name = name;
+	}
+
+	StringSet& TypeAttribute::attributes()
+	{
+		return impl->attributes;
+	}
+
+	void TypeAttribute::output(std::ostream& o, enum OutputStyle style) const
+	{
+		o << "typeattribute " << impl->name << " ";
+		output_set_comma(o, impl->attributes);
+		o << ";";
+	}
+
+        //
+        // TypeAlias
+        //
+
+        struct TypeAliasImpl
+        {
+                std::string name;
+                StringSet aliases;
+        };
+
+        void TypeAlias::init() { impl = new TypeAliasImpl; }
+
+        TypeAlias::TypeAlias()
+        {
+                init();
+        }
+
+        TypeAlias::TypeAlias(const TypeAlias& other)
+                : Node()
+        {
+                *impl = *other.impl;
+        }
+
+        TypeAlias::~TypeAlias()
+        {
+                delete impl;
+        }
+
+        void TypeAlias::operator=(const TypeAlias& other)
+        {
+                *impl = *other.impl;
+        }
+
+        const std::string& TypeAlias::get_name() const
+        {
+                return impl->name;
+        }
+
+        void TypeAlias::set_name(const std::string& name)
+        {
+                impl->name = name;
+        }
+
+        StringSet& TypeAlias::aliases()
+        {
+                return impl->aliases;
+        }
+
+        void TypeAlias::output(std::ostream& o, enum OutputStyle style) const
+        {
+                o << "typealias " << impl->name << " ";
+                output_set_space(o, impl->aliases);
+                o << ";";
+        }
+
+
+} // namespace policyrep
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/tests/Makefile
--- a/libpolicyrep/tests/Makefile	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/tests/Makefile	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,24 @@
+M4 ?= m4
+MKDIR ?= mkdir
+EXE ?= libpolicyrep-test
+
+CFLAGS += -g3 -gdwarf-2 -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter -Werror -I../include
+
+LIBPOLICYREP := ../src/libpolicyrep.a
+
+# test program object files
+objs := $(patsubst %.cpp,%.o,$(wildcard *.cpp))
+
+all: $(EXE)
+
+$(EXE): $(objs) $(LIBPOLICYREP)
+	g++ $(CFLAGS) $(objs) $(LIBPOLICYREP) -lboost_serialization -o $@
+
+%.o:  %.cpp
+	g++ $(CFLAGS) -fPIC -c -o $@ $<
+
+clean: 
+	rm -f $(objs) $(EXE)
+
+test: $(EXE)
+	./$(EXE)
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/tests/example.te
--- a/libpolicyrep/tests/example.te	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/tests/example.te	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,24 @@
+module foo 1.0;
+
+class bar
+
+class foo
+		
+class bar
+{
+	read
+	write
+	append	
+}
+
+sid mysid
+
+attribute domain;
+
+type mydomain_t;
+
+type user_t alias luser_t;
+
+type mozilla_t, domain;
+
+allow foo bar : file { read write execute };
diff -r f7c0c0ec9d61 -r f71c0f396608 libpolicyrep/tests/libpolicyrep-test.cpp
--- a/libpolicyrep/tests/libpolicyrep-test.cpp	Thu Jun 28 10:11:06 2007 -0400
+++ b/libpolicyrep/tests/libpolicyrep-test.cpp	Thu Jun 28 10:11:17 2007 -0400
@@ -0,0 +1,59 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
+#include <policyrep/policy.hpp>
+#include <policyrep/parse.hpp>
+
+#include <sstream>
+#include <iostream>
+
+using namespace policyrep;
+
+int main(int argc, char **argv)
+{
+        PolicyPtr pol(new Policy());
+        ModulePtr mod(new Module("foo", "1.0"));
+        pol->append_child(mod);
+        TypePtr t(new Type("foo"));
+        t->aliases().insert("bar");
+        t->aliases().insert("baz");
+        t->aliases().insert("bar"); // duplicate - will be ingored
+        t->attributes().insert("domain");
+        t->attributes().insert("userdomain");
+        
+        mod->append_child(t);
+        
+	std::cout << "============ basic test ============" << std::endl;
+        output_tree(std::cout, *pol);
+        
+        std::stringstream s;
+        output_tree(s, *pol);
+        std::cout << s.str() << std::endl;
+
+	std::cout << "============ Parsing ============" << std::endl;
+	Parser p;
+	//p.trace_parsing = true;
+	//p.trace_scanning = true;
+
+	ModulePtr parsed_mod = p.parse("example.te");
+	output_tree(std::cout, *parsed_mod);
+			      
+	return 0;
+}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
