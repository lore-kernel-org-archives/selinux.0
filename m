Return-Path: <SRS0=k4Wl=RH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5482BC43381
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 17:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25045206B8
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 17:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="u/15sAWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfCDRBL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:01:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40443 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfCDRBK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Mar 2019 12:01:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so3438729pfo.7
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2019 09:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NgpxjmBV3GaSEJloWQ0qOTaQZvSmlTVRb07fqyDgFDg=;
        b=u/15sAWENuu3jsxE18EsKKD04gJljPSbXj6TAuU6UWlud40NuuA8HJic+zpb/V583N
         B6pP+5pL9tDXFpL7yrsalbV9n22kAMgRMMnmgkyRS3i6EffVYh3W+9CbkSKwdbPF20om
         /rr/GrVKYND6o7fNjUqnBbn9pKF96Hn41Hrki5wza48TbHLKnriw9zJrjs7TuCHUXXGK
         yrMXzb+UdHxElAUL7d3+OsZpaFEWVlY9ESBe48BKuQV4O5CiXR8Cpbmzyjqc8jNjmIKE
         JY/jE2YIFLrZ7cCnJlVDlqxmyuWpVoKKGaK/TP9NsFldpd56E+04/8xRhc/piAZmBFMF
         RoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NgpxjmBV3GaSEJloWQ0qOTaQZvSmlTVRb07fqyDgFDg=;
        b=MjdbfJW8XsQS7H1iCG917RCoMjTzBU7FjfYtGDW9lcEQ4Tqe0l7v0JCiBdqjaIJrKr
         gqzRPzgAwug2LDprT6yGSFpZeiDKnND7/opwxg3l87KAN78y8j3Hgb3GWQJYUiWDqU2I
         zeUPuHC/vAekUfyXmTSbCD3gBKW910u/ip13WfjhVMfXulXFxTwV/QZF7+jkoObOjbiz
         1TFOEIS8U1AX8qDbTZ61YZk1TsnyyeZ1M9/Sttig0Dn+Ti5HLzpziEG/LIo/iKOR4fFE
         swFH1z6ZjrmYHPA3Hr2kWX3Orvsjw6PR9w59xj6jhXhzipnKVVA3UOIvOAghDdKFR9LU
         gEVg==
X-Gm-Message-State: APjAAAWPwLRK5b/2oSrYKON655TS12NSx+KQDPp/1UdJWU9DlyJ7r8kh
        sucPrU36PULSdLDsZptmLHRTnQ==
X-Google-Smtp-Source: APXvYqyXZzpKsXq1tjtTCWFq8nMRh0LcXq79aU2sm+JeaHi/ApTEtt7p+RAKvgQMr9gzIZKYdPg+Sw==
X-Received: by 2002:a63:5362:: with SMTP id t34mr18972139pgl.81.1551718869633;
        Mon, 04 Mar 2019 09:01:09 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id o7sm16694043pfi.105.2019.03.04.09.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 09:01:09 -0800 (PST)
Subject: Re: overlayfs access checks on underlying layers
To:     Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com>
 <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com>
 <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
 <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <20181129134943.GA16762@redhat.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <fe78aaed-5fb1-3c51-1330-39de46ae39c5@android.com>
Date:   Mon, 4 Mar 2019 09:01:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181129134943.GA16762@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/29/2018 05:49 AM, Vivek Goyal wrote:
> So will override_creds=off solve the NFS issue also where all access will
> happen with the creds of task now? Though it will stil require more
> priviliges in task for other operations in overlay to succeed.

NFS problems seems to have ended the discussion, too many stakeholders? 
too many outstanding questions?

Do we accept the limitations of the override_creds patch as is, and then 
have the folks more familiar with the NFS scenario(s) build on it?

[TL;DR]

After looking at all this discussion, it feels like a larger audited 
rewrite of the security model is in order and override_creds=off may be 
a disservice (although expediently deals with Android's needs) to a 
correct general solution. I admit I have little idea where to go from 
here for a general solution.

As far as I see it, the model of creator && caller credentials is a 
problem for any non-overlapping (MAC) privilege models. This patch 
allows one to drop any creator privilege escalation, re-introducing the 
"caller" to the lower layers.

As such I would expect a better model is to _always_ check the caller 
credentials again in the lower layers, and only check the creator 
credentials, some without caller credentials, for some special cases? 
Change an && to an || for some of the checks? What are those special 
cases? I must admit _none_ of those special cases need attention in the 
Android usage models though making it difficult for me to do the fight 
thing for the associated stakeholders.

The lower privileged application access to the directory cache inherited 
by other callers troubles me (not for Android, but in general) and feels 
troublesome (flush out the directory cache? how to tag the privileges 
associated with the current instance of the directory cache?). Some 
operations (eg: delete a file for incoming, create mknod in upperdir) 
are special cases requiring the checking of caller credentaisl to 
function (not a problem for Android as the caller that deletes a file 
just so happens to have the necessary privileges).

Also, mount namespaces (in upper, lower, etc), how will they affect this 
all, is there a need for more attention to this as well?

-- Mark
