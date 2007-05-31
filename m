Subject: Re: SELinux userspace infrastructure language
From: Karl MacMillan <kmacmill@redhat.com>
To: Chad Sellers <csellers@tresys.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <C2848590.223A5%csellers@tresys.com>
References: <C2848590.223A5%csellers@tresys.com>
Content-Type: text/plain
Date: Thu, 31 May 2007 15:13:22 -0400
Message-Id: <1180638802.22021.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-31 at 14:00 -0400, Chad Sellers wrote:
> On 5/31/07 1:47 PM, "Karl MacMillan" <kmacmill@redhat.com> wrote:
> 
> > On Thu, 2007-05-31 at 13:35 -0400, Joshua Brindle wrote:
> >> Some discussion has started off-list about what language to use for the
> >> implementation of the new policy intermediary format and we'd like to
> >> bring this discussion into the community to get feedback from users and
> >> other developers.
> >> 
> >> In the policyrep branch we've basically started taking OOisms and
> >> pythonisms and reimplementing them in C which is non-ideal.
> > 
> > No pythonisms that I am aware of (and I have avoided them).
> > 
> >>  There is
> >> also madness behind the string handling in some newer work we are doing.
> >> We discussed the possibility of using python or C++ for our libraries so
> >> that they are more represenative of the datastructures that are being
> >> created elsewhere and being reimplemented in C.
> >> 
> >> Libsemanage could easily be implemented in pure python, it doesn't do
> >> much hard work, libsepol, on the other hand, is used by a lot of
> >> external stuff so it's a more difficult sell. It would be nice to
> >> potentially use the STL for a lot of the stuff we are doing in libsepol.
> >> 
> >> Libsemanage need not be rewritten immediately (or at all if not
> >> considered a necessity) but the new policy representation work will be
> >> happening in the near term so the language chosen for it will
> >> immediately be used. This language would be required for any systems
> >> with managed policies (eg., using policy modules and semanage) so that
> >> is something to be considered.
> >> 
> > 
> > To make this more concrete, there are two basic options (as I see it):
> > 
> > 1) adopt sepolgen as the new policyrep and implement the policy
> > compilers on top of that. The policyrep branch is in some senses a port
> > of part of sepolgen.
> > 2) Keep going with policyrep, but in C++.
> > 
> > 1 is less work but harder for cross-language development. 2 is much more
> > work, potentially forever.
> > 
> And don't forget about option 3, which is continue down the C path. This is
> the most painful immediate option, but may have less ripple effect among the
> users of the library.
> 

Good point. For what it's worth my preferences in order:

1) Use sepolgen - my experience creating this tells me that Python is
massively more productive for these tasks. I do have some reluctance,
though, mainly around the lack of static typing and cross-language
support.

2) Switch to C++ plus extra libraries. I don't think C++ by itself is
enough of a productivity win, we would need to add some libraries (e.g.,
http://boost.org/). My biggest concerns here are 1) general hatred of C
++ by many in the Linux world and 2) the need for restraint to keep the
C++ readable (e.g., template meta-programming is probably a bad idea in
this library).

3) Continue inventing type systems in C - yay!

Karl

> Chad
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
