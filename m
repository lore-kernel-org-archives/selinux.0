Return-Path: <SRS0=Mzal=CH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD6C433E2
	for <selinux@archiver.kernel.org>; Sat, 29 Aug 2020 16:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B06B20707
	for <selinux@archiver.kernel.org>; Sat, 29 Aug 2020 16:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="I7s3No+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgH2QnA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:43:00 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:33617
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728374AbgH2QnA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 29 Aug 2020 12:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598719378; bh=IZaN0xCMSiL8mVyXLXVNzBvGi8FzytPMGPnIc0tyxQg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=I7s3No+nwgTewXKeW9SEoX8v2+s1XG1WPTVUGgo8fMA2lVSB4xzPXYGu3s/8/Cy6RoJi+r1DsX1R1Sum3dMi2X3UX9jU/npiovYOogC72kJ2M4JP0mJyB88MlOGHCzndPXm1Km/FP0fh2EYMJY3+ZflKOakxaB9wv9wbfnf2HQEWvp5mApFODilHuq7fseN0A8PFQn6mWD7NyG7mUkEmDxjcwSos530vM3TDQf42eKegW07dZrSCdbWdXfNYKMVdhZV7HvyZsbVZ0wfei/ZozQup1qA0UxcL4Umh7go0I+hJOYiUanRA2nXl9UDmgAc6+lCClTf3bAIiWJnsSdM1Hg==
X-YMail-OSG: 2WuAuCQVM1lVevuneRZWHfA9oAAt30.bZfngtzaXcVeAod_7vKRYAs_dyiqTJHI
 n7sBuhWKwp1wd7gV9n.7L2ZOverbNB4bQdHynVqal9sShGXoDABhgXJf3SWc2wmticozonwtqRAv
 OswQqFSPt9nzSf7beC_2AX9MDiJ2g0M4AhpIXNzde7us_n5YWlYK8Bb.0cq0FThv6PLT5pxFa0FG
 .gMRlYy3rrdbipc0p2u05B.KUH3DC447s8a8vD3_35vcWXsXPEFZvyMXv0a6N_fGbn7glM0L04_a
 Sa5M4ueeKf1zcI6LCMLaSPThHeDGPi28ZD.bleE_cA_lD77GHmZ.Cr0QP6U4SuI86m8W9vAnAdhx
 OVeLBzBb7ekGBzpctHRvw04RcFg3eB4lKtoceNnunJRnrXwuOGys2Wpt09wKD2dlFYfSjcmpSKzN
 mgrXdQtsvdQWAbtoZ7QF26DaTYLUSMwbuEwmSVrPqgaVCmtGWW.LYRYjSplj2DMpTc1MPJLvm.CK
 37qLp7WXWKmV8Fqp9_iACip.4ygQu_2mgAewyvAG0VRcHdUnGcjWK4BpqvrDK94nxxuIyfqT_cm6
 aBmB4Dj0_q1T2YgyBeGlCh5LeohzKAjNFU3wBvwe8YoPMbcEOgrXF3I5LZPTw0nLrac8ea61XRRR
 nRuthebt1uAsO56Q1I7jIprm1kxaGhTrUGpLc.m3FthHIf3jhtxj64EihytcZ4IX_rCOyVRyyOBI
 hysc6i612NaXZGABaylB43ZD7ty3CU7cXHtCMUZjKJGEQuzMnvymbpJTOsan1i8mI2vOs0VRDJzm
 .33kGLb0C.0xJFj1EpOewA2U800Xv3DF6Ws.l5QACze5W_rZMVgf03zPv6sh_6FLopS2ek.H75A.
 lXnuAlArWAXSxoABhinQFJ.9azpSGXh_a0GYqRd.ExyN03lGcGOUQkbLkEOCDGgGNrHEG5dmsf9u
 HsdZFgsESJydwIgbQNEYlb5QQ9ONF_9BaV3zy25.k55mA.euT3vcjogvJdybp35AuOEUUfBDIaTr
 R_9kNeRWDMt1lA8pI1ZLv4t1.wm3nVKj_NUOleNdZwLyGVjuTKdTG1pO.Z8KnE1eI7aQ3F8bb0Nj
 1hjsLkjKdSzz1iRNpJUjXEfAZ7ROJt.axkYOQ50SHoTm4G1fHApSSZOVndqQOaOvCWp9KqcG2UO7
 D.xRnmfmUQ71PArcEQePIQ6nYZpGfH.p2msJnWfIQFu9WnxtnJAIiMx3Sd3ZT_FKI7w5DpFnbtrV
 Vz5coNh1UNPiB..jOnQY2GeXzihky1hnEZgvS7MDgUlc4BFSRhb.dLt9P15N0_4uxcTspgScI3Su
 WubbCj5f_tquBAhOpfKjxBXhV1VY2clMxx7SZ8KsPIQz7qv3aV2oaY67cKPhaG0DT0_dareVVG7d
 bCIY_8bOWjtxDAGSym9.8R.L2je138FSQ2PziU4pR9YOtzNJJFyGIDNbw1x6QUcrKoC_TcE37tKz
 PuZDUrwgqD3qabScNyFXnJF8dl3nrRUXciwqVpYv..WMUR5Jz_VmcpmNT3PtGOmgGzqWb6tJWKvS
 gTsQhsJ9jYaz0NQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sat, 29 Aug 2020 16:42:58 +0000
