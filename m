Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3912C433EF
	for <selinux@archiver.kernel.org>; Thu,  4 Nov 2021 18:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B853960FED
	for <selinux@archiver.kernel.org>; Thu,  4 Nov 2021 18:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhKDSQR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:16:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33462 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhKDSQQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Nov 2021 14:16:16 -0400
Received: from [192.168.1.10] (pool-173-66-191-184.washdc.fios.verizon.net [173.66.191.184])
        by linux.microsoft.com (Postfix) with ESMTPSA id E0FBD20ABA95;
        Thu,  4 Nov 2021 11:13:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0FBD20ABA95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1636049618;
        bh=ul3oWxrKiQgyN+YlJq/R4vMVkwSMteBJCN5cUvwwlGU=;
        h=Date:From:Subject:To:From;
        b=TPNDnpcG9IpW2aGkemmnFtCPajq+eS74vX7PjsQbjs0GFK+fhzt95q38D8q8rMeQ8
         84p0WaAdvOHzqRncxYipHa99Yc3FHoMzTISm92Bl7lePHuNksjVm6HNGiGvKyTVhjN
         oIsomaAUffLxU5TkUVsmqVcG8IMTV0Alur2J2Qhc=
Message-ID: <7d775f7f-1377-edde-8474-ba2126256852@linux.microsoft.com>
Date:   Thu, 4 Nov 2021 14:13:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Subject: [RFC] Cascade: a high level SELinux policy language
To:     selinux@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We have been working over the past few months on a new high level 
language for specifying SELinux policy, in line with the original intent 
of CIL, to enable the creation of high level languages that compile into 
CIL.

Our objective is to create a language that enables the efficient 
creation of useful abstractions by policy experts while enabling those 
abstractions to be easily usable by non-experts who may contribute to 
portions of the policy.

The design is heavily influenced by Object Oriented principles, with a 
goal of enabling the efficient creation of type hierarchies and 
eliminating boilerplate through the use of inheritance.  The use of 
"virtual" types, (which compile into attributes) allows both attribute 
like behavior, and also the creation of inherited member functions, 
allowing for interfaces as in refpolicy without the redundant 
boilerplate.  Another key feature is "resource association" which makes 
explicit the connections between domains and associated types such as 
tmp files.  This feature allows for common patterns (such as setting up 
a tmp file with a domain transition rule and manage access) to be done 
automatically behind the scenes, minimizing the chance of mistakes and 
allowing policy developers to focus more on security decisions.

The core language functionality is written as a library, which will 
hopefully enable the easy creation of associated tooling and plugins 
that build on top of that library.  It is our hope that this 
architecture will assist an expansion of available tooling to aid policy 
developers in their work.

This is still a very early prototype and so some functionality may be 
missing or incomplete, but we wanted to make what we have so far 
available for community feedback and discussion as we continue development.

You can find the code and associated documentation at 
https://github.com/dburgener/cascade

I hope this is something that people will find useful and welcome 
feedback and contributions as we aim towards the goal of enabling 
smoother policy development.

-Daniel
