Subject: Re: thread level controls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02554940@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02554940@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 10:40:46 -0400
Message-Id: <1192804846.9395.146.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-19 at 07:10 -0700, Clarkson, Mike R (US SSA) wrote:
> Are there any plans to extend SELinux to provide thread level controls?
> 
> I recognize that this is considerably harder than process level controls
> given that threads share a number of resources, but it would be quite
> useful, at least from an MLS perspective.
> 
> Today, most systems are going to contain web servers, corba services, or
> some other form of client-server architecture where a server runs as a
> single process and starts separate threads for client connections. It's
> often not going to be viable to have separate servers for each different
> compartment/classification, especially when considering the rainbow of
> possible compartment combinations (x, y, z, xy, xz, yz, xyz)
> 
> Any thought?

What constitutes "thread level controls"?

For example, threads share the same global memory, so no separation is
possible there.  Thus, if you have one thread labeled "x" and one thread
labeled "y", and the first thread reads some data from a file labeled
"x" into memory, the second thread is free to read that data in memory
and write it out to a file labeled "y".  Thus, the threads are being
fully trusted to maintain the separation and the per-thread labels are
largely illusory.

The threads also share other attributes, like open file descriptors,
although I suppose our read/write revalidation would catch attempts by
the "y" process to use a descriptor opened by the "x" thread.

I think that this has come up before for e.g. userspace file server (ala
samba), where making the userspace file server handle all of the
enforcement is problematic as it cannot atomically check permissions and
perform the operation on the underlying file system.  There you might
want it to be able to assume a given credential for file permission
checking by the kernel.  Also related to the NFS and Cachefiles patches
for an "actor SID", although that is all in-kernel and not exposed to
userspace.

Note that simply assuming the level of the client may not be safe, as it
then exposes the server thread to potential influence by the client
(e.g. if the server thread runs at the same level as the client thread,
what prevents the client thread from sending it a signal, accessing
its /proc/self files, etc).  That can be mitigated in one of two ways:
distinguish them based on another attribute (e.g. type, uid) or the
fsuid/fsgid/actor SID approach where you mutate one label for checks
where the thread is the subject but leave its real label alone for
checks where the thread is the object.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
