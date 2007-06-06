Subject: RE: SELinux userspace infrastructure language
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BF0548@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	 <1180633622.3534.78.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	 <1180639909.22021.26.camel@localhost.localdomain>
	 <1180995888.9766.63.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF044D@exchange.columbia.tresys.com>
	 <1180975778.2862.36.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0507@exchange.columbia.tresys.com>
	 <1181141337.12540.16.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0548@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 11:18:08 -0400
Message-Id: <1181143088.12540.42.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-06 at 10:59 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Tue, 2007-06-05 at 19:18 -0400, Joshua Brindle wrote:
> >> Karl MacMillan wrote:
> >>> On Mon, 2007-06-04 at 20:52 -0400, Joshua Brindle wrote:
> >>>> Karl MacMillan wrote:
> >>>> <snip>
> >> 
> >>> [...]
> >>> 
> >>>>> diff -r 83885c13a34d libpolicyrep/include/policyrep/policy.hpp
> >>>>> --- a/libpolicyrep/include/policyrep/policy.hpp       Mon Jun 04
> >>>>> 13:24:11 2007 -0400 +++
> >>>>> b/libpolicyrep/include/policyrep/policy.hpp 
> >>>>> Mon
> >>>> Jun
> >>>> 04
> >>>> 
> >> 
> >> One thing is that I thought you going to separate classes of object
> >> into their own files (eg., types.cpp, users.cpp, etc) since you had
> >> always complained about them being munged together in libsepol.
> >> 
> > 
> > You've got that backwards - I've always complained about too
> > many headers in libsepol (two per object).
> > 
> 
> Nuh uh.. You always said you wanted functions for each object separated
> out of policydb.c, write.c and so on. You even started this when you did
> the conditional work and put it in booleans.c instead of policydb.c.
> 

Oh - that. I wanted the functions related to each "object" grouped
together rather than spread through separate files. Multiple objects in
the same file is preferable unless the file gets too big.

> Not sure why I'm surprised though, you change your mind more often than
> anyone I know :)
> 

I thought about arguing with you but then I changed my mind.

> >>>> So this is exported and stable? We never previously exported the
> >>>> policydb, is this intentional?
> >>>> 
> >>> 
> >>> Not yet - but I intend this to be stable. That is one of the things
> >>> we need to consider - C++ is not the best for ABI compatibility. I
> >>> think we can make reasonable API/ABI guarantees for stable versions
> >>> while still making more changes than we make to libselinux/libsepol
> >>> (since it will be selinux tools linking to this library I think they
> >>> will be more tolerant to changes).
> >>> 
> >> 
> >> I worry about making the whole policy structure public instead of
> >> just the public parts, maybe this isn't something you can do in c++?
> >> 
> > 
> > Not certain what you mean - you mean the private variables? You can
> > use the PIMPL idiom - http://www.codepedia.com/1/CppPimpl - but I'm
> > not convinced it's worth the pain. After the care we took to hide
> > implementation in libsepol we didn't really make changes that would
> > have broken in the ABI. 
> > 
> 
> Ok, I guess the fact that the variables are all going to be in the
> private section is good enough since the compiler won't let you directly
> access them anyway (correct?)
> 

It won't (though you can do nasty things to get access if you want). The
variables do become part of the ABI though (since classes are glorified
structs and access is still based on offset like in C).

> >>> [...]
> >>> 
> >>> 
> >>>>> +        std::ostream& operator<<(std::ostream& o, const Node& n);
> >>>>> + +
> >>>> 
> >>>> Are you overloading the << operator? I thought we weren't going to
> >>>> overload operators. 
> >>>> 
> >>> 
> >>> Overloading << is pretty much required for efficient use of
> >>> streams. It allows you to do: 
> >>> 
> >>> policyrep::Type t;
> >>> std::cout << t << std::endl;
> >>> 
> >>> I'm not really a fan of operator overloading in general, but in this
> >>> case I think it is worthwhile. And because of the friend function
> >>> hack in the base class we only need to do it in on place - the
> >>> subclasses simply override the virtual function "output".
> >>> 
> >> 
> >> Hrm, so these aren't included in the elusive "stuff we shouldn't do
> >> in c++" list? 
> >> 
> > 
> > Nope - this is _very_ standard for C++. Not doing this would be like
> > avoiding printf. 
> > 
> 
> Ok, I understand. We are assuming here that all these objects can indeed
> be printed as a string (which is fair). How does this work with a policy
> tree, is this essentially how dumping it out as a source policy would
> work?

You have to iterate over the whole tree outputting as you go:

void output_tree(std::ostream& o, Parent& p, enum OutputStyle style)
{
        Parent::iterator i, end;
        end = p.end();
        for (i = p.begin(TreeIterator::HYBRID); i != end; ++i) {
                o << Output(*i, i.get_visited(), style) << "\n";
        }
        o << std::flush;
}

The Output thing is how you control the output options (I'm not entirely
happy with that design, but it is similar to how output formatting is
done with streams). It also takes into account whether this is the
opening of a block ("if (foo) {") or the closing ("}"). This doesn't yet
handle indentation.

>  How are we going to differenciate serializing to strings and
> serializing to a binary module?
> 

The serialization module handles that - it depends on the type on the
left.

std::cout << foo; // string

std::ofstream fout("filename");
boost::archive::text_oarchive ar(fout);
ar << p; // serialization - actually calls serialize method

> Also, how cheap is the binary serializing/unserializing going to be? We
> don't want it to be equivalent to re-parsing from source (or else there
> is no reason to have a binary format).

It will be pretty cheap - much better than parsing. It should also be a
more compact form.

>  Are we going to build compression
> of the modules in from the get-go to avoid the complaints about
> oversized modules that we had before?

I would like to, but I haven't looked much for compressed streams.
Something like http://www.cs.unc.edu/Research/compgeom/gzstream/ might
work.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
