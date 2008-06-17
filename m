Subject: Re: SELinux Bootstrap - without chroot
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Cc: SELinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <4857CFB6.20000@windriver.com>
References: <4856998A.1020606@windriver.com>
	 <1213639038.15523.141.camel@moss-spartans.epoch.ncsc.mil>
	 <4856A941.9080300@windriver.com>
	 <1213640369.15523.152.camel@moss-spartans.epoch.ncsc.mil>
	 <4856DC93.5000909@windriver.com>
	 <1213706319.32066.28.camel@moss-spartans.epoch.ncsc.mil>
	 <4857C18B.6000007@windriver.com>
	 <1213712831.32066.46.camel@moss-spartans.epoch.ncsc.mil>
	 <4857CFB6.20000@windriver.com>
Content-Type: text/plain
Date: Tue, 17 Jun 2008 12:43:54 -0400
Message-Id: <1213721034.32066.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-06-17 at 10:52 -0400, Vikram Ambrose wrote:
> Stephen Smalley wrote:
> > On Tue, 2008-06-17 at 09:52 -0400, Vikram Ambrose wrote:
> >   
> >> Stephen Smalley wrote:
> >>     
> >>> On Mon, 2008-06-16 at 17:35 -0400, Vikram Ambrose wrote:
> >>>   
> >>>       
> >>>> Stephen Smalley wrote:
> >>>>     
> >>>>         
> >>>>> On Mon, 2008-06-16 at 13:56 -0400, Vikram Ambrose wrote:
> >>>>>   
> >>>>>       
> >>>>>           
> >>>>>> Stephen Smalley wrote:
> >>>>>>     
> >>>>>>         
> >>>>>>             
> >>>>>>> Note that they get installed to $DESTDIR/usr/share/selinux/$SELINUXTYPE
> >>>>>>> by make install.  In Fedora, they are packaged as such, then when you
> >>>>>>> install the package on the target host, they are unpacked
> >>>>>>> to /usr/share/selinux/$SELINUXTYPE by the package manager and then a %
> >>>>>>> post scriptlet runs semodule on them to install them under /etc/selinux
> >>>>>>> and load them.
> >>>>>>>
> >>>>>>>   
> >>>>>>>       
> >>>>>>>           
> >>>>>>>               
> >>>>>> In Fedora, does anaconda chroot into the sysroot and call semodule 
> >>>>>> during installation?
> >>>>>>     
> >>>>>>         
> >>>>>>             
> >>>>> Some combination of anaconda and rpm, yes.  semodule runs from a %post
> >>>>> scriptlet in the selinux-policy-targeted package at package install
> >>>>> time.
> >>>>>
> >>>>>   
> >>>>>       
> >>>>>           
> >>>>>>> Options for you might include:
> >>>>>>> 1) Run semodule_link and semodule_expand at build time to link and
> >>>>>>> expand the modules to a kernel policy up front.  Then you can just put
> >>>>>>> the files into place without running semodule later.
> >>>>>>>   
> >>>>>>>       
> >>>>>>>           
> >>>>>>>               
> >>>>>> I will investigate this option further, thank you.
> >>>>>>     
> >>>>>>         
> >>>>>>             
> >>>>> Ok.  You can see an example of it in the 'make validate' target,
> >>>>> although that is just to check that they will link and expand
> >>>>> successfully; it isn't used to install the policy normally and likely
> >>>>> doesn't keep the final result around.
> >>>>>
> >>>>>   
> >>>>>       
> >>>>>           
> >>>> I am getting a bit confused between "modular" and "monolithic", in both 
> >>>> cases a policy.X file is needed to load the policy into the kernel, right?
> >>>>
> >>>> and in the modular case, the policy.X file simply points to the various 
> >>>> .pp files and in the monolithic case everything is in the policy.X file? 
> >>>> Analogous to shared library and static library link (modular/monolithic)?
> >>>>     
> >>>>         
> >>> In either case, we ultimately need a complete policy.N file that
> >>> contains all of the information for loading into the kernel.  The kernel
> >>> only knows about the policy.N format; it knows nothing of policy
> >>> modules.
> >>>
> >>> The difference is whether we need to compile a complete set of policy
> >>> sources directly into the policy.N file, or whether we can separately
> >>> compile and package each policy module into a .pp file and then later
> >>> link and expand the set of installed policy modules to create a policy.N
> >>> file.
> >>>
> >>> The modular policy support was introduced later (first appeared in
> >>> Fedora Core 5), to allow for local customization of policy without
> >>> requiring complete policy sources and to enable third party policy and
> >>> decomposition of distribution policy among the packages.
> >>>
> >>> In a monolithic policy build, you take the entire set of policy sources,
> >>> apply various preprocessing steps, combine the result into a single
> >>> policy.conf file, and then feed that to the checkpolicy program to
> >>> generate the policy.N file for the kernel.  And you likewise preprocess
> >>> and combine the .fc files to form the complete file_contexts
> >>> configuration.  Later if you want to add more policy, you drop it into
> >>> the policy source tree and repeat the entire process.
> >>>
> >>> In the modular policy build, you take each policy module's sources (.te
> >>> file), apply various preprocessing steps, feed the result to the
> >>> checkmodule program to generate a binary module (.mod) file, then feed
> >>> the .mod file and the .fc file to semodule_package to generate the
> >>> policy package (.pp) file.  Then you ship the .pp files to the target
> >>> host, run semodule to insert them into the policy module store, link
> >>> them together, and expand them into a policy.N file on that host.  Later
> >>> if you want to add more policy, you compile it as a module separately,
> >>> ship the resulting .pp file to the target host, and then run semodule on
> >>> it, which will add it to the policy store and generate an updated
> >>> policy.N file.
> >>>
> >>>   
> >>>       
> >> hmm, that somewhat explains it, but the terminology used across man 
> >> pages and the internet doesn't seem to be consistent so it's a bit 
> >> difficult to understand whats what.
> >> So to avoid semodule's affinity for /etc/selinux i can get  away with 
> >> semodule_link and semodule_expand?
> >> I don't understand what the output of each command is. I did a 
> >> semodule_link of all my .pp files and then did a senodule_expand of that 
> >> file into another file, and then cat'ed that into /selinux/load and i 
> >> got an error about a map.
> >>
> >> [600793.305757] security: ebitmap: truncated map
> >>
> >> Also, once the policy.X file is loaded, does the system need access to 
> >> /etc/selinux/$POLICY ?
> >>     
> >
> > You can do that, but I'm still not clear on why you are doing it.  It
> > seems like you should be doing one of the following instead:
> > 1) run semodule on the target system to install the .pp files and load
> > the resulting policy rather than trying to do it all on the build host,
> > -or-
> >   
> Yes this works, however i'd like to have it running out of the box 
> without this step.

