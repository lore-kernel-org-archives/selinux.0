Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9ABC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524B12082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Gftqzhnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDIVrn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:47:43 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:38790
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbfDIVrm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846460; bh=SZYg1Wi0LMwFByFftzNFND25krgaK/dx2rMyRGqBnIU=; h=To:From:Subject:Date:From:Subject; b=Gftqzhnhcf/n82rGp+z97NU8oXKvSYt9tUfe7Gxev19sUH+hJTWNm52kq0fj9Y0J9EGnCNDS8pr3bWqS/iLANCMB9y8hHxx5UN8RgtTv6yW/PPHffhGSHkRChHh58qYlerKIE4t/XchfYtaVRkPGTAiMnZ9NApcjE2Xtrmax80FQIeOYCja5smU0yHvVx/6VUYErz8KCWXTWuLE+Si1i41RQePK5o0C3Qsa1ghnrfF7O22ZaHlE7D/hIH+8Xe6f+4HpbPcXSNhNci9gcWTKEdFtEr6hEGg0LhKnOQsQHi4u6pKAE3tSY3UtZA5tn5WzAAnMrVl8jdOuqAwDvD3sj6g==
X-YMail-OSG: wIo3xn8VM1lj6mzWhe3ttJwJ2e.stc_SprcuqFHyWqvyKUU9bgnnvpJpLsHPu5D
 VraNMl2DqGua.u1ibTDE4iU7jopSn.xYJQgntz6eJxPlHYpB8yyEm26Bz5kbEWWCj9SvwELN8hDc
 uXhRTZcK.n8lOA0kNTg50Sw1vbBONH.aqgaH088LFrGjrASl9JvMT5SpJy.k3GFbGqT4XjDQ87dH
 i0sS.uTdUM933NdITmD4dyQdDaMFdtNf20S0N2OsjwqKXaNi2MjE5lxY6uqkJXHZOlBq4dcakxR4
 0gYWbjSQN3yE2q_1ewyyZrSCQEEjSJrz2i3QH8UDFZL4hsR5rT5bry7UiYLfcUFSnmGfNk9UEsdw
 7.x4TGp5Z3WDCOZEmEpFMdSX0cHs9BftDsrY315MApNiGbGNRzJlT2Re_S0wtmpr7eRt6ppVKaFX
 dvZCNEUFIAs0ZXayy9vvnepHxnfeh5QFXWOMIzmXrn9czis5HzVYkKZ7t3UwOHPcIJOnhE1oa03y
 6ocFKrledelgfESCPtbBsToemB8u4_e8uamIkjiNEOAhPOo9xdL3Z4LTzg.mp2blih0b2oxuuZ4W
 RiYoPRfbqHrfFeF2.U7bvo.jLb1P0DrdKkc2EJLd96CeyHsFS57Km1.bJ0zYnNuGALKNKsmAabOc
 ef9QYNji32hNA5made7YrpMJQ41_8iZbUFaZETcyWukVJepW_loiizO7BB11Fk8hiE0rVQp86K38
 9TSY9sZVQ4PGSG18Zw9DgP6vXpcF_TwjXIabd8OxK7w1__LiPGCBz4bU30MLmF7VeQlYIGmm7DOh
 WkyRhqwqtqseLVr6YaLT68Y2U2_66bSyC.VRYjQ0uKIss1WXmlif6aiJF7.VvbN8l9bU5JKZvZr9
 lEH_0brR5NChlx8ouz77ZVUrfXrXBKfiICtgprSfU7Af1yYgMx0AoZkeFC5FeXk1xhhnvIRfmCbw
 .k.gS0U1J34aKTJRNYHcx.oh0tMv7L6Wuocb0cXDHJfyA9VtKUFEh1tJVcgEW..K9tcBpz3WOE_B
 mdm1uqTYrizJ3QGiBodZjhxQInIehPLkUOXQkvHm5Du.pQkHn2._dHWNkoNNCVNt.ZmNMmHPbpbJ
 8qERmVCNaxZ7Tw.MLHss2TFD1cPRZIir13PBq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:47:40 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp414.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9d15304f7cedfc525723d3c5375058ff;
          Tue, 09 Apr 2019 21:46:51 +0000 (UTC)
To:     James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Sorry about duplicates on the stacking patches
Message-ID: <f87bed11-22a3-bc2a-9d46-fc44030ed389@schaufler-ca.com>
Date:   Tue, 9 Apr 2019 14:46:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Sorry about the duplicates on the stacking patch set.
I have a new machine and my ISP changed their login procedures,
resulting in git send-email dying halfway through the posting
process. It should all be good now.

