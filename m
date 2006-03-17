Subject: Re: semodule dumps core
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20060316224834.GA8552@thorium.jmh.mhn.de>
References: <20060316224834.GA8552@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 08:07:33 -0500
Message-Id: <1142600853.14284.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-16 at 23:48 +0100, Thomas Bleher wrote:
> Seems like semodule doesn't like me. I just recompiled my policy with
> the new versions of the tools and now semodule dumps core when I do a 
> "semodule -b base.pp".
> 
> The backtrace from gdb looks like this:
> (gdb) backtrace
> #0  0x37ec2f5c in fclose@plt () from /lib/libsemanage.so.1
> #1  0x37ec8950 in semanage_direct_commit (sh=0x804c4a8) at direct_api.c:401
> #2  0x37eca3fe in semanage_commit (sh=0x804c4a8) at handle.c:227
> #3  0x08049507 in main (argc=3, argv=0x3fc5db44) at semodule.c:361
> 
> I'm not experienced in debugging this so I put up semodule, the corefile
> and the base.pp at
> http://www.cip.ifi.lmu.de/~bleher/selinux/ubuntu/semodule-coredump.tar.bz2
> (1.5MB)
> 
> In this directory you will also find the Debian packages I used
> (libsemanage, libsepol, ...).
> 
> Please let me know if you need more information.

Hmmm...I can successfully run that semodule binary (with my own
libsemanage and libsepol) on that base.pp file, ala:
mkdir -p /etc/selinux/bleher/policy
mkdir -p /etc/selinux/bleher/contexts/files
valgrind ./semodule -v -s bleher -b base.pp

The -s option is to install it to an alternate "store" so that it
doesn't clobber my own active policy or try to load it.

Pardon my ignorance, but how does one unpack a binary deb file on a
rpm-based system like Fedora (so that I can extract your libse*
binaries)?   Any equivalent to rpm2cpio for extracting deb files?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
