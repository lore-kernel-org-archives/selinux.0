Subject: Re: filesystem mount AVC denial
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <49874331.2050102@redhat.com>
References: <7b4dai$ejec6@dmzms99901.na.baesystems.com>
	 <1233583453.3826.4.camel@localhost.localdomain>
	 <49874331.2050102@redhat.com>
Content-Type: text/plain
Date: Tue, 03 Feb 2009 08:41:15 -0500
Message-Id: <1233668475.14235.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-02-02 at 14:02 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Fri, 2009-01-30 at 15:45 -0800, Clarkson, Mike R (US SSA) wrote:
> >> I got the following AVC denial in the audit logs and I'm wondering what
> >> would cause this:
> >>
> >> type=AVC msg=audit(1232734163.528:997720):avc: denied { mount } for
> >> pid=28016 comm="find" name="/" dev=0:1c ino=0
> >> scontext=root:staff_r:libstart_t:s0-s4:c0.c255
> >> tcontext=system_u:object_r:nfs_t:s0 tclass=filesystem
> >>
> >> The program running in the libstart_t domain is using the "find" cmd,
> >> and find is requiring the "mount" permission. Could this be caused by
> >> "find" traversing into an automounted (NFS) directory? But in that case
> >> I would expect the automount daemon, which is running in the automount_t
> >> domain, to do the mounting.
> > 
> > Could be a nfs submount, triggered upon traversing the boundary?
> > 
> We had this happen on another bug report, and I think it is just wrong.
> 
> Since automounter could mount any file system or any file for that
> matter, this means in order to make this work, any confined domain that
> could traverse a directory that is automounted could fail with an AVC
> like the above.
> 
> guest_t cd to /mynfs Would fail????
> 
> automount is doing the mount so the kernel should say automount not
> libstart_t.
> 
> I think this is a bug in the kernel.

Yes, it is similar to the recent proc/self/net problem.

Eric?  James?  The fundamental issue is that we are performing a
permission check in a core function that gets used internally by the
kernel for mounts, not just when userspace initiates a mount.  In the
proc case we could use MS_KERNMOUNT as a discriminator, but not in this
case, at least at present.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
