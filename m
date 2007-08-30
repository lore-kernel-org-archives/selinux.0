Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7UHcmaL008179
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 13:38:48 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7UHcl3V020689
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 17:38:47 GMT
Subject: Re: ANN: SELinux Policy IDE (SLIDE) version 1.2
From: Dave Sugar <dsugar@tresys.com>
To: Ken YANG <spng.yang@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46D4CD70.6030606@gmail.com>
References: <1187974484.17434.6.camel@localhost.localdomain>
	 <46CFB291.6010000@gmail.com>
	 <1188304656.4977.4.camel@localhost.localdomain>
	 <46D4CD70.6030606@gmail.com>
Content-Type: text/plain
Date: Thu, 30 Aug 2007 13:38:44 -0400
Message-Id: <1188495524.10110.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ken,

I have not tested SLIDE on F8 rawhide, 

You might want to try the RPM installation since you are using eclipse
installed through an RPM also.  There is a download for
eclipse-slide-1.2.4.noarch.rpm on the download page.  You will also need
the eclipse-setools-3.3.0-1.i386.rpm and you will need to get the
SETools 3.3 rpms (setools-libs-java-3.3.0.i386.rpm and
setools-libs-3.3.0.i386.rpm) from
http://oss.tresys.com/projects/setools/wiki/download to get all of the
features in SLIDE.

>From the error you are describing, I'm not sure if you having a problem
with your eclipse installation or not.  You might want to try erasing
and reinstalling your eclipse-cdt tools and see if some of those
configuration errors go away.

Dave


On Wed, 2007-08-29 at 09:35 +0800, Ken YANG wrote:
> Dave Sugar wrote:
> > Ken,
> > 
> > Can you give me some more information about what is going on?
> > Have you followed the directions posted on the SLIDE project site
> > (http://oss.tresys.com/projects/slide/wiki/download)?
> > Are there any errors being displayed?
> > What platform are you running on?  FC6, f7? x86, x86_64, PPC?
> 
> thanks for your reply
> 
> originally, i use the eclipse to install slide following the
> "Using the Eclipse Update Site" section.
> 
> now i want to update through eclipse:
> 
> 'Help > Software Updates > Find and Install... > Search for updates
> of the currently installed features '
> 
> but eclipse told me there are not any update.
> 
> 
> after that, i try install a new feature:
> 
> Select 'Search for new features to install' and click 'Next'.
> 
> but there are some error imformations:
> 
> The current configuration contains errors and this operation can have
> unpredictable results.
>   Autotools Feature (0.9.2) requires feature "org.eclipse.cdt
> (4.0.0.200706261300)", or later version.
>   Eclipse C/C++ Development Tools CppUnit support (2.0.0) requires
> plug-in "org.eclipse.cdt.core".
>   Mylyn Task List (Required) (2.0.0.v20070627-1400) requires plug-in
> "org.eclipse.mylar (2.0.0.v20070614-1800)", or compatible.
> 
> 
> my platform is F8 Rawhide, x86 and eclipse is:
> 
> -(:09:24:$)-> rpm -qa |grep eclipse
> eclipse-jdt-3.3.0-9.fc8.i386
> eclipse-cdt-4.0.0-5.fc8.i386
> eclipse-subclipse-book-1.2.2-3.fc8.i386
> tomcat5-jasper-eclipse-5.5.23-9jpp.4.fc8.i386
> eclipse-mylyn-2.0.0-4.fc8.i386
> eclipse-platform-3.3.0-9.fc8.i386
> eclipse-subclipse-1.2.2-3.fc8.i386
> icu4j-eclipse-3.6.1-1jpp.2.fc8.i386
> eclipse-rcp-3.3.0-9.fc8.i386
> eclipse-ecj-3.3.0-9.fc8.i386
> eclipse-changelog-2.5.1-2.fc8.i386
> eclipse-cvs-client-3.3.0-9.fc8.i386
> eclipse-gef-3.2.1-4.fc7.i386
> 
> 
> 
> > 
> > Thanks
> > Dave Sugar
> > dsugar@tresys.com
> > 
> > On Sat, 2007-08-25 at 12:39 +0800, Ken YANG wrote:
> >> Dave Sugar wrote:
> >>> Version 1.2 of the SELinux Policy IDE (SLIDE) from Tresys Technology is
> >>> now available for download from the Tresys Open source website at
> >>> http://oss.tresys.com.
> >> i can not update through update functionality in Eclipse, i.e.
> >>
> >> Help->Software Updates->Find and install...
> >>
> >>
> >>> SLIDE is an Eclipse plug-in that integrates with the SELinux Reference
> >>> Policy to provide a development environment for building SELinux policy.
> >>>
> >>> SLIDE Features:
> >>>
> >>>
> >>> * A graphical user interface for policy development, including policy
> >>> syntax highlighting, context suggestions, and integrated compilation.
> >>> * Integration with SELinux Reference Policy, including quick lookup and
> >>> documentation for interfaces and macros.
> >>> * Wizards and easy to use templates to automate common tasks from
> >>> creating a new SELinux policy to adding an interface into an existing
> >>> module.
> >>> * Integrated remote policy installation and audit log monitoring, to
> >>> facilitate policy testing.
> >>> * Seamless integration with the power of standard Eclipse.
> >>>
> >>> Version 1.2 highlights:
> >>>
> >>> * Graphical interface for network configuration via corenetwork.
> >>> * Added auto completion, context help, and tool tip descriptions for
> >>> Reference Policy macros, as well as including macros in the interface
> >>> view and showing their definitions in the declaration view.
> >>> * Improved documentation on the open source web site.
> >>> * Updates to work with SETools version 3.3.
> >>> * Fixed problems with the Console output.
> >>> * Bugs fixed with undo/redo when toggling commenting on numerous lines
> >>> of policy.
> >>>
> >>>
> >>>
> >>> If you would like to contribute, currently the best help would be to
> >>> test and provide feedback on the SLIDE plugin and SLIDE Remote.
> >>>
> >>> Dave Sugar
> >>> Tresys Technology, LLC
> >>>
> >>> --
> >>> fedora-selinux-list mailing list
> >>> fedora-selinux-list@redhat.com
> >>> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
> >>>
> > 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
