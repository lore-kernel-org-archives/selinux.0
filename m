Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SCbcqr028419
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 08:37:38 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7SCbbM5024332
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 12:37:37 GMT
Subject: Re: ANN: SELinux Policy IDE (SLIDE) version 1.2
From: Dave Sugar <dsugar@tresys.com>
To: selinux@tycho.nsa.gov
Cc: Ken YANG <spng.yang@gmail.com>
In-Reply-To: <46CFB291.6010000@gmail.com>
References: <1187974484.17434.6.camel@localhost.localdomain>
	 <46CFB291.6010000@gmail.com>
Content-Type: text/plain
Date: Tue, 28 Aug 2007 08:37:36 -0400
Message-Id: <1188304656.4977.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ken,

Can you give me some more information about what is going on?
Have you followed the directions posted on the SLIDE project site
(http://oss.tresys.com/projects/slide/wiki/download)?
Are there any errors being displayed?
What platform are you running on?  FC6, f7? x86, x86_64, PPC?

Thanks
Dave Sugar
dsugar@tresys.com

On Sat, 2007-08-25 at 12:39 +0800, Ken YANG wrote:
> Dave Sugar wrote:
> > Version 1.2 of the SELinux Policy IDE (SLIDE) from Tresys Technology is
> > now available for download from the Tresys Open source website at
> > http://oss.tresys.com.
> 
> i can not update through update functionality in Eclipse, i.e.
> 
> Help->Software Updates->Find and install...
> 
> 
> > 
> > SLIDE is an Eclipse plug-in that integrates with the SELinux Reference
> > Policy to provide a development environment for building SELinux policy.
> > 
> > SLIDE Features:
> > 
> > 
> > * A graphical user interface for policy development, including policy
> > syntax highlighting, context suggestions, and integrated compilation.
> > * Integration with SELinux Reference Policy, including quick lookup and
> > documentation for interfaces and macros.
> > * Wizards and easy to use templates to automate common tasks from
> > creating a new SELinux policy to adding an interface into an existing
> > module.
> > * Integrated remote policy installation and audit log monitoring, to
> > facilitate policy testing.
> > * Seamless integration with the power of standard Eclipse.
> > 
> > Version 1.2 highlights:
> > 
> > * Graphical interface for network configuration via corenetwork.
> > * Added auto completion, context help, and tool tip descriptions for
> > Reference Policy macros, as well as including macros in the interface
> > view and showing their definitions in the declaration view.
> > * Improved documentation on the open source web site.
> > * Updates to work with SETools version 3.3.
> > * Fixed problems with the Console output.
> > * Bugs fixed with undo/redo when toggling commenting on numerous lines
> > of policy.
> > 
> > 
> > 
> > If you would like to contribute, currently the best help would be to
> > test and provide feedback on the SLIDE plugin and SLIDE Remote.
> > 
> > Dave Sugar
> > Tresys Technology, LLC
> > 
> > --
> > fedora-selinux-list mailing list
> > fedora-selinux-list@redhat.com
> > https://www.redhat.com/mailman/listinfo/fedora-selinux-list
> > 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
