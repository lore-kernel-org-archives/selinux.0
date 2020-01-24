Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D1CC32771
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 14:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1F6214AF
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 14:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lakong7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405008AbgAXOUn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:20:43 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:36763 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404965AbgAXOUm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 09:20:42 -0500
X-EEMSG-check-017: 48456298|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,357,1574121600"; 
   d="scan'208";a="48456298"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 14:20:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579875640; x=1611411640;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KdohOk+O52K5iJTwsNkGtSePcVxc5DHaOA9fLXWKQqE=;
  b=lakong7O8tQ1zhMPSqFM98kmi9IxoHnUxw5LBXdxTM5qrGZa4zx1aMJf
   84amoDpPKWAFN14c7ZIAn4pxKGEg/Sf7FN5lzqvrCQCdreDOu+jhaLkXG
   CbazbZVzbJTATjEUmL9YqTpQAOVPWZRjfgcTteFIn9jDfoAIAJD2Hi8Ud
   N6aNSawjh14XDHf7Sxne6inLstb4prFfsUliav1SzTlp7tKNh2jQ6TwnC
   Zm9NK0tT8L1nvuukyunKZpMY0DkeXoge7uYaa/XP7UzjcLabbFYSlvqk6
   xRWkfm1iSItHS/pScnX54YJqMg5aqRODSynaQ2v9Wu37HWEJ4lv7XyMov
   w==;
X-IronPort-AV: E=Sophos;i="5.70,357,1574121600"; 
   d="scan'208";a="38204156"
