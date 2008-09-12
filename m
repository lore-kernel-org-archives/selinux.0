Message-ID: <48CAB248.6060701@tresys.com>
Date: Fri, 12 Sep 2008 14:17:44 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        jmorris@namei.org, paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] Thread/Child-Domain Assignment (rev.6)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <4897EB6F.6080709@ak.jp.nec.com> <48B2A66D.7030608@ak.jp.nec.com> <48B6C966.7040006@tresys.com> <48B756C4.2090909@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3510@exchange2.columbia.tresys.com> <48BB8B1E.7010208@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3609@exchange2.columbia.tresys.com> <48BC141F.2060802@kaigai.gr.jp> <48C5D9A7.7090909@ak.jp.nec.com>
In-Reply-To: <48C5D9A7.7090909@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> The attached patch for libsepol add suport for a new policy version
> named as (MOD_)POLICYDB_VERSION_BOUNDARY.
> Userspace hierarchy checks are reworked in this revision.
> 
> FEATURES:
> 
> - Boundary feature support:
>  The upcoming kernel has a feature to define boundary relationship
>  between two users, roles and types. It enables to restrict a bounded
>  one can never have wider permissions than its bounds one.
>  Any XXXX_datum_t structure have "u32 bounds" member to indicate its
>  bounds, and we can handle it with the latest version of policy format
>  provided by this patch.
> 
> - Loading attributes into kernel space:
>  The upcoming kernel also allows to load entries of attribute.
>  The attached patch turn off to drop them, when it tries to write
>  kernel policy with its version is equal or greater than
>  POLICYDB_VERSION_BOUNDARY.
>  Any entries of attribute has a property of TYPEDATUM_PROPERTY_ATTRIBUTE.
> 
> - Improvement of type_datum format on kernel/modular policy.
>  The type_datum entry has several its attribute fields like "primary",
>  "flavor" and "flags", and these are stored within separated fields
>  on-disk format. This patch enables to pack them into a single field.
>  Currently four bits are defined, and rest of them are reserved.
>    #define TYPEDATUM_PROPERTY_PRIMARY      0x0001
>    #define TYPEDATUM_PROPERTY_ATTRIBUTE    0x0002
>    #define TYPEDATUM_PROPERTY_ALIAS        0x0004  /* userspace only */
>    #define TYPEDATUM_PROPERTY_PERMISSIVE   0x0008  /* userspace only */
> 
> - Hierarchy checks are reworked
>  The existing userspace hierarchy checks are reworked for the upcoming
>  boundary feature. It can handle parent one based on both newer bounds
>  relationship and existing name-based hierarchy.
> 
>  In addition, I put a trick to evaluate conditional rules correctly.
>  The following example shows a confusable case. A_t is the bounds of B_t,
>  so B_t can never has wider permission than A_t.
> 
>  Example)
>    allow B_t X_t : file { read_file_perms };
>    if (A_can_write_X) {
>        allow A_t X_t : file { write_file_perms };
>    } else {
>        allow A_t X_t : file { read_file_perms };
>    }
> 
>  A_t's permissions on X_t is depend on the 'A_can_write_X', however,
>  a part of them, like 'read', are unconditionally allowed.
>  If we can find common permission on both of true/false lists, these
>  are pulled up to unconditional rules.
>  Thus, B_t's read permission on X_t is not hierarchy violated in the
>  above example. It also matches the upcoming kernel behavior no need
>  to say.
> 

Was this the latest patch? I can't seem to apply it either to the latest git HEAD or to the last svn revision:

[root@misterfreeze trunk]# patch -p0 --dry-run -F5< /root/selinux/patch                
patching file libsepol/include/sepol/policydb/policydb.h
Hunk #1 succeeded at 119 with fuzz 3.
Hunk #2 FAILED at 146.
Hunk #3 succeeded at 167 with fuzz 3.
Hunk #4 FAILED at 607.
Hunk #5 FAILED at 621.
3 out of 5 hunks FAILED -- saving rejects to file libsepol/include/sepol/policydb/policydb.h.rej
patching file libsepol/src/policydb.c
Hunk #1 succeeded at 110 with fuzz 3.
Hunk #2 succeeded at 147 with fuzz 3.
Hunk #3 succeeded at 182 with fuzz 3.
Hunk #4 FAILED at 1873.
Hunk #5 succeeded at 1947 with fuzz 3.
Hunk #6 FAILED at 1962.
Hunk #7 FAILED at 2338.
3 out of 7 hunks FAILED -- saving rejects to file libsepol/src/policydb.c.rej
patching file libsepol/src/hierarchy.c
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 46.
Hunk #3 FAILED at 125.
Hunk #4 FAILED at 157.
Hunk #5 FAILED at 335.
Hunk #6 FAILED at 402.
Hunk #7 FAILED at 428.
Hunk #8 succeeded at 467 with fuzz 3.
7 out of 8 hunks FAILED -- saving rejects to file libsepol/src/hierarchy.c.rej
patching file libsepol/src/expand.c
Hunk #1 succeeded at 466 with fuzz 3.
Hunk #2 succeeded at 1959 with fuzz 3.
Hunk #3 succeeded at 2462 with fuzz 3.
Hunk #4 succeeded at 2480 with fuzz 3.
Hunk #5 succeeded at 2498 with fuzz 3.
Hunk #6 succeeded at 2590 with fuzz 3.
patching file libsepol/src/write.c
Hunk #1 succeeded at 920 with fuzz 3.
Hunk #2 FAILED at 954.
Hunk #3 succeeded at 1031 with fuzz 3.
1 out of 3 hunks FAILED -- saving rejects to file libsepol/src/write.c.rej
patching file libsepol/src/link.c
Hunk #1 succeeded at 660 with fuzz 3.
Hunk #2 FAILED at 1453.
1 out of 2 hunks FAILED -- saving rejects to file libsepol/src/link.c.rej

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
