Return-Path: <SRS0=5TXQ=P6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95619C282C3
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 19:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBA82084A
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 19:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="b2/Z7KhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfAVT5p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:57:45 -0500
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:54553 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAVT5o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Jan 2019 14:57:44 -0500
X-EEMSG-check-017: 635992139|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,508,1539648000"; 
   d="scan'208";a="635992139"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Jan 2019 19:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548187047; x=1579723047;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5Cge0TXL3hrcsFcltZxOQEwU1hUfz9xyLgfOgTM7nd4=;
  b=b2/Z7KhEqg9rREvhUfF+HY6Z/mZmC2JCb1MhYJhLZ2b0mZDRwrI8g60g
   Ax4nxI0iKWX/xsHjpo7UTL5a2wgVQY2Mrt5WefQkQFZAM3Nq8/4ERlKgc
   rF7L4qWL8mI5SJ72myOkCois0CGjxmRyE89UG5sA+ipfUQW9Mty5DyhsT
   5FHyGPHffC0LTJCGtmvtLwgM/8s65xfN89c/nREYnuL9ZgKEOs2tzu+Fy
   VOewckhY3KdBqfozO12pb/kvevzYUOH4mxp704b8hacvM/4cahaRzS1v+
   0ojhI3ZYYP4WQS+VQPVIclrIFOtmgi/7bEulkTiLTH5QLFOsK3zblKDMR
   w==;
X-IronPort-AV: E=Sophos;i="5.56,508,1539648000"; 
   d="scan'208";a="19745831"
IronPort-PHdr: =?us-ascii?q?9a23=3AFiqkvRI4HWrcvL+yPdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKvTzrarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cSE+YNOOBVpJT/qVQTtxuzHRSiCv3hyjFIhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXbOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCqF5tQsjuVN4pwQs46WWFnpjs1yr0ctp?=
 =?us-ascii?q?6nZiQF1JMnxxvZZveacIaI+gruWPueLDp3nn5oeK+ziwys/UWv1OHwTNS43V?=
 =?us-ascii?q?BXpSRfiNbMrGoC1xnL58iCTfty41mu1C6U1wDW9uFEOUc0lbfHK5I5wr4/iJ?=
 =?us-ascii?q?4TsUPbEy/qgkr2lq6Wdlg/+uSy9+TmYqnppp+bN4NujAHxLr8uldClDeQ9Mw?=
 =?us-ascii?q?gOW3CX+eW61LL94U30WKhGg/I5n6XDsJ3WON4XqrC2DgNLyIov9g6zDzK839?=
 =?us-ascii?q?QZmXkHIkhFeBWCj4XxIFHBPev4AOyjg1WsjDhrx/fGMqfnApXWNHfPirjhfb?=
 =?us-ascii?q?Fj60JE0go80chf545ICrEGOP/zQlX+tMHcDhIiKwy72fvnCNFk2oMbXmKPBb?=
 =?us-ascii?q?WZP73IvVCU4eIvJvGGZJUJtzblN/gl+/nugGc+mV8Yeqmpxp0XZ2qkEft4OE?=
 =?us-ascii?q?iZe2TjjcoBEWgQogoyVvDliFqHUTRLfXa9Q7o85i0nCIKhFYrDXZ6igLiA3C?=
 =?us-ascii?q?e9A51XaXtLCk6DEXj2bYWIQfQMZzyIIs9njDMEUaKtS4g71RGhrAX60aZoLv?=
 =?us-ascii?q?LI+i0EspLuzNx15+zVlREv+j14Ft6S03yQQGF1gmMFXCU2075irkx90FiDzb?=
 =?us-ascii?q?J0jOBfFdxW//lJSBs1NYbAz+xmDND/Qh/Of9mTR1aiWdWmASo8TsgvzNATY0?=
 =?us-ascii?q?ZyAcmiggrf0CqtBr9G34CMUaQ976aU+n/2Pcs1n27Pya0Jl1A7Ro5KMmq8i+?=
 =?us-ascii?q?h08A2FQ8bulUmDmqTiUKMH2ifG+WTLmW2Lu1peWQV9eb/IUXAWeg3dqtGvtW?=
 =?us-ascii?q?3YSLr7MqgqKgtMz4a5L6JObtD4xQFdSOzLJMXVY2X3nXy5QxmP2OXfP8LRZ2?=
 =?us-ascii?q?wB0XCFWwA/mAcJ8CPDbFFmCw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BEAQBEdUdc/wHyM5BjGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?WZLBDMnhAGUBkwBAQEBAQEGgQgIJYkzjmKBZzAIAYRAAoJtIjgSAQMBAQEBA?=
 =?us-ascii?q?QECAWwcDII6KQGCZgEBAQECASMVQRALGAICJgICVwYBDAYCAQGCXz8BgXQFC?=
 =?us-ascii?q?A+tRoEvhUOEaAWBC4s2F3iBB4E4DIIqNYMeBBiBL4MhglcCiVAVhiVJOVaQP?=
 =?us-ascii?q?gmHJIpxBhiBZohmh0iKBIUcjVohgVYrCAIYCCEPgyeCJxeDS4pxIQMwAYEEA?=
 =?us-ascii?q?QGKEAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Jan 2019 19:57:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0MJvOPF007409;
        Tue, 22 Jan 2019 14:57:25 -0500
