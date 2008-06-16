Subject: Re: SELinux Bootstrap - without chroot
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Cc: SELinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <4856998A.1020606@windriver.com>
References: <4856998A.1020606@windriver.com>
Content-Type: text/plain
Date: Mon, 16 Jun 2008 13:57:18 -0400
Message-Id: <1213639038.15523.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-06-16 at 12:49 -0400, Vikram Ambrose wrote:
> Without a chroot environment, How does one go about building/installing, 
> well basically the entire process including the bootstrap in a self 
> contained build directory?
> 
> I have been playing with refpolicy. And from what I have learned, 
> refpolicy allows you to define a LOCAL_ROOT but none of the selinux 
> userspace tools allow you to make use of a folder other than 
> /etc/selinux as that path is hard coded in all the source files.
> 
> In essence I want to know how to build a policy and tar it up, extract 
> it into a target rootfs and simply call "load_policy" to use it.

I'm not sure LOCAL_ROOT is what you think it is; there is a DESTDIR
definition though that gets used by the Fedora policy package build.
Looks like there is even a TEST_TOOLCHAIN definition although I haven't
used that one and it would have the same problems with libsemanage
helpers that you ran into earlier.

Note that they get installed to $DESTDIR/usr/share/selinux/$SELINUXTYPE
by make install.  In Fedora, they are packaged as such, then when you
install the package on the target host, they are unpacked
to /usr/share/selinux/$SELINUXTYPE by the package manager and then a %
post scriptlet runs semodule on them to install them under /etc/selinux
and load them.

Options for you might include:
1) Run semodule_link and semodule_expand at build time to link and
expand the modules to a kernel policy up front.  Then you can just put
the files into place without running semodule later.
2) Build monolithic policy instead of modular policy.  Then there is no
intermediate step and no use of semodule*.

You don't really want to load the policy on the build host, do you?
That's not a good idea - it will disturb the functioning of the build
host, and you still need to restart userspace to get everything into the
right domain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
