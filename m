Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A78CC43217
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 07:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A76023125
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 07:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbhAGHyl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Jan 2021 02:54:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbhAGHyk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Jan 2021 02:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610005993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePuYlgZEkaEcQdDpcjAq4jOJppnPZp+F3f7z/sHPxcU=;
        b=PeZMWa++i52FS3/Uyw/dQXSqepDS1d4SR1OTggsrSQHZJioOkTajvNqeDP7x1lR19qQeeR
        VpP/SATS8bQ5AppijkrZfPH+rdqm2VPJl+IRxCY8TV/3NQnDEVP79tdkjhSVB6VRMD3UL+
        eG/ViN9zk75r4Kfr3CDzxxOGHFXThmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-bjHxNTy6MgGHVl3IvY3ojg-1; Thu, 07 Jan 2021 02:53:09 -0500
X-MC-Unique: bjHxNTy6MgGHVl3IvY3ojg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34798800D55;
        Thu,  7 Jan 2021 07:53:08 +0000 (UTC)
Received: from localhost (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAD6E1346D;
        Thu,  7 Jan 2021 07:53:07 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Ashish Mishra <ashishm@mvista.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: Git link to get semanage , sesearch source code
In-Reply-To: <CAP2OjcieTJAmeuZX_uGQjjsqCZ7x208aHAVSzHfZxS9uzyBAzg@mail.gmail.com>
References: <CAP2OjcieTJAmeuZX_uGQjjsqCZ7x208aHAVSzHfZxS9uzyBAzg@mail.gmail.com>
Date:   Thu, 07 Jan 2021 08:53:06 +0100
Message-ID: <87y2h5ji8t.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ashish Mishra <ashishm@mvista.com> writes:

> Hi Senior Members ,
>
> Good Evening.
>
> I am trying to get SELINUX on our custom SDK for which we have added :
> a) Userland libraries and tools projects from
> https://github.com/SELinuxProject/selinux
> b) Refpolicy from https://github.com/SELinuxProject/refpolicy
>
> With these added , I can't see binary for applications like semanage &
> sesearch .
> Further looking I tried to get the packages mentioned below which
> provide these binaries.
> Can members please let me know which stable source code for
>        a) policycoreutils-python    ( to get semanage on target )

semanage is a python script -
https://github.com/SELinuxProject/selinux/blob/master/python/semanage/semanage

The latest released version is provided by selinux-python-3.1.tar.gz,
see https://github.com/SELinuxProject/selinux/releases/tag/20200710

SELinux libraries and tools can be installed from distribution packages
or built from sources, see README.md -
https://github.com/SELinuxProject/selinux/blob/master/README.md 

You can download sources directly form the repo or use the latest
release -
https://github.com/SELinuxProject/selinux/releases/tag/20200710 -
https://github.com/SELinuxProject/selinux/archive/20200710.tar.gz


>        b) setools-console              ( to get seinfo / sesearch on target )

seinfo and sesearch are part of SETools, see
https://github.com/SELinuxProject/setools/blob/master/README.md


> Since I came across these while working for another issue , I thought of
> creating a new thread just for this to keep it separate .
> Please do let me know if this is violating any accepted norms of
> community here ,
> I would align with community rules.
>


