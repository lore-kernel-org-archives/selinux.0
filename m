Subject: Re: I would like to propose some kind of consolidation of tmpfs_t
	and tmp_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <4242CABC.70400@redhat.com>
References: <4242CABC.70400@redhat.com>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 09:37:37 -0500
Message-Id: <1111675057.12486.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-24 at 09:12 -0500, Daniel J Walsh wrote:
> We are seeing a growing amount of bug reports on using the /tmp 
> directory as a tmpfs_t file system.  Do we need to have
> two separate types? Can I make the following change?
> diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te 
> policy-1.23.4/macros/global_macros.te
> --- nsapolicy/macros/global_macros.te   2005-03-24 08:58:29.000000000 -0500
> +++ policy-1.23.4/macros/global_macros.te       2005-03-23 
> 12:36:36.000000000 -0500
> @@ -418,8 +418,8 @@
>  define(`tmp_domain', `
>  type $1_tmp_t, file_type, sysadmfile, tmpfile $2;
>  ifelse($3, `',
> -`file_type_auto_trans($1_t, tmp_t, $1_tmp_t, `{ file dir }')',
> -`file_type_auto_trans($1_t, tmp_t, $1_tmp_t, `$3')')
> +`file_type_auto_trans($1_t, { tmpfs_t tmp_t }, $1_tmp_t, `{ file dir }')',
> +`file_type_auto_trans($1_t, { tmpfs_t tmp_t }, $1_tmp_t, `$3')')
>  ')
> 
> There are a few places where this conflicts such as apache where it 
> calls tmpfs_domain.  But that looks
> like
> +`file_type_auto_trans($1_t, tmpfs_t, $1_tmpfs_t, `$3')')
> Is there anything significant about this differenct.  Or can we just 
> eliminate $1_tmpfs_t stuff?
> 
> Using mount -fscontext=tmp_t does not work because of other problems.

tmpfs can be used for several different purposes, including a kernel
internal mount for shared anon mappings and System V shared memory, a
mount on /dev/shm for POSIX shared memory, a mount on /dev for udev,
optionally /tmp and /var/tmp, etc.  The original tmpfs rules were
oriented toward controlling shared memory access by a domain.  For /dev,
I think that the Fedora solution was to run restorecon from rc.sysinit
to reset the security context on the top-level /dev directory and any
nodes already created, while leaving the fscontext unmodified, whereas
others have been using a fscontext= mount for it.

For /tmp, a fscontext= mount seems to have an issue in that it is still
using type transitions for labeling inodes (including the root), so we
end up with mount_tmp_t on /tmp at least under strict policy.  Possibly
we could/should change the way that works for the root inode.  For
context= mounts, we get the desired behavior (tmp_t on /tmp and typical
derived types on files created under it), but we lose the ability to
[gs]etfilecon and setfscreatecon on /tmp presently (which we
could/should also change at least for tmpfs).  We also need a policy
change (allow tmpfile tmp_t:filesystem associate;), but that is trivial.

The concern with collapsing tmpfs_t and tmp_t together (and $1_tmpfs_t
and $1_tmp_t as well, to avoid type transition conflicts, which would
occur quite extensively with strict policy) is that it means that policy
can no longer distinguish between a domain's ability to act on /tmp
files versus its ability to act on shared memory objects (aside from the
additional controls on System V shared memory).  If everyone were using
tmpfs /tmp, that might be less of a concern, as a tmpfs file is
effectively a shared memory object too.  But if some people still want
to use a traditional /tmp, then they might care about the distinction.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
