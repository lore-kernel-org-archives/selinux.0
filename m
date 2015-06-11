From: Paul Moore <pmoore@redhat.com>
To: Jeff Vander Stoep <jeffv@google.com>, sds@tycho.nsa.gov
Subject: Re: [PATCH 2/2 v5] selinux: extended permissions for ioctls
Date: Thu, 11 Jun 2015 16:24:32 -0400
Message-ID: <18158698.EnkkgkmIrz@sifl>
In-Reply-To: <1433360485-16365-1-git-send-email-jeffv@google.com>
References: <1433360485-16365-1-git-send-email-jeffv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, james.l.morris@oracle.com,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, June 03, 2015 12:41:25 PM Jeff Vander Stoep wrote:
> Add extended permissions logic to selinux. Extended permissions
> provides additional permissions in 256 bit increments. Extend the
> generic ioctl permission check to use the extended permissions for
> per-command filtering. Source/target/class sets including the ioctl
> permission may additionally include a set of commands. Example:
> 
> allowxperm <source> <target>:<class> ioctl unpriv_app_socket_cmds
> auditallowxperm <source> <target>:<class> ioctl priv_gpu_cmds
> 
> Where unpriv_app_socket_cmds and priv_gpu_cmds are macros
> representing commonly granted sets of ioctl commands.
> 
> When ioctl commands are omitted only the permissions are checked.
> This feature is intended to provide finer granularity for the ioctl
> permission that may be too imprecise. For example, the same driver
> may use ioctls to provide important and benign functionality such as
> driver version or socket type as well as dangerous capabilities such
> as debugging features, read/write/execute to physical memory or
> access to sensitive data. Per-command filtering provides a mechanism
> to reduce the attack surface of the kernel, and limit applications
> to the subset of commands required.
> 
> The format of the policy binary has been modified to include ioctl
> commands, and the policy version number has been incremented to
> POLICYDB_VERSION_XPERMS_IOCTL=30 to account for the format
> change.
> 
> The extended permissions logic is deliberately generic to allow
> components to be reused e.g. netlink filters
> 
> Bug: 19416735
> Change-Id: Ibd462f12ba5748cf5dd91f28e5795764363121a2
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
> 
> Version 5 changes:
> 
> The policy binary format changes slightly. The avtab_operations structure
> is now the avtab_extended_perms structure. This structure now contains
> a specified variable that is used as an extenstion to the
> avtab_key.specified. Currently only used for ioctls, more values may be
> specified to use extended_perms for netfilter etc.
> 
> In the avc, operations structures are likewise renamed extended_perms.
> Adding support for netfilter is outside the scope of this patch.

Thank you for your patience, and the rework.  With the exception of one minor 
fix to some comments (see below) I'm happy to merge this work.  If you could 
make the fix below and repost a v6 patchset with both the LSM patch (your 
patch 1/2) as well as the SELinux patch (this one), I'll merge both into the 
SELinux next-queue branch.

> @@ -523,14 +809,17 @@ out:
>   * @perms : Permission mask bits
>   * @ssid,@tsid,@tclass : identifier of an AVC entry
>   * @seqno : sequence number when decision was made
> + * @xpd: extended_perms_decision to be added to the node
>   *
>   * if a valid AVC entry doesn't exist,this function returns -ENOENT.
>   * if kmalloc() called internal returns NULL, this function returns
> -ENOMEM.
>   * otherwise, this function updates the AVC entry. The original
> AVC-entry object
>   * will release later by RCU.
>   */
> -static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16
> tclass,
> -			   u32 seqno)
> +static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32
> ssid,
> +			u32 tsid, u16 tclass, u32 seqno,
> +			struct extended_perms_decision *xpd,
> +			u32 flags)

I believe you left out function comment header entries for driver, xperm, and 
flags.

-- 
paul moore
security @ redhat
