Subject: Re: [PATCH -v2] kernel: selinux: policy selectable handling
	of	unknown classes and perms
From: Eric Paris <eparis@redhat.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        jmorris@namei.org, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <46F03EC1.3010900@tycho.nsa.gov>
References: <1189695931.3391.46.camel@localhost.localdomain>
	 <1190132935.14037.8.camel@moss-spartans.epoch.ncsc.mil>
	 <46F03EC1.3010900@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 20 Sep 2007 15:18:55 -0400
Message-Id: <1190315935.3451.112.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-18 at 17:10 -0400, Eamon Walsh wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-09-13 at 11:05 -0400, Eric Paris wrote:
> >> Allow policy to select, in much the same way as it selects MLS support,
> >> how the kernel should handle access decisions which contain either
> >> unknown classes or unknown permissions in known classes.  The three
> >> choices are
> >>
> >> 0 - Deny unknown security access. (default)
> >> 2 - reject loading policy if it does not contain all definitions
> >> 4 - allow unknown security access
> >>
> >> The policy's choice is exported (with a value of 0,2,4) to userspace
> >> through /selinuxfs/handle_unknown 
> > 
> > Eamon, does this userspace interface work for you to use in the
> > userspace AVC?  Do you want the integer value like this or would you
> > prefer the "reject", "deny", or "allow" string that is displayed by the
> > kernel in its log message at load policy time?
> > 
> 
> Numeric values are fine, but the tristate is a little cumbersome.  Would 
> it be possible to split this into two boolean files, one reporting 
> zero/one for "don't reject/reject" and one reporting zero/one for 
> "allow/deny"?

Is this really necessary?  Are you really trying to say you don't want
to know about reject and if I put it in another file you can just ignore
it?  I'm fine with that if userspace just plain doesn't care about it,
I'll just make one allow/deny boolean.  I don't want to create another
selinuxfs file if it is going to be useless.  If 2 files are actually
useful and needed I'm willing to do that too, or maybe one file which
outputs 2 boolean flags.

cat unknown
0 0

> Also, I quickly scanned the patch and I didn't see any netlink code.  I 
> need a netlink notification delivered to userspace when the values 
> change.  This could be added to the policyload message, or a new 
> separate message type, or both.

Its not there.  I guess I'll look at this now.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
