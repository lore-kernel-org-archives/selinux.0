Message-ID: <488ADF55.9020007@kaigai.gr.jp>
Date: Sat, 26 Jul 2008 17:24:53 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <stephen.smalley@gmail.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
        paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment
References: <487C7698.60503@ak.jp.nec.com> <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil> <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com>  <4889CF30.2060306@ak.jp.nec.com> <1216993463.11948.22.camel@sulphur> <6FE441CD9F0C0C479F2D88F959B015880246B43E@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880246B43E@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On Fri, 2008-07-25 at 22:03 +0900, KaiGai Kohei wrote:
>>> [1/3] thread-context-kernel.1.patch
>>>   This patch enables to assign a thread a "weaker" hierarchical
>>>   domain, only if the destinated domain is a child of the current
>>>   domain. Hierachy relationships are defined in the policy version
>>>   24. This patch also enables to read the new version of policy.
>> If you are going to take type hierarchy support into the
>> kernel, then it seems like it should be completely taken into
>> the kernel, i.e. the hierarchy checking should be applied by
>> the kernel rather than by the toolchain.  That is what the
>> Flask security server did for its extensible policy mechanism.
>>
> 
> If we are going to do this we also might as well implement the explicit
> hierarchy support and get away from name based hierarchy.
> 
>> And I think both the neverallow checking and the type
>> hierarchy checking needs to move away from needing to do a
>> full expansion in order to check; it is just too expensive these days.
>>
> 
> Do you think it will be faster to do attribute based lookups? It will
> certainly use significantly less memory.

What do you means the attribute based lookups?

In hierarchy checks, we should not expand any attribute of type without
applying them to its parent type. We can check it by comparing type_attr_map
of both types, without additional memory consumption.

In never allow checks, all we have to do is adding a "else if" block to check
in context_struct_compute_av(), like:

------------
   ebitmap_for_each_positive_bit(sattr, snode, i) {
       ebitmap_for_each_positive_bit(tattr, tnode, j) {
           avkey.source_type = i + 1;
           avkey.target_type = j + 1;
           for (node = avtab_search_node(&policydb.te_avtab, &avkey);
                node != NULL;
                node = avtab_search_node_next(node, avkey.specified)) {
               if (node->key.specified == AVTAB_ALLOWED)
                   avd->allowed |= node->datum.data;
               else if (node->key.specified == AVTAB_AUDITALLOW)
                   avd->auditallow |= node->datum.data;
               else if (node->key.specified == AVTAB_AUDITDENY)
                   avd->auditdeny &= node->datum.data;
+             else if (node->key.specified == AVTAB_NEVERALLOW)
+                  avd->allowed &= ~node->datum.data;
+                  /* TODO: print logs to notice masked perms */
           }

           /* Check conditional av table for additional permissions */
           cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
       }
   }
------------

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