Received: by smtp401.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 375355fcaedf113f7c0acdd505ec0aa4;
          Sat, 29 Aug 2020 16:42:56 +0000 (UTC)
Subject: Re: Hiding names of unreadable files
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        SElinux list <selinux@vger.kernel.org>
Cc:     survolog@yandex.ru, Vladimir Potapov <vladimir.potapov@rosalab.ru>,
        =?UTF-8?B?0JzQuNGF0LDQuNC7INCc0L7RgdC+0LvQvtCy?= 
        <m.mosolov@rosalinux.ru>, Casey Schaufler <casey@schaufler-ca.com>
References: <829a4d86-b5b8-69e4-e1d5-dbdcb9c1401e@rosalinux.ru>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f2db2efd-1852-bcb9-c734-68d29b9f1880@schaufler-ca.com>
Date:   Sat, 29 Aug 2020 09:42:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <829a4d86-b5b8-69e4-e1d5-dbdcb9c1401e@rosalinux.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16565 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/29/2020 4:08 AM, Mikhail Novosyolov wrote:
> Hello everyone,
>
> We have been thinking on such problem: read access to a file may be restricted with SELinux MCS/MLS, especially MLS/MCS.
> If a file with restricted access is inside a directory without restricted access, its name is readable.
> Name of the file may be used to store some "secret" information.
> Some system directories, e.g. /var/tmp, are writable for multiple users, and they may use it to exchange secret information,
> bypassing restrictions.
>
> Is there a way to restrict access to names of such files?

TL;DR - No

This is probably the oldest active question in the history
of UNIX/Linux security. In the late 1980's it arose many times
in the process of system security evaluations. Because the
name of a file is data in the directory, and not an attribute
of the file in UNIX/Linux filesystems, access to it is controlled
by access to the directory.

There was initially much crying and gnashing of teeth about this
in the evaluation community. Especially with regard to /tmp.
SELinux (and Smack, and B&L systems from the old days) have
explicit policies controlling how files can be created in
directories such that you can read the directory but not the
file attributes. While this can't prevent creating a file named
launch-the-missiles-at-noon, it provides accountability.

>
> What may theoretically be done:
>
> 1. Hide such files from directory listing. A bad idea, because most pieces of software (and people)
> are not ready to deal with situations when a file does not exist but a file with such name cannot be
> created because it already exists.
>
> 2. Change name of the file to "????". Even worse.
>
> 3. Do not show the name of the file at all. I do not know how it should be done,
> something like showing that an "inode" exists.
>
> 4. Try to just restrict write access to directories without proper MLS labels:
> separate /tmp for arch user, maybe separate /var/tmp for each user, chmod -x (maybe via ACL) for /run etc.
>
> Can and should it be done with SELinux? What about other LSM modules?
> Is there a more generic approach to hide names of unreadable files?
>
