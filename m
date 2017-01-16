Message-ID: <1484580399.19104.6.camel@redhat.com>
Subject: Re: [PATCH 00/46] SELinux: Fine-tuning for several function
 implementations
From: Eric Paris <eparis@redhat.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov, Eric Paris
 <eparis@parisplace.org>, James Morris <james.l.morris@oracle.com>, Paul
 Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen
 Smalley <sds@tycho.nsa.gov>, William Roberts <william.c.roberts@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Mon, 16 Jan 2017 10:26:39 -0500
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<opinion from irrelevant person>

All of the patches look good to me except most of those which change
the handling of `rc=`. I have a personal style preference for

rc = -ENOMEM;
val = kalloc();
if (!val)
  goto err;

vs

val = kalloc();
if (!val) {
  rc = -ENOMEM;
  goto err;
}

because it saves 1 line and I think the compiler does the right/same
thing. If there is preference among the people active in selinux
developers (like I said, I'm now irrelevant) I guess they win.

But certainly a big +1 from me for the array allocation and sizeof()
changes.

-Eric

On Sun, 2017-01-15 at 15:55 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 15:15:14 +0100
> 
> Several update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (46):
>   Use kmalloc_array() in cond_init_bool_indexes()
>   Delete an unnecessary return statement in cond_compute_av()
>   Improve size determinations in four functions
>   Use kmalloc_array() in hashtab_create()
>   Adjust four checks for null pointers
>   Use kcalloc() in policydb_index()
>   Delete unnecessary variable assignments in policydb_index()
>   Delete an unnecessary return statement in policydb_destroy()
>   Delete an error message for a failed memory allocation in
> policydb_read()
>   Move some assignments for the variable "rc" in policydb_read()
>   Return directly after a failed next_entry() in genfs_read()
>   Move assignments for two pointers in genfs_read()
>   Move four assignments for the variable "rc" in genfs_read()
>   One function call less in genfs_read() after null pointer detection
>   One check and function call less in genfs_read() after error
> detection
>   Move two assignments for the variable "rc" in filename_trans_read()
>   Delete an unnecessary variable assignment in filename_trans_read()
>   One function call less in filename_trans_read() after error
> detection
>   Return directly after a failed next_entry() in range_read()
>   Move four assignments for the variable "rc" in range_read()
>   Two function calls less in range_read() after error detection
>   Delete an unnecessary variable initialisation in range_read()
>   Move an assignment for a pointer in range_read()
>   Return directly after a failed kzalloc() in cat_read()
>   Return directly after a failed kzalloc() in sens_read()
>   Improve another size determination in sens_read()
>   Move an assignment for the variable "rc" in sens_read()
>   Return directly after a failed kzalloc() in user_read()
>   Return directly after a failed kzalloc() in type_read()
>   Return directly after a failed kzalloc() in role_read()
>   Move an assignment for the variable "rc" in role_read()
>   Return directly after a failed kzalloc() in class_read()
>   Move an assignment for the variable "rc" in class_read()
>   Return directly after a failed kzalloc() in common_read()
>   Return directly after a failed kzalloc() in perm_read()
>   Move an assignment for the variable "rc" in mls_read_range_helper()
>   Move an assignment for the variable "rc" in policydb_load_isids()
>   One function call less in five functions after null pointer
> detection
>   Move two assignments for the variable "rc" in ocontext_read()
>   Return directly after a failed kzalloc() in roles_init()
>   Move two assignments for the variable "rc" in roles_init()
>   One function call less in roles_init() after error detection
>   Use kmalloc_array() in sidtab_init()
>   Adjust two checks for null pointers
>   Use common error handling code in sidtab_insert()
>   Use seq_puts() in sel_avc_stats_seq_show()
> 
>  security/selinux/selinuxfs.c      |   8 +-
>  security/selinux/ss/conditional.c |  14 +--
>  security/selinux/ss/hashtab.c     |  10 +-
>  security/selinux/ss/policydb.c    | 255 ++++++++++++++++++++------
> ------------
>  security/selinux/ss/sidtab.c      |  22 ++--
>  5 files changed, 157 insertions(+), 152 deletions(-)
> 
