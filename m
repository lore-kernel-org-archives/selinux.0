Return-Path: <SRS0=TKTs=CI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B77C433E6
	for <selinux@archiver.kernel.org>; Sun, 30 Aug 2020 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A64B205CB
	for <selinux@archiver.kernel.org>; Sun, 30 Aug 2020 15:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kp2q+l8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgH3Pz1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 30 Aug 2020 11:55:27 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com ([66.163.191.153]:35586
        "EHLO sonic304-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgH3Pz0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 30 Aug 2020 11:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598802925; bh=AeGNAPyDynDXL5fHyKTkKoRhYk7KKIyvzP0XP1VMuy8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kp2q+l8n2/5gbthIBIE6A2J5LXpZKyZZ7IAkL2N64ykoSXMYudANZUf0K5wNzSzuS+kFedCu5viEZRyRAshHvpZE7G8/pQowpilUiZS66t3/NRNt5YGW95zzNaTe35vZKjMt8zn1ZODATJ0rajAAXWFnFx+bIU7vaON8Thn+yEmKAZzkG/omTqmJDHQSiLTBsmRSmWXSv8cFLz8IAC1YTKy6zXtJXeXypGes9/GLOt54fA9HoYSjJaHFOm/y0DPzm99yUcOXNVmIiKmDvTRGbmD5xrm4qDMLXSoPymJqqMfavokb/aqI/6JP4V1B41hCVowWbZGoAC8Ki+/uPC36/g==
X-YMail-OSG: uZxOwvEVM1lOUi1gWIXR7tw3lesT8OeNFkAPtQnDCv9_z9vxqnU.qRZMkKMx28s
 SP9uXCyDVLlnJDlMopYqAmtOURJoemAEMmChJAKh484P_ym35bNryW1vn9Qt6_pMUi1dZ43g9TwI
 lNJnob3Ms1hAT7DoZmgMBpitqXELVqoWlFal8xmmWpiwMvDvAPguFDg_wp7Ral9Cyj..7akyg4Zq
 tfrlIHreqRHZ6kFUqNF7BcJIBcrtKkjtpi5jTdYLjiTgFuayQFpKRvQwz9RHnY8ChirruXGSSrFc
 Lmqov7RmeFqfNsYn89w68Sllh9eT.mrVHyhIDm89kDRX1C8LmXsQa_zoxCuHEFIVobqdeAk1nx_C
 FsmAai8f3ZgCXEfY0TghMfJErdsDRF2QIgMdDGD4zW3NwdS8W04wmJg4ECi5rdmhpi39tIB8rgSm
 esvr.I_mGw7pLWz0Mm1YPaFhGKvfFBUIW96CtcW5yVvd8CPgfEbgpmRDld0DGLTqZ935dWT3GY3K
 C5DkT_u5bJCbp9P1N_oHaIaH42Hvia1Os3ksX2MYQViRDXKaqnHhw_bvwBdtF0bz9B2bZhocuzNt
 ZJunfywPprD34yuaD_RUaHbzu30OtfIJDN1CaBHbAhzWKSofeoFUK1afvYk6Kvuycdx7ngntGmgd
 SSf0sKSre__zC..aBchZ17xQ4Y.cOAHomSnTu9VTdBY8WWARMKtvzpVXjrdqx5zW2d4EtEWrPZ1g
 vsbSopYVtJRFm6Oku9U7s26ThuIbCPCiUHbDK6vdoSRnV0Z0PYNSmeGAo3kMuxwYIFV.3dC0Pp32
 EpBXn99jZKEgRfLN_PxuwceplY6IhEoDrECLPi01bCWrRrOyFjilqg7_wjphj4OguH54shYMuoJ.
 0k3nI_7q5_kHeXD5Q9Ofq.eJ_H6xl0xIUXs5oUhkb6MT7_285avU9LcB4BPgVnEEdywM8gPDaVZt
 qAXn5GdCmmdXY.obUPhXUDlhvHVuVHmNXCiKYuTLg6x86AOYaN_ucBBKIsStfdY8y17l33HIye1D
 yjqrHwvydjMypltRhRjwMjr9XtB.XeMbeF6PhGGKwcNznuadB5Vrm4SlkIJpAMfv404JsUuPtalg
 qDypK2Iv7jK28n2zFoS6itDjK4sjyFCVF.fDMFGhyKofVsq_xUYYIFKwLGbvythLULRQ7_dVJK2Y
 FBBoLrrvJ7XfPQB6rajIYKVGQdDpSfeLx_Vcw8dy3o6GA8hWUamLr3CkwdSzTohXh2iMatRkVHVQ
 7j8q6Ty5YB.G_q1SdcmgNqbN1jS5tnSp5qRPK5TkwqKGqW184.IO8Ug2mKuSNgbZIw3tSC8ogyzu
 hj_StUPms5RCcK_DnZIMVVNQbYz85J4waKhRMI9yJ5mxJuHNmgaKprXl6mrIgPDiQqo_B_DVh9PS
 tLKnAaA1BCIPNWkOKjFRJLRq6WvVIjLDMMuw_4fdGvwu5IXrd_4ykas7wd3t8o6U3.lFl.520Tmr
 hSgBfLd6vcgwBpb6TiSL0MyT06K2V4UO8_zxgYWkZH24roVSu0eRtgs6.PyCcTFyUiGi35KOPXmc
 G__G44qkV9uiXHh1ZKFbm
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sun, 30 Aug 2020 15:55:25 +0000
Received: by smtp416.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 94a7ae52c40575ad0c6c49ff1c6d4e9c;
          Sun, 30 Aug 2020 15:55:23 +0000 (UTC)
Subject: Re: Hiding names of unreadable files
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        SElinux list <selinux@vger.kernel.org>
Cc:     survolog@yandex.ru, Vladimir Potapov <vladimir.potapov@rosalab.ru>,
        =?UTF-8?B?0JzQuNGF0LDQuNC7INCc0L7RgdC+0LvQvtCy?= 
        <m.mosolov@rosalinux.ru>, Casey Schaufler <casey@schaufler-ca.com>
References: <829a4d86-b5b8-69e4-e1d5-dbdcb9c1401e@rosalinux.ru>
 <f2db2efd-1852-bcb9-c734-68d29b9f1880@schaufler-ca.com>
 <e8efae23-ac19-ce3d-4988-b3e304e4807b@rosalinux.ru>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <381721a7-0c00-5e93-c662-4a4fb15ec11a@schaufler-ca.com>
Date:   Sun, 30 Aug 2020 08:55:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e8efae23-ac19-ce3d-4988-b3e304e4807b@rosalinux.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16565 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/29/2020 4:30 PM, Mikhail Novosyolov wrote:
> 29.08.2020 19:42, Casey Schaufler ??????????:
>> On 8/29/2020 4:08 AM, Mikhail Novosyolov wrote:
>>> Hello everyone,
>>>
>>> We have been thinking on such problem: read access to a file may be restricted with SELinux MCS/MLS, especially MLS/MCS.
>>> If a file with restricted access is inside a directory without restricted access, its name is readable.
>>> Name of the file may be used to store some "secret" information.
>>> Some system directories, e.g. /var/tmp, are writable for multiple users, and they may use it to exchange secret information,
>>> bypassing restrictions.
>>>
>>> Is there a way to restrict access to names of such files?
>> TL;DR - No
>>
>> This is probably the oldest active question in the history
>> of UNIX/Linux security. In the late 1980's it arose many times
>> in the process of system security evaluations. Because the
>> name of a file is data in the directory, and not an attribute
>> of the file in UNIX/Linux filesystems, access to it is controlled
>> by access to the directory.
>>
>> There was initially much crying and gnashing of teeth about this
>> in the evaluation community. Especially with regard to /tmp.
>> SELinux (and Smack, and B&L systems from the old days) have
>> explicit policies controlling how files can be created in
>> directories such that you can read the directory but not the
>> file attributes. While this can't prevent creating a file named
>> launch-the-missiles-at-noon, it provides accountability.
> Very interesting, thanks.But are there technical restrictions to implement hiding names of files?
> Let's assume that we will be OK with performance penalty of directory listing because of checking access rights to each file inside the directory.
> Were there any attempts to implement this?

Yes, it has been attempted and isn't really that hard if you're willing to
abandon the name/inode pair model for directory entries. That leads to breaking
the traditional filesystem semantics, some of which are "curious" but important.
Hard links need to either be carefully coordinated or unsupported if attributes
are stored in the directory entry, for example. This worked in the days when
a system supported a single filesystem type, but would be much more challenging
with VFS.

