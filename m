MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 01/15] [src-policy] refpol language and tools
Date: Wed, 27 Jan 2010 14:54:21 -0500
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E0199EAEA@exchange2.columbia.tresys.com>
In-Reply-To: <1264621184.17372.50.camel@moss-pluto.epoch.ncsc.mil>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com> <1264543701-20638-2-git-send-email-ccase@tresys.com> <1264621184.17372.50.camel@moss-pluto.epoch.ncsc.mil>
From: "Caleb Case" <ccase@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Chad Sellers" <csellers@tresys.com>,
        "Karl MacMillan" <kmacmillan@tresys.com>, <jwcart2@tycho.nsa.gov>,
        "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Wednesday, January 27, 2010 2:40 PM
> To: Caleb Case
> Cc: selinux@tycho.nsa.gov; Chad Sellers; Karl MacMillan;
> jwcart2@tycho.nsa.gov; Joshua Brindle
> Subject: Re: [PATCH 01/15] [src-policy] refpol language and tools
> 
> On Tue, 2010-01-26 at 17:08 -0500, Caleb Case wrote:
> > [refpol Language]
> >
> > The refpol language is a simple transformation of a standard
Reference
> > Policy module consisting of 3 files to a single file format with
> > sections. Each Reference Policy file is placed into a refpol section
as
> > follows:
> >
> >    <module>.if   =>   [interface]
> >    <module>.te   =>   [policy]
> >    <module>.fc   =>   [context]
> >
> > * These are the only valid section headers.
> >
> > * A section begins with a section marker and ends with the next
marker
> >   encountered or the end of the file.
> >
> > * If a file has at least one section marker and there is text before
the
> >   first section then this is an error.
> >
> > * There can be at most one of each valid section marker in a file.
> >
> > * A file without any section markers is assumed to be only policy.
> >
> > * The valid contents of each section are the same as for the
separate
> >   reference policy files.
> >
> > * The standard filename extension is '.ref'.
> >
> > [refpol Tool]
> >
> > The refpol tool can create a refpol module from a Reference Policy
> > module.
> >
> >    Usage: refpol COMMAND [OPTIONS] MODULE.ref
> >
> >    Commands:
> >      create		create a new refpol
> >      extract		extract .if, .te, and .fc files from a
refpol
> >
> >    Options:
> >      --version             show program's version number and exit
> >      -h, --help            show this help message and exit
> >      -f, --force           force overwriting existing files
> >
> >      Create options:
> >        -i FILE, --interface=FILE
> >                            interface file
> >        -p FILE, --policy=FILE
> >                            policy file
> >        -c FILE, --context=FILE
> >                            context file
> >
> > Example:
> >
> > # refpol create -i alsa.if -p alsa.te -c alsa.fc alsa.ref
> >
> > refpol modules should have the '.ref' extension. The resulting
alsa.ref
> > looks like this:
> >
> >    [interface]
> >
> >    policy_module(alsa, 1.8.0)
> 
> The policy_module() declaration in existing modules is in their .te
> file, not their .if file.
> 
> If you are going to move up the declaration, then:
> a) What you say earlier about the mapping of the current files and the
> valid contents of the sections is not entirely accurate, and
> b) Wouldn't it make more sense to move the declaration to the very
> beginning before the three sections, as it pertains to all three?

Sorry, this is a typo. I seem to have swapped the [policy] and
[interface] sections. The tool doesn't move the policy_module statement.

> 
> >
> >    ########################################
> >    #
> >    # Declarations
> >    #
> >    <snip>
> >
> >    [policy]
> >    ## <summary>Ainit ALSA configuration tool</summary>
> >    <snip>
> >
> >    [context]
> >    /bin/alsaunmute		--
> 	gen_context(system_u:object_r:alsa_exec_t,s0)
> >    <snip>
> >
> > [refpol HLL compiler]
> >
> > The refpolc high level language (HLL) compiler performs basic
formatting
> > checks and extracts the policy version from the policy_module
statement.
> >
> >    Usage: refpolc [OPTIONS] [MODULE]
> >
> >    Input is read from stdin unless MODULE is provided.
> >    Output is written to stdout unless -o is specified.
> >
> >    Options:
> >      --version             show program's version number and exit
> >      -h, --help            show this help message and exit
> >      -f, --force           force overwriting existing files
> >      -o FILE, --output=FILE
> >                            output file
> >
> > Example:
> >
> > # refpolc < apache.ref > apache.cil 3<> apache.version
> 
> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