IronPort-PHdr: =?us-ascii?q?9a23=3AUmRdABQy9dWjjwABkUMrBE/8NNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YRSDt8tkgFKBZ4jH8fUM07OQ7/m8HzZcqsvQ+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTvHdFdOtayGNsKFmOmxrw+tq88IRs/ihNtf8t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks03O?=
 =?us-ascii?q?Q7FQHNwRIuEdQAvn/JqNn5LakfXOSwwKTO0D7Nbe5Z2S3l5YbVbB4hr/GCU7?=
 =?us-ascii?q?F+f8XfxkYgFR/KgFqLpIz5PT6YzPgBv3SV4udiU++klm4pqxt2ojiq3soil5?=
 =?us-ascii?q?XJiZwNylDE6yp5xps+K8C9SEFhZd6kFIVftiGHPIZxWcMtXnpotT0myrwGpZ?=
 =?us-ascii?q?G7fC8KxI4hxx7EcfOLaYeI4hX9VOuIJzpzmXFreKqnihqv/kWtxffwW8mp3F?=
 =?us-ascii?q?pQsCZIncfAumoQ2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6Iwlo?=
 =?us-ascii?q?IUsUTeAi/6gEX2g7GSdkUj4uWo9/7oYq/npp+BLI94kAD+MqIgmsy4GuQ3LB?=
 =?us-ascii?q?QBU3KH+eW8yLLj/Ur5TK9MjvIqianWrIrWJcEapq69GwNV04Aj5AijDzq+zd?=
 =?us-ascii?q?gVknYKIEhFdR6alYTlJV7DLO7iAfuim1islS1kx/HCPr3vGJXNKX3Dna/6fb?=
 =?us-ascii?q?lg8E5R0xYzzNBD6JJUDbENOvTzWlTru9DCAR85NBK0z/79CNphzoMeRX6PAq?=
 =?us-ascii?q?iBPazOq1CI/fwgIumXaY8OpDn9K+Iq5+PgjX89h1AdZ7Cl0ocNZ3yiAvtmJE?=
 =?us-ascii?q?CZa2L2gtgdCWcKohY+TOvyhVKeSzFTfGi9XqIm6jEgFI2mDZ3MRp2jgLyFwi?=
 =?us-ascii?q?i7BIZbZmFAClCQD3joc5+IVOsLaCKXOsVhiCALVaC9S4890hGjrA36y79gLu?=
 =?us-ascii?q?rO4C0YtInj2cNz5+LJkBE96z10A96a02GXQGF+hnkISCMu3KBjvUx9zU+O0a?=
 =?us-ascii?q?x5g/xeCNxS6OpFUhwkOpHA0ux6EdHyWh7Bf9uQTVamRcipASw1Tt0v2NIOfU?=
 =?us-ascii?q?l9FMu4jhzZ3CqlHaUVl7qVC5ww6K7c2GLxJ8llwXbcyKYhl0UmQtdINWC+na?=
 =?us-ascii?q?5w6QzTB4/Pk0WEmKenbroc3CHT+2eZ12aOv19XUBR2UarbWXATfEzWrc725k?=
 =?us-ascii?q?naVb+hFawnMhddyc6FMqZKacPmgktdRPj/P9TeZGGxlnysChaI3LOMa4/qe2?=
 =?us-ascii?q?QA3CXYEkQElBoT/XmePwgkGiihu37eDCBpFV/3YUPs9ul+qHWhQk82yAGKb1?=
 =?us-ascii?q?du17yu+hELg/yRUO8c0agCuCcmrTV0HUqy0MjSC9aauwVhe6Bca8sn4FhbzW?=
 =?us-ascii?q?LZqxB9Ppu4IqB6mFEedQt3v17v1xVxE4lAktYlrGkszAVsLaKVy1JBeyqc3Z?=
 =?us-ascii?q?D3JL3YNHP+/Au1ZK7Vx1HeysyZ9r0J6PsmsVnjvhmpHFI483p7y9lVz2ec5p?=
 =?us-ascii?q?LSAQoKS53xT0I3+gNip77Afyk945rY1XhrMamzqD/NxcglC/ciyhalLJ9jN/?=
 =?us-ascii?q?avHRT/AoUhDMinNeIulkLhOhkNJ+1D3LU/P8q7ef+LwuugNaBrmzfwySxM6Z?=
 =?us-ascii?q?twwwSX/Cp1V+DM0owtwveE0w/BXDD5yB+jt8ftg4FfTTcbG2e+jy/+C8oZYq?=
 =?us-ascii?q?x0YJZOEmqlPte22sQ7gpnhRnpV3ECsCklA28KzfxeWKVvn0kkYzkkToHq6iQ?=
 =?us-ascii?q?OmwDFu1TIktKyS2GrJ2euxWgAAPztwWGR6jVrqabOxhtQeUVngOxMljzO59E?=
 =?us-ascii?q?36wO5dv605IG7NFxQbNxPqJn1vB/Pj/oGJZNRCvdZx6nRa?=
X-IPAS-Result: =?us-ascii?q?A2BsAgCu/Cpe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBKJA4Z5BoE3iW+RSQkBAQEBAQEBAQE3AQGEQAKCRjgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIxVBBQsLGAICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CVwUgrAh1gTKFSoM4gT6BDiqMMXmBB4E4D4IvLj6BF4ZCgl4EllNhRpdeg?=
 =?us-ascii?q?kOCTJNlBhuafI5gnR4igVgrCAIYCCEPgydQGA2IDReOQSMDMI1WAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 Jan 2020 14:20:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OEJma4238676;
        Fri, 24 Jan 2020 09:19:49 -0500
Subject: Re: [PATCH v14 02/23] LSM: Create and manage the lsmblob data
 structure.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-3-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4280042d-a9e1-41ad-b547-b2e3f0e2f767@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 09:21:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200124002306.3552-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/23/20 7:22 PM, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
> 
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
> 
> The audit rules data is expanded to use an array of
> security module data rather than a single instance.
> Because IMA uses the audit rule functions it is
> affected as well.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index b2f87015d6e9..91662325e450 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -102,6 +102,11 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
>   };
>   
> +static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
> +	.lsm = "landlock",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   static int __init lockdown_lsm_init(void)
>   {
>   #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)

You really want landlock merged, don't you?

