Message-ID: <72222DC86846D411ABD300A0C9EB08A101524357@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>,
        "'Howard Holm'" <hdholm@epoch.ncsc.mil>, SELinux@tycho.nsa.gov
Subject: RE: SELinux RPM Version
Date: Tue, 23 Apr 2002 07:24:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Monday, April 22, 2002 4:38 PM Russell Coker wrote:

> On Mon, 22 Apr 2002 14:40, Westerman, Mark wrote:
> > Current SELinux package
> > 	selinux-<kernel version>-<NSA Release number>
> > 	Current planed release:
> > 		selinux-2.4.18-2002031409.i386.rpm
> > 		selinux-dev-2.4.18-2002031409.i838.rpm
> 
> Why have the kernel version in the package name?  The NSA is  only making 
> releases for the latest kernel.  I've backported a couple of  the changes
to 
> an older kernel, but AFAIK no-one else is doing so.

While it is true that the NSA is only making releases for the latest kernel
we might need in the future the older version. A user might not want to
upgrade there kernel version. If is not to hard to keep the kernel version
I think it just adds to less confusion.

> Also the relevant thing is not the kernel version but the 
> policy version.  
> 
> What we need to eventually do is split checkpolicy out into a 
> separate package so we can have multiple versions installed, then we 
> need to have the ability to compile multiple versions and load the version

> that matches the  kernel (how do we determine the policy version in the
running 
> kernel?).
> 
> Maybe the load_policy program should be able to look at a  directory full
of 
> policy files and load the one that matches the kernel policy version?
> 
> > If future releases of selinux I think we should sub-divided into
> > more packages
> > 	selinux-kernel-<kernel version>-<NSA Release number>
> > 	selinux-policy-<version number>-<release>
> > 	selinxu-utils-<version number>-<release>
> > 		To include newrole, run_init and ......
> > 		Or a separate rpm for utility ?
> 
> Why split the sample policy from the utilities?  Why would 
> you use one 
> without the other?
>

There might be different verions of a policy. Such as a policy
for just bind (i.e. a DNS server only). If we have package for
policy then maybe different policies will be built. 
  

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
