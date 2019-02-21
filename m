Return-Path: <SRS0=eFyr=Q4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AEDC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 16:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743412083E
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 16:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IlMSoOkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfBUQwi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:52:38 -0500
Received: from sonic315-14.consmr.mail.gq1.yahoo.com ([98.137.65.38]:35898
        "EHLO sonic315-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfBUQwi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Feb 2019 11:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1550767957; bh=bmadhQQC7bqlXt50DQRo82QBsvRuMgLNFCg6SUydqC4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=IlMSoOkOjUK+yPVQ0ZMWz63w8vBrFaOzJ69QVLcXnABkqVlZmhz7VqNVlDqGNZr1zgfSGSjr1tgF0EXs3xc51rh0bCmV3+rlo8QpF38ulqneDwRJLL/uhy6Az82y1NkgmjvhnlUbdx0m9i7TbSHER5O6piL7xTYZ+WS3oo7aYYCFl9kFOvWWfFrau72j6LgV6eVTzpo7ZgdW/nr/I/pwXLbMWkCqdKgXwaGPe35yKBHVdKPY1DPSxMyosjV4QifTrjvO8Fj8i3HX9ut6ml8x9FqMqJ6nJ2b7lHRcxmKqzv5JrclLdUPjM+qsivA1WxDv7Hrmc/dputQpFRKUbS5Utg==
X-YMail-OSG: wjKwoRQVM1llJLMsIX5iiGMWW8_mC.TDwjjm2pCJ.0mYSeVwVcBQunjptSfuH73
 _Jv.HnP73r._jO5Xb3GDlSlGKrw2JRIlC9D5d4ZutmmVi8S602czlH1smVXn8__yRKRo3hxc7qYt
 mdMSVwKZYc6ER1vBuXriGIJ9FeL30.Rh8MnNr7yL7Ofl_Vu2z4n9AP1JRAqsNuGhfM5mV603h7lM
 UWP6hfUHlkp4kekC6DVqCwvMy53HeKCFqOCSg9vD2o8aPs8GVvrex7lXMzjBgeK5ynKk2G0kbH4D
 Lk5sFAT6N9FpGiTx8ZpCf1wgM7sQPnP13Ksdbq55r_mNcqIad.L3.v8Q.yF8ooo4htYx9y41tque
 nALHOxsuJ2Ww_9iuytg5vJlI_HXIEtEOI234NDeiEMZzisNd4ZNZGwobAhnx8ZLDOBVR9B.ry8SW
 8IsAVIRTngia2kAVBgmrGJcS_jgoNMpjtDs_rj2fYzz7B40k4qNUfWnpgjlltYEI39d9xHS8Ca8U
 68pNlN5XfoZ9Esn7mWVTKzQpLTvF1bN7svH7RbeHXCxaJAuy8PbNFg7Mfv7lMbSF5EriWXAPxcVJ
 i8aQ3MiZlhYtGwOYk1nLGAUsXPlr0t7B8czSyxLe0S4qjFZMFt5fAIRDW_6czgsO1cMKmIjBzQiH
 nsWOOc7UU6mQDlHqlmglrJFtEfjuiRqv9EG4_XlgEq4k3al.j7FT1VXYc7mtUDMoN.LUHm9DnGPp
 pLDIOMgrJaJEW3uOMv3cIjnJwYFXYxYy.5JhI9.T_BTYnlscKNX3seNUvIV3r9xZXxsk__DWGY_W
 UCkMjWZIt1IQ.z414frmIz4N8rKQezaDQ6IsN.AvqxtPyFp1pLArpfx4Wzc2LVmRMsluv9vbH.Wy
 PDMvOumnL4QRh1hpjcsqJjzz7U_cfbi9Hr3YChyOrzI0m2jYNGmN7fdW13GU4bDeObXU_6EFzAzw
 XfxUxxNxAPD2EqdgqWa5_nLq3M3ecoUCLhYL2XmpJ68UZDGUXb1yaueWIHX5b7MlzIMe9VcgPvkQ
 b27ZDUjbOvvRQYlDQWTdmegl9bh63OrwMAQrrN90FlR9Nc1Z.8Wfz_yugZtVpR4F4Yb8WTjxEzc.
 g_ruySKVrPXg43Kk.o9vjQw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 21 Feb 2019 16:52:37 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 53967e73d2f51e432241f3b0340d2690;
          Thu, 21 Feb 2019 16:52:34 +0000 (UTC)
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, casey@schaufler-ca.com
References: <20190214095015.16032-1-omosnace@redhat.com>
 <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com>
 <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
 <20190215155014.GP50184@devbig004.ftw2.facebook.com>
 <CAFqZXNvVb75K9ZemVObcBB+rntL38_VfY5P6jyAbuwjymt6MQQ@mail.gmail.com>
 <8c1ddde8-c7aa-7dca-3a0f-2d425c6879b4@schaufler-ca.com>
 <CAFqZXNtJFrtAqnu=CmoSPnPM312DKF73ALkLeekMk8Me5ojntw@mail.gmail.com>
 <0942b8c9-79a3-47a9-a28d-276d322fd9e1@schaufler-ca.com>
 <CAFqZXNvWyBQ5g6nwD4AiePxEDXGP2DY31S0RWttqcRSa90SakA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2de9569d-2368-1dc9-f757-0a7a0a116c16@schaufler-ca.com>
Date:   Thu, 21 Feb 2019 08:52:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvWyBQ5g6nwD4AiePxEDXGP2DY31S0RWttqcRSa90SakA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/21/2019 1:13 AM, Ondrej Mosnacek wrote:
> On Tue, Feb 19, 2019 at 5:43 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> .....
>> The state you're maintaining is kernfs state, not LSM
>> infrastructure state. The state should be maintained in
>> kernfs, not in the LSM infrastructure.
> But I'm not maintaining any state. I'm merely trying to answer the
> query "Is there anything that will handle this hook? Do I need to
> prepare stuff for it?", which is obviously a query about the LSM
> state. Granted, ideally we wouldn't need to do any preparatory work at
> all, but that would require exposing more of the kernfs internals
> (which brings its own issues, but maybe I'll need to look into that
> approach more...).

It sounds like you're bumping up against the limitations
of the finely honed optimized implementation of kernfs. :(
If it where still the pre-android era, when using an LSM
was rare, the check for an LSM might have made sense. Today,
with the vast majority of systems using LSMs*, optimizing for
the no LSM case is nonsensical.

---
* Android, Tizen, Fedora/RHEL, Ubuntu

> ...
> Kernfs is an important component of the kernel. So is
> the security infrastructure. I would hope you don't want
> to turn this into a contest to see which maintainer has
> the biggest clout.
> Oh, no, you misunderstood my intention. I just got a feeling that this
> thread was turning into a discussion about perceived code ugliness
> (and about which subsystem that ugliness ends up in), which is
> naturally a very subjective topic, so I wanted to know what is the
> opinion of the people that have the final decision about whether the
> code should get in or not. Anyway, I'll try to find a more elegant
> variant of the solution once again, hopefully I manage to get to
> something less controversial.

Thank you. I believe (which, of course, doesn't make it true)
that when a component goes outside the general system architecture
the way that kernfs does *even for performance reasons* that it is
responsible for the edge cases it encounters. I know that I've had
to do a good bit of that in Smack.
  

