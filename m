Subject: RE: SELinux userspace infrastructure language
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BF044D@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	 <1180633622.3534.78.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	 <1180639909.22021.26.camel@localhost.localdomain>
	 <1180995888.9766.63.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF044D@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 04 Jun 2007 12:49:38 -0400
Message-Id: <1180975778.2862.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-04 at 20:52 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> <snip> 
> > 
> > To explore this, I coded up some basic ideas in C++ to get a
> > feel for the time savings (patch below). What I came up with
> > allows you to do
> > this:
> > 
> > int main(int argc, char **arv)
> > {
> >         shared_ptr<Policy> pol(new Policy());
> >         shared_ptr<Module> mod(new Module("foo", "1.0"));
> >         pol->append_child(mod);
> >         shared_ptr<Type> type(new Type("foo"));
> >         type->aliases().insert("bar");
> >         type->aliases().insert("baz");
> >         type->aliases().insert("bar"); // duplicate - will be ingored
> >         type->attributes().insert("domain");
> >         type->attributes().insert("userdomain");
> > 
> 
> Interesting, you didn't create attributes/aliases as a proper type? They
> are just strings associated with types? I'm not adverse to this, I'm
> just noting that it's a large difference from what we are doing now.
> 

It's what I do in sepolgen and what I've done in all of the policyrep
patches so far. Note that there will be types for attribute, typealias,
and typeattribute statements - my goal is to represent the policy
language fairly directly. So far it works well - it makes
programmatically manipulating policies really simple.

[...]

> 
> > * Parts of this are _much_ better than the C equivalent in
> > ways that are very hard to duplicate. The output, for
> > example, is simple and shared for file, stream, and string output.
> > 
> > * Most of this is pretty standard - any C++ coder would be
> > able to get up to speed quickly.
> > 
> > * The biggest drawback is, as usual, that some problems
> > caused long and mysterious compiler errors (including nested
> > template insanity out of some of the boost libraries). I'm
> > pretty used to this but non-C++ programmers might be put off by this.
> > 
> > I also did serialization using the boost serialization
> > library. This allows us to do:
> > 
> 
> Does this mean binary serialization?

Whatever you want - there is binary, text, XML, and you can implement
arbitrary formats. The custom format thing is nice - you just need to
implement support for built-in types (plus some other low-level stuff)
and the library takes care of using that to serialize higher-level
types.

>  Is the serialization stable
> (between versions of boost, even major versions?)
> 

I'm still looking into this, but it seems that is the case.

> Will we be able to use this serialization for everything including
> reading/writing binary modules, reading/writing to sockets?
> 

Yes - should be able to serialize to any stream. You can also start the
serialization from any point in the tree (though I believe you have to
know the starting type for de-serialization).

> > [...]
> > 	save_policy(*pol, "archive");
> > 
> > 	shared_ptr<Policy> newpol(new Policy());
> >         load_policy(*newpol, "archive");
> >         output_tree(std::cout, *newpol, DEBUG_OUTPUT);
> > 
> > The serialization is pretty easy - for example, serializing
> > "Type" is done with (this works for both saving and loading):
> > 
> > template<class Archive>
> > void Type::serialize(Archive& ar, const unsigned int version) {
> > 	ar & boost::serialization::base_object<Node>(*this); 	ar &
> m_name;
> > 	ar & m_attributes;
> > 	ar & m_aliases;
> > }
> > 
> > Finally, I made Python bindings using Boost::Python. The
> > result is Python bindings that are _easy_ to make and very
> > idiomatic. For example, Type needs (plus a few simple helpers
> > and the wrapping for Node):
> > 
> > class_<StringSet>("StringSet")
> >         .def("add", &set_insert)
> >         .def("discard", &set_erase)
> >         .def("__str__", &set_to_string)
> >         .def("__repr__", &set_to_string)
> >         .def("__iter__", range(&StringSet::begin, &StringSet::end))  
> 
> Are those last 3 special functions that are expected to be there by
> boost? 

Boost doesn't care - they just make the type behave like a regular
python class.

> Do we really have to implement our own stringset class? There is
> nothing in boost or elsewhere that does this really basic stuff?
> 

I am just wrapping std::set<std::string> which is typedef'd to
StringSet, so I didn't implement anything. What is above is pretty
fantastic if you ask me (just the iterator mapping is a huge win). But
yes, there are easy ways to export container types (through "indexing
suites"). For example, a vector of nodes is exported via:

class_<NodeVector>("NodeVector")
        .def(vector_indexing_suite<NodeVector, true>());

That gives you all of special functions that you would expect (and
conversion to/from python lists). Unfortunately, there seems to only be
support for map and vector types - sets aren't supported, probably
because they are less commonly used.

> > ; 
> > 
> > class_<Type, bases<Node> >("Type")
> >         .add_property("name", &Type::get_name, &Type::set_name)
> >         .add_property("aliases"
> >                 , make_function(
> >                         &Type::aliases,
> > return_value_policy<reference_existing_object>()
> >                  ))
> >         .add_property("attributes"
> >                         , make_function(
> >                                 &Type::attributes,
> > return_value_policy<reference_existing_object>()
> >                          ))
> >                 ;
> > 
> > Which yields bindings that allow you to do:
> > 
> > import policyrep
> > 
> > t = policyrep.Type()
> > t.name = "user_t"
> > t.aliases.add("foo")
> > t.aliases.add("bar")
> > 
> > for a in t.aliases:
> >     print a
> > 
> > These bindings are much better than what you can get out of
> > swig with much less work. The tradeoff is that they use deep
> > and mysterious C++ magic, which sometimes makes the compiler
> > very unhappy.
> > 
> 
> They do look much better,

And there are some advantages that aren't readily visible - like there
are none of those odd swig shadow types. This creates real new-style
python classes directly.

>  what do you mean unhappy?
> 

Ummm - you just have to see it to believe it :) For example, changing
true to false in the vector example above causes the error message at
the bottom of this email.

The good news, though, is that once you get things right everything
works well. Part of the advantage to boost::python is that it is uses
the C++ compiler to introspect the classes / functions at compile time
to generate the bindings. That means that all of the C++ type
information is available (unlike swig - which can't fully parse and
understand the semantics of C or C++). The downside is that the
compilation can consume huge amounts of cpu / memory and generate
bizarre errors if the code is wrong.

> > This has basically convinced me that C++ is the way to go (or
> > to put it another way - please, oh, please don't make me
> > write any more C code).
> > Thoughts?
> > 
> 
> Great news :)
> 

