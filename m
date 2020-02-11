Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4E7C35242
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 19:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1432C20714
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 19:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jYMl6iAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgBKTvT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:51:19 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:9068 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgBKTvT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 14:51:19 -0500
X-EEMSG-check-017: 55012240|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="55012240"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Feb 2020 19:51:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581450675; x=1612986675;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tdOKc6iX6o1IXD2gs3BApfg8tzVjd9TZFtFtpUJXf0Q=;
  b=jYMl6iAZLwLmr7fDklMWEIDolOpEI7F5U30mU3iIhKbM2QEUXhICJrD7
   K9+0YOt4rBmd1aaBhIzEvbhVge29/RKz0bSVq7aPPCoQiAl/yFdxiTq3M
   EVDszewxn9YDyWsX2zqtrcC2Uods0XkFWW8qq9j2/W7ssWRBO7Oz+vNGn
   eDsXCAwm0DgLLHD/BmZTkKumOfmcX3jWdGBGRrh4g+TGSK4Nw7rTxVpJI
   kN4Uri5Pg5pHOL8FSopOfni8EnoV11Yd5x5b1s9uXqQsNJokOcsddvB0F
   M1x6wpSCtSVF52LAG+FD7bbR1LMtlFPQO64v5f2Z5KBx+NWLxQxN34iGl
   g==;
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="38973817"
IronPort-PHdr: =?us-ascii?q?9a23=3AdOLrAxYxe+8xOF99DXrjRwH/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsm/bnLW6fgltlLVR4KTs6sC17OK9f67EjVZsN6oizMrTt9lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrogjdrMgbjIVtJqos1x?=
 =?us-ascii?q?fEpmZDdvhLy29vOV+ckBHw69uq8pV+6SpQofUh98BBUaX+Yas1SKFTASolPW?=
 =?us-ascii?q?4o+sDlrAHPQgST6HQSVGUWiQdIDBPe7B7mRJfxszD1ufR71SKHIMD5V7E0WT?=
 =?us-ascii?q?Cl76d2VB/ljToMOjAl/G3LjMF7kblWqwy9qRNh34HUYZmVNPtgcaPbYdMaXn?=
 =?us-ascii?q?dKUsJIWyBcHo+wc44DAuwPMuZCq4n2ukUAox2wCwKxAO/j0zFFi3vz0aA8zu?=
 =?us-ascii?q?8vExzJ3BY4EtwTrnrUotX7OqQcX++7w6bHzynMYfxN1Dfh64XFaAwtre2CUL?=
 =?us-ascii?q?9yd8fa1EkhFxnCjlWVsYHrIi+V2foVs2ib8eVgU/+khXMiqw5rpjivwtkji4?=
 =?us-ascii?q?nUjY8S0VDL6D55zZ0pJdy4VEF7YdmkHIFWtyGBLYR6WMwiQ2Z2uCsjzLANpJ?=
 =?us-ascii?q?21fDASxZg6yBPSZOaLfoiV7h75SuqcLil0iGh4dL+5mh2861KvyvfmWcmxyF?=
 =?us-ascii?q?tKqy1FncTSuX0VzBzT79SHSuN6/ke8xTaDzwDT5f9AIUAzjafbN4QuwqQxlp?=
 =?us-ascii?q?oOqkTPBC72mEP4jK+RbUUr5PSn5/77YrTmupCcN4h0hhv4MqsygcywHf40Mg?=
 =?us-ascii?q?0PX2if4ei81bvj8lPlQLhSk/E7nabUvIraKMgGvKK1HQBY3pg55xqiFzum1c?=
 =?us-ascii?q?4XnXgDLFJLYhKHiI3pNknVIP/lFveymEiskTd3yPDGOb3tGJPNLmPZn7v7cr?=
 =?us-ascii?q?Z97FBcxBIpzd9D/5JUFq0BIPXrV0Dtu9zZDxg5MwqqzOb8E9h92YQeWWWAAq?=
 =?us-ascii?q?+dLqzStEWH5uMrI+WWeIAVvzP9IeA/5/HylX85hUMdfa6x0JsPbHC3BOlmI1?=
 =?us-ascii?q?mDYXX3mNgMCn0KsRQjQ+zqklKCTSRfaGq1X6I5/js7Ep6pDZ/fRoCxh7yMxD?=
 =?us-ascii?q?y7EYNSZmBHDFCMDHjpep6aW/cDdi2SONVtkj8aWri7TY8uyxWuuBX9y7p9Ie?=
 =?us-ascii?q?qHshEf4Lnjztlu++zakyYdayBoFM+d3inZRG5mmWUFXBc526dwpUF4w1aHl6?=
 =?us-ascii?q?N/hqoLO8ZU4qZyTgoiNZPah9d/AtT2VxOJKsyFU366U96mBnc3Vdt3zNgQNR?=
 =?us-ascii?q?UuU+6+hwzOinL5S4QekKaGUdltqfPR?=
X-IPAS-Result: =?us-ascii?q?A2BPBADTBENe/wHyM5BmHQEBAQkBEQUFAYF7gX2BbSASK?=
 =?us-ascii?q?oQViQOGZwEBAQaBEiWJcIonhT2BZwkBAQEBAQEBAQE3AQGEQAKCazgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYMCAQUjDwEFQRALGAICJgICVwYNBgIBAYJjP?=
 =?us-ascii?q?4JLAwklrDCBMoVKgkYNYoE+gQ4qjD15gQeBOAwDgl0+ghuCFoMqgl4EmAiXa?=
 =?us-ascii?q?oJEgk6TeAYbmw8tq20igVgrCAIYCCEPgydQGA2dASMDMI5oAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Feb 2020 19:51:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01BJoECF053328;
        Tue, 11 Feb 2020 14:50:15 -0500
Subject: Re: [PATCH] libselinux: drop error return from is_selinux_enabled.3
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20200207143744.9944-1-cgzones@googlemail.com>
 <pjd36bm4dat.fsf@redhat.com>
 <53df5cb3-798c-66da-604b-94e7e48c5803@tycho.nsa.gov>
 <CAJ2a_Dc4Ud9EeP6WN9xHP0sn9vsgjgZWz7LM2xF_2_kLV9AydA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ecfe72b7-60a9-2410-4b2c-0e09463c4dff@tycho.nsa.gov>
Date:   Tue, 11 Feb 2020 14:52:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJ2a_Dc4Ud9EeP6WN9xHP0sn9vsgjgZWz7LM2xF_2_kLV9AydA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/11/20 2:12 PM, Christian Göttsche wrote:
> Am Fr., 7. Feb. 2020 um 18:51 Uhr schrieb Stephen Smalley <sds@tycho.nsa.gov>:
>>
>> On 2/7/20 10:39 AM, Petr Lautrbach wrote:
>>>
>>> Christian Göttsche <cgzones@googlemail.com> writes:
>>>
>>>> is_selinux_enabled() does never return -1, do not say so in the manpage.
> 
> I am having second thoughts about this:
> With the current inaccurate documentation the worst effect are dead
> error handlers in client code.
> But when removed now, after a potential SELinux rework (either kernel
> or userland) in some years it might be way harder to re-introduce
> error checking in all client applications.

Looking around at callers via codesearch, I don't see any actual error 
handlers for is_selinux_enabled() < 0.  There is also inconsistent 
handling of the < 0 case; some code handles it the same as 0 (disabled) 
while other code handles any non-zero result as selinux-enabled. 
Probably better to fix the man page and header.