Subject: Re: [PATCH v2] selinux: log invalid contexts in AVCs
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>
References: <20190121153605.26847-1-omosnace@redhat.com>
 <CAHC9VhRDSMeojFEFz+8rshiP4TmtoGuEuOK0AwZecyJ0SWN3Ug@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d2e83637-f9fa-9744-a9d0-407ad108db3a@tycho.nsa.gov>
Date:   Tue, 22 Jan 2019 15:00:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRDSMeojFEFz+8rshiP4TmtoGuEuOK0AwZecyJ0SWN3Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/22/19 2:42 PM, Paul Moore wrote:
> On Mon, Jan 21, 2019 at 10:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> In case a file has an invalid context set, in an AVC record generated
>> upon access to such file, the target context is always reported as
>> unlabeled. This patch adds new optional fields to the AVC record
>> (srawcon and trawcon) that report the actual context string if it
>> differs from the one reported in scontext/tcontext. This is useful for
>> diagnosing SELinux denials involving invalid contexts.
>>
>> To trigger an AVC that illustrates this situation:
>>
>>      # setenforce 0
>>      # touch /tmp/testfile
>>      # setfattr -n security.selinux -v system_u:object_r:banana_t:s0 /tmp/testfile
>>      # runcon system_u:system_r:sshd_t:s0 cat /tmp/testfile
>>
>> AVC before:
>>
>> type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file permissive=1
>>
>> AVC after:
>>
>> type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 trawcon=system_u:object_r:banana_t:s0 tclass=file permissive=1
> 
> I would like us to add new fields at the end of existing records; the
> recent audit config changes are a bit of a special case as discussed
> previously.
> 
> Also, under what cases would we ever see a srawcon field?  This is
> only going to happen if we have a running process whose domain is
> removed during a policy reload, correct?  I'm find with including this
> for the sake of completeness, but I would mention this in the patch
> description for the next revision.

Technically could occur on other permission checks where the source 
context isn't a process context, e.g. filesystem associate check 
(scontext/srawcon is a file context), socket checks (scontext/srawcon is 
a socket context, which may not correspond to any running process if 
passed to another or using /proc/self/attr/sockcreate), msgq enqueue 
(scontext/srawcon is context of message).  Common property is that the 
context had to have been valid at the point it was converted to a SID 
and then invalidated by a policy reload.  In contrast, trawcon can occur 
for file contexts read from the filesystem that were never valid under 
any policy loaded into the kernel since boot.

> 
>> Cc: Daniel Walsh <dwalsh@redhat.com>
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1135683
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>> ---
>>
>> v2: Rename fields to "(s|t)rawcon".
>>
>>   security/selinux/avc.c | 49 +++++++++++++++++++++++++-----------------
>>   1 file changed, 29 insertions(+), 20 deletions(-)
>>
>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>> index 9b63d8ee1687..df5490db575b 100644
>> --- a/security/selinux/avc.c
>> +++ b/security/selinux/avc.c
>> @@ -165,6 +165,32 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
>>          audit_log_format(ab, " }");
>>   }
>>
>> +static void avc_dump_sid(struct audit_buffer *ab, struct selinux_state *state,
>> +                        u32 sid, char type)
>> +{
>> +       int rc;
>> +       char *context, *rcontext;
>> +       u32 context_len, rcontext_len;
>> +
>> +       rc = security_sid_to_context(state, sid, &context, &context_len);
>> +       if (rc) {
>> +               audit_log_format(ab, "%csid=%d ", type, sid);
>> +               return;
>> +       }
>> +
>> +       audit_log_format(ab, "%ccontext=%s ", type, context);
>> +
>> +       /* in case of invalid context report also the actual context string */
>> +       rc = security_sid_to_context_force(state, sid, &rcontext,
>> +                                          &rcontext_len);
>> +       if (!rc) {
>> +               if (strcmp(context, rcontext))
>> +                       audit_log_format(ab, "%crawcon=%s ", type, rcontext);
>> +               kfree(rcontext);
>> +       }
>> +       kfree(context);
>> +}
>> +
>>   /**
>>    * avc_dump_query - Display a SID pair and a class in human-readable form.
>>    * @ssid: source security identifier
>> @@ -174,28 +200,11 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
>>   static void avc_dump_query(struct audit_buffer *ab, struct selinux_state *state,
>>                             u32 ssid, u32 tsid, u16 tclass)
>>   {
>> -       int rc;
>> -       char *scontext;
>> -       u32 scontext_len;
>> -
>> -       rc = security_sid_to_context(state, ssid, &scontext, &scontext_len);
>> -       if (rc)
>> -               audit_log_format(ab, "ssid=%d", ssid);
>> -       else {
>> -               audit_log_format(ab, "scontext=%s", scontext);
>> -               kfree(scontext);
>> -       }
>> -
>> -       rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
>> -       if (rc)
>> -               audit_log_format(ab, " tsid=%d", tsid);
>> -       else {
>> -               audit_log_format(ab, " tcontext=%s", scontext);
>> -               kfree(scontext);
>> -       }
>> +       avc_dump_sid(ab, state, ssid, 's');
>> +       avc_dump_sid(ab, state, tsid, 't');
>>
>>          BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
>> -       audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
>> +       audit_log_format(ab, "tclass=%s", secclass_map[tclass-1].name);
>>   }
>>
>>   /**
>> --
>> 2.20.1
> 

