Return-Path: <SRS0=rKV4=B2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D7CC433DF
	for <selinux@archiver.kernel.org>; Sun, 16 Aug 2020 00:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E3520657
	for <selinux@archiver.kernel.org>; Sun, 16 Aug 2020 00:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="o2LMj+Sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgHPAKl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Aug 2020 20:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgHPAKk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Aug 2020 20:10:40 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Aug 2020 17:10:40 PDT
Received: from resqmta-ch2-10v.sys.comcast.net (resqmta-ch2-10v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13BC061786
        for <selinux@vger.kernel.org>; Sat, 15 Aug 2020 17:10:40 -0700 (PDT)
Received: from resomta-ch2-03v.sys.comcast.net ([69.252.207.99])
        by resqmta-ch2-10v.sys.comcast.net with ESMTP
        id 767HkwYezG7kL76DUk50gM; Sun, 16 Aug 2020 00:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1597536484;
        bh=Im+/ftQL4wEY1f4RwuwABKvz9Zs2TI39XRzujgGnvuA=;
        h=Received:Received:Received:To:From:Subject:Message-ID:Date:
         MIME-Version:Content-Type;
        b=o2LMj+SbO+AuG2UIAjPGs5R4dnTBqu9vMvHhCmUX7n1vAh+x1BqspFlf9W99ZeOYz
         tM9cPXDKWMMRe/kr4CItCgjToFOA1rLL493Zc2HgrW9kRX1m5AfKz4PWyvZprcNrr9
         DtL/d/8/QRiIA9joMpB0o64AfOGtOl9OTV9lWaTJVy1wXyuZxWJZEw/K9Omej3z35A
         wGGS3Aq9IsVYKNqHjgIRc1UWUCbzfGvh+NuiMhKKjjpONMI7wvvRVWkotodZN2V5W+
         uP2wg70oBZKV+EV8fspqK0O/xVqPJaKsXHnEgNB9PCVTQ4qyGacw9p1x2c8P5Clgsx
         s8P8tl5ojC83Q==
Received: from omega-3g.local ([73.51.179.25])
        by resomta-ch2-03v.sys.comcast.net with ESMTPA
        id 76DKkwN1IuUuA76DLkmDSX; Sun, 16 Aug 2020 00:08:04 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgeduiedruddttddgfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtjeertddtfeejnecuhfhrohhmpeftohgsvghrthcupfhitghhohhlshcuoeftpfhitghhohhlshegvdestghomhgtrghsthdrnhgvtheqnecuggftrfgrthhtvghrnheptdeuudeiteekueefiedtteevveelhfefkefhgffhvdeugfelhfduhfetfeetueeinecuffhomhgrihhnpehhthhtphguphhorhhtkedtkedthhhoshhtohhmvghgrgdqfehgrdhlohgtrghlpdhhthhtphgtrggthhgvphhorhhtthhttghpshhotghkvghtnhgrmhgvtghonhhnvggtthdqqdgsohgsnhhitghhohhlshhrnhhitghhohhlshegvdgtohhmtggrshhtrdhnvghtnecukfhppeejfedrhedurddujeelrddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehomhgvghgrqdefghdrlhhotggrlhdpihhnvghtpeejfedrhedurddujeelrddvhedpmhgrihhlfhhrohhmpehrnhhitghhohhlshegvdestghomhgtrghsthdrnhgvthdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Xfinity-VMeta: sc=0.00;st=legit
Received: from omega-3g.local (localhost [127.0.0.1])
        by omega-3g.local (8.14.4/8.14.4) with ESMTP id 07G06rnb012825
        for <selinux@vger.kernel.org>; Sat, 15 Aug 2020 19:06:54 -0500
To:     selinux@vger.kernel.org
From:   Robert Nichols <RNichols42@comcast.net>
Subject: httpd blocked from http_cache_port_t
Message-ID: <126e3922-3897-2ba9-3061-8bbc90cdc4b0@comcast.net>
Date:   Sat, 15 Aug 2020 19:06:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Would someone please explain the reason that httpd should not by default be allowed to connect to http_cache_port_t. What would be the downside to my allowing this? FWIW, httpd seems to work just fine with that connection blocked (the content does get sent), but it causes a flood of SELinux alerts.

Additional Information:
Source Context                system_u:system_r:httpd_t:s0
Target Context                system_u:object_r:http_cache_port_t:s0
Target Objects                 [ tcp_socket ]
Source                        httpd
Source Path                   /usr/sbin/httpd
Port                          8080
Host                          omega-3g.local
Source RPM Packages           httpd-2.2.15-69.el6.centos.x86_64
Target RPM Packages
Policy RPM                    selinux-policy-3.7.19-312.el6.noarch
Selinux Enabled               True
Policy Type                   targeted
Enforcing Mode                Enforcing
Host Name                     omega-3g.local
Platform                      Linux omega-3g.local 2.6.32-754.31.1.el6.x86_64 #1
                               SMP Wed Jul 15 16:02:21 UTC 2020 x86_64 x86_64
Alert Count                   33
First Seen                    Sat 15 Aug 2020 06:48:57 PM CDT
Last Seen                     Sat 15 Aug 2020 06:49:29 PM CDT
Local ID                      9cff892f-b1e6-4823-ae34-e1a3cf532f2f

Raw Audit Messages
type=AVC msg=audit(1597535369.505:23573): avc:  denied  { name_connect } for  pid=3596 comm="httpd" dest=8080 scontext=system_u:system_r:httpd_t:s0 tcontext=system_u:object_r:http_cache_port_t:s0 tclass=tcp_socket


type=SYSCALL msg=audit(1597535369.505:23573): arch=x86_64 syscall=connect success=no exit=EACCES a0=a a1=56246d05d160 a2=10 a3=4 items=0 ppid=1 pid=3596 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm=httpd exe=/usr/sbin/httpd subj=system_u:system_r:httpd_t:s0 key=(null)

Hash: httpd,httpd_t,http_cache_port_t,tcp_socket,name_connect

-- 
Bob Nichols         RNichols42@comcast.net