I assume that means you think this is the way to go? Steve - any
thoughts?

[...]

> > diff -r 83885c13a34d libpolicyrep/include/policyrep/policy.hpp
> > --- a/libpolicyrep/include/policyrep/policy.hpp       Mon Jun 04
> 13:24:11
> > 2007 -0400 +++ b/libpolicyrep/include/policyrep/policy.hpp    Mon
> Jun
> 04
> 
> So this is exported and stable? We never previously exported the
> policydb, is this intentional?
> 

Not yet - but I intend this to be stable. That is one of the things we
need to consider - C++ is not the best for ABI compatibility. I think we
can make reasonable API/ABI guarantees for stable versions while still
making more changes than we make to libselinux/libsepol (since it will
be selinux tools linking to this library I think they will be more
tolerant to changes).

[...]


> > +        std::ostream& operator<<(std::ostream& o, const Node& n); +
> 
> Are you overloading the << operator? I thought we weren't going to
> overload operators.
> 

Overloading << is pretty much required for efficient use of streams. It
allows you to do:

policyrep::Type t;
std::cout << t << std::endl;

I'm not really a fan of operator overloading in general, but in this
case I think it is worthwhile. And because of the friend function hack
in the base class we only need to do it in on place - the subclasses
simply override the virtual function "output".

Karl

Error message from example above:

g++ -Wall -W -Wundef -Wmissing-format-attribute -Wno-unused-parameter
-I. -I../include -D_GNU_SOURCE -I/usr/include/python2.4 -fPIC -DSHARED
-c -o policyrep_python.lo policyrep_python.cpp
/usr/include/boost/python/with_custodian_and_ward.hpp: In static member
function ‘static PyObject*
boost::python::with_custodian_and_ward_postcall<custodian, ward,
BasePolicy_>::postcall(const ArgumentPackage&, PyObject*) [with
ArgumentPackage = PyObject*, long unsigned int custodian = 0ul, long
unsigned int ward = 1ul, BasePolicy_ =
boost::python::default_call_policies]’:
/usr/include/boost/python/detail/caller.hpp:201:   instantiated from
‘PyObject* boost::python::detail::caller_arity<1u>::impl<F, Policies,
Sig>::operator()(PyObject*, PyObject*) [with F =
boost::python::objects::iterator_range<boost::python::return_internal_reference<1ul, boost::python::default_call_policies>, __gnu_cxx::__normal_iterator<boost::shared_ptr<policyrep::Node>*, std::vector<boost::shared_ptr<policyrep::Node>, std::allocator<boost::shared_ptr<policyrep::Node> > > > >::next, Policies = boost::python::return_internal_reference<1ul, boost::python::default_call_policies>, Sig = boost::mpl::vector2<boost::shared_ptr<policyrep::Node>&, boost::python::objects::iterator_range<boost::python::return_internal_reference<1ul, boost::python::default_call_policies>, __gnu_cxx::__normal_iterator<boost::shared_ptr<policyrep::Node>*, std::vector<boost::shared_ptr<policyrep::Node>, std::allocator<boost::shared_ptr<policyrep::Node> > > > >&>]’
/usr/include/boost/python/object/py_function.hpp:38:   instantiated from
‘PyObject*
boost::python::objects::caller_py_function_impl<Caller>::operator()(PyObject*, PyObject*) [with Caller = boost::python::detail::caller<boost::python::objects::iterator_range<boost::python::return_internal_reference<1ul, boost::python::default_call_policies>, __gnu_cxx::__normal_iterator<boost::shared_ptr<policyrep::Node>*, std::vector<boost::shared_ptr<policyrep::Node>, std::allocator<boost::shared_ptr<policyrep::Node> > > > >::next, boost::python::return_internal_reference<1ul, boost::python::default_call_policies>, boost::mpl::vector2<boost::shared_ptr<policyrep::Node>&, boost::python::objects::iterator_range<boost::python::return_internal_reference<1ul, boost::python::default_call_policies>, __gnu_cxx::__normal_iterator<boost::shared_ptr<policyrep::Node>*, std::vector<boost::shared_ptr<policyrep::Node>, std::allocator<boost::shared_ptr<policyrep::Node> > > > >&> >]’
policyrep_python.cpp:74:   instantiated from here
/usr/include/boost/python/with_custodian_and_ward.hpp:87: warning:
comparison of unsigned expression < 0 is always false






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
