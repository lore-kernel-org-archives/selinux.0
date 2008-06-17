Subject: Re: SELinux Bootstrap - without chroot
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Cc: SELinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <4856DC93.5000909@windriver.com>
References: <4856998A.1020606@windriver.com>
	 <1213639038.15523.141.camel@moss-spartans.epoch.ncsc.mil>
	 <4856A941.9080300@windriver.com>
	 <1213640369.15523.152.camel@moss-spartans.epoch.ncsc.mil>
	 <4856DC93.5000909@windriver.com>
Content-Type: text/plain
Date: Tue, 17 Jun 2008 08:38:39 -0400
Message-Id: <1213706319.32066.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-06-16 at 17:35 -0400, Vikram Ambrose wrote:
> Stephen Smalley wrote:
> > On Mon, 2008-06-16 at 13:56 -0400, Vikram Ambrose wrote:
> >   
> >> Stephen Smalley wrote:
> >>     
> >>> Note that they get installed to $DESTDIR/usr/share/selinux/$SELINUXTYPE
> >>> by make install.  In Fedora, they are packaged as such, then when you
> >>> install the package on the target host, they are unpacked
> >>> to /usr/share/selinux/$SELINUXTYPE by the package manager and then a %
> >>> post scriptlet runs semodule on them to install them under /etc/selinux
> >>> and load them.
> >>>
> >>>   
> >>>       
> >> In Fedora, does anaconda chroot into the sysroot and call semodule 
> >> during installation?
> >>     
> >
> > Some combination of anaconda and rpm, yes.  semodule runs from a %post
> > scriptlet in the selinux-policy-targeted package at package install
> > time.
> >
> >   
> >>> Options for you might include:
> >>> 1) Run semodule_link and semodule_expand at build time to link and
> >>> expand the modules to a kernel policy up front.  Then you can just put
> >>> the files into place without running semodule later.
> >>>   
> >>>       
> >> I will investigate this option further, thank you.
> >>     
> >
> > Ok.  You can see an example of it in the 'make validate' target,
> > although that is just to check that they will link and expand
> > successfully; it isn't used to install the policy normally and likely
> > doesn't keep the final result around.
> >
> >   
> I am getting a bit confused between "modular" and "monolithic", in both 
> cases a policy.X file is needed to load the policy into the kernel, right?
> 
> and in the modular case, the policy.X file simply points to the various 
> .pp files and in the monolithic case everything is in the policy.X file? 
> Analogous to shared library and static library link (modular/monolithic)?

In either case, we ultimately need a complete policy.N file that
contains all of the information for loading into the kernel.  The kernel
only knows about the policy.N format; it knows nothing of policy
modules.

The difference is whether we need to compile a complete set of policy
sources directly into the policy.N file, or whether we can separately
compile and package each policy module into a .pp file and then later
link and expand the set of installed policy modules to create a policy.N
file.

The modular policy support was introduced later (first appeared in
Fedora Core 5), to allow for local customization of policy without
requiring complete policy sources and to enable third party policy and
decomposition of distribution policy among the packages.

In a monolithic policy build, you take the entire set of policy sources,
apply various preprocessing steps, combine the result into a single
policy.conf file, and then feed that to the checkpolicy program to
generate the policy.N file for the kernel.  And you likewise preprocess
and combine the .fc files to form the complete file_contexts
configuration.  Later if you want to add more policy, you drop it into
the policy source tree and repeat the entire process.

In the modular policy build, you take each policy module's sources (.te
file), apply various preprocessing steps, feed the result to the
checkmodule program to generate a binary module (.mod) file, then feed
the .mod file and the .fc file to semodule_package to generate the
policy package (.pp) file.  Then you ship the .pp files to the target
host, run semodule to insert them into the policy module store, link
them together, and expand them into a policy.N file on that host.  Later
if you want to add more policy, you compile it as a module separately,
ship the resulting .pp file to the target host, and then run semodule on
it, which will add it to the policy store and generate an updated
policy.N file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
