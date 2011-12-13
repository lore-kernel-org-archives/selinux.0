Subject: Re: We are seeing more and more programs accessing sysfs_t.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4EE7B79A.7000101@redhat.com>
References: <4EE7B79A.7000101@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Dec 2011 15:44:15 -0500
Message-ID: <1323809055.21623.39.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-12-13 at 15:37 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Every domain is now reading /sys/devices/system/cpu/online because of
> changes to glibc.
> 
> We are also seeing domains that need write access.
> 
> For example
> 
> > https://bugzilla.redhat.com/show_bug.cgi?id=685096
> > 
> > for https://bugzilla.redhat.com/show_bug.cgi?id=685096 (IP over 
> > Infiniband support for NetworkManager), NM needs to be able to 
> > write to /sys/class/net/ib*/mode. audit2allow says:
> > 
> > allow NetworkManager_t sysfs_t:file write;
> 
> It seems we need a better way of labeling files under /sys.
> 
> genfscon only seems to work at the top level.
> 
> Allowing all domains to read sysfs_t does not seem like the correct
> solution, and allow NetworkManager to write anywhere on /sys is
> probably not good either.

Modern kernels support setfilecon()/setxattr() on sysfs nodes, so a
userspace program can set specific types on them.  That was added a
couple of years ago for libvirt.  Just specify the desired labels in
file_contexts and restorecon -R /sys at boot.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