Up to you, of course, but note that at least in Fedora, this happens
naturally via a %post scriptlet in the selinux-policy packages and isn't
fundamentally different than other %post actions performed for system
setup when a package is installed.

> > 2) run semodule within a chroot on the build system to install the .pp
> > files and create the kernel policy.  Eric Paris has been getting such
> > builds to work for Fedora live CD creation.
> >   
> I'm not a fan of the chroot environment, but now that i have learned 
> that i can manually semodule_link/expand to create my policy.X file, i 
> can do the whole operation without using /etc/, this makes 
> packaging/building out of the target system much easier, as well as 
> deployment is a simple:
> 1. untar the .pp files to /usr/share/selinux/policy/ for devs to use
> 2. refpolicy make install, stuff untar'ed to 
> /etc/selinux/policy/contexts  and
> 3. copy my policy.X file that was produced by link/expand (also from the 
> build host), to /etc/selinux/policy/policy
> 4. edit semanage.conf and selinux.conf, throw in load_policy into 
> sysvinit and i'm done!

You may also need to manually generate the file_contexts file and put it
into place, as semodule_link/expand doesn't presently handle that for
you.

> > -or-
> > 3) perform a monolithic policy build in the first place and thus avoid
> > the entire indirection of modules and semodule in the first place.
> >
> > Also, you said you didn't want to load the policy on the build host so
> > I'm not sure why you are trying to do that. The reason that it is
> > failing is not that the policy is invalid but because the cat program
> > writes it in fixed size chunks rather than atomically in one write call,
> > and /selinux/load requires that the entire policy be fed to it in a
> > single write call.  The load_policy program does this by opening the
> > policy file, fstat'ing it to get the size, mmap'ing it into memory, and
> > then write'ing the entire memory region to /selinux/load in a single
> > write() call.  You can see that logic in libselinux/src/load_policy.c;
> > it was once directly implemented in the load_policy program but later
> > moved into the library and further encapsulated.
> >
> >   
> Yes i just found out myself too. so I used dd with a big block size and 
> it worked beautifully.

Ok, a useful workaround to know.

> > semodule_link/expand are developer tools for manually applying the link
> > +expand phases, and thus will operate on whatever inputs you provide
> > rather than only operating on a policy store under /etc/selinux.
> >
> > The kernel doesn't care where the policy originates; it is only
> > userspace that has the convention that it lives under /etc/selinux.
> >
> >   
> thanks Stephen. I think I have found my solution.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
