Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E10C433F5
	for <selinux@archiver.kernel.org>; Fri, 27 May 2022 17:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352477AbiE0RwG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 May 2022 13:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349832AbiE0RwF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 May 2022 13:52:05 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78A233357
        for <selinux@vger.kernel.org>; Fri, 27 May 2022 10:52:02 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id DFCFCFC04B7;
        Fri, 27 May 2022 19:51:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1653673920;
        bh=jZ39FA42wzg88LBjgHCBPdQLQTF4dYs9doYksZbUIW4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qrQPdfeAwhonxQwXqAZkdYCUQHBhtnH5di6xwWPfQG6+UU8TrYRBFl9P7vf5Kb3ym
         qhYmr9IksdgtQjuSBJdMGZaFyYegx4R3YKI1sQ8VNMRCiU8QIdeqyPIVbqIN/twQ/y
         HRZew7wG3IhAKlLwkOVliNIZrmUNzeyQO2kykNzs=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [SELinux-notebook PATCH] network_support.md: clarify local port
 range and name_bind
References: <CAHC9VhSJUmLmeNQBc5-ornFqtB1v1ogjmwfVBN+VKg4qK7PSuA@mail.gmail.com>
Date:   Fri, 27 May 2022 19:51:59 +0200
In-Reply-To: <CAHC9VhSJUmLmeNQBc5-ornFqtB1v1ogjmwfVBN+VKg4qK7PSuA@mail.gmail.com>
        (Paul Moore's message of "Fri, 27 May 2022 13:14:00 -0400")
Message-ID: <877d66eudc.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> My apologies for not replying directly to the original posting, for
> some reason this never hit my inbox.

No problem

>
> From: Dominick Grift @ 2022-05-23
>> diff --git a/src/network_support.md b/src/network_support.md
>> index bec725e..05ec0e8 100644
>> --- a/src/network_support.md
>> +++ b/src/network_support.md
>> @@ -668,6 +668,17 @@ statements):
>> semanage port -a -t my_server_port_t -p tcp -r s0 12345
>> ```
>>
>> +Ports in the local port range can be auto-assigned by the kernel to
>> +unbound sockets on first use. Controlling binding to ports is only
>> +useful when the port number is a "name" (i.e. a well-defined value that
>> +is expected to correspond to a specific service).
>> +
>> +The *name_bind* operation is not controlled on sockets associated
>> +with ports in the local port range:
>> +```
>> +sysctl net.ipv4.ip_local_port_range
>> +```
>> +
>
> Despite the sysctl name, these ports are typically referred to as
> "ephemeral ports" and not "local ports".  I would suggest the text
> below as an alternate solution, what do you think?
>
> Only ports that fall outside the local, or ephemeral, port range are
> subject to the additional *name_bind* access check.  You can see the
> current ephemeral port range on your system by checking the
> *net.ipv4.ip_local_port_range* sysctl:
> ```
> sysctl net.ipv4.ip_local_port_range
> ```

Yes, looks good I will post a V2 tomorrow.

Thanks

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
