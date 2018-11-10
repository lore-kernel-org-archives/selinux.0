Return-Path: <SRS0=N6YB=NV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F43C0044B
	for <selinux@archiver.kernel.org>; Sat, 10 Nov 2018 14:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5D920858
	for <selinux@archiver.kernel.org>; Sat, 10 Nov 2018 14:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="FjSluTVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5D920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeKKANJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:13:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41767 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeKKANI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 10 Nov 2018 19:13:08 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so6570404qkj.8
        for <selinux@vger.kernel.org>; Sat, 10 Nov 2018 06:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lv5vyBv54Y4hdCwejdcA9Vz1VAfaiG3eYxudGXfwfpk=;
        b=FjSluTVM7RhwA0XaTfI2vY8pYEev25Ufw1+/Pe45RdoyAaxP/oRlqbggbmz5F4qWFU
         9CJK2YWxry17EBAFazPLdGargM9PTyQSjTmruTU4lrO3eVVdOmWzwXIg7lILkxObTI9W
         vdfQ15alfOic5/7rXdICOms+NiU7g3B8b28XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lv5vyBv54Y4hdCwejdcA9Vz1VAfaiG3eYxudGXfwfpk=;
        b=Jdx2luYDu+Xa6DGDsHsNEpKdtlfTjnp7MkvTdtoPP1ipmWveqdpViZAMJgLeyc4BRi
         2ENKmm6rGkHU0v0jwvHUvKLozNDlF9Ef18TXO7dZeQNhddS9t4aPGVCju7bUFKVHEmha
         1k7wFOOr8LfUcwLe7SR81CIQ00BWzBKNsFrUFYYK5lLGKAIKMnYVpzQjt5HmJ4X9y/mX
         9PxccFX9mbufY8TepkiwO8PX1U1k+nOlYbRxC9KhAemGrFVaVTQCzu4wEpkHUWL/MFV1
         R8M6OkTmvjqyT+Y61wxaUAZZ5rYNCqn3Z4bOhUB4OMCWH8woUzh8Isp7J+HFRI5lCqB2
         713w==
X-Gm-Message-State: AGRZ1gJGmxjnSULmt0JrIeJEsZzten1p1DOVUw0wkbK3Ew8P4VL68qst
        XdI7jm6uhQky/hQxIWsMiosGYHvltK2jMw==
X-Google-Smtp-Source: AJdET5f+mxPUA2gxudMEhtbdDavC74vvvz2ZIFPunPqk96vL6KuEzCy640RsDdU77J5y68ExRHgJyw==
X-Received: by 2002:aed:3723:: with SMTP id i32-v6mr12610402qtb.270.1541860076672;
        Sat, 10 Nov 2018 06:27:56 -0800 (PST)
Received: from [192.168.1.190] (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id a79sm2064109qkc.9.2018.11.10.06.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 06:27:55 -0800 (PST)
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.2.0
To:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Message-ID: <69d8bb67-67aa-bf50-c659-1528a420500f@ieee.org>
Date:   Sat, 10 Nov 2018 09:27:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An SETools 4.2.0 release is now available:

https://github.com/SELinuxProject/setools/releases/tag/4.2.0

This release focused on improving performance and reducing memory usage.

A Cython-based policy representation replaced the 
Python/SWIG/static-linked-libsepol implemention. SETools no longer 
statically links to libsepol, though it is strongly suggested that users 
rebuild SETools after updating libsepol, in case the policy structure 
changes.

Building on the policy representation change, refinements in sediff 
yielded as much as a 90% reduction in memory use, depending on the policies.

This release of SETools has different dependencies than previous 
versions. See README.md for more details.

Support for Python 2.7 was dropped because all current 
SELinux-supporting distributions provide Python 3.

Other smaller changes included:

* Added support for SCTP portcons

* Updated permission maps

* Policy symbol names are now available as the name attribute (e.g. 
Boolean.name, Type.name, etc.)

* Revised some apol layouts to increase the size of text entry fields.

* Revised package structure to make policyrep a module of the setools 
package.

* Moved constraint expression to its own class

* Made Conditional.evaluate() more useful and added BaseTERule.enabled() 
method to determine if a rule is enabled


Changes since v4.2.0-rc:

* Restored missing statement() methods in some policyrep classes

* Fixed NULL pointer dereference when iterating over type attributes
when the policy has none

* Added xdp_socket permission mapping


-- 
Chris PeBenito
