Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67059C433F5
	for <selinux@archiver.kernel.org>; Tue,  1 Mar 2022 23:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiCAXDb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Mar 2022 18:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiCAXDa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Mar 2022 18:03:30 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4843EBA0
        for <selinux@vger.kernel.org>; Tue,  1 Mar 2022 15:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646175768; bh=Kp2bogsfp7LPpVPIDNcfMQ9J9KygW1VuyuANTL5wBos=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=pirP/OS0wHobN81MzRAeOJJX572Zq8iZeieZnLl2rp0VHR6e7mZRoSPW/SgghvLUOYGapxdLnRbZAVc8R8wnjvK7i9A/AuoSuEi/moxjGqb3Cqf0iX/fMk+DXz5q6w6/i2fkkeuAqqcajCeVyFuIVAxdLyrEiy95+H27A9IXtfoA3HYZd4XVpU/cRdSYjwhuP4t1OcHE7AYfBKx1qGEJv6f2R6vP6UUpaIKoNHRNFDc9D1Xm0PGe6SM6gumN/qHotOrdNkWrxvrn3EX8vWAujeTmk3oOPTK13NOMcmGYJPBWnvqG2333y6t0S2Vvp5RGZoT29Iw+0JPJSxlkl+lA9w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646175768; bh=Xxtk52+zA1foEkJVpTxH5PIaBCvO6mTiYF/1iMP05Fb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QeIJRtNhDGQFWQt9H1+958I3YGFkUq6XND+5IyaKz3OR4jrbfrw5EjvrRVQupUMeAQpRKhHGv6+StB3M78reI8BQMJhVTgdajFw9GhW6x26lE7gMbbhomn2AKSGGkCNSksjUUTAJNilqREoWaxGouJm/l0EGFTDq/rQSHccKyvCDkMPjkxPg2VxUz2y4WSLG/vsFT+uhfD6uRfeTvSTTadBeWIjdMDTKp7L4DKB8j6TrMhKBBVj21USlqfJ8Ni1EiCJb4ASlPE2IGxqy+r9j8AU89BTk2u88R2eaE/ou8PDwzsBepuw9huPfl/VgjwR0tRuR/FFae2vW2Q4Sr5eliQ==
