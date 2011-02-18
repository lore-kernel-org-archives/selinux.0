MIME-Version: 1.0
In-Reply-To: <1298036143.23592.9.camel@moss-pluto>
References: <OFF4F848CC.EFE2D45E-ON8625783A.0076BBE7-8625783B.001141BA@us.ibm.com>
	<1298035684.23592.6.camel@moss-pluto>
	<1298036143.23592.9.camel@moss-pluto>
Date: Fri, 18 Feb 2011 10:18:26 -0500
Message-ID: <AANLkTims78jDd0LvPGTrmAnmK6BVo_y+qZ3q_Omw+6-y@mail.gmail.com>
Subject: Re: inode security state and cluster file systems
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Yuri L Volobuev <volobuev@us.ibm.com>, SELinux@tycho.nsa.gov,
        selinux@davequigley.com, swhiteho@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adding GFS2 maintainer to thread.

On Fri, Feb 18, 2011 at 8:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2011-02-18 at 08:28 -0500, Stephen Smalley wrote:
>> On Thu, 2011-02-17 at 21:08 -0600, Yuri L Volobuev wrote:
>> > Hi,
>> >
>> > I'm a developer on the IBM General Parallel File System (GPFS) team.
>> > We are currently looking into implementing SELinux inode labeling
>> > support. In the process, we've run into some complications that have
>> > to do with the semantics of the Linux LSM API. We've discussed the
>> > issue briefly with Eric Paris from RedHat, who has recommended that I
>> > bring up this topic on a public list, since it concerns a larger issue
>> > of LSM interaction with cluster file systems. The idea here is not
>> > just to make a change for the benefit of an out-of-tree file system,
>> > but rather improve the LSM API to be friendlier to cluster file
>> > systems in general.
>> >
>> > The issue has to do with the semantics of multi-node xattr updates.
>> > The desirable behavior is simple: a change in an inode security label
>> > (stored as an xattr) made on nodeA should be visible on all other
>> > nodes on the next access. As far as I can tell, the current SELinux
>> > code would initialize the inode security state on the first access
>> > (e.g. via security_d_instantiate/inode_doinit_with_dentry), and from
>> > that point on the cached security state is considered valid, until the
>> > inode is destroyed or reused. Any subsequent inode_doinit_with_dentry
>> > call would be a no-op, since isec->initialized is true. There's no way
>> > to clear 'initialized', as far as I can see. This works when all
>> > changes to the inode are local, and a local setxattr call would update
>> > the inode security state. However, if the security label has been
>> > changed on another node, some mechanism is needed to update the cached
>> > security state. One could achieve this by using
>> > security_inode_notifysecctx if the value of the security context is
>> > known. However, in the general case retrieving the context value would
>> > require some knowledge about the implementation details of LSM (like
>> > the name of the security label xattr), and such knowledge is currently
>> > kept within LSM code, and arguably should remain so. In other words,
>> > one would have to resort to hacking.
>>
>> Isn't this what inode_getsecctx() is for?  So that on the node where the
>> setxattr() occurs, you can fetch the security context (without needing
>> to know the attribute name or whether it is even implemented via zero,
>> one, or many attributes), and then ship that context over the wire using
>> whatever protocol you like to the other nodes.  Then on the other nodes,
>> you can invoke inode_notifysecctx() as you said to update the context.
>> I think that is how it works for the labeled NFS support (not yet in
>> mainline).  Admittedly that is a simpler client/server model and not a
>> distributed cluster model.
>>
>> > To remedy this situation, a new API is proposed, courtesy of Eric
>> > Paris:
>> >
>> > void security_inode_refresh_security(struct dentry *dentry);
>> >
>> > The semantics would be similar to what SELinux inode_doinit provides:
>> > for the SECURITY_FS_USE_XATTR case, inode security state would be set
>> > based on the value of the security label fetched via getxattr -- even
>> > if the security state is already initialized. For other labeling
>> > behaviors, the call could be a no-op if security is already
>> > initialized, and an equivalent of inode_doinit otherwise.
>> >
>> > Does this API look useful, in particular to other cluster file
>> > systems?
>>
>> How do you know when to call this interface?  And if you know to call
>> it, why don't you know what the new context is already?
>
> It would also be useful to know how you handle uid/gid/mode/ACL updates.
> Ideally we would follow a similar model for the security contexts.

It sounds to me from reading the GFS2 bugzilla like the GFS2
->getxattr() call is cluster coherent.  They explictly have a call to
flush cached ACLs when one changes somewhere and plan to use that same
explicit mechanism to flush the 'cached' sid.  I don't know how they
handle uid/gid/etc changes....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
