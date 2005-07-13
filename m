Subject: Re: MCS/Targeted Policy...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <42D53E2D.8000107@redhat.com>
References: <20050713155129.60027.qmail@web31606.mail.mud.yahoo.com>
	 <42D53E2D.8000107@redhat.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 12:32:47 -0400
Message-Id: <1121272367.1547.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-07-13 at 12:15 -0400, Daniel J Walsh wrote:
> Maybe unlabled is a better choice
> 
> sid unlabeled   system_u:object_r:unlabeled_t:s9:c0.c127
> For MLS.
> 
> sid unlabeled   system_u:object_r:unlabeled_t:s0
> For MCS

Doesn't matter, as long as it can be configured differently for the
evaluated MLS policy vs. the Fedora MCS policy.

The 'file' initial SID is presently used as the default file context for
files on filesystems that support security xattrs when the file lacks an
xattr value for SELinux (i.e. completely missing security context).
Hence, using the MLS value from that context is also quite reasonable
for files that have an xattr but lack any MLS value in the xattr; they
would need to be system high for MLS in both cases.

The 'unlabeled' initial SID is presently used as the initial state of
incore inodes when they are first allocated, prior to being associated
with an actual file, and for files in filesystems that have no
associated labeling scheme configured in the policy at all.  Invalidated
SIDs are also re-mapped to the unlabeled SID.  Hence, the unlabeled SID
will also likely have a system high level in a MLS policy.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
