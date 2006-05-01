Subject: Re: [PATCH ] consistent labeling of block|character devices
From: Stephen Smalley <sds@tycho.nsa.gov>
To: edwin@gurde.com
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        fireflier-devel@lists.sourceforge.net
In-Reply-To: <200605011906.38351.edwin@gurde.com>
References: <200604021240.21290.edwin@gurde.com>
	 <200604262113.01211.edwin@gurde.com>
	 <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
	 <200605011906.38351.edwin@gurde.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 01 May 2006 15:51:59 -0400
Message-Id: <1146513119.3534.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-01 at 19:06 +0300, Török Edwin wrote:
> On Wednesday 26 April 2006 22:26, Stephen Smalley wrote:
> >  However, ensuring a consistent label on devices
> > irrespective of filesystem node used to access them would be nice; there
> > has been some consideration of labeling the internal objects rather than
> > just the filesystem nodes and applying access control at that layer to
> > ensure consistent control. 
> IMHO there are two approaches here: 
> 1) introduce a sid member in struct block_device and struct cdev
> and then each time someone reads the sid of an inode of class 
> SECCLASS_BLKFILE|SECCLASS_CHR_FILE, returns the sid of the associated device.
> If relabeling is to be allowed, then relabeling the inode would mean 
> relabeling the associated device.
> But this would introduce additional overhead (the extra if to determine if we 
> are dealing with device files) every time we read the sid of an inode. This 
> seems not acceptable to me.

This assumes that the label of the filesystem node used to access the
device has to be the same as the label of the device itself.  Instead
consider labeling both objects and apply the appropriate access controls
at each layer.  Determining precisely the right objects to label and
control likely requires some investigation and discussion with the
maintainers of the driver core, e.g. Greg KH.

> 2) put a constant(invariant) label on devices, defined by policy
> Policy would define what label a device with giver major/minor number.
> We would then use this as the security context of the inode, no matter what 
> its xattr would say.
> So no matter how many device files we have pointing to the same device (same 
> major/minor no.) all will have the same sid.

This also makes the same assumption, and the device number is not really
a good way of identifying the devices and mapping them to labels,
particularly moving forward toward dynamic device numbers.

> I tried putting an additional condition in inode_doinit_with_dentry, to 
> compute the sid of block and character devices in a different way than for 
> normal files. This would take care of initial labeling.

I don't think this is the right approach.

> Any ideas,suggestions?

I think more investigation and discussion is required before we start
tossing code around, and requires the involvement of the relevant kernel
maintainers.  If you want to start such a dialogue just by asking the
relevant questions, feel free (but cc me and James Morris).  Greg is
likely a good starting point.  The hard part is asking the right
questions ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
