Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682D1C43387
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 20:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCC02133F
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 20:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547239962;
	bh=F4KVr2Dppdkh7+RVgiEgcdUYUtlD9R28sbZvO62lMaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gqxpk0mJ6c7k+Gb4hnnxFfyXadHkW15zmflXqe2HJ4Qg7CHxjG5GGsK+loBIgNIDZ
	 0SYIpaVkNNe4/U6DHLyIa9FqDQJmgQyvENC8AkWRSDpoeaHiME7Ae3JZz9ixPXzQHH
	 kyzUV4S8oykNltAOPchTMi2BWGtdTWX7nueD/hmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfAKUwl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:52:41 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36872 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfAKUwk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Jan 2019 15:52:40 -0500
Received: by mail-yb1-f195.google.com with SMTP id 2so6362356ybw.4;
        Fri, 11 Jan 2019 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XMGdZ/ZfxLohpq4R8GU1yTo04xAelE7zNz7jmzpqx/0=;
        b=XbyliV7ctETmJyY21+NDQhVsWxDvBzfhYzw2BQ0/wzl44oyuoJre2bIkRWJlkfFy5n
         xqMDzfeTJAfG4q4cJiADlV59ijkXanW80PD/NfyBGBShz7YYCU4rsyS4huxE7a4FDaje
         ZoEznbxatK7/sZJ2ZFd83+a9QEyw3MzL1rcBGU5DiHXIsp0pfwubBdsCvd7ZflBuORep
         1subt1g1QFmUG5VJzO+IQ9Eoqs9VyzRI6wUZGnYAJ1YXe9zxdtpoTGCD4PsQm1uNNKEg
         VHzyEPatxt557rMumUSCXluvCXBSGG0G1ytHgXVXpp6/HLpYqJAgdzVfXXRgAmyEB6/q
         MHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XMGdZ/ZfxLohpq4R8GU1yTo04xAelE7zNz7jmzpqx/0=;
        b=gQF2CQoPEV4mG9pvrOmRfFXMtdvvoA2LVVcWWy72WsrvmzF0cxzIgXJNUH6/IvoaA+
         amxA+6FTzXdfysK01wF9ETN9XHYMXQvpWoJGxHXAwnpagxJkwFzvlt4OrwK0umiPbYWH
         G+h3askGxQex0EUo5UluNOmgWXgwXGP34UNf+cl5gfQsBpSho1G1gsUkMi/OX4mlTCEq
         mwlrXTJcHVnC6O9JDkWJCGIRyW4EiMNBys/LpjDHuWbvp72jtHods7Z1rLVetbszLoRG
         FkWmCnzTu5sCAifK5WYmOI+jk8vrMObNcjiaxAbRtwbkDQ4tOB/rtEZ1iEMdtnKUHDYv
         sjuw==
X-Gm-Message-State: AJcUuke7ob8wGrwjtHyGBqZKN8TrWSODKAZARVYVzuzX0uXHP8GusHEZ
        YmgdwfOuS78FJAMNTp7Sd1c=
X-Google-Smtp-Source: ALg8bN7O9f/dmWsZTTldyZNFFB4meR2CxfpiyxqV2Q/KfP3oETEZuNqhLw9IItfKOY2vSly9k8KmKg==
X-Received: by 2002:a25:dc12:: with SMTP id y18mr15323339ybe.75.1547239958430;
        Fri, 11 Jan 2019 12:52:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:1af2])
        by smtp.gmail.com with ESMTPSA id x132sm36724186ywx.27.2019.01.11.12.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 12:52:37 -0800 (PST)
Date:   Fri, 11 Jan 2019 12:52:35 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kernfs: Initialize security of newly created nodes
Message-ID: <20190111205235.GW2509588@devbig004.ftw2.facebook.com>
References: <20190109162830.8309-1-omosnace@redhat.com>
 <20190109162830.8309-4-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109162830.8309-4-omosnace@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 09, 2019 at 05:28:30PM +0100, Ondrej Mosnacek wrote:
> Use the new security_object_init_security() hook to allow LSMs to
> possibly assign a non-default security context to newly created nodes
> based on the context of their parent node.
> 
> This fixes an issue with cgroupfs under SELinux, where newly created
> cgroup subdirectories would not inherit its parent's context if it had
> been set explicitly to a non-default value (other than the genfs context
> specified by the policy). This can be reproduced as follows:

I'm not yet sure about using selinux on cgroupfs.  Let's please
discuss that first.

Thanks.

-- 
tejun