X-YMail-OSG: HmjfXlUVM1kZafXNmpHb.EefBbcAMFmmc2AYzHIp3oxZm4dHJLgZrylmDLTcDds
 f4_OKMwAEe6wX9HKwshrKVnxZubrhw8p5onQeNOyuh0rGrpIwAT1CeN6teNKSJ2bMw2k82DCcD1V
 J8VGjMsciWM_AYSwXvnjmY8XDaZz1awPEUVbS2GwiisamBRYWu99wuxuWHq.fNLYvVab8r3ZSwXZ
 YaW8Z76JP5N4XyDRkL9qUwrCzABsSv4Yrj5TyjfaHsXukh5hIPQMJZx8ZzwDkbbnbFDCBoSL0qNg
 FCTUw2PdLQy0YGEQb6nBPz96UvKPNiJfDPtNx6608m3b5JIS_8tNieBHen8qRyvYLE_MusIzPi.T
 6SxOBsP_px9AL_gNLJKAXXoN1PpeKFVbRf5CllV9i7QXJ4oe0DT9jdJjnHh_XZnblxR5KG.UxDiZ
 dEl23e3H6bLSshi9L92Gccb71IVw3UvoSlvqOQWXxyJjkciB611AJalYRNxRDWP8z8V1And3Usu4
 fclgKrf0dShxAUW20gNR6lPzh1lpw8h.Cnp8OlV0.Wm7lAC.D82eqD9oWnwJmRbwo2RQaTFIgQFO
 Esgxn4q9KFkABXOCsUIYJp2ZUpnzQri8Jgs2Uf9amJHFDtc_nVvGMRCJW1A9DiUCYJDBkT4VFC2P
 fUCdgjFZISCYNddUqx4Iv0FM5jm41JtchsAmE4p4YzHitNrhFN.gzKcdM8Msm9TsyCCTzha9VAPb
 k4PVmpurTXa7HzknWr1mMiFkqNJUFejVCMz7hNL8UrxnOvn6UDo__tFav1EM85g2aXpg.GsekQuw
 1EJzJEI0INJVZxZUSzKayyNvp1K6FU7DaccGtXGaD8qRiq71bFxCSm5t_8zwkFtU1r_1W1G6kmg4
 fkJY4RC52rN1lhrcE1U6mC6_xATbz0oQbikis_QBdUq9jLMqmuDufVpGXHrZVge2tJdOiBLUanZX
 Xutrt4kW_4MrkU3yAy85HdqKqA8iR.Bjr.37AunZaM_UpImwUfwOw0jrLxgfZXp5wEMjJ.oN5jvh
 KmzL3x7P4PuJsh7sT_bG1wPQ3F1Epp1P4vrIuTjbkOVZgqpMC1nsdh.LeUFDeD8uB4eW7_NulXig
 gdpT8IwRpNFbYpkD5ukqEFrCBA1saLg5ulg9fncTaJtKa95fF3yDeElDPizg3zgGkTZ0pwMVTWTi
 xmiGHnXC8dpahVjTc6i8B1s1O_tfgszYEv1HzKpxQLStXLNpqFwEXxmGfK_Nl0nkSx2RXPmV_y8c
 u6MwxOEg9jGOBdsGzjrOWsiCns0_vsHgBCs6jKtPEntC4vwWSx.JZCWe6IuFcffSdeGjPFFgc3y1
 390Lh.XKbKE_o7pYwsKGzz_W0h6rX4Jz_WnbtKshjfJzExwX5rmA9wi7iM9CZQMmPbZTLl3I0AOf
 Lv7yxMznO2_FP6OHeeyYYE.rGWG8XV1ruJP7OhVLFM3psRmvVuuBMIDq0P8Abr1xNpJZrJqAQPme
 MOiVsbxLigi4IPjhP5vUp5yb0BsTK3dtZytIsR6397znxSbKo.6DhurwQnx3gWcKwwMNlYZQFLHu
 ozNdO8pOx8tlcPGXcVDEYaCsjgRYSVF2Kdq8fhn_kIkxA7i3HGZHqaoEo0HugrpP9RXHY_DJ.qHH
 j9TGte0.y14XQdsWPCRR3.orA6x5CXdprMxLzByRvijAw7tufmS55B20cRwVGwNrcToZ82kDXnP1
 wjfOLteJJ.6SE5UojJbOmVyrylc_LWlVBq7_rFgwFmt_dHLICFHJ5NPqmoCzr3eYwbP2BpSRIMLM
 PdeBLDCVuzylYT7foEj53rfA51laOgmzuv2YYvu3NuLGNz0Rcp4XipKPWVeftU0LEe8P.aj90nA7
 I4QPLC0McG9hZ7RvuzK4TBDYgvhlNLDB6ZdkLOpnClmsY_dG8_FtHSdIVY9jUgdWKqpWsUgA.GXb
 cNWc4EVo9Vg6xCpkhNtKFaeF0iLr4nNG26fCqZkUrebM9G.QQddKOQ5S_sNbHRSPpa6kZpQuHJ5L
 0eFBIyndqWTY_NYrYpWPIQTWBSBESRi7lsQusrGmJLB4S9EWOQglkvF28O6AmY6I2z.ikhnBRaOI
 O_E9E2IYKybzWzPT32k799eDxtn8KhNXCURBDdL7HTGCYwpiFI7_XcGBaDtQES7zssN7pFzgQyNv
 ethDRzgivKEl24TgWa8iCkg3yxvKyM677XTOncHZPLgwH9Pz2p94G_hmzKNbRAhuy8uSwty3G_Na
 ZF9CsIc7f46REEj0.WxPZ7L86dYmSInLtBOXkrEl.kGfHS7FBYpRXbDPYAf4UeQxN
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 1 Mar 2022 23:02:48 +0000
Received: by kubenode521.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ed7fff620cd38ac2fae6e44a0e6a6c67;
          Tue, 01 Mar 2022 23:02:42 +0000 (UTC)
Message-ID: <692d5257-349f-d39e-1507-ddb90c5bebd6@schaufler-ca.com>
Date:   Tue, 1 Mar 2022 15:02:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <164617518151.117500.8843073220563946007.stgit@olly>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <164617518151.117500.8843073220563946007.stgit@olly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/1/2022 2:53 PM, Paul Moore wrote:
> We deprecated the SELinux runtime disable functionality in Linux
> v5.6, and it is time to get a bit more serious about removing it.
> Add a five second sleep to anyone using it to help draw their
> attention to the deprecation and provide a URL which helps explain
> things in more detail, including how to add kernel command line
> parameters to some of the more popular Linux distributions.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Thank you for pressing on this. FWIW -
Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>   security/selinux/selinuxfs.c |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f2f6203e0fff..3739155ee0db 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -293,6 +293,8 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>   	 *       kernel releases until eventually it is removed
>   	 */
>   	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
> +	pr_err("SELinux:  https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
> +	ssleep(5);
>   
>   	if (count >= PAGE_SIZE)
>   		return -ENOMEM;
>
