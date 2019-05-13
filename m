Return-Path: <SRS0=Ozag=TN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CBBC04AA7
	for <selinux@archiver.kernel.org>; Mon, 13 May 2019 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8CC208C2
	for <selinux@archiver.kernel.org>; Mon, 13 May 2019 13:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qWp49DDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfEMN0s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 May 2019 09:26:48 -0400
Received: from usfb19pa11.eemsg.mail.mil ([214.24.26.82]:12593 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbfEMN0s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 May 2019 09:26:48 -0400
X-EEMSG-check-017: 139729489|USFB19PA11_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 May 2019 13:26:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1557754005; x=1589290005;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0HJZiuSDl+E9DaPg/8etdATlBAA0Ml0vjm++Bysxhq8=;
  b=qWp49DDYrbmnPF0NI26UEfUlMycW36YkstdAp1a4KNNVbs8cSEm0Jl/Q
   fiZ2fBIQQ1+LbnuZbC32dq9iYsocLlvecAnZ4zbJ+a2c2MA4yAwproQOF
   6HOEEs8R2nfRbcGK7Xt0bxswP4L11bmRc692J4W9E0ehO8J8H9eE9MLEa
   fz2OYL2H/F79jYg+QHPRdMojzbz51G3nN/1WAiEOCLgJT6PAox5cYHSuo
   H9rNAsEGnMzZQxKlrSNbFgDmRDux0LITjxHRbF2bu+2EySDu7Ktq+Mqbk
   7v5pVRvNJsVJGvWg+xtMGQuHPmo5k+PE5UQm+oPi+hGOEbj4HQJNw1aUO
   w==;
X-IronPort-AV: E=Sophos;i="5.60,465,1549929600"; 
   d="scan'208";a="23636745"
IronPort-PHdr: =?us-ascii?q?9a23=3AvzbjPhLvKGYvGr9TB9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKvT+rarrMEGX3/hxlliBBdydt6sdzbuK+P64EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCegbb9oKBi7ogrdu8gKjYB/Nqs/1x?=
 =?us-ascii?q?zFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0QrNEAjsoNW?=
 =?us-ascii?q?A1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVT?=
 =?us-ascii?q?i+6apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSG?=
 =?us-ascii?q?xPUcZLUyxKH52yYY0BAeEcOepUtofwql8LoRa4GAKiBv7gyiVQi3Hrw6M63e?=
 =?us-ascii?q?QvHwLI0gMuEN0BsmjbotruOacOU+241rXEwSnNYv5U3zr29YjGcgomofGJRb?=
 =?us-ascii?q?9+bNbRxlc3FwPFkFqQr5HuMS6Q1usXt2ib6/RvVOKygGMgsAF+vyOvy9wwio?=
 =?us-ascii?q?jJmo0VylfE+T9/wIYuP9K0UkF7Ydm6EJZJsSyRKoV4QsQnQ25yuSY6zKULuY?=
 =?us-ascii?q?SlcycXyJQo3QLfZ+abfIiP5xLvTOmRITZkhHJlZbKwnAy+/lSnyu35UMS/zV?=
 =?us-ascii?q?VErjJdn9XRuX0A2Abf58iaRvdn4Eus1iiD2xrO5uxCPEs6j7DUK4Q7zb41jp?=
 =?us-ascii?q?cTtEPDETLol0jul6+Wc1kk+vCv6+T6frXqvp+cOJFwigH5KqkuhtawAf45Mg?=
 =?us-ascii?q?gTRGiX4/i81b3/8k35R7VGlPs2nbXCsJ/GP8gbo6+5AwtN3oYi7RawESum3c?=
 =?us-ascii?q?wFkXQII19JYhKKg5XzN13QL/30E+2zj0m0nDdu3f/GP7nhApvXLnjElbfsZa?=
 =?us-ascii?q?195FNHyAco0dBe545bCrEGIP7pXE/xr8bXAgU2Mwyz3ebrEM992Z8GWWKTHq?=
 =?us-ascii?q?+ZN7vfsViN5uIoOOmMYpUatyrjJPU+/f7hk2I2mV8Hcqm1x5cYdHe4HvF+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmV+zlllmCUT9VZ3avUKMx/S87CI24AofZXIytg6KO3D?=
 =?us-ascii?q?29HpJIYmBKEFeMEW3nd4+cQfcDdDqSItN9kjwDTbWhU5Uu1QyqtALh07poNP?=
 =?us-ascii?q?fU+ikBuZLm09h14PfTmg8o+TNoCMSd1nmHT3tokWMQWz82wKd/rFRmyleHy6?=
 =?us-ascii?q?d5jeZYGsJV5/xVTAg3LoLcz/ZkBNDpWgPBZc2FR0qhQtWjGTsxVM4+w8cSY0?=
 =?us-ascii?q?ZhHNWvlgjD3y6wDL8Ii7yLHoc7/bjH0njrOcly1nbG27M9j1U8XsRPMmim1e?=
 =?us-ascii?q?ZD8F30AYLTnkfRsqGxc60X0S2FoGCGynGItUpVeBR9XaXMQTYUYU6A/vrj4U?=
 =?us-ascii?q?aXdKOjEbQqNEN6zMeGLqZbIonygU5uWOboONOYZXm43Wi3G0Dblfu3cIP2dj?=
 =?us-ascii?q?BFj23mA08enlVWpC3XOA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BSAADyb9lc/wHyM5BaChsBAQEBAwEBAQcDAQEBgVMEA?=
 =?us-ascii?q?QEBCwEBgWUqaVEBMiiEEZNdAQEBAQEBBoEQJX6IT48GFIFnCQEBAQEBAQEBA?=
 =?us-ascii?q?S0HAQIBAYFLgi9GAoITIzYHDgEDAQEBBAEBAQEDAQFsHAxCFgGBYSkBgmcBB?=
 =?us-ascii?q?SMEEUEQCw4KAgIRFQICVwYNBgIBAYJfPwGBdhQPq0x8M4QyAYEUgx6BRoELK?=
 =?us-ascii?q?AGLThd4gQeBEScMgio1PoJhAgIYgQIaaoJLglgEinsgARKHHVKUOAmCC4IIh?=
 =?us-ascii?q?BiMNgYblWyTCIp4hTYOI4FXKwgCGAghD4MnCYISF4EBAQEIgkGEUYYeIwMwA?=
 =?us-ascii?q?Ql8AQGIboYKAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 May 2019 13:26:43 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4DDQgwt006476;
        Mon, 13 May 2019 09:26:42 -0400
Subject: Re: [PATCH] selinux: support attributes in type transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Steve Lawrence <slawrence@tresys.com>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20190506131213.31044-1-omosnace@redhat.com>
 <d0a812be-ab7c-4674-2125-c7156152db2c@tycho.nsa.gov>
 <CAFqZXNsUBtek6YY2qnCpqfTSJxpyyDfdf_zh_+f4LN2K0-nF_Q@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <67f9a097-0552-6b76-4eea-6f9b52534a3d@tycho.nsa.gov>
Date:   Mon, 13 May 2019 09:18:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsUBtek6YY2qnCpqfTSJxpyyDfdf_zh_+f4LN2K0-nF_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/13/19 7:16 AM, Ondrej Mosnacek wrote:
> On Mon, May 6, 2019 at 11:02 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 5/6/19 9:12 AM, Ondrej Mosnacek wrote:
>>> The amount of filename transition rules used in Fedora has grown a lot
>>> due to many domains needing rules for correct /dev file labeling. This
>>> has in turn caused the binary policy to increase in size a lot, too.
>>>
>>> To mitigate this, start properly handling type attributes in type
>>> transitions so that userspace can avoid always expanding them and
>>> generate smaller policies. (Note: adding attribute support only for
>>> named transition rules would be enough, but this patch adds it to all
>>> type transition rules to keep better consistency.)
>>>
>>> As an illustration, this change will reduce Fedora 31 binary policy from
>>> ~8.4 MiB to only ~2.8 MiB (~250K type transition rules to ~28K). These
>>> numbers only take into account named file transition rules; the
>>> reduction from basic type transition rules is likely going to be much
>>> less radical.
>>>
>>> The fact whether the kernel supports this feature is signaled to
>>> userspace by an increment in policy version. With older policies the
>>> transition computation is handled as before to avoid performance
>>> regression.
>>
>> NB I haven't looked at the code itself yet.  However, my concerns with
>> this change conceptually are:
>>
>> 1) The AVC does not cache security_transition_sid() results and
>> therefore doing the attribute expansion at runtime versus policy
>> build-time is likely to have a more significant runtime performance
>> impact (for operations that involve security_transition_sid, e.g. file
>> creation, socket creation, msgsnd(2)) than the corresponding impact from
>> when we introduced attribute support for allow rules in the kernel
>> (commit 782ebb992ec20b5afdd5786ee8c2f1b58b631f24), which was at least
>> mitigated by caching.  This could perhaps be addressed by augmenting the
>> AVC to cache security_transition_sid() results as well, as has already
>> been done in the userspace AVC in libselinux (where the equivalent to
>> security_transition_sid is security_compute_create(3) and the AVC
>> provides an avc_compute_create(3) interface).  You note that you avoid a
>> performance regression for older policies by falling back to the old
>> logic, but that won't help with newer policies of course.
> 
> Yes, I'm probably underestimating the performance impact of the
> change... I'm trying right now to collect some statistics to help
> quantify the difference and try some optimization ideas.
> 
>>
>> 2) Even with caching of results, we have seen performance problems with
>> security_compute_av() having unacceptable latency when called on AVC
>> misses due to types with many attributes, requiring a number of changes
>> to the policy toolchain to allow better control over attribute expansion
>> and retention, which would presumably also be needed here.  This change
>> would further require retaining attributes used in type transitions in
>> addition to those used in allow rules, which could impact the
>> performance of security_compute_av() in addition to
>> security_transition_sid().
>>
>> 3) IIRC, the pattern we saw when we made the equivalent change for allow
>> rules was likewise an immediate drastic reduction in kernel memory usage
>> (as reported in the commit message) followed by a long period of
>> explosive allow rule growth in policy, ultimately bringing policy size
>> and kernel memory usage back up to its prior levels (or worse).
>> Subsequently there was significant work to shrink the policy through a
>> major rewrite of allow rules to use attributes whenever possible. This
>> in turn required the introduction of more attributes per type, which
>> then harmed security_compute_av() performance as above. We want to avoid
>> a similar cycle here.
> 
> Again, this is something that I will need to analyze via statistics
> and think it through...
> 
>>
>> 4) This change does not fix the limitation in the ability to support
>> more flexible name-based transitions (e.g. simple wildcarding, file
>> globs, or regex matching), which is another factor in the large number
>> of name-based transition rules in Fedora policy and would benefit a
>> wider set of use cases IMHO.
> 
> Yes, this feature remains relevant and no doubt would be very useful,
> however I'm not sure how much work that would require... Implementing
> even simplified regexes in the kernel sounds tricky... (or is there
> already some library that we could use? I didn't check). But maybe in
> the end it will be easier than going in the direction of this patch :)

