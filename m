Message-ID: <48CF10DB.5030702@ak.jp.nec.com>
Date: Tue, 16 Sep 2008 10:50:19 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, Stephen Smalley <sds@tycho.nsa.gov>,
        jmorris@namei.org, paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] Thread/Child-Domain Assignment (rev.6)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <4897EB6F.6080709@ak.jp.nec.com> <48B2A66D.7030608@ak.jp.nec.com> <48B6C966.7040006@tresys.com> <48B756C4.2090909@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3510@exchange2.columbia.tresys.com> <48BB8B1E.7010208@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3609@exchange2.columbia.tresys.com> <48BC141F.2060802@kaigai.gr.jp> <48C5D9A7.7090909@ak.jp.nec.com> <48CAB248.6060701@tresys.com> <48CAF936.1090009@kaigai.gr.jp> <48CE66B1.7080108@tresys.com>
In-Reply-To: <48CE66B1.7080108@tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> KaiGai Kohei wrote:
>> Joshua Brindle wrote:
>>> KaiGai Kohei wrote:
>>>> The attached patch for libsepol add suport for a new policy version
>>>> named as (MOD_)POLICYDB_VERSION_BOUNDARY.
>>>> Userspace hierarchy checks are reworked in this revision.
>>>>
>>>> FEATURES:
>>>>
>>>> - Boundary feature support:
>>>>  The upcoming kernel has a feature to define boundary relationship
>>>>  between two users, roles and types. It enables to restrict a bounded
>>>>  one can never have wider permissions than its bounds one.
>>>>  Any XXXX_datum_t structure have "u32 bounds" member to indicate its
>>>>  bounds, and we can handle it with the latest version of policy format
>>>>  provided by this patch.
>>>>
>>>> - Loading attributes into kernel space:
>>>>  The upcoming kernel also allows to load entries of attribute.
>>>>  The attached patch turn off to drop them, when it tries to write
>>>>  kernel policy with its version is equal or greater than
>>>>  POLICYDB_VERSION_BOUNDARY.
>>>>  Any entries of attribute has a property of TYPEDATUM_PROPERTY_ATTRIBUTE.
>>>>
>>>> - Improvement of type_datum format on kernel/modular policy.
>>>>  The type_datum entry has several its attribute fields like "primary",
>>>>  "flavor" and "flags", and these are stored within separated fields
>>>>  on-disk format. This patch enables to pack them into a single field.
>>>>  Currently four bits are defined, and rest of them are reserved.
>>>>    #define TYPEDATUM_PROPERTY_PRIMARY      0x0001
>>>>    #define TYPEDATUM_PROPERTY_ATTRIBUTE    0x0002
>>>>    #define TYPEDATUM_PROPERTY_ALIAS        0x0004  /* userspace only */
>>>>    #define TYPEDATUM_PROPERTY_PERMISSIVE   0x0008  /* userspace only */
>>>>
>>>> - Hierarchy checks are reworked
>>>>  The existing userspace hierarchy checks are reworked for the upcoming
>>>>  boundary feature. It can handle parent one based on both newer bounds
>>>>  relationship and existing name-based hierarchy.
>>>>
>>>>  In addition, I put a trick to evaluate conditional rules correctly.
>>>>  The following example shows a confusable case. A_t is the bounds of B_t,
>>>>  so B_t can never has wider permission than A_t.
>>>>
>>>>  Example)
>>>>    allow B_t X_t : file { read_file_perms };
>>>>    if (A_can_write_X) {
>>>>        allow A_t X_t : file { write_file_perms };
>>>>    } else {
>>>>        allow A_t X_t : file { read_file_perms };
>>>>    }
>>>>
>>>>  A_t's permissions on X_t is depend on the 'A_can_write_X', however,
>>>>  a part of them, like 'read', are unconditionally allowed.
>>>>  If we can find common permission on both of true/false lists, these
>>>>  are pulled up to unconditional rules.
>>>>  Thus, B_t's read permission on X_t is not hierarchy violated in the
>>>>  above example. It also matches the upcoming kernel behavior no need
>>>>  to say.
>>>>
>>> Was this the latest patch? I can't seem to apply it either to the latest
>>> git HEAD or to the last svn revision:
>> Sorry, my Thunderbird translated any tabs into spaces.
>> The patch is made based on the latest subversion repository.
>> Can you apply the attached one correctly?
>>
> 
> Yes it applies. I'm going to have to track down that bug you reported
> before merging this because it prevents policy compilation.

Note that the patch does not contain fixes for a bug I reported.

IMO, alias types of invisible primay should be simply filtered
at the expand_module(), or should generate an error.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
