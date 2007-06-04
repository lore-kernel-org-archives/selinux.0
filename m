Subject: RE: SELinux userspace infrastructure language
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1180639909.22021.26.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	 <1180633622.3534.78.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	 <1180639909.22021.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 18:24:48 -0400
Message-Id: <1180995888.9766.63.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-31 at 15:31 -0400, Karl MacMillan wrote:
> On Thu, 2007-05-31 at 13:54 -0400, Joshua Brindle wrote:
> > Karl MacMillan wrote:
[...]
> > 
> > > 1) adopt sepolgen as the new policyrep and implement the
> > > policy compilers on top of that. The policyrep branch is in
> > > some senses a port of part of sepolgen.
> > > 2) Keep going with policyrep, but in C++.
> > > 
> > > 1 is less work but harder for cross-language development. 2
> > > is much more work, potentially forever.
> > > 
> > 
> > So, the new representation should make it much easier to interact with
> > parts of policy and hopefully users will come (and continue) to do
> > policy analysis, generation, writing, etc using these representations
> > that we are making. My main concern is that us doing it in python
> > basically puts a huge damper on what our users will do (eg., who are we
> > to say someone writing an analysis tool can't use haskell if they want
> > ;) ). SLIDE, which will become increasingly important IMO, is in java
> > which /can/ use python (using jython) but I am under the impression
> > there are risks of incompatibilities and a huge lag in support. 
> > 
> > Setools also wants to use the new representation to do analysis of the
> > policy (and SLIDE wants to integrate with setools for debugging
> > assistance), all of this is made possible by the new representation but
> > using python inherently limits what they can do.
> > 
> > Given all this I think C++ is the best bet, though I'm not adverse to
> > most of the frontends being written in python, it would just be nice if
> > the actual policy representation and accessors are available from a
> > shared library API that most languages can use.
> > 
> 
> I'm basically OK with this approach with some caveats / concerns:
> 
> 1) We need to allow the use of the boost libraries, particularly
> boost::python. Wrapping C++ with boost::python gets you a lot for very
> little code (and a fair amount of CPU usage during compile). I think it
> is _much_ better than swig for creating idiomatic bindings. Many of the
> other libraries are excellent and, in my opinion, indispensable for C++
> work.
> 
> 2) How are we going to proceed with the development? Create a brand new
> library in C++ and pull in parts of libsepol as needed? I guess we would
> simultaneously rip out parts of the current libsepol that are no longer
> needed.
> 
> 3) We should adopt some C++ coding standards before development starts
> to avoid really bad C++.
> 
> I still think we should consider sepolgen, but C++ may be the best
> choice.
> 

To explore this, I coded up some basic ideas in C++ to get a feel for
the time savings (patch below). What I came up with allows you to do
this:

int main(int argc, char **arv)
{
        shared_ptr<Policy> pol(new Policy());
        shared_ptr<Module> mod(new Module("foo", "1.0"));
        pol->append_child(mod);
        shared_ptr<Type> type(new Type("foo"));
        type->aliases().insert("bar");
        type->aliases().insert("baz");
        type->aliases().insert("bar"); // duplicate - will be ingored
        type->attributes().insert("domain");
        type->attributes().insert("userdomain");
        
        mod->append_child(type);
        
        output_tree(std::cout, *pol); 
}

Which outputs:

module foo 1.0;
type foo alias { bar baz }, domain, userdomain;

Notes:

* This took the better part of two days, though a fair amount of that
time was spent remembering how C++ worked and looking at new boost
libraries.

* The shared_ptr business gives us reference counting, so that when the
top-level node (pol in this example) is deleted / goes out of scope the
rest of the tree is destroyed. This is a very standard technique, but I
can remove it if it is too strange for people. On the other hand I had
no memory leaks in the initial version.

* This is basically equivalent to where the policyrep branch is today -
so there is a huge savings in development time with C++. Having lists,
vectors, sets, etc. all int the stl helps immensely.

* Parts of this are _much_ better than the C equivalent in ways that are
very hard to duplicate. The output, for example, is simple and shared
for file, stream, and string output.

* Most of this is pretty standard - any C++ coder would be able to get
up to speed quickly.

