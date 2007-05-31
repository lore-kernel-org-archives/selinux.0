Subject: RE: SELinux userspace infrastructure language
From: Karl MacMillan <kmacmill@redhat.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	 <1180633622.3534.78.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 31 May 2007 15:31:49 -0400
Message-Id: <1180639909.22021.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-31 at 13:54 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Thu, 2007-05-31 at 13:35 -0400, Joshua Brindle wrote:
> >> Some discussion has started off-list about what language to use for
> >> the implementation of the new policy intermediary format and we'd
> >> like to bring this discussion into the community to get feedback
> >> from users and other developers. 
> >> 
> >> In the policyrep branch we've basically started taking OOisms and
> >> pythonisms and reimplementing them in C which is non-ideal.
> > 
> > No pythonisms that I am aware of (and I have avoided them).
> 
> Fine, more OOisms though.
> 
> > 
> >>  There is
> >> also madness behind the string handling in some newer work we are
> >> doing. We discussed the possibility of using python or C++ for our
> >> libraries so that they are more represenative of the datastructures
> >> that are being created elsewhere and being reimplemented in C.
> >> 
> >> Libsemanage could easily be implemented in pure python, it doesn't do
> >> much hard work, libsepol, on the other hand, is used by a lot of
> >> external stuff so it's a more difficult sell. It would be nice to
> >> potentially use the STL for a lot of the stuff we are doing in
> >> libsepol. 
> >> 
> >> Libsemanage need not be rewritten immediately (or at all if not
> >> considered a necessity) but the new policy representation work will
> >> be happening in the near term so the language chosen for it will
> >> immediately be used. This language would be required for any systems
> >> with managed policies (eg., using policy modules and semanage) so
> >> that is something to be considered.
> >> 
> > 
> > To make this more concrete, there are two basic options (as I see it):
> > 
> 
> Agreed.
> 
> > 1) adopt sepolgen as the new policyrep and implement the
> > policy compilers on top of that. The policyrep branch is in
> > some senses a port of part of sepolgen.
> > 2) Keep going with policyrep, but in C++.
> > 
> > 1 is less work but harder for cross-language development. 2
> > is much more work, potentially forever.
> > 
> 
> So, the new representation should make it much easier to interact with
> parts of policy and hopefully users will come (and continue) to do
> policy analysis, generation, writing, etc using these representations
> that we are making. My main concern is that us doing it in python
> basically puts a huge damper on what our users will do (eg., who are we
> to say someone writing an analysis tool can't use haskell if they want
> ;) ). SLIDE, which will become increasingly important IMO, is in java
> which /can/ use python (using jython) but I am under the impression
> there are risks of incompatibilities and a huge lag in support. 
> 
> Setools also wants to use the new representation to do analysis of the
> policy (and SLIDE wants to integrate with setools for debugging
> assistance), all of this is made possible by the new representation but
> using python inherently limits what they can do.
> 
> Given all this I think C++ is the best bet, though I'm not adverse to
> most of the frontends being written in python, it would just be nice if
> the actual policy representation and accessors are available from a
> shared library API that most languages can use.
> 

I'm basically OK with this approach with some caveats / concerns:

1) We need to allow the use of the boost libraries, particularly
boost::python. Wrapping C++ with boost::python gets you a lot for very
little code (and a fair amount of CPU usage during compile). I think it
is _much_ better than swig for creating idiomatic bindings. Many of the
other libraries are excellent and, in my opinion, indispensable for C++
work.

2) How are we going to proceed with the development? Create a brand new
library in C++ and pull in parts of libsepol as needed? I guess we would
simultaneously rip out parts of the current libsepol that are no longer
needed.

3) We should adopt some C++ coding standards before development starts
to avoid really bad C++.

I still think we should consider sepolgen, but C++ may be the best
choice.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
