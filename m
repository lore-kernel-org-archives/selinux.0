Subject: Re: Socket and inode label consistency
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Trent Jaeger <tjaeger@cse.psu.edu>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <E0F1193F-FE77-4B1D-87BA-3289AD37C385@cse.psu.edu>
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu>
	 <1219838254.5708.4.camel@moss-spartans.epoch.ncsc.mil>
	 <200808271149.38256.paul.moore@hp.com>
	 <E0F1193F-FE77-4B1D-87BA-3289AD37C385@cse.psu.edu>
Content-Type: text/plain
Date: Wed, 27 Aug 2008 14:16:45 -0400
Message-Id: <1219861005.5708.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-08-27 at 14:08 -0400, Trent Jaeger wrote:
> 
> On Aug 27, 2008, at 11:49 AM, Paul Moore wrote:
> > On Wednesday 27 August 2008 7:57:34 am Stephen Smalley wrote:
> > > On Tue, 2008-08-26 at 20:50 -0400, Trent Jaeger wrote:
> > > > Hi,
> > > > 
> > > > 
> > > > I see on the Kernel Development To Do list at http://
> > > > selinuxproject.org/page/Kernel_Development that the following
> > > > task
> > > > is identified:
> > > > 
> > > > 
> > > > "Full APIs for getting and setting security contexts of sockets
> > > > and
> > > > IPC objects. Ensure that socket context is kept consistent on
> > > > socket inode and sock structures when changed."
> > > > 
> > > > 
> > > > We are being bitten by this now, so I am wondering if anyone is
> > > > working on it or wishes to discuss how to proceed.  We would be
> > > > interested in addressing this issue.
> > > 
> > > 
> > > I don't know of anyone working on it, but we are interested in it.
> > 
> > 
> > It is something that has been on my todo list for some time but it
> > is 
> > stuck with such a low priority that I haven't been able to make any 
> > progress on it.  If you've got time to work on it, I would be very 
> > happy :)
> > 
> > 
> > > As I recall, you can get and set the socket inode label via
> > > fgetxattr
> > > and fsetxattr but the struct sock label isn't accessible from
> > > userspace (except via getpeercon, and then only for the peer).  I
> > > think you'd need to add a .setxattr method to the socket_file_ops
> > > and
> > > have them call into the LSM interface to update the sock
> > > information
> > > (as well as continuing to update the socket inode info).
> > 
> > 
> > There would also need to be some work done to ensure that all the 
> > outbound labeled networking stuff is updated when the socket's label
> > is 
> > changed via the xattr operations.  Right now there is no way (at
> > least 
> > not that I know of) to change the label of an existing socket so we 
> > don't have to worry about that problem.
> > 
> > 
> > I also wonder about changing the label of a socket while it is 
> > connected, probably not a big issue for dgram sockets but I think
> > it 
> > could get pretty strange for stream sockets.
> 
> 
> Hi,
> 
> 
> What we want is to create a socket within the context of a multilevel
> secure process.  For example, if the process has an MLS range of
> s0-s1, we may want an s0 or s1 socket.  
> 
> 
> Thus, in theory, we should be able to avoid dealing with context
> changes on connected sockets and such.  Once the socket goes into any
> use, it cannot be relabeled.
> 
> 
> I am not sure that setxattr will work as this is an inode operation,
> and I do not see a reference from an inode to an associated socket.  
> 
> 
> Originally, I was thinking of setsockopt, but I agree that it would be
> nice to deal with it via the file interface, like fsetfilecon.

If you know the label you want to use for the socket _before_ you create
it, you can just use setsockcreatecon() prior to calling socket().

You may be right about setxattr not being viable due to it being an
inode op.  setsockopt may be the right approach there if we need to
support relabeling of sockets at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
