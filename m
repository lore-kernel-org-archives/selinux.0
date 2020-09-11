Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80928C433E2
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 15:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2047E20758
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 15:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s2Zkqa4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgIKPqW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:46:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53844 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgIKPos (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 11:44:48 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 146F820716E8;
        Fri, 11 Sep 2020 07:20:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 146F820716E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599834015;
        bh=9RA9nhOzT6vdg1S/lZxqvbQn4W6CCsRJxEAv3KIvf6g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=s2Zkqa4Wr9UMnw25DaSNf7jTx0+AqS76N8s6MBLxalPbC8Ys1H4EKTdRtQoOVBWvX
         UWQ1b1j5Z79g+7hwJa/N+4jvcdULhVQyoWMyrIS2tzbKIsLCkuuQevJWvABEs4fQlq
         yNKZ4zUDvWe73gFdl34xUSdh//toyVXD2urfGXlQ=
Subject: Re: [PATCH v2] selinux: Add helper functions to get and set
 checkreqprot
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        selinux@vger.kernel.org
References: <20200909222822.23198-1-nramas@linux.microsoft.com>
 <CAHC9VhSZiuHHg+oJPcaRLoZaDhARgiJ2PN5LiMHcVk1yB0a+ng@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a09f9a78-a8ee-5b13-c4d9-e939a4edeb5c@linux.microsoft.com>
Date:   Fri, 11 Sep 2020 07:20:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSZiuHHg+oJPcaRLoZaDhARgiJ2PN5LiMHcVk1yB0a+ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/11/20 7:07 AM, Paul Moore wrote:

>>
>> +static inline bool checkreqprot_enabled(const struct selinux_state *state)
>> +{
>> +       return READ_ONCE(state->checkreqprot);
>> +}
>> +
>> +static inline void checkreqprot_set(struct selinux_state *state, bool value)
>> +{
>> +       WRITE_ONCE(state->checkreqprot, value);
>> +}
> 
> This is a nitpick, and I recognize that Stephen already suggested the
> use of "*_set()" and "*_enabled()" for names, but if we are going to
> name the setter "*_set()" let's also name the getter "*_get()".
> 
> Other than that, it looks fine to me.
> 

Sure - I can do that.

Are you expecting something like below (for checkreqprot and enforcing)?

s/checkreqprot_enabled/checkreqprot_get/

s/enforcing_enabled/enforcing_get/

  -lakshmi
