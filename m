Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61561C001DF
	for <selinux@archiver.kernel.org>; Fri, 20 Oct 2023 20:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjJTUww (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Oct 2023 16:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjJTUwv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Oct 2023 16:52:51 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C622D68
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697835164; bh=j5YMf+IUrLV84CJaVH7XwvAy//oM8Jflt46jb/7JQOg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ArAqPboG/mX1rB0+ptRHTRH9q0vghjkeMlgTL5RK5q6wWhcxY5zjZ9pDsI+v15m+55CJJ5Wj3jZblZzywHmBI1E+dJa6H7F4O5YKWKaHsU65mzHR9citMJlMgQugibmlQsDkWA3nDFQu6lgoJAD3EVm9gbH+7TWsiFCwZoGjrWFaIixhsgwFyQGoaDPy73ZbZYI+XBBnlMmdFYLcjTM93gPE1jf//o58rpqkYSqZlMS5OANGKJ2neCcRO75LQ7+zcLZF1zX2RxGQ8r7zqf1TEZO4MgsSTZDjjY4kO32nE6yS5uWhn4joX/nu/eHXRWNADLaHHyEnpLsStTwUcjD99A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697835164; bh=kY1AsUq68XgSsqyHldRs43b3iGx7p5rWl5QJlYlDJVj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UtQjeNOH4LeNE8o3SqahHu+SuUH7R77GSoHIdWzo/f7+EGJwH32EHcf5uxVijmJO49UseUszRqYf77YskQ6H34WCsglA13EDuL6ug0BKFXvpUQuyDwr3ItskbzvToNmFU1jqvxfteEm9tcSAGlcJxdzaJnpJ2O6b8wqzGi5bNpr1InLgWbVljO9UtL5FTyVDo/sDlkXypyBvw0+YDzK+zoXCoO9cw5iIwl5mpW7wAlKYJ17Zu1MUH9NL2OqzURQNuRIAK1Bacm30c60NN6HrJ0h67Y9k/3jMi19rToc4JJXpXUmG9vZw0cbRsSf6nrNuSmZbC5x4nJnnyYMUEhgoOQ==
X-YMail-OSG: 78V6EQkVM1nobBtYmnJyo54m5GmfUTOyckmdc2GVNtbsaFFpU31ypbtuhAYzML.
 RXPzSORyLM9guTDP1jd8Ny_F86AmX2Wwvg0HJih1puVz91wUZaVz9oYU3QcJl.uEIBTV6qiDK6t1
 ID_yxIz_t.eNeD77fXYJx0tUUusaBCwb8.SClEydCULWMtRYpvJPkSP3xMDKi25VhyeQ0lKVnVvI
 hKyKMLoCdz29Hat1yfu5PS_Is3UDYqGJ7SyxV64nkeJVU9thndjc6T1IavnBaheik4RBelK718kS
 GHeo7n_GVH.2MNb.WqgqF_YYrn7zF3qppnJ0X8tjW7eiWptWNla3k5axuwoNtXya0oMJpoe_aBSJ
 7aytNCwPaIBof0IA870MzGLLGsI7EUWiNVKuJt.NmkJURhwVgI036H2BHDWMrNDfnsZGlE2nqh.4
 fHek1BORbxdf8PUYfrAaz2E.UZYVNmOCMo5.P8HZ96KQm.wmuqWABqi.yTsMVg2EqdHL.zw71N9T
 6bQIqDf0VSjBsMdLBxcDBBEDar4YDbjMTMqqaO3ip2x7ghL.sD6MpmcskrQ.bpbiKB.g8A2DvTPM
 7BiZj_1bVPQE02uzYbIXp9pDhhLEjWsL.Oq5oYb0N.GcKPlRsvBXzLMIl88p.flIjWLNzRlpnF38
 RlbWC1mAGBikEdi_CwhwxG7ywRUZUNsWRGK0fAmxU4TQN6gD0b2skXVD1urxaGo50RT_pZSN0lKU
 xMxcAmH_s7TzCyBs1E.VMj_JSbUJS6xOCcSzwe_TGs0s2g6ye21mcxkurS16MZpF.b6g5cm.kivw
 vmCmttKNmUAuqGye3Xt.UlVw0AyQMzhAa.JGjNdb6DXmgu7LyYYJXVeMEzWAzRttme4b09.ZAxTj
 ag9IlcUOAN7NY_Q88QUR8v4sugMWl49hFWXerEwMaYs7Xf2tR5E8kIjpjOJYc8Jrvo2wQAm7N0tN
 Qr4hb0_hM5RaUXrT3yodOQPxc8fL2R_ZGPnm7aqPJWLv8j.7ayVGLCYlA02Yh_qmngxLy3HaIY6V
 Llwc9F4L7rqffZT9iB2QPbE4yzrclB.fLPk3mRCYCDcJ5t_T54pFxQhUG9fsd99y9gZ5bl9_Dyaw
 yCD5L_QvV8OG9xbgTwRPZ_OwO9ttbtx69aMRbAZZG1G3fzOATkxSCBB3SkdybzhdAMqJ9wWJ_Cy1
 3tDZ0FT0TP_1zY5TVQtqxe.cFAzeRKDaSpcXaDZG3vIUteEd5Y365VciZXuykMNIQwlph4iXjw_n
 pQte79A450PQxIyU1jIDBkzhFADjNx3uI6yEbPzIieHVzXR1jXF6.Nxh7fwGVAkImnW7.kJ91zjs
 2v.av2hgc0WN075mx13PTZpcurVcQ_XSLXhyr0jtME9tF9ZTOtVL4Ew374beG.5o.UUwakKjEiRh
 H3_7G3g_yJFKj3asSJnhZ9jkV9E6AGtYs2yIqP4ERMKkdMyxRA0Lar9r20JX2SOSWSd6CnVd2vmE
 0UU1gLkAP8wUgAPIfnoRIVgIERARx3tLCgQpAomWfe90sRXQAWUv8dq3ZRY9mmkJizJ3x4fj_sKu
 Xg1Hj_T.Lkvv0rvyoe5VBEWNGxBPLK6acVyCaVrKMqu9AnVFjZTdcQQu.Y.h5OvUDsyIfASc7Y3X
 Y8xQJ_T5ep9fpct.cNxHeYQfjtkTkMf5WZE7lTO4JHmg_lfbc.N2U9RjHhhSQ.A1xCLLbbUvzSFf
 aFziPpx0GmeRD53mWvsnUYVcFfHQ_Eamjrtpdg9u7rkkB8IUtxw2tYleM6.JSvHN1KOd3rhipywp
 eu0AJIuEIMQkGuVST.AdpKoB3KS6ineuokR8cZb56PZPeyDCa8y66ra4KmBt9DXihbknzBkADZl_
 0QEcBdhQp2ye5uC9g3jp51lDrd4TEkjRnvq1y5qCZApW4eLG3TRAyHdKZIzQTFR7jNmQ4xXIAW2f
 es0h4R16PevDDRsMG0mQq5K2HWYOcjPRunDvJ5yZAH5aFu_2hJx_HV86lnY5HX2Y_5j6snNw23NB
 ilS3rVwtQtcmlQo2T88Fc_4VKYcKv7E_Kst04CYDY7vGAZBu3fPBmTNMH9l7VcCtx5v4sW_8hOXh
 H5ht5.ePshljApZbiKSLwXXH_B3Jrzlj8vnENPnIXN5pOJhAaprV.1hiVIfegmV9KCVKfLi76emP
 oXP4ejKQNEB0hf_.ejp6PHhYtWFa_GjD8eMD4KfguaeBDijI3REUm8mJFItPKjkQYMD0f7c15SCu
 ayoi_fG5QzBCoguwHfmmhSsCnnwy1hXgI46o39d05iuC6ed4fmMNxv33.CtPqO9Lek.hm7IF20Au
 hj3aWfA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cab04250-69ec-4008-aa0f-cd0a15e9d66f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Oct 2023 20:52:44 +0000
Received: by hermes--production-ne1-68668bc7f7-bjk24 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a96b4cbbba13e310b867fd7c42fa3582;
          Fri, 20 Oct 2023 20:52:39 +0000 (UTC)
Message-ID: <1402dd88-f22d-405a-9f5b-dd399fe1dda7@schaufler-ca.com>
Date:   Fri, 20 Oct 2023 13:52:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: thoughts on SELinux namespacing
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
 <051cde5d-c6ef-4b44-ba0f-ebad382fa656@schaufler-ca.com>
 <CAHC9VhQDQ8nkoTfVEYY-7Kmykq84MkwuRssNDqvGor6c445Xdg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQDQ8nkoTfVEYY-7Kmykq84MkwuRssNDqvGor6c445Xdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/20/2023 10:29 AM, Paul Moore wrote:
> On Fri, Oct 20, 2023 at 12:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/11/2023 3:54 PM, Paul Moore wrote:
>>> Hello all,
>>>
>>> The SELinux namespace effort has been stuck for several years as we
>>> try to solve the problem of managing individual file labels across
>>> multiple namespaces. Our only solution thus far, adding namespace
>>> specific xattrs to each file, is relatively simple but doesn't scale,
>>> and has the potential to become a management problem as a namespace
>>> specific identifier needs to be encoded in the xattr name.  Having
>>> continued to think about this problem, I believe I have an idea which
>>> might allow us to move past this problem and start making progress on
>>> SELinux namespaces.  I'd like to get everyone's thoughts on the
>>> proposal below ...
>>>
>>> THE IDEA
>>>
>>> With the understanding that we only have one persistent label
>>> per-file, we need to get a little creative with how we represent a
>>> single entity's label in both the parent and child namespaces.  Since
>>> our existing approach towards SELinux policy for containers and VMs
>>> (sVirt) is to treat the container/VM as a single security domain,
>>> let's continue this philosophy to a SELinux namespace: a child
>>> namespace will appear as a single SELinux domain/type in the parent
>>> namespace, with newly created processes and objects all appearing to
>>> have the same type from the parent's point of view.  From the child
>>> namespace's perspective, everything will behave as they would
>>> normally: processes would run in multiple domains as determined by the
>>> namespace's policy, with files labeled according to the labeling rules
>>> defined in the namespace's policy (e.g. xattrs, context mounts, etc.).
>>> The one exception to this would be existing mounted filesystems that
>>> are shared between parent and child namespaces: shared filesytems
>>> would be labeled according to the namespace which mounted the
>>> filesystem originally (the parent, grandparent, etc.), and those file
>>> labels would be shared across all namespace boundaries.  If a
>>> particular namespace does not have the necessary labels defined in its
>>> policy for a shared filesystem, those undefined labels will be
>>> represented just as bogus labels are represented today
>>> ("unlabeled_t").  For this to work well there must be shared
>>> understanding/types between the parent and child namespace SELinux
>>> policies, but if the namespaces are already sharing a filesystem this
>>> seems like a reasonable requirement.
>>>
>>> I'll leave this as an exercise for the reader, but this approach
>>> should also support arbitrary nesting.
>> An SELinux label is currently made up of several components. You
>> could add a new "subdomain" component. The subdomain component would
>> be ignored unless the process is in a namespace, in which case it
>> would be treated as an additional restriction.
> I think the compatibility challenges with adding another field to a
> SELinux label at this point in time, e.g.
> namespace:user:role:type:mls, would make an already challenging task
> almost impossible.

I pretty much figured that. My hope was that since mls is optional, or
at least not always used, there might be some flexibility.

>   I'm also not sure how one would handle nested
> namespaces with this approach, add additional namespace fields to the
> label?

My thought was that the subdomain ("namespace" above) would itself
be a SELinux label to which policy specific to the namespace would be
applied. A subdomain, being an SELinux label, could itself have a
subdomain.

But, as you say, compatibility probably kills the notion.

