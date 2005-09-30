Subject: Re: /proc and chcon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: James Morris <jmorris@namei.org>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200509302147.14082.russell@coker.com.au>
References: <200509302147.14082.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 08:54:49 -0400
Message-Id: <1128084889.12459.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 21:47 +1000, Russell Coker wrote:
> Was it the intention that some /proc objects can be relabeled now that the 
> kernel supports exposing their context through the xattr interface?
> 
> It's impossible to change the context of /proc/PID entries, but files such 
> as /proc/mtrr can be relabeled.
> 
> It seems to me that this functionality is undesirable.  Apart from /proc/PID 
> entries everything under /proc has genfscon entries, I think it makes sense 
> to have that as the only way of labeling /proc.

I did note that side effect as a potential concern when I posted the
rfc/patch for the kernel changes.  People seemed to think that policy
control was sufficient, e.g. under strict policy here:
# chcon -t etc_t /proc/mtrr
chcon: failed to change context of /proc/mtrr to system_u:object_r:etc_t: Permission denied

I saw potential benefit in allowing the mechanism to relabel files that
were normally handled via genfs_contexts, as that could enable
finer-grained labeling of some pseudo filesystems (e.g. sysfs) from
early userspace (although there might be an issue with them "losing"
their label if the inode isn't pinned in memory and it is evicted and
then later re-created again).

We could possibly impose a special check for the proc case in the
SELinux module, and prohibit relabeling from selinux_inode_setxattr in
that case, but I don't think we want it to be a blanket prohibition on
everything that uses genfs_contexts.

> Also I imagine that the plan is to have the xattr interface also be used to 
> display the context for a file system mounted with "-o context=...".

Yes, that also works via James' subsequent patches (in -mm, queued for
2.6.15 I think) to allow the security module to canonicalize the reply
from getxattr.

>   For 
> that case I also think that it would be a bad idea to support changing the 
> context via restorecon/chcon.

selinux_inode_setxattr does prohibit relabeling of inodes in filesystems
that have the "mountpoint labeling" behavior (i.e. the context= option
at mount time).  So that is prohibited still.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
