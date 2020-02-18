Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79D9C34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 18:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBCB208C4
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 18:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Ikn5/051"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgBRSSG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:18:06 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:38498 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBRSSG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 13:18:06 -0500
X-EEMSG-check-017: 57473143|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="57473143"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 18:18:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582049884; x=1613585884;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Tpe34GwD0qZbVLtcAjkPclTN5c6V7/yfT/419gfXZRk=;
  b=Ikn5/0513WMy82oIZne/WQHC+QA3++bCs72N+KIYMtbWJTKdt91Y7hO0
   HZ4LY6mgGxX0X8yhXvAafgB30F9/eB2QWg5E9Fe8eigXF01VuKEjAerxr
   2WSjdF97AesvR6CzJObCb4f3Wuy/7ofPhmRidJUN2jCLuoPmpN1rnAoaf
   EHVD63gWhz+cQmal03ZEFwgm3ephElevbmlz0R2vU3QIHbuC88SwqYih/
   lhEkT9SUlumY4FrHlDSjQYFVVOi0/YEipoT1D99Tqz8G1DqNYujIRfIWQ
   yHn8XFRbwN3LzW7gMeEYmOnE39n8N46bOcsiQwGvSxnXLiVl328MiaGnR
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="39242330"
IronPort-PHdr: =?us-ascii?q?9a23=3A8q/mihRnWUJlPSWsy+ZdXwK5dNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YByHt8tkgFKBZ4jH8fUM07OQ7/m8HzNQqs/Y6TgrS99laV?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4lvJ6U+xh?=
 =?us-ascii?q?fUv3dEZvldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U7NVCSktPn?=
 =?us-ascii?q?426sP2qxTNVBOD6XQAXGoYlBpIGBXF4wrhXpjtqCv6t/Fy1zecMMbrUL07Qz?=
 =?us-ascii?q?Wi76NsSB/1lCcKMiMy/W/LhsBsiq9QvQmsrAJjzYHKfI6VNeJ+fqLDctMcWW?=
 =?us-ascii?q?pBRdtaWyhYDo+hc4cDE+8NMOBWoInno1sFsAWwCw+iCujyzjNEn2H60Kk/3+?=
 =?us-ascii?q?knDArI3hEvH8gWvXrJstv1OqccX+O7wqbGwjrMbe9Z1zjm5YjUcB0su+2AUa?=
 =?us-ascii?q?5+fMfTz0QkCgPLjk+XqYzgJz6by/gNvHaD7+pgS+2vjXMspRx0oje1wscsjp?=
 =?us-ascii?q?fGh4IIwV3D7iV23Z01KMakSE97fdGkEJxQuzucN4ttWMwuWW5ouCEkyrAfv5?=
 =?us-ascii?q?OwYSsEyIw/yhLCZPGKfJKE7xL+WOqLPzt1i2xpdKiiixu07EOu0PfzVtOu31?=
 =?us-ascii?q?ZPtidFl97MuW0T2BHL8ciHT+d9/l+m2TaSywDf8uFELl4wlarcM5Mh3qQ/lo?=
 =?us-ascii?q?ASsUTeBS/6gkT2jKmYdkUj4ein9fjobq/6pp6cK4B0igb+Pr4omsOjGuQ3Lh?=
 =?us-ascii?q?ICX22a+eS4zLHj/Ev5T6tWjvAuj6XUv5/XKd4bq6KkGQNZzIku5wilAzu7yN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLejjDfiimFShiytrxvDaMb3hBZXBNH7DkKz7cr?=
 =?us-ascii?q?pn5E5czxQzwchF551IErEBPO7zWkjpudPEFBA5KBK7wub8BdVmyoweWXiAAr?=
 =?us-ascii?q?KXMKPWr1CI/PsjLPWWa4MPpDn9LP0l7eb0jXAlgV8dYbWp3ZwPZX+kBPtmOF?=
 =?us-ascii?q?uWYHr2jtcaDWgKvhAxTPHkiF2GTzFTfW2/X6M65jEnFo2mCZ3PSZyqgLyExC?=
 =?us-ascii?q?27BIFZZnhaClCQFnflb4eEW/ILaCKIOM9hkycEWKOnS4A70BGhqg76x6BgLu?=
 =?us-ascii?q?rO9S0SrYjj28Rt5+3PiREy8iR5D8Cc02GLUmF1kXoERyQo069jvEx90FaD0b?=
 =?us-ascii?q?R4gvBBENxT4O5GUho+NZHC1OF6Fd/yVRzbftuTS1apXM+mATcvQdI12dMOZF?=
 =?us-ascii?q?x9G9q6hBDZwyWqG6MVl6CMBJEs6aLTwXzxJ8d7y3bb26gslEcmQsRROm28nK?=
 =?us-ascii?q?J/9BbcB5TPk0qHk6amb6Mc3DTC9G2b12qBoFlYUBJsUaXCRX0fZVXZosri5k?=
 =?us-ascii?q?zeSL+uDrcnPxBdxs6CMKtKbdjpjVRbRPfmItjeZHixm2ioDxaS2ryMdJbqe3?=
 =?us-ascii?q?ka3CjFCkgElAAT/XCcOQg8ASeho3jRDDp1FV3xZUPh6vVxp2m9Tk8zyQGKbl?=
 =?us-ascii?q?Fu2KCx+hIPmfOcTPYT1KoeuCg9szV0AEq939XOBtqYuQVheqpcYc484FdBzG?=
 =?us-ascii?q?7ZtBJyPoamL698gl4TaAV3s1rq1xVwFIVPj9ImrGgwwwpxNKKYyklOeyme3Z?=
 =?us-ascii?q?/uILHXKHHy9gi1a6HKwlHezMqW+qAX5fQgsVrjoQWpG1E683p9ztlV12KQ5p?=
 =?us-ascii?q?DNDAoVS5L+TFw7+AR9p7HfMWEB4Nb/3GZhIOGPuT/LxtwtCfFtnh2pZNpOGL?=
 =?us-ascii?q?iPFAbvHckXHY2lIaohnF3/KloPNftf5egvNMOvavWC1bSDPeB8kTbghmNCpM?=
 =?us-ascii?q?h/10WW7StnYujB2psEhfaC0U/PUzb6kUfkqc38hJpFeSBXG22z1CzpLJBea7?=
 =?us-ascii?q?c0fosRD2qqZcqtyZE2nJPpWnhF5Ha9CF4cnsykYxyfaxr6xwID+14QpCmchS?=
 =?us-ascii?q?agzzFy2wosp66b0T2Gl//ubzIbK2VLQy9kll6qLo+q2YNJFHO0ZhQkwUP2rX?=
 =?us-ascii?q?3xwLJW8eEmdTje?=
