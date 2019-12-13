Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E21AC43603
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A4424788
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HvDtyyS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfLMOov (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:44:51 -0500
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:42807 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfLMOov (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 09:44:51 -0500
X-EEMSG-check-017: 61127807|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="61127807"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Dec 2019 14:44:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576248278; x=1607784278;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=V08vmwYKY7dHXnNq/BlnBla4LqHPzdgvxV9xUj0JqkQ=;
  b=HvDtyyS7A1wwUg/ekPIdbn7GZuO92UDi3xYMwEBg/Q4BWdSiExNZE6xS
   Lu2syIgLG0ff10mNp25kqpDuNgHdO9UktBfWXbzkLxEZPbZfeZtvuVh2/
   jnWmIMNacG5KhRh65gPheflZK8XGHLswlpl6Ps6zXu0GFGqB0AaRNCyRO
   IuazL0C8mV0RBpBT5Fos1inkz82FuCOVtU3P5Q2BvSVYsIg8KPj4+kkjE
   0sM0y3SzTI/5Sqqo6zfC/1ZHrdGd61khOLdvDJi2QnzbQpLDK6j+j575u
   LB/hWYV1bbO0sOqXAJ7HOx/vNZDfOY62Se3WL3IyojNrc2aHYQFYnC+OE
   g==;
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="31079681"
IronPort-PHdr: =?us-ascii?q?9a23=3A1XZbshXuGRvWkdPmn+9hGb6hbQjV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBOCt8tkgFKBZ4jH8fUM07OQ7/m7HzVRsN3f7jgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajI9mJ6o+yx?=
 =?us-ascii?q?bEo2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+27ZkMxwiL9QrgynqRJx3oXYZJiZOfp6c6/Ye94RWG?=
 =?us-ascii?q?hPUdtLVyFZH42ycYUPAeoCM+hWoYbyqFkBogexCwS3GOPiyCVFimPq0aA00e?=
 =?us-ascii?q?ksFxzN0gw6H9IJtXTZtMj7NLsMXuCtzKnH0zPDZO5L1zf48ofIdhQhru+MXL?=
 =?us-ascii?q?ltdsfR0lQgFxjeg1WMqY3qIzOV1uMXv2id9OpvT/iji2EgqwFvuzWiwNonhI?=
 =?us-ascii?q?rRho8N11zJ+ip0zJw1KNGlUkJ3f9GpHIVKuy2HMYZ9X9ksTHtyuCkgz70LoZ?=
 =?us-ascii?q?u7fC8Xx5s53xPfcPmHc5SQ4hLkSeaRPS90hHJ7d7K7gBa/6VSgxffmVsm1zV?=
 =?us-ascii?q?ZKtTBJktjKtnAD0BzT8daIRedn8ke92TeAywDT6uZeLUAyiaXbMIIuzqQ1lp?=
 =?us-ascii?q?oStUTPBi72mEPog6+Kbkgo5+el5uv9brjmu5OQLZF4hw7gPqg0h8CzGeE4PR?=
 =?us-ascii?q?IPX2if9+S8zrrj/UjhTbVRk/I2ibLUsIzaJMsHpq65BBVZ0oA46xmlFTum39?=
 =?us-ascii?q?MYnWcfIFJfZB2Hl5TpO03JIP3gFfewmUmskDNwyvDeJLLhH5HNImHGkLfmer?=
 =?us-ascii?q?Z98VBTxBAvwtBY4pJeEqsBL+7rWk/tqNzYCQc0MxeqzObjCdV90J4eWG2UD6?=
 =?us-ascii?q?+HP6Pdr0WI6vgsI+aSfo8VvijyK/w/6/7pl385lkcXfbO10psPdHC4AvNmLl?=
 =?us-ascii?q?2eYXrphdcBCmEKsRAiQ+P0k1CCSyBcaGuyX60m+jE3Ep6pDYDGRtPlvLvUxC?=
 =?us-ascii?q?6mGrVOb31CT1WLFm3lMY6DXqQiciWXd/R9nyQEWL7pcIoo0RWjpUeu0LZ8Bv?=
 =?us-ascii?q?bF8S0f85T43Z564POFxkJ6ziB9E8nIizLFdGpzhG5dAmJn0Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BbAABDo/Nd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQDiQOGbgEBAQEBAQaBEiWJaZFGCQEBAQEBAQEBA?=
 =?us-ascii?q?TcBAYRAAoIzOBMCEAEBAQQBAQEBAQUDAQFshQsHMYI7KYJ6AQEBAQIBIwQRQ?=
 =?us-ascii?q?RALGAICJgICVxMGAgEBgl8/glMFIKwZdX8zhU+DNIFIgQ4ojDJ5gQeBOAwDg?=
 =?us-ascii?q?l0+h1mCXgSWImFGlyaCOoI8kzcGG4JCjDeLSC2qbCKBWCsIAhgIIQ+DJ1ARF?=
 =?us-ascii?q?IsMghIXjkEjAzCQGwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Dec 2019 14:44:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBDEiKZx234540;
        Fri, 13 Dec 2019 09:44:21 -0500
Subject: Re: [RFC PATCH] selinux: clean up selinux_enabled/disabled
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
References: <20191213143218.149544-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7e45e92b-0883-c65e-3809-ecdc8148127b@tycho.nsa.gov>
Date:   Fri, 13 Dec 2019 09:45:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213143218.149544-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/13/19 9:32 AM, Stephen Smalley wrote:
> Rename selinux_enabled to selinux_enabled_boot to make it clear that
> it only reflects whether SELinux was enabled at boot.  Further make it
> unconditionally read-only-after-init and stop needlessly clearing it
> in selinux_disable() since it is only used to skip other SELinux
> initialization code.
> 
> Wrap the disabled field in the struct selinux_state with
> CONFIG_SECURITY_SELINUX_DISABLE since it is only used for
> runtime disable.
> 
> Introduce a selinux_is_enabled() static inline that tests both
> selinux_enabled_boot and selinux_state.disabled as appropriate
> to determine whether SELinux is in an enabled state.  Use this function
> in the MAC_STATUS audit log message in place of selinux_enabled(_boot).
> It is unclear why this information is included in that audit record
> since selinuxfs is never registered at all if !selinux_enabled_boot
> and is unregistered in the runtime disable case, so this code should never
> be reached if SELinux is disabled.  It is also unclear why it is logged
> twice under enabled/old-enabled since setenforce does not change its
> value. Regardless, we leave it as is for compatibility.

Just noticed that there is another AUDIT_MAC_STATUS audit log in 
sel_write_disable() that uses hardcoded 0, 1 for enabled and old-enabled 
values in the audit record.  Don't know if it should also use 
selinux_is_enabled(), or if we should likewise just hardcode the values 
used in the sel_write_enforce() case (to 1, 1, since this code shouldn't 
be reachable if SELinux were disabled).  If the latter, we don't need 
selinux_is_enabled() at all.

> 
> As a further cleanup, we could make selinux_enabled_boot __initdata if
> we were to stop testing it for the MAC_STATUS audit record since that
> is the only non-init code that uses it.  The selinux_is_enabled()
> static inline function could be reduced to only testing
> selinux_state.disabled or always being 1 if
> CONFIG_SECURITY_SELINUX_DISABLE=n, with it being implicit that we would
> not have reached the test if selinux_enabled_boot was not 1.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   security/selinux/hooks.c            | 10 ++++------
>   security/selinux/ibpkey.c           |  2 +-
>   security/selinux/include/security.h | 16 +++++++++++++++-
>   security/selinux/netif.c            |  2 +-
>   security/selinux/netnode.c          |  2 +-
>   security/selinux/netport.c          |  2 +-
>   security/selinux/selinuxfs.c        |  4 ++--
>   7 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 40ec866e48da..7984e72312da 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -123,13 +123,13 @@ __setup("enforcing=", enforcing_setup);
>   #define selinux_enforcing_boot 1
>   #endif
>   
> -int selinux_enabled __lsm_ro_after_init = 1;
> +int selinux_enabled_boot __ro_after_init = 1;
>   #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
>   static int __init selinux_enabled_setup(char *str)
>   {
>   	unsigned long enabled;
>   	if (!kstrtoul(str, 0, &enabled))
> -		selinux_enabled = enabled ? 1 : 0;
> +		selinux_enabled_boot = enabled ? 1 : 0;
>   	return 1;
>   }
>   __setup("selinux=", selinux_enabled_setup);
> @@ -7202,7 +7202,7 @@ void selinux_complete_init(void)
>   DEFINE_LSM(selinux) = {
>   	.name = "selinux",
>   	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
> -	.enabled = &selinux_enabled,
> +	.enabled = &selinux_enabled_boot,
>   	.blobs = &selinux_blob_sizes,
>   	.init = selinux_init,
>   };
> @@ -7271,7 +7271,7 @@ static int __init selinux_nf_ip_init(void)
>   {
>   	int err;
>   
> -	if (!selinux_enabled)
> +	if (!selinux_enabled_boot)
>   		return 0;
>   
>   	pr_debug("SELinux:  Registering netfilter hooks\n");
> @@ -7318,8 +7318,6 @@ int selinux_disable(struct selinux_state *state)
>   
>   	pr_info("SELinux:  Disabled at runtime.\n");
>   
> -	selinux_enabled = 0;
> -
>   	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
>   
>   	/* Try to destroy the avc node cache */
> diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
> index de92365e4324..f68a7617cfb9 100644
> --- a/security/selinux/ibpkey.c
> +++ b/security/selinux/ibpkey.c
> @@ -222,7 +222,7 @@ static __init int sel_ib_pkey_init(void)
>   {
>   	int iter;
>   
> -	if (!selinux_enabled)
> +	if (!selinux_enabled_boot)
>   		return 0;
>   
>   	for (iter = 0; iter < SEL_PKEY_HASH_SIZE; iter++) {
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 8c0dbbd076c6..49737087ad33 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -69,7 +69,7 @@
>   
>   struct netlbl_lsm_secattr;
>   
> -extern int selinux_enabled;
> +extern int selinux_enabled_boot;
>   
>   /* Policy capabilities */
>   enum {
> @@ -99,7 +99,9 @@ struct selinux_avc;
>   struct selinux_ss;
>   
>   struct selinux_state {
> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
>   	bool disabled;
> +#endif
>   #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
>   	bool enforcing;
>   #endif
> @@ -136,6 +138,18 @@ static inline void enforcing_set(struct selinux_state *state, bool value)
>   }
>   #endif
>   
> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> +static inline bool selinux_is_enabled(struct selinux_state *state)
> +{
> +	return selinux_enabled_boot && !state->disabled;
> +}
> +#else
> +static inline bool selinux_is_enabled(struct selinux_state *state)
> +{
> +	return selinux_enabled_boot;
> +}
> +#endif
> +
>   static inline bool selinux_policycap_netpeer(void)
>   {
>   	struct selinux_state *state = &selinux_state;
> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> index e40fecd73752..15b8c1bcd7d0 100644
> --- a/security/selinux/netif.c
> +++ b/security/selinux/netif.c
> @@ -266,7 +266,7 @@ static __init int sel_netif_init(void)
>   {
>   	int i;
>   
> -	if (!selinux_enabled)
> +	if (!selinux_enabled_boot)
>   		return 0;
>   
>   	for (i = 0; i < SEL_NETIF_HASH_SIZE; i++)
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 9ab84efa46c7..dff587d1e164 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -291,7 +291,7 @@ static __init int sel_netnode_init(void)
>   {
>   	int iter;
>   
> -	if (!selinux_enabled)
> +	if (!selinux_enabled_boot)
>   		return 0;
>   
>   	for (iter = 0; iter < SEL_NETNODE_HASH_SIZE; iter++) {
> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index 3f8b2c0458c8..de727f7489b7 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -225,7 +225,7 @@ static __init int sel_netport_init(void)
>   {
>   	int iter;
>   
> -	if (!selinux_enabled)
> +	if (!selinux_enabled_boot)
>   		return 0;
>   
>   	for (iter = 0; iter < SEL_NETPORT_HASH_SIZE; iter++) {
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index dd7bb1f1dc99..3b8397ed87f3 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -172,7 +172,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>   			new_value, old_value,
>   			from_kuid(&init_user_ns, audit_get_loginuid(current)),
>   			audit_get_sessionid(current),
> -			selinux_enabled, selinux_enabled);
> +			selinux_is_enabled(state), selinux_is_enabled(state));
>   		enforcing_set(state, new_value);
>   		if (new_value)
>   			avc_ss_reset(state->avc, 0);
> @@ -2105,7 +2105,7 @@ static int __init init_sel_fs(void)
>   					  sizeof(NULL_FILE_NAME)-1);
>   	int err;
>   
> -	if (!selinux_enabled)
> +	if (!selinux_enabled_boot)
>   		return 0;
>   
>   	err = sysfs_create_mount_point(fs_kobj, "selinux");
> 

