Date: Wed, 28 Mar 2001 15:59:34 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Rajan Ravindran <rajancr@us.ibm.com>
cc: SELinux@tycho.nsa.gov
Subject: Re: Problem in installation...
In-Reply-To: <OFD5847509.3CE84D5D-ON85256A1D.00715B88@pok.ibm.com>
Message-ID: <Pine.SOL.3.95.1010328155612.13062K-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Several people have reported problems using the build-kernel script,
but they haven't identified the exact nature of the problem, and
it doesn't seem to occur on our RedHat 6.1 systems.  Try expanding
a clean copy of the release and building the kernel by hand, e.g.

tar xzf slinux-200103151617-release.tgz
cd slinux
ln -sf kernel-2.4 kernel
cd kernel
make xconfig
	(Configure the kernel appropriately for your hardware.)
make dep
make 
make modules

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Wed, 28 Mar 2001, Rajan Ravindran wrote:

> 
> Hi,
> I started installing the security-enchanced linux as per the
> procedure mentioned in
> 
> http://www.nsa.gov/selinux/doc/install.html
> 
> While building the kernel by running
> 
> ./tools/build-kernel
> 
> i'm getting an error "stddef.h not found", this
> happening while running make xconfig itself (stddef.h is present
> in kernel/linux/include directory). If anyone
> knows the solution for this problem, please let me know.
> 
> Thanks,
> Rajan.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
