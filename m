Return-Path: <SRS0=0msR=X3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3EFC47404
	for <selinux@archiver.kernel.org>; Wed,  2 Oct 2019 19:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D88321D82
	for <selinux@archiver.kernel.org>; Wed,  2 Oct 2019 19:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjsQgkyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfJBTZZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:25:25 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36412 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBTZY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Oct 2019 15:25:24 -0400
Received: by mail-ot1-f43.google.com with SMTP id 67so201783oto.3
        for <selinux@vger.kernel.org>; Wed, 02 Oct 2019 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kAeaI06jmJHHnvAuPJTDRUxRVy0FUsLZ4YI1L7I5T/o=;
        b=UjsQgkyB00TJGFSWEnkVDPVC0rcpZdnYnFaXDn3M+iJPRCLdpcZksFCWVTYLJ1C1Hw
         GcXhOmSMV/QFiV7v5+gPQ12293p9uf6hu5mzV5PmTCcBwZVUuyX9bLu9y27crdZsXNGD
         gc6gMHWOZAkkOkLYmr428B2M3VBpsnwal7dIr8rHZVp6PlWzeT+1oxvDF4L0W+DUMxoq
         Du6cHo7WWOcf9mGnMCtFbHdkTRTPnUHIeK+LUSIuw7Wy3hdSVsepZ1+GazHoX5odFlkH
         RwxnzG9iIUaWFKGd38rE/f/E7J6pET5Y00XYXV5tAaJlSBAjluSjoDAX2Vpr7Vg+H6jc
         WJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kAeaI06jmJHHnvAuPJTDRUxRVy0FUsLZ4YI1L7I5T/o=;
        b=Q1rtM10tBnRRDwEUQzSvtRdiI1k3m23vmBADWTsayyNX7s3hnII4wqZb3yoYgw72lb
         jLkiyucQVIRGlictvQHkZpWDua7uyoZOVdP5g//u3KckuwJ7EBGxJLwmVtcEis96xmSC
         ig0VljP2MdWWr/Akqjy7ErmtCRvyOqYJ/cAwcfTlvH7tA31SB1SsWIoiMvvDbZoXcZuH
         OkuX7xUag15Ycq7lVU1/bVo61VMwKsssFG/k8xWpul2z03fu92S0Kd196esF2AY0BXzn
         ntARCXRqYhn2uCyWAYI8wuXnYV+Vi1R94bfhDtyqUPoDDOPEGch61E2WV2B1H3o5lE3z
         8xdA==
X-Gm-Message-State: APjAAAVZHb6fJLNuj18a70ApB1T5YZXreS/c2kbEItlLXIQRpjfqBiwh
        e1D8AzrH6yzfge2Ra438j79K4Iym
X-Google-Smtp-Source: APXvYqwGRzsi6QgRZnJNWig/xGcxd619X1+He32yepjGybwAS/Nj0Xvn8nas/soBCyWgdqagv5GXbQ==
X-Received: by 2002:a9d:5f6:: with SMTP id 109mr3765765otd.358.1570044323879;
        Wed, 02 Oct 2019 12:25:23 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c82:1efa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id v24sm76181ote.23.2019.10.02.12.25.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 12:25:23 -0700 (PDT)
To:     selinux@vger.kernel.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: execve silently blocked
Message-ID: <43c6d9cc-bf9f-b729-2a0c-54a73fa79fdc@gmail.com>
Date:   Wed, 2 Oct 2019 14:25:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I am writing an SELinux policy for a daemon that needs to exec an
external program.  The execve call is being denied (permission denied),
but no denial is being logged, even after disabling dontaudit rules
(semodule -DB).

(The execve call does succeed in permissive mode.)

How can I troubleshoot this?

Thanks!

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
