Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6792C433DB
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 15:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2E464FB0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 15:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhCDP0o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231946AbhCDP0S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 10:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614871493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XxvADttYW50rWCXLLjXkfpqWm3g7ayZEyf773NfcFvk=;
        b=dQ78AEHv+8gT0hIINQBvZQvrwFAL8S9j0Rx0tPBQ71+uFjjffaO5DSxmdXOv4aZnD1s0+r
        374PdP4bb/7mtgsffEWMCG/tHHsth0vCCJ/fiy+X9ScrFkdD7ugW/qyrDSOD/QqmA2F/c+
        RXgfGyRqkGLS3nQ7GnmVYw+0H3GaVEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-3vQpgPCuMoy5mDjHL8r2mA-1; Thu, 04 Mar 2021 10:24:50 -0500
X-MC-Unique: 3vQpgPCuMoy5mDjHL8r2mA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E233819057A2
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 15:24:49 +0000 (UTC)
Received: from localhost (unknown [10.40.196.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B35653E35;
        Thu,  4 Mar 2021 15:24:49 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Subject: Re: [PATCH userspace] fixfiles: do not exclude /dev and /run in -C
 mode
In-Reply-To: <CAFqZXNuzTSEok=x3ZyVyQvUK_DsBS6Ykfxk6DrUPLpnF+TQGRw@mail.gmail.com>
References: <20210301171922.321907-1-omosnace@redhat.com>
 <871rcv9dww.fsf@redhat.com>
 <CAFqZXNuzTSEok=x3ZyVyQvUK_DsBS6Ykfxk6DrUPLpnF+TQGRw@mail.gmail.com>
Date:   Thu, 04 Mar 2021 16:24:48 +0100
Message-ID: <87y2f37xhb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Thu, Mar 4, 2021 at 3:44 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>> Ondrej Mosnacek <omosnace@redhat.com> writes:
>>
>> > I can't think of a good reason why they should be excluded. On the
>> > contrary, excluding them can cause trouble very easily if some labeling
>> > rules for these directories change. For example, we changed the label
>> > for /dev/nvme* from nvme_device_t to fixed_disk_device_t in Fedora
>> > (updating the allow rules accordingly) and after policy update they
>> > ended up with an invalid context, causing denials.
>>
>> I guess that /dev/ is there in order to avoid relabeling tty devices and block
>> the user from access:
>>
>> [root@localhost ~]# ls -Z /dev/tty1
>> user_u:object_r:user_tty_device_t:s0 /dev/tty1
>>
>> [root@localhost ~]# matchpathcon /dev/tty1
>> /dev/tty1       system_u:object_r:tty_device_t:s0
>
> $ sudo chcon user_u:object_r:user_tty_device_t:s0 /dev/tty21
> $ ll -Z /dev/tty21
> crw--w----. 1 root tty user_u:object_r:user_tty_device_t:s0 4, 21 feb
> 26 15:13 /dev/tty21
> $ sudo restorecon -v /dev/tty21
> /dev/tty21 not reset as customized by admin to
> user_u:object_r:user_tty_device_t:s0
> $ ll -Z /dev/tty21
> crw--w----. 1 root tty user_u:object_r:user_tty_device_t:s0 4, 21 feb
> 26 15:13 /dev/tty21
>
> $ cat /etc/selinux/targeted/contexts/customizable_types
> container_file_t
> sandbox_file_t
> svirt_image_t
> svirt_home_t
> svirt_sandbox_file_t
> virt_content_t
> httpd_user_htaccess_t
> httpd_user_script_exec_t
> httpd_user_rw_content_t
> httpd_user_ra_content_t
> httpd_user_content_t
> git_session_content_t
> home_bin_t
> user_tty_device_t
>
> restorecon also doesn't change the user portion of the label if I only
> change that to user_u (leaving the type as tty_device_t).
>

Right.

But what is the reason why /dev/ was listed, and /run? And /dev was
there twice so it was probably important to skip /dev/.

Could be the reason that both /dev and /run are important for running
system? There are about 350 file contexts entries related to /dev and
more than 600 to /run. But the only customizable file is
user_tty_device_t.

I don't know. I'd like to avoid such change it there's no clear
confirmation it's not needed anymore.