X-IPAS-Result: =?us-ascii?q?A2BcAgDyKUxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQUiQOGYAMGgRIliXCRSgkBAQEBAQEBAQE3BAEBhEACgic4EwIQA?=
 =?us-ascii?q?QEBBQEBAQEBBQMBAWyFQ4I7KQGDAgEFIxVBEAsYAgImAgJXBgEMBgIBAYJjP?=
 =?us-ascii?q?4JXJa4BgTKFSoNpgT6BDiqMPnmBB4E4DAOCXT6HW4JeBJdSRpdygkWCUJQDB?=
 =?us-ascii?q?hyCOZhtjm2dTyKBWCsIAhgIIQ+DJ1AYDZ0BIwMwkGkBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Feb 2020 18:18:02 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IIH2ft111770;
        Tue, 18 Feb 2020 13:17:02 -0500
Subject: Re: [PATCH v15 23/23] AppArmor: Remove the exclusive flag
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200214234203.7086-1-casey@schaufler-ca.com>
 <20200214234203.7086-24-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8ab883c7-3a59-043e-7635-8bcdfce247d4@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 13:19:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214234203.7086-24-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/20 6:42 PM, Casey Schaufler wrote:
> With the inclusion of the "display" process attribute
> mechanism AppArmor no longer needs to be treated as an
> "exclusive" security module. Remove the flag that indicates
> it is exclusive. Remove the stub getpeersec_dgram AppArmor
> hook as it has no effect in the single LSM case and
> interferes in the multiple LSM case.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

[...]
