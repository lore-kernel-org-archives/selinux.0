Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62A8C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736E521D7D
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 19:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hgimmIYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLRTMF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:12:05 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:55407 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLRTME (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 14:12:04 -0500
X-EEMSG-check-017: 37143007|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="37143007"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 19:12:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576696322; x=1608232322;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GgVRHkXgTTX+Q9n18HEwM9oVnW/gdL84rpy6A9dg5zc=;
  b=hgimmIYIoAlPy74LW8/UYKSquenAN09IdbDxRjQe4SyzE/U6L6y5knWp
   biVZPNuEWLYwpuemmbNns2jmPjMkhjDhsX+Wrx0U/5Gqv27ZN2/JLBDTB
   o/Xg9QaKGuuvgsNPS8qu3e3eqmZy2jOJZOm3auGJaIRufYlieMHlbudZO
   Sh7RgiBI5lIX6H1QhVHj0CwI/SfTRirVcWMYRr7a3YxJolU1VE5R5mJ7E
   p2sdFoz/i94xgjJgd7CIzhSsBW11a1g54BRymIBIGMZ6n4UfC+/jyRzjO
   7ohAgjCAVcFHMVGDUvxS5THi44SNCq+XNpjCQ1xaDhcoznJ/uuJehjNyA
   A==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="31250812"
IronPort-PHdr: =?us-ascii?q?9a23=3ArM0Z1hDJAbeuirLOHULzUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP3/oMiwAkXT6L1XgUPTWs2DsrQY0rGQ6fixEjVZv96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txvdutUSjIdtN6o91x?=
 =?us-ascii?q?rEqWZUdupLwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q6FGATo/K2?=
 =?us-ascii?q?w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWT?=
 =?us-ascii?q?mn8qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSX?=
 =?us-ascii?q?ddUspNUiBMBI2zb5ELD+EcI+hWqYfzrEYKoRenGwWhAObjxzlVjXH0wKI6yf?=
 =?us-ascii?q?wsHxzG0gI+EdIAs3rao9v6O6gQTe+7w7LFzSnAYv5MxTvx9IbFfxInrPqRXb?=
 =?us-ascii?q?xwa83RyUw3Gg3YklWft5TlPzOL2eQLrmOV8u9gWviri24jtQ5woiWky8A3io?=
 =?us-ascii?q?bUnYIY0UzE9CVlz4Y1It20Ukh7YcW+H5dKuCGaMJV2T9okTmp1uyg60qULtY?=
 =?us-ascii?q?O0cSUF0pgqxwPTZ+aZf4WH/B7vTvudLDFlj3x/Yr2/nQy98U24x+35Ucm7zU?=
 =?us-ascii?q?hFozJektnJqnANzxvT6tWbSvdl/keuxzKP1wfL5+FYO080j6vbK4M6wrIql5?=
 =?us-ascii?q?oTt0rDHijtmErokKCabFkk++i05OTnZbXqvJmcOJNvig7iKKgun82/AeAgPg?=
 =?us-ascii?q?gPWWiU5/i82aX+8UD2T7hGlP07nrTDvJzEKskXuLS1DxJN3oYm8Rm/DjOm0N?=
 =?us-ascii?q?oCnXkAKVJIYAmHgJXyO1zVPPD5Deuwg1SrkDtxwfDGJafuDo/CLnjEjrftZa?=
 =?us-ascii?q?x95FJEyAov0dBf4IpZBa0bL/LoREDwtMfVDgQlPAy02ennFdt91ocAVmKVG6?=
 =?us-ascii?q?OWLLndvUWU6eIoJumGfJUVtyrlK/g5+/7uimc0lkMHcqmyw5QWaGq0Hu96LE?=
 =?us-ascii?q?WZe3Xsn9kBEWMUsQokV+HqiVuCUSJNaHa2Ra4z+jY7CIe+B4fZWo+tmKCB3D?=
 =?us-ascii?q?u8HpBOZGBGD1eMEW3yd4WFQPcBcySSLdVkkjMaVLitUYgh1QuhtAXi0bpoMv?=
 =?us-ascii?q?LU+jEEtZLkzNV14+zTlRcv9T17FsidyH+CQH1pnmMSRj82wKB+rVV4yleEzK?=
 =?us-ascii?q?d4nvhYGsJI6vNXXQc1K4Tcw/Z5C9/sQALBeMmGSFK8TtWhGzExQco7w8USbE?=
 =?us-ascii?q?ZlB9WikhfD0jKxA7ALk7yLBZo08r/T3nXqOcZ9xGjJ1LM7g1klXMRPL2umib?=
 =?us-ascii?q?B79wTJAI7JiUqZnb6wdasAxC7N6HuDzW2WsUFbTgF/T77FUmwYZkvRrtT0/V?=
 =?us-ascii?q?/NT7+0CbQgNwtByNOCKq5QZt3ul1VGS+/pOM7CbGKph2ewGRGIy6uObIrte2?=
 =?us-ascii?q?Ud2j/RCEoDkwAT53mGMxM+CTmno2/FEDNhD1TvY0Tq8el/tHy0VEs0wxuWYE?=
 =?us-ascii?q?1m0rq/4gQViuCES/MPwrIEvz8sqy1qE1a70NLWFtuApwx4cKVff9w9+lFH2n?=
 =?us-ascii?q?zdtwFmP5ysNqRihlkAcwtppU/uzA94CoZdkcgwtnwm1gxyJryC3FNDbzOSxY?=
 =?us-ascii?q?rwNaHPKmnu4BCvbLbb2knE39aL/qcC8+w4pE/+vAGtD0Yi9nJn095P03SC/J?=
 =?us-ascii?q?nFEA0SUZeiGnowojNzvLzLKhI254rJ23lhK+HguTbZ1sMBH+Alwwuue9pFda?=
 =?us-ascii?q?iNUgT1FpteT8OnM+E73UOibhsZMuRf7oY1Od+rc72N36vvdORlmyi8jH9v5o?=
 =?us-ascii?q?l430PK8DBzDqbM3pAY07SD0wCaTTbgnRKktczqnY1sez4fBCy8xDLiCYoXYb?=
 =?us-ascii?q?d9Oc4QBGOvJdCn7stxioSrWHNC8lOnQVQc15yHYx2XOmfh0BVQ2EJfmnmunS?=
 =?us-ascii?q?+13nQgiD0yhraO1yzJheL5fVwIPXAdFzoqtkvlPYXh14NSZ0OvdQV80UL/tE?=
 =?us-ascii?q?s=3D?=
X-IPAS-Result: =?us-ascii?q?A2DJAADhePpd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF2gW0gEiqEBIkDhlkGgRIlgQGIaZFFCQEBAQEBAQEBATcBAYRAAoI9O?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMECwEFQRAJAhgCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/glMlkhCbdH8ziRWBQYEOKIglhA15gQeBEScMA4IoNT6HWYJeB?=
 =?us-ascii?q?I04iHWBJ3eWPoI/gkOKJYklBhuaTi2OIZxfIoFYKwgCGAghDzuCbFAYDY0eF?=
 =?us-ascii?q?45BIwMwjy0BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2019 19:12:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIJBb2i104231;
        Wed, 18 Dec 2019 14:11:40 -0500
Subject: Re: [PATCH v12 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-24-casey@schaufler-ca.com>
 <56b96440-a304-42b6-1515-1ad2659b2581@tycho.nsa.gov>
Message-ID: <e7aa3b6f-cee1-6277-21dd-77a4db9bbc2b@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 14:12:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <56b96440-a304-42b6-1515-1ad2659b2581@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/18/19 1:28 PM, Stephen Smalley wrote:
> On 12/16/19 5:36 PM, Casey Schaufler wrote:
>> The getsockopt SO_PEERSEC provides the LSM based security
>> information for a single module, but for reasons of backward
>> compatibility cannot include the information for multiple
>> modules. A new option SO_PEERCONTEXT is added to report the
>> security "context" of multiple modules using a "compound" format
>>
>>          lsm1\0value\0lsm2\0value\0
>>
>> This is expected to be used by system services, including dbus-daemon.
>> The exact format of a compound context has been the subject of
>> considerable debate. This format was suggested by Simon McVittie,
>> a dbus maintainer with a significant stake in the format being
>> usable.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> cc: netdev@vger.kernel.org
> 
> Requires ack by netdev and linux-api.  A couple of comments below.

Also, have you tested this new interface?  I may be doing something 
wrong, but a trivial attempt to use SO_PEERCONTEXT with both SELinux and 
AppArmor enabled only appeared to return the SELinux portion of the 
label 
(selinux\0unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023\0), 
whereas /proc/self/attr/context returned a compound context (the same 
but with apparmor\0unconfined\n\0 appended).

> 
>> ---
> 
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 2bf82e1cf347..2ae10e7f81a7 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -880,8 +880,8 @@
>>    *    SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
>>    *    socket is associated with an ipsec SA.
>>    *    @sock is the local socket.
>> - *    @optval userspace memory where the security state is to be copied.
>> - *    @optlen userspace int where the module should copy the actual 
>> length
>> + *    @optval memory where the security state is to be copied.
> 
> This is misleading; it suggests that the caller is providing an 
> allocated buffer into which the security module copies its data. Instead 
> it is just a pointer to a pointer that is then set by the security 
> module to a buffer the module allocates.
> 
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 536db4dbfcbb..b72bb90b1903 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -181,7 +181,7 @@ struct lsmblob {
>>   #define LSMBLOB_NEEDED        -2    /* Slot requested on 
>> initialization */
>>   #define LSMBLOB_NOT_NEEDED    -3    /* Slot not requested */
>>   #define LSMBLOB_DISPLAY        -4    /* Use the "display" slot */
>> -#define LSMBLOB_FIRST        -5    /* Use the default "display" slot */
>> +#define LSMBLOB_COMPOUND    -5    /* A compound "display" */
> 
> I'm puzzled by the removal of LSMBLOB_FIRST by this patch; it suggests 
> it was never needed in the first place by the patch that introduced it. 
> But more below.
> 
>> diff --git a/security/security.c b/security/security.c
>> index d0b57a7c3b31..1afe245f3246 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -723,6 +723,42 @@ static void __init lsm_early_task(struct 
>> task_struct *task)
>>           panic("%s: Early task alloc failed.\n", __func__);
>>   }
>> +/**
>> + * append_ctx - append a lsm/context pair to a compound context
>> + * @ctx: the existing compound context
>> + * @ctxlen: size of the old context, including terminating nul byte
>> + * @lsm: new lsm name, nul terminated
>> + * @new: new context, possibly nul terminated
>> + * @newlen: maximum size of @new
>> + *
>> + * replace @ctx with a new compound context, appending @newlsm and @new
>> + * to @ctx. On exit the new data replaces the old, which is freed.
>> + * @ctxlen is set to the new size, which includes a trailing nul byte.
>> + *
>> + * Returns 0 on success, -ENOMEM if no memory is available.
>> + */
>> +static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char 
>> *new,
>> +              int newlen)
>> +{
>> +    char *final;
>> +    int llen;
>> +
>> +    llen = strlen(lsm) + 1;
>> +    newlen = strnlen(new, newlen) + 1;
>> +
>> +    final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
>> +    if (final == NULL)
>> +        return -ENOMEM;
>> +    if (*ctxlen)
>> +        memcpy(final, *ctx, *ctxlen);
>> +    memcpy(final + *ctxlen, lsm, llen);
>> +    memcpy(final + *ctxlen + llen, new, newlen);
>> +    kfree(*ctx);
>> +    *ctx = final;
>> +    *ctxlen = *ctxlen + llen + newlen;
>> +    return 0;
>> +}
> 
> You should likely take some precautions against integer overflows in the 
> above code?
> 
>> +
>>   /*
>>    * Hook list operation macros.
>>    *
>> @@ -2164,8 +2200,8 @@ int security_setprocattr(const char *lsm, const 
>> char *name, void *value,
>>       hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>>           if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>>               continue;
>> -        if (lsm == NULL && *display != LSMBLOB_INVALID &&
>> -            *display != hp->lsmid->slot)
>> +        if (lsm == NULL && display != NULL &&
>> +            *display != LSMBLOB_INVALID && *display != hp->lsmid->slot)
>>               continue;
>>           return hp->hook.setprocattr(name, value, size);
>>       }
> 
> Is this a bug fix that should be folded into the earlier patch that 
> introduced it?
> 
>> @@ -2196,7 +2232,7 @@ int security_secid_to_secctx(struct lsmblob 
>> *blob, struct lsmcontext *cp,
>>        */
>>       if (display == LSMBLOB_DISPLAY)
>>           display = lsm_task_display(current);
>> -    else if (display == LSMBLOB_FIRST)
>> +    else if (display == 0)
>>           display = LSMBLOB_INVALID;
>>       else if (display < 0) {
>>           WARN_ONCE(true,
> 
> Why is it necessary to re-map display 0 in this manner? Previously if 
> display 0 was specified, it would require it to match the lsmid->slot 
> value.  Won't it match anyway?
> 
>> @@ -2246,6 +2282,15 @@ void security_release_secctx(struct lsmcontext 
>> *cp)
>>       struct security_hook_list *hp;
>>       bool found = false;
>> +    if (cp->slot == LSMBLOB_INVALID)
>> +        return;
>> +
>> +    if (cp->slot == LSMBLOB_COMPOUND) {
>> +        kfree(cp->context);
>> +        found = true;
>> +        goto clear_out;
>> +    }
>> +
> 
> If you re-order your pr_warn() below with your memset() to address the 
> earlier comment, you'll end up trying to print the freed memory.  Not a 
> problem if you just drop the pr_warn() altogether.

