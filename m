Message-ID: <48E7FCA4.2070803@manicmethod.com>
Date: Sat, 04 Oct 2008 19:30:44 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, Stephen Smalley <sds@tycho.nsa.gov>,
        jmorris@namei.org, paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] Thread/Child-Domain Assignment (rev.6)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <4897EB6F.6080709@ak.jp.nec.com> <48B2A66D.7030608@ak.jp.nec.com> <48B6C966.7040006@tresys.com> <48B756C4.2090909@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3510@exchange2.columbia.tresys.com> <48BB8B1E.7010208@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3609@exchange2.columbia.tresys.com> <48BC141F.2060802@kaigai.gr.jp> <48C5D9A7.7090909@ak.jp.nec.com> <48CAB248.6060701@tresys.com> <48CAF936.1090009@kaigai.gr.jp> <48E2310D.1080101@manicmethod.com> <48E32C7E.7020800@ak.jp.nec.com>
In-Reply-To: <48E32C7E.7020800@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Joshua Brindle wrote:
>> KaiGai Kohei wrote:
>>> Joshua Brindle wrote:
>>>> KaiGai Kohei wrote:
>>>>> The attached patch for libsepol add suport for a new policy version
>>>>> named as (MOD_)POLICYDB_VERSION_BOUNDARY.
>>>>> Userspace hierarchy checks are reworked in this revision.
>>>>>
>> I'm seeing a couple problems. First when writing out the policy
>> it doesn't seem to respect policyvers, I told it to generate
>> a version 23 and it still made a 24.
> 
> Are you saying a configuration of "policy-version = 23" at semanage.conf
> is ignored? I could not reproduce it in my environment.
> Could you tell me the steps to reproduce it?
> 
> I injected several printf()'s, but it shows a proper policyvers
> which reflects semanage.conf correctly.
> 
>> Second it is failing to downgrade the 24 to 23 since my kernel doesn't support 24.
> 

I'm not sure why this wasn't happening to you but from what I can tell the new patch was returning from type_write when an attribute was passed in, however the length of the table was not updated. This caused policydb_read to read over the edge of the type symbol table, resulting in badness.

Rather than trying to calculate the length without attributes I just removed the attribute check. This causes attributes to be written for all versions, but this should not cause any problems at all.

Do you have a problem with this Stephen?

index 6f1f655..d2c2c32 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -954,15 +954,6 @@ static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 
        typdatum = (type_datum_t *) datum;
 
-       /*
-        * The kernel policy version less than 24 (= POLICYDB_VERSION_BOUNDARY)
-        * does not support to load entries of attribute, so we skip to write it.
-        */
-       if (p->policy_type == POLICY_KERN
-           && p->policyvers < POLICYDB_VERSION_BOUNDARY
-           && typdatum->flavor == TYPE_ATTRIB)
-               return POLICYDB_SUCCESS;
-
        len = strlen(key);
        items = 0;
        buf[items++] = cpu_to_le32(len);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
