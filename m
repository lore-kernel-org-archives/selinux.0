Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D6EC0018C
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 19:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377392AbjKBTA4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 15:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377378AbjKBTAs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 15:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF9812D
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698951598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GEm2sns0/+Gc/wAqvpwT2aL5eohIrGGeBjAVrS1qrIg=;
        b=fJcTFQHXZndQggvIKmomnTBLTGtmkPP9v7KBdRHIKoVmjt93HFq1MqagLmhUcN+eryqwOA
        sGtqlCw0H3wgichHevFqy60z6l7RXLmLKHGJLWl7U7ZQdJQKCK9cbWnON5+E+uayNKIqNw
        5+lKkW9j3K/xXk9DjQee7CzVh7C0qjU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-YZa4o3IwNvSmwv5gp8udzg-1; Thu, 02 Nov 2023 14:59:54 -0400
X-MC-Unique: YZa4o3IwNvSmwv5gp8udzg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4084d08235fso7998375e9.3
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 11:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951593; x=1699556393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEm2sns0/+Gc/wAqvpwT2aL5eohIrGGeBjAVrS1qrIg=;
        b=wf+LRtp+BfswFJiv0yKa4MLheBv18Z8wLiG0Rb0yQAxI/gSTI06skqqXYmzmwtgAyF
         MVzWztDLYAq6krhNxZlY/DH3tsAg1+8r3NQ+3iPdXTaL/mpjeQYzSYacCfWtuKdJ4Eyo
         pnLgFmOXE6Uxi1iPOJ6ufcL6HLnbnW4lHjYrlrUqZuDED1xjbCoBzCPIPcBrRFeM6fs7
         JfdiScFEcCuJrO8TPBzGC27tWfH6SboRppTb/sfC7kJ83dDBsxReTIBGrFiq1bvsOR7k
         wBtlGJ7okZho003PGn26nrITu7Rm+Dd/UsqTWHrTNFAD/k2hYmO8HGystvoly2uNfrKi
         Voqw==
X-Gm-Message-State: AOJu0YxnPRXVVDnh7y9oQNl+eov9TgWqM2UIMbqh+5eCtazJcOnPIckg
        c3oZDX29EOqT4V+BevOCAOce6yABRvzUv46ObH7UiNgNf7tBqRDnYZ1DITfcYUJ2bixHtwz6l9p
        q1CcxbV+jG5j4E24XuA==
X-Received: by 2002:a05:600c:354c:b0:408:4cf7:4f91 with SMTP id i12-20020a05600c354c00b004084cf74f91mr16063509wmq.16.1698951593783;
        Thu, 02 Nov 2023 11:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVTJzaSJ0vkl4qcwzTZ0JUe1Z1QgiS+92pttSKu/xQqyJpNN5GsaGvuUhusOPQ1kxeMxjXtw==
X-Received: by 2002:a05:600c:354c:b0:408:4cf7:4f91 with SMTP id i12-20020a05600c354c00b004084cf74f91mr16063485wmq.16.1698951593366;
        Thu, 02 Nov 2023 11:59:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b00405c7591b09sm31517wmq.35.2023.11.02.11.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:59:52 -0700 (PDT)
Date:   Thu, 2 Nov 2023 14:59:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, xieyongji@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
Message-ID: <20231102145932-mutt-send-email-mst@kernel.org>
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
 <20231020155819.24000-5-maxime.coquelin@redhat.com>
 <c8f189e6-c79b-429a-ab36-2193bb68e3e9@schaufler-ca.com>
 <923f87a1-1871-479e-832e-db67b5ae87fd@redhat.com>
 <64626db9-e37a-4c65-a455-fc3985382216@schaufler-ca.com>
 <7524dee3-7c48-4864-8182-1b166b0f6faa@redhat.com>
 <b307ec62-7cfd-4a58-88ef-ea549c64e75e@schaufler-ca.com>
 <76572500-5f90-46fe-9bf2-b090bf1b616b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76572500-5f90-46fe-9bf2-b090bf1b616b@redhat.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 02, 2023 at 06:56:59PM +0100, Maxime Coquelin wrote:
> 
> 
> On 10/24/23 17:30, Casey Schaufler wrote:
> > On 10/24/2023 2:49 AM, Maxime Coquelin wrote:
> > > 
> > > 
> > > On 10/23/23 17:13, Casey Schaufler wrote:
> > > > On 10/23/2023 12:28 AM, Maxime Coquelin wrote:
> > > > > 
> > > > > 
> > > > > On 10/21/23 00:20, Casey Schaufler wrote:
> > > > > > On 10/20/2023 8:58 AM, Maxime Coquelin wrote:
> > > > > > > This patch introduces LSM hooks for devices creation,
> > > > > > > destruction and opening operations, checking the
> > > > > > > application is allowed to perform these operations for
> > > > > > > the Virtio device type.
> > > > > > 
> > > > > > Why do you think that there needs to be a special LSM check for virtio
> > > > > > devices? What can't existing device attributes be used?
> > > > > 
> > > > > Michael asked for a way for SELinux to allow/prevent the creation of
> > > > > some types of devices [0].
> > > > > 
> > > > > A device is created using ioctl() on VDUSE control chardev. Its type is
> > > > > specified via a field in the structure passed in argument.
> > > > > 
> > > > > I didn't see other way than adding dedicated LSM hooks to achieve this,
> > > > > but it is possible that their is a better way to do it?
> > > > 
> > > > At the very least the hook should be made more general, and I'd have to
> > > > see a proposal before commenting on that. security_dev_destroy(dev)
> > > > might
> > > > be a better approach. If there's reason to control destruction of vduse
> > > > devices it's reasonable to assume that there are other devices with the
> > > > same or similar properties.
> > > 
> > > VDUSE is different from other devices as the device is actually
> > > implemented by the user-space application, so this is very specific in
> > > my opinion.
> > 
> > This is hardly unique. If you're implementing the device
> > in user-space you may well be able to implement the desired
> > controls there.
> > 
> > > 
> > > > 
> > > > Since SELinux is your target use case, can you explain why you can't
> > > > create SELinux policy to enforce the restrictions you're after? I
> > > > believe
> > > > (but can be proven wrong, of course) that SELinux has mechanism for
> > > > dealing
> > > > with controls on ioctls.
> > > > 
> > > 
> > > I am not aware of such mechanism to deal with ioctl(), if you have a
> > > pointer that would be welcome.
> > 
> > security/selinux/hooks.c
> 
> We might be able to extend selinux_file_ioctl(), but that will only
> covers the ioctl for the control file, this patch also adds hook for the
> device file opening that would need dedicated hook as the device type
> information is stored in the device's private data.
> 
> Michael, before going further, I would be interested in your feedback.
> Was this patch what you had in mind when requesting for a way to
> allow/deny devices types for a given application?
> 
> Regards,
> Maxime


Yes, this is more or less what I had in mind.

> > 
> > > 
> > > Thanks,
> > > Maxime
> > > 
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Maxime
> > > > > 
> > > > > [0]:
> > > > > https://lore.kernel.org/all/20230829130430-mutt-send-email-mst@kernel.org/
> > > > > 
> > > > > 
> > > > 
> > > 
> > 

