MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 00/15] RFC Source Policy Support
Date: Wed, 27 Jan 2010 15:18:52 -0500
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E0199EAFC@exchange2.columbia.tresys.com>
In-Reply-To: <1264622421.17372.68.camel@moss-pluto.epoch.ncsc.mil>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com> <1264622421.17372.68.camel@moss-pluto.epoch.ncsc.mil>
From: "Caleb Case" <ccase@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Chad Sellers" <csellers@tresys.com>,
        "Karl MacMillan" <kmacmillan@tresys.com>, <jwcart2@tycho.nsa.gov>,
        "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Wednesday, January 27, 2010 3:00 PM
> To: Caleb Case
> Cc: selinux@tycho.nsa.gov; Chad Sellers; Karl MacMillan;
> jwcart2@tycho.nsa.gov; Joshua Brindle
> Subject: Re: [PATCH 00/15] RFC Source Policy Support
> 
> On Tue, 2010-01-26 at 17:08 -0500, Caleb Case wrote:
> <snip>
> > Module Ordering - The current reference policy compilation
> > infrastructure devotes substantial attention to dealing with
ordering
> > problems. Some of these problems are fundamental (such as the
ordering
> > of portcon statements) while others are an artifact of the current
> > compiler and M4 (such as the need to separate out interface
statements
> > in .if files). Rather than devote substantial effort to creating
> > mechanisms for specifying or dealing with ordering, it was felt that
the
> > long term solution to this problem is in the improvements that will
come
> > from the proposed common intermediate language [1]. Therefore, in
the
> > short term, several modules will be ordered specially based upon
name
> > and certain policy statements will only be supported in those
specially
> > ordered modules (e.g., a module for specifying defines such as
> > DISTRO_REDHAT). These hacks can be removed at a later date.
> 
> These specially ordered modules and restrictions on policy statements
> usable by other modules sound just like the base module today.  Did
you
> just re-invent the base module under a different name?

The special modules are something like a base module that has been
broken out into its individual parts. We broke it out like this so that
it would match more closely with what was in the reference policy build
environment and to promote them being separate files (similar to how we
would expect them to be in the proposed cil). Having the base module
split out like this also has the advantage that you can override just a
small part of 'base' without needing to fork all the rest of it.

> 
> > Base Module Removal - The decision to support a special base binary
> > module was made to make bootstrapping a module store easier by
including
> > a module that was required to have a minimal but complete system
policy
> > and to deal with ordering by only allowing order dependent
statements to
> > appear in the base (such as object class or portcon). Over time it
has
> > become clear that the base module limitations outweigh any of the
> > intended benefits. This is especially true as support for overriding
> > policy modules is included. Therefore, the source semanage store
will no
> > longer support or require a special base module.  Further, there
will be
> > no restrictions on the use of policy statements in modules. While
this
> > will allow some unintentional mistakes (e.g., including a broad
portcon
> > in a module that gets processed first) it will also allow additional
> > freedom (e.g., the use of narrow portcon statements in modules).
> 
> I originally assumed you considered portcon statements to be one of
the
> statements limited to the specially ordered modules above, but
evidently
> not.  So how then will you ensure proper ordering of them?

For the most part they are expected to be part of the special modules.
You could pull out specific portcon statements (simple non-ranged ones)
into the modules if you were certain that no other portcons existed for
those ports.

> 
> Why not just eliminate the ordering dependency altogether from
portcons.
> Just mandate that more specific entries (e.g. portcon 80) always take
> precedence over less specific entries (e.g. portcon 1-1024), and sort
> them accordingly in the toolchain before generating the kernel policy.

How would these be sorted?

portcon 1-3
portcon 3-5
portcon 2-4

I think the long term goal is to use an fcglob style sorting (where the
above would be an error since its ambiguous). That kind of sorting would
be part of the proposed cil. (You are right it makes more sense for them
to be sorted in toolchain, we just haven't gotten to the point where we
can do that yet).

> 
> > [User Experience Overview]
> >
> > The overall user experience will shift from using external tools to
> > compile a policy package (.pp) to working directly with source
modules.
> >
> > Source modules will be a single text file containing all of the
policy
> > for that module. For the current reference policy that will require
> > combining the current interface, type enforcement, and file context
> > files into a single text file. The user will then use that text file
> > similarly to how the current binary modules are used. Insertion
would be
> > performed using semodule (the 'ref' extension is for the single file
> > reference policy format):
> >
> > # semodule -i apache.ref
> >
> > Note that the language for the module will be inferred from the
> > extension to avoid the general tools, such as semodule, needing an
> > awareness of the format of all source policies. The name would be
taken
> > from the input filename.
> 
> I assume you mean that you don't want libsemanage to need to be aware
of
> the format of all source policies, as semodule itself shouldn't ever
> peer inside of the module?

Yes

> 
> If I try to insert two modules with the same prefix but different
> suffixes, are they one module or two different ones?

One

> 
> > The first large change to user experience is the introduction of a
> > command to retrieve a module:
> >
> > # semodule -g apache
> > # ls
> > apache.ref
> >
> > # semodule -g apache -o myapache.ref
> > # ls
> > myapache.ref
> >
> > Similarly, there is the addition of an edit command that is similar
to
> > sudoedit. This is purely a convenience; it will retrieve the module
to a
> > temporary location and install it after updates are made.
> >
> > # semodule --edit apache
> >
> > Finally, semodule now supports adding a user message when making
> > changes:
> >
> > # semodule --edit apache -m "Allow apache to execute cowsay."
> 
> Do we really need/want to provide this functionality in
> semodule/libsemanage?  Why not just have the user get the module, edit
> it as desired, and then insert it?  By the way, this could also be
> referred to as checkout and checkin/commit.

--get is not the same as checkout since someone else could modify the
file while you are editing it. --edit is designed to address that
problem by allowing you to do it within a single transaction lock.

> 
> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
