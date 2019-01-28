Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5B4C282CD
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 22:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0F020856
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 22:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pVGF+MyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfA1WSz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:18:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36303 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfA1WSz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jan 2019 17:18:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so15729353ljk.3
        for <selinux@vger.kernel.org>; Mon, 28 Jan 2019 14:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7Gs7bTAwClf5KxYna9Vewiot580IUcIoS/C4VroQj0=;
        b=pVGF+MyIyAJ8WyCraAGurY1wEkFM3NfO3p5OQ2PaHiL5NhC5lBqSb4djOUEhYmcQv/
         UHJ2BAND6mkYAanUwKd3J4Vd5RszkpIwlIWXZpOhAQcKHbkl64HvxHSYNisrZNPv/Fsz
         LiUZFM2LxKoHyIgYVUq9C+e4z77YZGm/aCj2SrECNLZ97TunG3JroVm03meqYZAUq6p7
         zVkfquY5BZlD8QUibD4mz/nFJ1a5os8cC+x0jn1frDOPbgdxLIYm69AmYhjWJQ0khdw0
         qhnyKrou0Y1AQwbNdpLYBDjp1XSflsCL9JmCSRQZYoK3jwvyKDaJKdQMkNdr0z8iXy2/
         K/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7Gs7bTAwClf5KxYna9Vewiot580IUcIoS/C4VroQj0=;
        b=f/jcI0mAC7C3rB/T87iTT8gRZIT/Hdlnwd/4wod8eZ2jBk6uosy2luhG22yIZzMLl+
         OYRjSKY/b/R5OzxNvcbwzX2yCEWsY8goAqi8OzPdG3b04aGCJiWVphmaybPt6ac4ZxqM
         P3cY59Lwz30vt0w7Hmz77jEceEnK464rbuEspKvXtR2WmonvZxxiUKhkxB6S/k/nVRbq
         SPHNqAe5rnixQ9wv4wk104uw/0VwHna1t27UN10jx6VzG9yxppdqIQhHQ0cZjDqo25zs
         JEX6s6g+GcI/IPSzUpi+2SCHxW89xoCbKDipP7Hiu/OFi+Rd+LiWupWb81sloiZ5kiix
         GZOA==
X-Gm-Message-State: AJcUukcO0IvWuAWuzS+1b4ySOwrvpTA6phyz7HBMmWmmVaHeAMKKe98G
        GKfUMgq3HkuiibdHlwKVCJh8kmjiS2SOingt0VCZ
X-Google-Smtp-Source: ALg8bN7F3AwxqmyO1KLKgaxhG/J7lNs744zjDF1omCIYf7PBoTX0rhXMDQDmT/1bjZyMvHdtokYrY3Hfef6a7LWtulI=
X-Received: by 2002:a2e:9c87:: with SMTP id x7-v6mr17654893lji.196.1548713932777;
 Mon, 28 Jan 2019 14:18:52 -0800 (PST)
MIME-Version: 1.0
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
 <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
 <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
 <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
 <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
 <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net> <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
 <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net> <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
 <1125571548681054@iva5-0acfc31d2b43.qloud-c.yandex.net>
In-Reply-To: <1125571548681054@iva5-0acfc31d2b43.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jan 2019 17:18:41 -0500
Message-ID: <CAHC9VhRC8BC9Ocs9FYVrwnWutWD4Dow_MjwpvowxmJd=NtVN5g@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
To:     Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 28, 2019 at 8:10 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> 25.01.2019, 19:46, "Paul Moore" <paul@paul-moore.com>:
> > Hmm, I think the above calculation should take into account the actual
> > length of the IP options, and not just the max size (calculate it
> > based on iphdr->ihl).
> >
> > Beyond that fix, I think it's time to put together a proper patchset
> > and post it to the lists for formal review/merging.
> >
> > Thanks for your work on this.
> >
> > --
> > paul moore
> > www.paul-moore.com
>
> Where we can take actual IP options length? Sorry, I'm not so familiar with linux network stack.

I'm the one who needs to apologize; you're doing it correctly.  Not
sure what I was thinking there, sorry about that.

> And also, ip_options_compile could change IP options data (SSRR, LSRR, RR, TIMESTAMP options),
> so, we can't use ip_options_compile again for these options. Am I right?

If we don't pass a skb into ip_options_compile(), meaning both "skb"
and "rt" will be NULL, then I don't believe the option data will
change.  Am I missing something?

-- 
paul moore
www.paul-moore.com
