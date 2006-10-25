Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9PHGJbJ032091
	for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 13:16:19 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9PHFW1U001401
	for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 17:15:33 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7) with ESMTP id k9PHFene013352
	for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 13:15:41 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k9PHFeNb013351
	for selinux@tycho.nsa.gov; Wed, 25 Oct 2006 13:15:40 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9PGq2DK031290
	for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 12:52:02 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9PGoV3h015085
	for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 16:50:32 GMT
Received: by wx-out-0506.google.com with SMTP id i26so191890wxd
        for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 09:52:03 -0700 (PDT)
Message-ID: <5c49b0ed0610250952i2fcc64b7t47fb7565cada14c6@mail.gmail.com>
Date: Wed, 25 Oct 2006 09:52:03 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "David Howells" <dhowells@redhat.com>
Subject: Re: Security issues with local filesystem caching
Cc: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
        "Christoph Hellwig" <hch@infradead.org>
In-Reply-To: <16969.1161771256@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <16969.1161771256@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/25/06, David Howells <dhowells@redhat.com> wrote:
>
> Hi,
>
> Some issues have been raised by Christoph Hellwig over how I'm handling
> filesystem security in my CacheFiles module, and I'd like advice on how to deal
> with them.
>
> CacheFiles stores its cache objects as files and directories in a tree under a
> directory nominated by the configuration.  This means the data it is holding
> (a) is potentially exposed to userspace, and (b) must be labelled for access
> control according to the usual filesystem rules.
>
> Currently, CacheFiles temporarily changes fsuid and fsgid to 0 whilst doing its
> own pathwalk through the cache and whilst creating files and directories in the
> cache.  This allows it to deal with DAC security directly.  All the directories
> it creates are given permissions mask 0700 and all files 0000.
>
> However, Christoph has objected to this practice, and has said that I'm not
> allowed to change fsuid and fsgid.  The problem with not doing so is that this
> code is running in the context of the process that issued the original open(),
> read(), write(), etc, and so any accesses or creations it does would be done
> with that process's fsuid and fsgid, which would lead to a cache with bits that
> can't be shared between users.

I don't really understand the objection here.  Is it likely to cause
security breaches?  None of the proposed solutions seem particularly
elegant, so arguing that the current approach is a hack doesn't hold
much water with me.

> Another thing I'm currently doing is bypassing the usual calls to the LSM
> hooks.  This means that I'm not setting and checking security labels and MACs.
> The reason for this is again that I'm running in some random process's context
> and labelling and MAC'ing will affect the sharability of the cache.  This was
> objected to also.
>
> This also bypasses auditing (I think).  I don't want the CacheFiles module's
> access to the cache to be logged against whatever process was accessing, say,
> an NFS file.  That process didn't ask to access the cache, and the cache is
> meant to be transparent.

Christoph, are you objecting to this behavior as well?  This seems
like the desired outcome.  Do you think there is buggy behavior here,
or do you just have issues with David's design?  Can you suggest any
alternatives of your own?

NATE

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
