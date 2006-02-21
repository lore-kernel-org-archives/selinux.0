Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1LCiF2B032588
	for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2006 07:44:15 -0500
Received: from e4.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1LCgoLF007192
	for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2006 12:42:50 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k1LCiEAv002294
	for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2006 07:44:14 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k1LCiE4s225094
	for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2006 07:44:14 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k1LCiDia019963
	for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2006 07:44:14 -0500
Date: Tue, 21 Feb 2006 06:44:13 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: How to build external policy modules outside of the main tree
Message-ID: <20060221124413.GA31922@sergelap.austin.ibm.com>
References: <20060220232156.GD7304@thorium.jmh.mhn.de> <43FA9809.5010307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43FA9809.5010307@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Any plans of getting 'make install-headers' or some variant to install
these from cvs?

As it is, afaict after make install-headers one must either make a new
makefile based on the one from cvs, or copy the fedora one, hacking for
some path changes.  But I assumed this is simply considered a "work in
progresss."

thanks,
-serge

Quoting Daniel J Walsh (dwalsh@redhat.com):
> Thomas Bleher wrote:
> >Reference policy allows policy modules to be built outside of the main
> >source tree. I didn't find any instructions on how to do it, so here are
> >my notes:
> >
> >You will need the following directories and files:
> >  Makefile
> >  build.conf
> >  policy/
> >  policy/modules/
> >  policy/modules/apps/
> >  policy/modules/apps/example.fc
> >  policy/modules/apps/example.if
> >  policy/modules/apps/example.te
> >  policy/modules/apps/metadata.xml
> >
> >Additionally, you will need to have policy sources installed (probably
> >not full sources, but at least the Makefile, all interfaces you are
> >going to use, everything under support/ and likely some more files).
> >I assume the source is available at /etc/selinux/refpolicy/src/policy .
> >
> >The Makefile is just three lines long:
> >  
> >>ROOT=/etc/selinux/refpolicy/src/policy
> >>LOCAL_ROOT=.
> >>include /etc/selinux/refpolicy/src/policy/Makefile
> >>    
> >
> >The build.conf should contain build options equivalent to the ones your
> >policy was built with. You can try to symlink your build.conf from the
> >policy sources, but please keep in mind that the build.conf shipped as
> >part of the source may not accurately reflect how the base policy was
> >built; that's because the variables in build.conf can be overridden on
> >the command line.
> >
> >Without comments, my build.conf looks like this:
> >  
> >>TYPE = strict-mcs
> >>NAME = refpolicy-strict
> >>DISTRO = debian
> >>DIRECT_INITRC=y
> >>MONOLITHIC=n
> >>POLY=n
> >>QUIET=n
> >>    
> >
> >Now you can create your policy in the appropriate layer under
> >policy/modules/. For every layer, you will need a file "metadata.xml";
> >just copy it from the policy sources.
> >
> >To actually build the module you'll need a policy/modules.conf. Just
> >create it by calling "make conf".
> >Presumably you don't want to rebuild every shipped module when building
> >your module, so edit the generated file and do an s/= base/= off/g and
> >s/= module/= off/g and then enable your module again. Don't completely
> >remove the lines of the other modules, otherwise you won't be able to
> >use their interfaces.
> >
> >After that, a "make modules" will build your shiny new policy module and
> >put it in your base directory. From there you can load it using
> >"semodule -i".
> >
> >Happy policy hacking,
> >Thomas
> >
> >  
> 
> Actually on Fedora you can install selinux-policy-devel package.
> 
> You will find that it installs /usr/share/selinux/refpolicy
> 
> Under this directory you will find a Makefile and policygentool
> You can use this tool to generate a quick template te,fc and if file.
> 
> You can then use the Makefile to start building a loadable module.
> 
> The include directory includes all reference policy if files and additional
> files needed to build a reference policy loadable module including the 
> build.conf
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
> with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
