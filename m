Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8AAC3F6B0
	for <selinux@archiver.kernel.org>; Wed, 17 Aug 2022 20:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiHQUts (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Aug 2022 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiHQUtr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Aug 2022 16:49:47 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B6AB045
        for <selinux@vger.kernel.org>; Wed, 17 Aug 2022 13:49:45 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-f2a4c51c45so16503870fac.9
        for <selinux@vger.kernel.org>; Wed, 17 Aug 2022 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WocqWgrjZXzufYo+VjvTjuC+trLAVg+IW3LrnJQvHGE=;
        b=g1WCGszeBqwTD8agA02TuqmykLiU3UlCqugxRruNCwiUqV6kBwSlBPqnfcq/vMwlsa
         eCa90QNIPID6sn7JAir2054BADdX5AvoNySUc/pNkDUUbcDfysA7QsBDWXnxZVyGq96W
         69hQbic9OR1TNB3N5ZWku6TQ3kWtoUzvr0RDPtKkmsy79upmeNBP5UxwOY36OEdVQHwA
         6ceFDWj3HSzKGU9lMd3skFae+8J31ync3+4TDWbgIS1qurg+60Woymvi4tFdNvijkEA5
         cSFJGIVatpFPpqtTUqVrb2ALIcIMzswsa9Mv/YTTKVBVRiZZ/mQgr8B23EtZLlwZO0v6
         vvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WocqWgrjZXzufYo+VjvTjuC+trLAVg+IW3LrnJQvHGE=;
        b=t7J6AvZaLkZi4qFaww6ngpsressCGRaVVonnL/jcrgwNYRmqt6hzRmhLtIwCADIRt7
         EoIvcaN0dza2TmuUWzVj+2YILb5Drel6U2o0icnrfv3iZn7jvF0LL+wuPjSU1jy6SkYS
         l1qUcpumlzAJVLpgwhtPIpmegVo3WIlSp/zChQE+RhFNNCzPAtQ5x+7ib0p/MWTWtYqu
         aIYiQLA/FoBZUP4FsUgMyiEnLOUY6GSWO+TGIzA/2mMK2Xs12qA93RbtZjxxyz4ged4i
         bUBKFUUuNCBQsywaO4HdFiAxsDaL0QZagPsQHm+tjBgr6PVEEeXLBpkufGJaR+lQF/Q+
         gPmw==
X-Gm-Message-State: ACgBeo23C/Uf340df8ftDNAqBcQjgC78xQmX54K2cG9vILfpv5lgL6nK
        gyoch3PcafEr8MkZ++NDiLGmA7Y67kVcbidvJO9U
X-Google-Smtp-Source: AA6agR7JrbP8UcP7////IGT6UrUCgbbez5V20Uid6fE58z/t6fsgDHCRKisRISPA7M6ysqvX0j+PENfk0lpPyBC4yLw=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr2733575oao.136.1660769385146; Wed, 17
 Aug 2022 13:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <ffbb5ff1-cec7-3dad-7330-31fdfb67fecc@huawei.com>
 <cc760579-36f4-fe32-3526-bb647efd438c@huawei.com> <CAHC9VhRCt9UKih_VzawKr9dL5oZ7fgOoiU5edLp3hGZ2LkhAYw@mail.gmail.com>
 <649f9797ae80907aa72a8c0418a71df9eacdd1f5.camel@linux.ibm.com>
 <CAHC9VhTO2YDF8paeYfPDj2aAdiNGCDxziHTY2Sa_5C=yup+P_w@mail.gmail.com>
 <c9e269ce-74aa-f2f0-f21d-0d023db23739@huawei.com> <283a9142-f9e5-24b9-808c-f980343acaa7@huawei.com>
 <1309f1ee6fafe75f9f25b2d936171c0c0d2a5fd1.camel@linux.ibm.com>
In-Reply-To: <1309f1ee6fafe75f9f25b2d936171c0c0d2a5fd1.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Aug 2022 16:49:34 -0400
Message-ID: <CAHC9VhTS4Py4YsAP8mNZpb+zaomKM_aB1WP=zm2LuqvZV5THGw@mail.gmail.com>
Subject: Re: Race conditioned discovered between ima_match_rules and ima_update_lsm_update_rules
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Guozihua (Scott)" <guozihua@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        selinux@vger.kernel.org,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>,
        luhuaxin <luhuaxin1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 17, 2022 at 3:26 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Wed, 2022-08-17 at 15:20 +0800, Guozihua (Scott) wrote:
> > On 2022/8/17 15:17, Guozihua (Scott) wrote:
> > > On 2022/8/16 6:23, Paul Moore wrote:
> > >> On Sun, Aug 14, 2022 at 2:30 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >>>
> > >>> Hi Scott, Paul,
> > >>>
> > >>> On Tue, 2022-08-09 at 12:24 -0400, Paul Moore wrote:
> > >>>> On Sun, Aug 7, 2022 at 11:19 PM Guozihua (Scott)
> > >>>> <guozihua@huawei.com> wrote:
> > >>>>>
> > >>>>> On 2022/8/8 11:02, Guozihua (Scott) wrote:
> > >>>>>> Hi Community,
> > >>>>>>
> > >>>>>> Recently we discovered a race condition while updating SELinux policy
> > >>>>>> with IMA lsm rule enabled. Which would lead to extra files being
> > >>>>>> measured.
> > >>>>>>
> > >>>>>> While SELinux policy is updated, the IDs for object types and such
> > >>>>>> would
> > >>>>>> be changed, and ima_lsm_update_rules would be called.
> > >>>>>>
> > >>>>>> There are no lock applied in ima_lsm_update_rules. If user accesses a
> > >>>>>> file during this time, ima_match_rules will be matching rules
> > >>>>>> based on
> > >>>>>> old SELinux au_seqno resulting in selinux_audit_rule_match returning
> > >>>>>> -ESTALE.
> > >>>>>>
> > >>>>>> However, in ima_match_rules, this error number is not handled,
> > >>>>>> causing
> > >>>>>> IMA to think the LSM rule is also a match, leading to measuring extra
> > >>>>>> files.
> > >>>>
> > >>>> ...
> > >>>>
> > >>>>>> Is this the intended behavior? Or is it a good idea to add a lock for
> > >>>>>> LSM rules during update?
> > >>>>
> > >>>> I'm not the IMA expert here, but a lot of effort has been into the
> > >>>> SELinux code to enable lockless/RCU SELinux policy access and I
> > >>>> *really* don't want to have to backtrack on that.
> > >>>
> > >>> IMA initially updated it's reference to the SELinux label ids lazily.
> > >>> More recently IMA refreshes the LSM label ids based on
> > >>> register_blocking_lsm_notifier().  As a result of commit 9ad6e9cb39c6
> > >>> ("selinux: fix race between old and new sidtab"), -ESTALE is now being
> > >>> returned.
> > >>
> > >> To be clear, are you seeing this only started happening after commit
> > >> 9ad6e9cb39c6?  If that is the case, I would suggest a retry loop
> > >> around ima_filter_rule_match() when -ESTALE is returned.  I believe
> > >> that should resolve the problem, if not please let us know.
> > >
> > > Hi Mimi and Paul
> > >
> > > It seems that selinux_audit_rule_match has been returning -ESTALE for a
> > > very long time. It dates back to 376bd9cb357ec.
> > >
> > > IMA used to have a retry mechanism, but it was removed by b16942455193
> > > ("ima: use the lsm policy update notifier"). Maybe we should consider
> > > bring it back or just add a lock in ima_lsm_update_rules().
> > >
> > > FYI, once ima received the notification, it starts updating all it's lsm
> > > rules one-by-one. During this time, calling ima_match_rules on any rule
> > > that is not yet updated would return -ESTALE.
> >
> > I mean a retry might still be needed in ima_match_rules(), but not the
> > ima_lsm_update_rules().
>
> Ok.  So eventually the LSM label ids are properly updated.  Did adding
> a retry loop around ima_filter_rule_match(), as Paul suggested, resolve
> the problem?

A good long-term solution to this would likely be to add a small
wrapper function for SELinux's security_audit_rule_match() hook (e.g.
loop on selinux_audit_rule_match() when ESTALE is returned) so that
callers wouldn't need to worry about this, but I first want to make
sure that is the problem.  If that *is* the problem, I can draft up a
SELinux patch pretty quick.

-- 
paul-moore.com
