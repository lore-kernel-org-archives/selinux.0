Message-ID: <52D006E2.5030906@tycho.nsa.gov>
Date: Fri, 10 Jan 2014 09:42:42 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>, Paul Moore <paul@paul-moore.com>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
References: <52CF1A53.9080501@redhat.com>
 <1389306084.15747.41.camel@x220.localdomain> <1453694.LHeEgrvlzg@sifl>
 <CACLa4pvs_qwHn3sf-y0bMZ5wSPs6C39nFZGsptDqo=kje2E5tg@mail.gmail.com>
In-Reply-To: <CACLa4pvs_qwHn3sf-y0bMZ5wSPs6C39nFZGsptDqo=kje2E5tg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/09/2014 06:07 PM, Eric Paris wrote:
> static int superblock_alloc_security(struct super_block *sb)
> {
> ...
>          sbsec->def_sid = SECINITSID_FILE;
> 
> static int inode_alloc_security(struct inode *inode)
> {
>         struct inode_security_struct *isec;
> ...
>         isec->sid = SECINITSID_UNLABELED;
> 
> static int inode_doinit_with_dentry(struct inode *inode, struct dentry
> *opt_dentry)
> {
> ...
>         if (rc != -ENODATA) {
>                 sid = sbsec->def_sid;
> ...
>         if (rc) {
> ...
>                 /* Leave with the unlabeled SID */
>                 rc = 0;
>                 break;
> 
> So there you have it...
> 
> I believe we need a new initial sid.  SECINITSID_INVALID_LABEL....

Difficult (impossible?) to do in a fully backward compatible manner (to
include the case of loading new policy on old kernel, whether initially
or update/reload on an already running kernel with an older policy).

SECINITSID_NUM is baked into the kernel, as are the indices.
You are more likely to have success by reusing one of the currently
unused initial SIDs for a new purpose, especially as some of them have
never been used in any mainline kernel (some of them predate Linux 2.6.0).

Dynamic initial sid lookup (ala the dynamic class/perm lookup) support
would be nice to have, but at most that will allow us to delete obsolete
initial SIDs from refpolicy, not fix old kernels.