* The biggest drawback is, as usual, that some problems caused long and
mysterious compiler errors (including nested template insanity out of
some of the boost libraries). I'm pretty used to this but non-C++
programmers might be put off by this.

I also did serialization using the boost serialization library. This
allows us to do:

[...]
	save_policy(*pol, "archive");

	shared_ptr<Policy> newpol(new Policy());
        load_policy(*newpol, "archive");
        output_tree(std::cout, *newpol, DEBUG_OUTPUT);

The serialization is pretty easy - for example, serializing "Type" is
done with (this works for both saving and loading):

template<class Archive>
void Type::serialize(Archive& ar, const unsigned int version)
{
	ar & boost::serialization::base_object<Node>(*this);
	ar & m_name;
	ar & m_attributes;
	ar & m_aliases;
}

Finally, I made Python bindings using Boost::Python. The result is
Python bindings that are _easy_ to make and very idiomatic. For example,
Type needs (plus a few simple helpers and the wrapping for Node):

class_<StringSet>("StringSet")
        .def("add", &set_insert)
        .def("discard", &set_erase)
        .def("__str__", &set_to_string)
        .def("__repr__", &set_to_string)
        .def("__iter__", range(&StringSet::begin, &StringSet::end))
        ;
        
class_<Type, bases<Node> >("Type")
        .add_property("name", &Type::get_name, &Type::set_name)
        .add_property("aliases"
                , make_function(
                        &Type::aliases, return_value_policy<reference_existing_object>()
                 ))
        .add_property("attributes"
                        , make_function(
                                &Type::attributes, return_value_policy<reference_existing_object>()
                         ))
                ;

Which yields bindings that allow you to do:

import policyrep

t = policyrep.Type()
t.name = "user_t"
t.aliases.add("foo")
t.aliases.add("bar")

for a in t.aliases:
    print a

These bindings are much better than what you can get out of swig with
much less work. The tradeoff is that they use deep and mysterious C++
magic, which sometimes makes the compiler very unhappy.

