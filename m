Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09N7fuP027491
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 18:07:41 -0500
Received: by mail-lb0-f176.google.com with SMTP id l4so2837986lbv.35
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 15:07:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453694.LHeEgrvlzg@sifl>
References: <52CF1A53.9080501@redhat.com>
 <1389306084.15747.41.camel@x220.localdomain>
 <1453694.LHeEgrvlzg@sifl>
Date: Thu, 9 Jan 2014 18:07:38 -0500
Message-ID: <CACLa4pvs_qwHn3sf-y0bMZ5wSPs6C39nFZGsptDqo=kje2E5tg@mail.gmail.com>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

static int superblock_alloc_security(struct super_block *sb)
{
...
         sbsec->def_sid = SECINITSID_FILE;

static int inode_alloc_security(struct inode *inode)
{
        struct inode_security_struct *isec;
...
        isec->sid = SECINITSID_UNLABELED;

static int inode_doinit_with_dentry(struct inode *inode, struct dentry
*opt_dentry)
{
...
        if (rc != -ENODATA) {
                sid = sbsec->def_sid;
...
        if (rc) {
...
                /* Leave with the unlabeled SID */
                rc = 0;
                break;

So there you have it...

I believe we need a new initial sid.  SECINITSID_INVALID_LABEL....

On Thu, Jan 9, 2014 at 5:54 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Thursday, January 09, 2014 11:21:24 PM Dominick Grift wrote:
>> Then leave the unlabeled isid for netlabel ( i think netlabel also uses
>> the unlabeled isid )
>
> While NetLabel uses the unlabeled initial sid, there are plenty of other
> places where it is used, the most obvious being almost all the initial object
> allocation functions in the kernel.  Were going to need to keep the unlabeled
> initial sid as "unlabeled_t" or similar for the foreseeable future.
>
> --
> paul moore
> www.paul-moore.com
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
