MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: using semodule_package
Date: Wed, 25 Jul 2007 10:40:28 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01FB737E@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01FB6DF2@blums0008.bluelnk.net> <1184156241.3392.41.camel@moss-spartans.epoch.ncsc.mil>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The manpage for checkmodule shows the following example using a .te
file:
	checkmodule -M -m httpd.te -o httpd.mod

Is this correct?

It fails for me with the following error:

# checkmodule -M -m zebra.te -o zebra.mod
checkmodule:  loading policy configuration from zebra.te
(unknown source)::ERROR 'syntax error' at token 'policy_module' on line
2:
policy_module(zebra,1.3.0)

checkmodule:  error(s) encountered while parsing configuration


The example below (from Stephen Smalley's below email) uses the .tmp
file and works:
	checkmodule -M -m tmp/zebra.tmp -o tmp/zebra.mod


Although this successfully creates the zebra.mod file, when I try to use
the zebra.mod file with semodule_package to create a zebra.pp file, the
zebra.pp file appears to be invalid. When I try to load the zebra.pp
file, I get the following error:

# semodule -i
/etc/selinux/refpolicy-targeted-mls/src/policy/tmp/zebra.pp
libsepol.context_from_record: user gen_context(system_u is not defined
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert
gen_context(system_u:object_r:zebra_conf_t,s0) to sid
/etc/selinux/refpolicy-targeted-mls/contexts/files/file_contexts:  line
398 has invalid context gen_context(system_u:object_r:zebra_conf_t,s0)
libsemanage.semanage_install_active: setfiles returned error code 1.
semodule:  Failed!

I created the zebra.pp file with the following command:
semodule_package -o zebra.pp -m zebra.mod -f
../policy/modules/services/zebra.fc

The other thing that I notice is that although I made no changes to the
zebra.fc file (I'm just trying to successfully create a .pp file first),
the zebra.pp file that the semodule_package cmd creates is not the same
size as the original zebra.pp file. This happens even when I don't
include the -f option with the semodule_package command.



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Wednesday, July 11, 2007 5:17 AM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov; Christopher J. PeBenito; Joshua Brindle;
Karl
> MacMillan
> Subject: Re: using semodule_package
> 
> On Tue, 2007-07-10 at 19:10 -0700, Clarkson, Mike R (US SSA) wrote:
> > The manpage for semodule_package gives examples for how to use it:
> > 	semodule_package -o httpd.pp -m httpd.mod -f httpd.fc
> >
> > Am I supposed to get the *.mod files for modules when I compile the
> > policy? I have a base.mod file, but no *.mod files for the loadable
> > modules. The closest that I have is <module_name>.mod.role files
under
> > the .../policy/tmp directory.
> >
> > I'd like to be able to use semodule_package to update file contexts
> > without having to recompile.
> 
> It appears that the .mod files are removed at the end of the build
> process after they have been packaged into .pp files.  Not sure why.
> Options, aside from tracking down the relevant makefile rule and
> removing it, might include:
> - regenerating the .mod via checkmodule on tmp/<name>.tmp, e.g.
> 	checkmodule -M -m tmp/zebra.tmp -o tmp/zebra.mod
> or
> - extracting the already built .mod file from the .pp file
> 
> I took the semodule_package.c code once and created a
> semodule_unpackage.c file from it to unpack the .mod file, but never
got
> around to generalizing it (e.g. unpacking all of the files) or
> committing it.  Attached below for your amusement.
> $ gcc -lsepol -o semodule_unpackage semodule_unpackage.c
> $ ./semodule_unpackage zebra.pp zebra.mod
> 
> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