This has basically convinced me that C++ is the way to go (or to put it
another way - please, oh, please don't make me write any more C code).
Thoughts?

Karl

-----

 Makefile                                  |    2 
 libpolicyrep/Makefile                     |   22 +
 libpolicyrep/include/Makefile             |   10 
 libpolicyrep/include/policyrep/policy.hpp |  175 ++++++++++++
 libpolicyrep/src/Makefile                 |   66 ++++
 libpolicyrep/src/policy.cpp               |  422 ++++++++++++++++++++++++++++++
 libpolicyrep/src/policyrep_python.cpp     |   75 +++++
 libpolicyrep/tests/Makefile               |   24 +
 libpolicyrep/tests/libpolicyrep-test.cpp  |   38 ++
 9 files changed, 833 insertions(+), 1 deletion(-)


diff -r 83885c13a34d Makefile
--- a/Makefile	Mon Jun 04 13:24:11 2007 -0400
+++ b/Makefile	Mon Jun 04 13:24:13 2007 -0400
@@ -1,4 +1,4 @@ SUBDIRS=libsepol libselinux libsemanage 
-SUBDIRS=libsepol libselinux libsemanage sepolgen checkpolicy policycoreutils # policy
+SUBDIRS=libsepol libselinux libsemanage libpolicyrep sepolgen checkpolicy policycoreutils # policy
 PYSUBDIRS=libselinux libsemanage
 
 ifeq ($(DEBUG),1)
diff -r 83885c13a34d libpolicyrep/Makefile
--- a/libpolicyrep/Makefile	Mon Jun 04 13:24:11 2007 -0400
+++ b/libpolicyrep/Makefile	Mon Jun 04 13:24:13 2007 -0400
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
+test:
+	$(MAKE) -C tests test
+
diff -r 83885c13a34d libpolicyrep/include/Makefile
--- a/libpolicyrep/include/Makefile	Mon Jun 04 13:24:11 2007 -0400
+++ b/libpolicyrep/include/Makefile	Mon Jun 04 13:24:13 2007 -0400
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
diff -r 83885c13a34d libpolicyrep/include/policyrep/policy.hpp
--- a/libpolicyrep/include/policyrep/policy.hpp	Mon Jun 04 13:24:11 2007 -0400
+++ b/libpolicyrep/include/policyrep/policy.hpp	Mon Jun 04 16:25:23 2007 -0400
@@ -0,0 +1,175 @@
+#include <vector>
+#include <list>
+#include <set>
+#include <string>
+
+#include <boost/shared_ptr.hpp>
+
+#include <boost/iterator/iterator_facade.hpp>
+
+#include <boost/archive/text_oarchive.hpp>
+#include <boost/archive/text_iarchive.hpp>
+#include <boost/serialization/vector.hpp>
+#include <boost/serialization/list.hpp>
+#include <boost/serialization/set.hpp>
+#include <boost/serialization/shared_ptr.hpp>
+
+namespace policyrep {
+        
+        class Node;
+        class Parent;
+        
+        typedef boost::shared_ptr<Node> NodePtr;
+        
+	enum OutputStyle { DEFAULT_OUTPUT, DEBUG_OUTPUT };
+
+        class Node {
+        public:
+                Node();
+                virtual ~Node() { };
+                
+                void set_parent(Parent* p);
+                Parent* get_parent() const;
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
+                Parent* m_parent;
+                int m_flags;
+                static const int VISITED = 1;
+	private:
+		friend class boost::serialization::access;
+		template<class Archive>
+		void serialize(Archive& ar, const unsigned int version);
+        };
+        
+        typedef std::vector<NodePtr> NodeVector;
+        typedef std::set<std::string> StringSet;
+        
+        std::ostream& operator<<(std::ostream& o, const Node& n);
+        
+        class Output {
+        public:
+                Output(const Node &n, bool end=false, enum OutputStyle style=DEFAULT_OUTPUT);
+                friend std::ostream& operator<<(std::ostream& o, const Output& op);
+        private:
+                const Node& m_n;
+                bool m_end;
+                enum OutputStyle m_style;
+        };
+        
+        void output_set_space(std::ostream& o, const StringSet& set);
+        void output_set_comma(std::ostream& o, const StringSet& set);
+        
+        class TreeIterator
+                : public boost::iterator_facade<TreeIterator, Node,
+                                                boost::forward_traversal_tag>
+        {
+        public:
+                enum Strategy { POSTORDER, PREORDER, HYBRID };
+                TreeIterator(enum Strategy strategy=POSTORDER);
+                explicit TreeIterator(Node& n, enum Strategy strategy=POSTORDER);
+                
+                bool get_visited() const;
+        private:
+                friend class boost::iterator_core_access;
+                void increment();
+                void increment_preorder();
+                void increment_postorder();
+                bool equal(const TreeIterator& other) const;
+                Node& dereference() const;
+                
+                int m_strategy;
+                std::list<Node*> m_stack;
+                Node* m_cur;
+                bool m_visited;
+        };
+        
+        class Parent : public Node {
+        public:
+                typedef TreeIterator iterator;                
+                virtual void append_child(NodePtr node);
+                virtual NodeVector& children();
+                
+                iterator begin(enum TreeIterator::Strategy strategy=TreeIterator::POSTORDER);
+                iterator end();
+        protected:
+                NodeVector m_children;  
+	private:
+		friend class boost::serialization::access;
+		template<class Archive>
+		void serialize(Archive& ar, const unsigned int version);     
+        };
+        
+        void output_tree(std::ostream& o, Parent& p,
+			 enum OutputStyle style=DEFAULT_OUTPUT);
+
+	class Policy : public Parent {
+	public:
+		Policy(bool mls=false);
+		virtual ~Policy() { };
+
+		bool get_mls() const;
+		void set_mls(bool val);
+                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+	protected:
+		bool m_mls;
+	private:
+		friend class boost::serialization::access;
+		template<class Archive>
+		void serialize(Archive& ar, const unsigned int version);
+	};
+	
+        class Module : public Parent {
+        public:
+		Module() { };
+                Module(std::string name, std::string version);
+                virtual ~Module() { };
+                
+                std::string get_name() const;
+                void set_name(std::string name);
+                std::string get_version() const;
+                void set_version(std::string version);
+                
+                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+        protected:
+                std::string m_name;
+                std::string m_version;
+	private:
+		friend class boost::serialization::access;
+		template<class Archive>
+		void serialize(Archive& ar, const unsigned int version);
+        };
+        
+        void save_policy(const Policy& p, std::string filename);
+        void load_policy(Policy& p, std::string filename);  
+        
+        class Type : public Node {
+        public:
+		Type() { };
+                Type(std::string name);
+                
+                std::string get_name() const;
+                void set_name(std::string name);
+                
+                virtual ~Type() { };
+                StringSet& aliases();
+                StringSet& attributes();
+                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
+        protected:
+                std::string m_name;
+                StringSet m_attributes;
+                StringSet m_aliases;
+	private:
+		friend class boost::serialization::access;
+		template<class Archive>
+		void serialize(Archive& ar, const unsigned int version);
+        };
+}
diff -r 83885c13a34d libpolicyrep/src/Makefile
--- a/libpolicyrep/src/Makefile	Mon Jun 04 13:24:11 2007 -0400
+++ b/libpolicyrep/src/Makefile	Mon Jun 04 16:15:40 2007 -0400
@@ -0,0 +1,66 @@
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
+LIBA=libpolicyrep.a 
+TARGET=libpolicyrep.so
+LIBSO=$(TARGET).$(LIBVERSION)
+OBJS= $(patsubst %.cpp,%.o,$(filter-out $(PYTHONCPP), $(wildcard *.cpp)))
+LOBJS= $(patsubst %.cpp,%.lo,$(filter-out $(PYTHONCPP), $(wildcard *.cpp)))
+CFLAGS ?= -Wall -W -Wundef -Wmissing-format-attribute -Wno-unused-parameter
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
+	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) $(PYTHONSO) $(PYTHONLOBJ)
+
+indent:
+	../../scripts/Lindent $(wildcard *.cpp)
+
diff -r 83885c13a34d libpolicyrep/src/policy.cpp
--- a/libpolicyrep/src/policy.cpp	Mon Jun 04 13:24:11 2007 -0400
+++ b/libpolicyrep/src/policy.cpp	Mon Jun 04 16:25:11 2007 -0400
@@ -0,0 +1,422 @@
+#include <policyrep/policy.hpp>
+
+#include <iostream>
+#include <algorithm>
+#include <fstream>
+#include <sstream>
+
+#include <boost/archive/text_oarchive.hpp>
+#include <boost/archive/text_iarchive.hpp>
+
+namespace policyrep {
+
+//
+// Node
+//
+
+Node::Node()
+: m_flags(0) { }
+
+void Node::set_parent(Parent* parent)
+{
+        m_parent = parent;       
+}
+
+Parent* Node::get_parent() const
+{
+        return m_parent;
+}
+
+bool Node::get_visited() const
+{
+        return m_flags & VISITED;       
+}
+
+void Node::set_visited(bool val)
+{
+        if (val)
+                m_flags |= VISITED;
+        else
+                m_flags &= ~VISITED;
+}
+
+void Node::output(std::ostream& o, enum OutputStyle style) const
+{
+	if (style == DEBUG_OUTPUT)
+		o << "[Node " << this << "]";       
+}
+
+void Node::output_end(std::ostream& o, enum OutputStyle style) const
+{
+        switch (style) {
+        case DEFAULT_OUTPUT:
+                break;
+        case DEBUG_OUTPUT:
+                o << "[END " << typeid(this).name() << " " << this << "]";
+        };    
+}
+
+void Node::output_end_brace(std::ostream& o, enum OutputStyle style) const
+{
+        switch (style) {
+        case DEFAULT_OUTPUT:
+                o << "}";
+                break;
+        case DEBUG_OUTPUT:
+                o << "} [" << typeid(this).name() << " " << this << "]";
+        };
+}
+
+std::string Node::to_string() const
+{
+        std::stringstream s;
+        s << *this;
+        return s.str();       
+}
+
+std::string Node::to_string_end() const
+{
+        std::stringstream s;
+        s << Output(*this, true, DEFAULT_OUTPUT);
+        return s.str();       
+}
+
+const int Node::VISITED;
+
+template<class Archive>
+void Node::serialize(Archive& ar, const unsigned int version)
+{
+        //if (m_parent)
+	//       ar & m_parent;
+	ar & m_flags;
+}
+
+std::ostream& operator<<(std::ostream& o, const Node& n)
+{
+        n.output(o);
+        return o;       
+}
+
+Output::Output(const Node &n, bool end, enum OutputStyle style)
+: m_n(n), m_end(end), m_style(style) { }
+
+std::ostream& operator<<(std::ostream& o, const Output& op)
+{
+        if (op.m_end)
+                op.m_n.output_end(o, op.m_style);
+        else
+                op.m_n.output(o, op.m_style);
+        return o;       
+}
+
+void output_set_space(std::ostream& o, const StringSet& set)
+{
+        if (set.size() > 1)
+                o << "{ ";
+        StringSet::const_iterator i;
+        bool first = true;
+        for (i = set.begin(); i != set.end(); ++i) {
+                if (first)        
+                        first = false;       
+                else
+                        o << " ";
+                o << *i;
+        }
+        if (set.size() > 1)
+                o << " }";
+}
+
+void output_set_comma(std::ostream& o, const StringSet& set)
+{
+        StringSet::const_iterator i;
+        bool first = true;
+        for (i = set.begin(); i != set.end(); ++i) {
+                if (first)        
+                        first = false;       
+                else
+                        o << ", ";
+                o << *i;
+        }       
+}
+
+//
+// TreeIterator
+//
+
+TreeIterator::TreeIterator(enum Strategy strategy)
+: m_strategy(strategy), m_cur(0) { }
+
+TreeIterator::TreeIterator(Node& n, enum Strategy strategy)
+: m_strategy(strategy), m_cur(&n)
+{
+        n.set_visited(false);
+        m_stack.push_back(&n);
+        increment();
+}
+
+bool TreeIterator::get_visited() const
+{
+        return m_visited;       
+}
+
+void TreeIterator::increment()
+{
+        switch (m_strategy) {
+        case POSTORDER:
+                this->increment_postorder();
+                break;
+        case PREORDER:
+        case HYBRID:
+                this->increment_preorder();
+                break;      
+        };       
+}
+
+void TreeIterator::increment_preorder()
+{
+        if (m_stack.empty()) {
+                m_cur = NULL;
+                return;       
+        }
+        m_cur = m_stack.back();
+        m_visited = m_cur->get_visited();
+        m_stack.pop_back();
+        
+        Parent* p = dynamic_cast<Parent*>(m_cur);
+        if (p and !p->get_visited()) {
+                  if (m_strategy == HYBRID) {
+                        p->set_visited(true);
+                        m_stack.push_back(m_cur);     
+                  }
+                  NodeVector::reverse_iterator i;
+                  for (i = p->children().rbegin(); i != p->children().rend(); ++i) {
+                        (*i)->set_visited(false);
+                        m_stack.push_back(i->get());
+                  }
+        }
+}
+
+void TreeIterator::increment_postorder()
+{
+        while (1) {
+                if (m_stack.empty()) {
+                        m_cur = NULL;
+                        return;       
+                }
+                Node* n = m_stack.back();
+                m_stack.pop_back();
+                
+                Parent* p = dynamic_cast<Parent*>(n);
+                if (n->get_visited() || p == 0) {
+                        m_cur = n;
+                        break;       
+                } else {
+                        p->set_visited(true);
+                        m_stack.push_back(n);
+                        NodeVector::reverse_iterator i;
+                        for (i = p->children().rbegin(); i != p->children().rend(); ++i) {
+                                (*i)->set_visited(false);
+                                m_stack.push_back(i->get());
+                        }                               
+                }
+        }
+}
+
+bool TreeIterator::equal(const TreeIterator& other) const
+{
+        return m_cur == other.m_cur;
+}
+
+Node& TreeIterator::dereference() const
+{
+        return *m_cur;
+}
+
+//
+// Parent
+//
+
+void Parent::append_child(NodePtr node)
+{
+        m_children.push_back(node);
+        node->set_parent(this);
+}
+
+NodeVector& Parent::children()
+{
+        return m_children;
+}
+
+Parent::iterator Parent::begin(enum TreeIterator::Strategy strategy)
+{
+        return TreeIterator(*this, strategy);
+}
+
+Parent::iterator Parent::end()
+{
+        return TreeIterator();              
+}
+
+template<class Archive>
+void Parent::serialize(Archive& ar, const unsigned int version)
+{
+	ar & boost::serialization::base_object<Node>(*this);
+	ar & m_children;
+}
+
+void output_tree(std::ostream& o, Parent& p,
+	enum OutputStyle style)
+{
+        Parent::iterator i, end;
+        end = p.end();
+        for (i = p.begin(TreeIterator::HYBRID); i != end; ++i) {
+                o << Output(*i, i.get_visited(), style) << "\n";
+        }
+        o << std::flush;
+}
+
+//
+// Policy
+//
+
+Policy::Policy(bool mls)
+: m_mls(mls) { }
+	
+bool Policy::get_mls() const
+{
+        return m_mls;       
+}
+
+void Policy::set_mls(bool val)
+{
+        m_mls = val;       
+}
+
+void Policy::output(std::ostream& o, enum OutputStyle style) const
+{
+	if (style == DEBUG_OUTPUT)
+		o << "[Policy " << this << "]";
+}
+
+template<class Archive>
+void Policy::serialize(Archive& ar, const unsigned int version)
+{
+        ar.register_type(static_cast<Node*>(NULL));
+        ar.register_type(static_cast<Parent*>(NULL));
+        ar.register_type(static_cast<Module*>(NULL));
+        ar.register_type(static_cast<Type*>(NULL));
+	ar & boost::serialization::base_object<Parent>(*this);
+	ar & m_mls;
+}
+
+void save_policy(const Policy& p, std::string filename)
+{
+        std::ofstream fout(filename.c_str());
+        boost::archive::text_oarchive ar(fout);
+        ar << p;
+}
+
+void load_policy(Policy& p, std::string filename)
+{
+        std::ifstream fin(filename.c_str(), std::ios::binary);
+        boost::archive::text_iarchive ia(fin);
+        ia >> p;
+}  
+
+//
+// Module
+//
+
+Module::Module(std::string name, std::string version)
+: m_name(name), m_version(version) { }
+
+std::string Module::get_name() const
+{
+        return m_name;       
+}
+
+void Module::set_name(std::string name)
+{
+        m_name = name;       
+}
+
+std::string Module::get_version() const
+{
+        return m_version;       
+}
+
+void Module::set_version(std::string version)
+{
+        m_version = version;       
+}
+
+void Module::output(std::ostream& o, enum OutputStyle style) const
+{
+	if (style == DEBUG_OUTPUT)
+		o << "[MODULE " << this << "]";
+        o << "module " << m_name << " " << m_version << ";";
+}
+
+template<class Archive>
+void Module::serialize(Archive& ar, const unsigned int version)
+{
+	ar & boost::serialization::base_object<Parent>(*this);
+	ar & m_name;
+	ar & m_version;
+}
+
+//
+// Type
+//
+
+Type::Type(std::string name)
+: m_name(name) { }
+
+std::string Type::get_name() const
+{
+        return m_name;       
+}
+
+void Type::set_name(std::string name)
+{
+        m_name = name;
+}
+
+StringSet& Type::aliases()
+{
+        return m_aliases;       
+}
+
+StringSet& Type::attributes()
+{
+        return m_attributes;       
+}
+
+void Type::output(std::ostream& o, enum OutputStyle style) const
+{
+	if (style == DEBUG_OUTPUT)
+		o << "[TYPE " << this << "]";
+
+        o << "type " << m_name;
+        if (!m_aliases.empty()) {
+                o << " alias ";
+                output_set_space(o, m_aliases);       
+        }
+        if (!m_attributes.empty()) {
+                o << ", ";
+                output_set_comma(o, m_attributes);       
+        }
+        o << ";";       
+}
+
+template<class Archive>
+void Type::serialize(Archive& ar, const unsigned int version)
+{
+	ar & boost::serialization::base_object<Node>(*this);
+	ar & m_name;
+	ar & m_attributes;
+	ar & m_aliases;
+}
+
+
+} // namespace policyrep
diff -r 83885c13a34d libpolicyrep/src/policyrep_python.cpp
--- a/libpolicyrep/src/policyrep_python.cpp	Mon Jun 04 13:24:11 2007 -0400
+++ b/libpolicyrep/src/policyrep_python.cpp	Mon Jun 04 18:11:20 2007 -0400
@@ -0,0 +1,75 @@
+#include <sstream>
+
+#include <policyrep/policy.hpp>
+using namespace policyrep;
+
+#include <boost/python.hpp>
+#include <boost/python/suite/indexing/vector_indexing_suite.hpp>
+using namespace boost::python;
+
+void set_insert(StringSet &s, const char* c) { s.insert(c); }
+void set_erase(StringSet &s, const char* c) { s.erase(c); }
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
+        class_<Node>("Node")
+                .def("get_parent", &Node::get_parent, return_value_policy<reference_existing_object>())
+                .def("set_parent", &Node::set_parent)//, return_value_policy<reference_existing_object>())
+                .add_property("visited", &Node::get_visited, &Node::set_visited)
+                .def("__str__", &Node::to_string)
+                .def("to_string_end", &Node::to_string_end)
+                ;
+                     
+        class_<NodeVector>("NodeVector")
+                .def(vector_indexing_suite<NodeVector, true>())
+                ;
+              
+        class_<Parent, bases<Node> >("Parent")
+                //.def("append_child", &Parent::append_child)
+                .def("children", &Parent::children, return_value_policy<reference_existing_object>())
+                ;
+
+        class_<Policy, bases<Parent> >("Policy")
+                .add_property("mls", &Policy::get_mls, &Policy::set_mls)
+                ;
+
+                
+        class_<Module, bases<Parent> >("Module")
+                .add_property("name", &Module::get_name, &Module::set_name)
+                .add_property("version", &Module::get_version, &Module::set_version)
+                ;
+
+        class_<StringSet>("StringSet")
+                .def("add", &set_insert)
+                .def("discard", &set_erase)
+                .def("__str__", &set_to_string)
+                .def("__repr__", &set_to_string)
+                .def("__iter__", range(&StringSet::begin, &StringSet::end))
+                ;
+                
+        class_<Type, bases<Node> >("Type")
+                .add_property("name", &Type::get_name, &Type::set_name)
+                .add_property("aliases"
+                        , make_function(
+                                &Type::aliases, return_value_policy<reference_existing_object>()
+                         ))
+                .add_property("attributes"
+                        , make_function(
+                                &Type::attributes, return_value_policy<reference_existing_object>()
+                         ))
+                ;
+}
diff -r 83885c13a34d libpolicyrep/tests/Makefile
--- a/libpolicyrep/tests/Makefile	Mon Jun 04 13:24:11 2007 -0400
+++ b/libpolicyrep/tests/Makefile	Mon Jun 04 13:24:13 2007 -0400
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
diff -r 83885c13a34d libpolicyrep/tests/libpolicyrep-test.cpp
--- a/libpolicyrep/tests/libpolicyrep-test.cpp	Mon Jun 04 13:24:11 2007 -0400
+++ b/libpolicyrep/tests/libpolicyrep-test.cpp	Mon Jun 04 15:58:15 2007 -0400
@@ -0,0 +1,38 @@
+#include <policyrep/policy.hpp>
+
+#include <iostream>
+#include <sstream>
+
+using namespace policyrep;
+using boost::shared_ptr;
+
+int main(int argc, char **argv)
+{
+        shared_ptr<Policy> pol(new Policy());
+        shared_ptr<Module> mod(new Module("foo", "1.0"));
+        pol->append_child(mod);
+        shared_ptr<Type> type(new Type("foo"));
+        type->aliases().insert("bar");
+        type->aliases().insert("baz");
+        type->aliases().insert("bar"); // duplicate - will be ingored
+        type->attributes().insert("domain");
+        type->attributes().insert("userdomain");
+        
+        mod->append_child(type);
+        
+        output_tree(std::cout, *pol);
+        
+        std::stringstream s;
+        output_tree(s, *pol, DEBUG_OUTPUT);
+        std::cout << s.str() << std::endl;
+
+        std::cout << "saving" << std::endl;
+        save_policy(*pol, "archive");
+
+	shared_ptr<Policy> newpol(new Policy());
+        std::cout << "loading" << std::endl;
+        load_policy(*newpol, "archive");
+        output_tree(std::cout, *newpol, DEBUG_OUTPUT);
+
+	return 0;
+}




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