Even basic prefix match would allow elimination of many redundant 
entries.  WRT glob or regex matching, there are some examples in 
lib/glob.c (glob), kernel/trace/* (simple regex), and 
security/apparmor/* (dfa).  That said, I don't think this will avoid the 
need for some form of this patch as well.

> 
>>
>> 5) It is unclear (to me) that Fedora truly needs to rely so heavily on
>> name-based type transitions for /dev node labeling, or to define the
>> transitions for so many domains, which ostensibly is the motivation for
>> this change.  Fedora didn't appear to need these rules prior to the use
>> of devtmpfs, and even with the use of devtmpfs, arguably these rules are
>> only needed for kernel_t and maybe unconfined_t, not all unconfined
>> domains. Name-based transitions were not designed to support general
>> purpose /dev node labeling; they were supposed to only be to handle edge
>> cases where userspace could not be modified to correctly label files and
>> per-file granularity was required.  Neither upstream refpolicy nor
>> Android employ large numbers of name-based transitions to my knowledge.
>> We don't want to encourage misuse of these rules or further growth in them.
> 
> I don't have a deep understanding of this, but I'm not sure if we can
> reliably enforce correct devtmpfs labeling in userspace (at least in
> Fedora). There shouldn't be too many services that need/may create
> files in devtmpfs, so they should probably be fixed, but now we have a
> chicken-and-egg problem: we can't remove the rules before all these
> cases are found and fixed, but as long as the rules are there, there
> is no push for the issues to be fixed...
> 
> I'll see if I can implement this without adding too much complexity
> and without killing performance. If not, then I'll probably just give
> up on this front...
> 
>>
>> That said, I'm willing to consider such a change, but I'd like to see
>> that the above issues are adequately explored before accepting it.
>>
>>>
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> ---
>>>
>>> Very mildly tested by applying a proof-of-concept patch against
>>> libsepol [1], which disables type attribute expansion on src/target of
>>> named file transition rules, and running the following on Fedora Rawhide
>>> (from an unconfined root shell):
>>>
>>>       mknod /dev/ram0 b 252 16
>>>       ls -lZ /dev/ram0
>>>       rm -f /dev/ram0
>>>
>>> Without this patch, the corresponding transition rule (which happens to
>>> have an attribute specified as the source type) didn't apply and the
>>> file got label device_t (as expected). With this patch (+ the policy
>>> version fallback condition disabled), the rule applied as it should and
>>> the file got labeled correctly as fixed_disk_device_t.
>>>
>>> We don't have a proper corresponding userspace patch yet, but I'd like
>>> to have this patch out and get some feedback before moving on further.
>>>
>>> See RHBZ 1660142 [2] for original discussion leading to this patch.
>>>
>>> [1] https://github.com/WOnder93/selinux/commit/26283729657ec33b6743e929e1b5b40a54294043
>>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1660142
>>>
>>>    security/selinux/include/security.h |  33 +++---
>>>    security/selinux/ss/services.c      | 177 ++++++++++++++++++++--------
>>>    2 files changed, 147 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>>> index 111121281c47..aa6b5a689cb7 100644
>>> --- a/security/selinux/include/security.h
>>> +++ b/security/selinux/include/security.h
>>> @@ -22,28 +22,29 @@
>>>    #define SECCLASS_NULL                       0x0000 /* no class */
>>>
>>>    /* Identify specific policy version changes */
>>> -#define POLICYDB_VERSION_BASE                15
>>> -#define POLICYDB_VERSION_BOOL                16
>>> -#define POLICYDB_VERSION_IPV6                17
>>> -#define POLICYDB_VERSION_NLCLASS     18
>>> -#define POLICYDB_VERSION_VALIDATETRANS       19
>>> -#define POLICYDB_VERSION_MLS         19
>>> -#define POLICYDB_VERSION_AVTAB               20
>>> -#define POLICYDB_VERSION_RANGETRANS  21
>>> -#define POLICYDB_VERSION_POLCAP              22
>>> -#define POLICYDB_VERSION_PERMISSIVE  23
>>> -#define POLICYDB_VERSION_BOUNDARY    24
>>> -#define POLICYDB_VERSION_FILENAME_TRANS      25
>>> -#define POLICYDB_VERSION_ROLETRANS   26
>>> +#define POLICYDB_VERSION_BASE                        15
>>> +#define POLICYDB_VERSION_BOOL                        16
>>> +#define POLICYDB_VERSION_IPV6                        17
>>> +#define POLICYDB_VERSION_NLCLASS             18
>>> +#define POLICYDB_VERSION_VALIDATETRANS               19
>>> +#define POLICYDB_VERSION_MLS                 19
>>> +#define POLICYDB_VERSION_AVTAB                       20
>>> +#define POLICYDB_VERSION_RANGETRANS          21
>>> +#define POLICYDB_VERSION_POLCAP                      22
>>> +#define POLICYDB_VERSION_PERMISSIVE          23
>>> +#define POLICYDB_VERSION_BOUNDARY            24
>>> +#define POLICYDB_VERSION_FILENAME_TRANS              25
>>> +#define POLICYDB_VERSION_ROLETRANS           26
>>>    #define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS        27
>>> -#define POLICYDB_VERSION_DEFAULT_TYPE        28
>>> +#define POLICYDB_VERSION_DEFAULT_TYPE                28
>>>    #define POLICYDB_VERSION_CONSTRAINT_NAMES   29
>>> -#define POLICYDB_VERSION_XPERMS_IOCTL        30
>>> +#define POLICYDB_VERSION_XPERMS_IOCTL                30
>>>    #define POLICYDB_VERSION_INFINIBAND         31
>>> +#define POLICYDB_VERSION_TYPE_TRANS_ATTR     32
>>>
>>>    /* Range of policy versions we understand*/
>>>    #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>>> -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_INFINIBAND
>>> +#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_TYPE_TRANS_ATTR
>>>
>>>    /* Mask for just the mount related flags */
>>>    #define SE_MNTMASK  0x0f
>>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>>> index cc043bc8fd4c..1e8293201184 100644
>>> --- a/security/selinux/ss/services.c
>>> +++ b/security/selinux/ss/services.c
>>> @@ -1610,30 +1610,137 @@ out:
>>>        return -EACCES;
>>>    }
>>>
>>> -static void filename_compute_type(struct policydb *policydb,
>>> -                               struct context *newcontext,
>>> -                               u32 stype, u32 ttype, u16 tclass,
>>> -                               const char *objname)
>>> +static void compute_type_noattr(struct policydb *policydb,
>>> +                             struct context *newcontext,
>>> +                             u32 stype, u32 ttype,
>>> +                             u16 tclass, u32 specified,
>>> +                             const char *objname)
>>>    {
>>> -     struct filename_trans ft;
>>> -     struct filename_trans_datum *otype;
>>> +     struct avtab_key avkey;
>>> +     struct avtab_datum *avdatum = NULL;
>>> +     struct avtab_node *node;
>>>
>>>        /*
>>> -      * Most filename trans rules are going to live in specific directories
>>> -      * like /dev or /var/run.  This bitmap will quickly skip rule searches
>>> -      * if the ttype does not contain any rules.
>>> +      * if we have a objname this is a file trans check so check those
>>> +      * rules
>>>         */
>>> -     if (!ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype))
>>> +     if (objname) {
>>> +             struct filename_trans ft;
>>> +             struct filename_trans_datum *otype;
>>> +
>>> +             /*
>>> +              * Most filename trans rules are going to live in specific
>>> +              * directories like /dev or /var/run.  This bitmap will quickly
>>> +              * skip rule searches if the ttype does not contain any rules.
>>> +              */
>>> +             if (ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype)) {
>>> +                     ft.stype = stype;
>>> +                     ft.ttype = ttype;
>>> +                     ft.tclass = tclass;
>>> +                     ft.name = objname;
>>> +
>>> +                     otype = hashtab_search(policydb->filename_trans, &ft);
>>> +                     if (otype) {
>>> +                             newcontext->type = otype->otype;
>>> +                             return;
>>> +                     }
>>> +             }
>>> +     }
>>> +
>>> +     /* Look for a type transition/member/change rule. */
>>> +     avkey.source_type = stype;
>>> +     avkey.target_type = ttype;
>>> +     avkey.target_class = tclass;
>>> +     avkey.specified = specified;
>>> +     avdatum = avtab_search(&policydb->te_avtab, &avkey);
>>> +     if (avdatum) {
>>> +             newcontext->type = avdatum->u.data;
>>>                return;
>>> +     }
>>> +
>>> +     /* If no permanent rule, also check for enabled conditional rules */
>>> +     node = avtab_search_node(&policydb->te_cond_avtab, &avkey);
>>> +     for (; node; node = avtab_search_node_next(node, specified)) {
>>> +             if (node->key.specified & AVTAB_ENABLED) {
>>> +                     newcontext->type = node->datum.u.data;
>>> +                     return;
>>> +             }
>>> +     }
>>> +}
>>>
>>> -     ft.stype = stype;
>>> -     ft.ttype = ttype;
>>> -     ft.tclass = tclass;
>>> -     ft.name = objname;
>>> +static void compute_type(struct policydb *policydb, struct context *newcontext,
>>> +                      u32 stype, u32 ttype, u16 tclass, u32 specified,
>>> +                      const char *objname)
>>> +{
>>> +     struct avtab_key avkey;
>>> +     struct avtab_datum *avdatum = NULL;
>>> +     struct avtab_node *node;
>>> +     struct ebitmap *sattr, *tattr;
>>> +     struct ebitmap_node *snode, *tnode;
>>> +     unsigned int i, j;
>>> +
>>> +     sattr = &policydb->type_attr_map_array[stype - 1];
>>> +     tattr = &policydb->type_attr_map_array[ttype - 1];
>>> +
>>> +     if (objname) {
>>> +             struct filename_trans ft;
>>> +             struct filename_trans_datum *otype;
>>> +
>>> +             ebitmap_for_each_positive_bit(tattr, tnode, j) {
>>> +                     /*
>>> +                      * Most filename trans rules are going to live in
>>> +                      * specific directories like /dev or /var/run.  This
>>> +                      * bitmap will quickly skip rule searches if the ttype
>>> +                      * does not contain any rules.
>>> +                      */
>>> +                     if (!ebitmap_get_bit(&policydb->filename_trans_ttypes,
>>> +                                          j + 1))
>>> +                             continue;
>>>
>>> -     otype = hashtab_search(policydb->filename_trans, &ft);
>>> -     if (otype)
>>> -             newcontext->type = otype->otype;
>>> +                     ebitmap_for_each_positive_bit(sattr, snode, i) {
>>> +                             ft.stype = i + 1;
>>> +                             ft.ttype = j + 1;
>>> +                             ft.tclass = tclass;
>>> +                             ft.name = objname;
>>> +
>>> +                             otype = hashtab_search(policydb->filename_trans,
>>> +                                                    &ft);
>>> +                             if (otype) {
>>> +                                     newcontext->type = otype->otype;
>>> +                                     return;
>>> +                             }
>>> +                     }
>>> +             }
>>> +     }
>>> +
>>> +     /* Look for a type transition/member/change rule. */
>>> +     avkey.target_class = tclass;
>>> +     avkey.specified = specified;
>>> +     ebitmap_for_each_positive_bit(sattr, snode, i) {
>>> +             ebitmap_for_each_positive_bit(tattr, tnode, j) {
>>> +                     avkey.source_type = i + 1;
>>> +                     avkey.target_type = j + 1;
>>> +                     avdatum = avtab_search(&policydb->te_avtab, &avkey);
>>> +                     if (avdatum) {
>>> +                             newcontext->type = avdatum->u.data;
>>> +                             return;
>>> +                     }
>>> +
>>> +                     /*
>>> +                      * If no permanent rule, also check for enabled
>>> +                      * conditional rules
>>> +                      */
>>> +                     node = avtab_search_node(&policydb->te_cond_avtab,
>>> +                                              &avkey);
>>> +                     for (; node;
>>> +                          node = avtab_search_node_next(node, specified)) {
>>> +                             if (node->key.specified & AVTAB_ENABLED) {
>>> +                                     newcontext->type = node->datum.u.data;
>>> +                                     return;
>>> +                             }
>>> +                     }
>>> +             }
>>> +     }
>>>    }
>>>
>>>    static int security_compute_sid(struct selinux_state *state,
>>> @@ -1650,9 +1757,6 @@ static int security_compute_sid(struct selinux_state *state,
>>>        struct class_datum *cladatum = NULL;
>>>        struct context *scontext = NULL, *tcontext = NULL, newcontext;
>>>        struct role_trans *roletr = NULL;
>>> -     struct avtab_key avkey;
>>> -     struct avtab_datum *avdatum;
>>> -     struct avtab_node *node;
>>>        u16 tclass;
>>>        int rc = 0;
>>>        bool sock;
>>> @@ -1748,33 +1852,12 @@ static int security_compute_sid(struct selinux_state *state,
>>>                }
>>>        }
>>>
>>> -     /* Look for a type transition/member/change rule. */
>>> -     avkey.source_type = scontext->type;
>>> -     avkey.target_type = tcontext->type;
>>> -     avkey.target_class = tclass;
>>> -     avkey.specified = specified;
>>> -     avdatum = avtab_search(&policydb->te_avtab, &avkey);
>>> -
>>> -     /* If no permanent rule, also check for enabled conditional rules */
>>> -     if (!avdatum) {
>>> -             node = avtab_search_node(&policydb->te_cond_avtab, &avkey);
>>> -             for (; node; node = avtab_search_node_next(node, specified)) {
>>> -                     if (node->key.specified & AVTAB_ENABLED) {
>>> -                             avdatum = &node->datum;
>>> -                             break;
>>> -                     }
>>> -             }
>>> -     }
>>> -
>>> -     if (avdatum) {
>>> -             /* Use the type from the type transition/member/change rule. */
>>> -             newcontext.type = avdatum->u.data;
>>> -     }
>>> -
>>> -     /* if we have a objname this is a file trans check so check those rules */
>>> -     if (objname)
>>> -             filename_compute_type(policydb, &newcontext, scontext->type,
>>> -                                   tcontext->type, tclass, objname);
>>> +     if (policydb->policyvers < POLICYDB_VERSION_TYPE_TRANS_ATTR)
>>> +             compute_type_noattr(policydb, &newcontext, scontext->type,
>>> +                                 tcontext->type, tclass, specified, objname);
>>> +     else
>>> +             compute_type(policydb, &newcontext, scontext->type,
>>> +                          tcontext->type, tclass, specified, objname);
>>>
>>>        /* Check for class-specific changes. */
>>>        if (specified & AVTAB_TRANSITION) {
>>>
> 
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
> 

