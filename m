Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AA3C433E1
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 21:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99296206C3
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 21:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgFIVJz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:09:55 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43448 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgFIVJx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 17:09:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jilVC-00051G-GE; Tue, 09 Jun 2020 15:09:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jilV9-0008Hl-NF; Tue, 09 Jun 2020 15:09:45 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        "Dirk Petersen" <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        "Casey Schaufler" <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-security-module\@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux\@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20200603162328.854164-1-areber@redhat.com>
        <20200603162328.854164-2-areber@redhat.com>
        <20200609184517.GL134822@grain>
        <cda72e8402244a85862f95ea84ff9204@EXMBDFT11.ad.twosigma.com>
Date:   Tue, 09 Jun 2020 16:05:35 -0500
In-Reply-To: <cda72e8402244a85862f95ea84ff9204@EXMBDFT11.ad.twosigma.com>
        (Nicolas Viennot's message of "Tue, 9 Jun 2020 20:09:49 +0000")
Message-ID: <875zc00x28.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jilV9-0008Hl-NF;;;mid=<875zc00x28.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+3zNtYhezsH7anMEiBSb9uRTosANJSnWY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Viennot <Nicolas.Viennot@twosigma.com> writes:

>>>  proc_map_files_get_link(struct dentry *dentry,
>>>  			struct inode *inode,
>>>  		        struct delayed_call *done)
>>>  {
>>> -	if (!capable(CAP_SYS_ADMIN))
>>> +	if (!(capable(CAP_SYS_ADMIN) || capable(CAP_CHECKPOINT_RESTORE)))
>>>  		return ERR_PTR(-EPERM);
>
>> First of all -- sorry for late reply. You know, looking into this
>> code more I think this CAP_SYS_ADMIN is simply wrong: for example I
>> can't even fetch links for /proc/self/map_files. Still
>> /proc/$pid/maps (which as well points to the files opened) test for
>> ptrace-read permission. I think we need ptrace-may-attach test here
>> instead of these capabilities (if I can attach to a process I can
>> read any data needed, including the content of the mapped files, if
>> only I'm not missing something obvious).
>
> Currently /proc/pid/map_files/* have exactly the same permission
> checks as /proc/pid/fd/*, with the exception of the extra
> CAP_SYS_ADMIN check. The check originated from the following
> discussions where 3 security issues are discussed:
> http://lkml.iu.edu/hypermail/linux/kernel/1505.2/02524.html
> http://lkml.iu.edu/hypermail/linux/kernel/1505.2/04030.html
>
> From what I understand, the extra CAP_SYS_ADMIN comes from the
> following issues:

> 1. Being able to open dma-buf / kdbus region (referred in the
> referenced email as problem #1). I don't fully understand what the
> dangers are, but perhaps we could do CAP_SYS_ADMIN check only for such
> dangerous files, as opposed to all files.

I don't know precisely the concern but my memory is that some drivers do
interesting things when mmaped.  Possibly even to changing the vm_file.

I think that is worth running to the ground and figuring out in the
context of checkpoint/restart because the ordinary checkpoint/restart
code won't be able deal with them either.

So I vote for figuring that case out and dealing with it.


> 2. /proc/pid/fd/* is already a security hole (Andy says "I hope to fix
> that some day"). He essentially says that it's not because fds are
> insecure that map_files should be too. He seems to claim that mapped
> files that are then closed seems to be a bigger concern than other
> opened files. However, in the present time (5 years after these email
> conversations), the fd directory does not have the CAP_SYS_ADMIN check
> which doesn't convinces me that the holes of /proc/pid/fd/* are such a
> big of a deal. I'm not entirely sure what security issue Andy refers
> to, but, I understand something along the lines of: Some process gets
> an fd of a file read-only opened (via a unix socket for example, or
> after a chroot), and gets to re-open the file in write access via
> /proc/self/fd/N to do some damage.

I would hope the other permission checks on such a file will prevent
some of that nonsense.  But definitely worth taking a hard look at.

> 3. Being able to ftruncate a file after a chroot+privilege drop. I may
> be wrong, but if privileges were dropped, then there's no reason that
> the then unprivileged user would have write access to the mmaped file
> inode. Seems a false problem.

Yes.

> It turns out that some of these concerns have been addressed with the
> introduction of memfd with seals, introduced around the same time
> where the map_files discussions took place. These seals allow one to
> share write access of an mmap region to an unsecure program, without
> fearing of getting a SIGBUS because the unsecure program could call
> ftruncate() on the fd. More on that at
> https://lwn.net/Articles/593918/ . Also, that article says "There are
> a number of fairly immediate use cases for the sealing functionality
> in general. Graphics drivers could use it to safely receive buffers
> from applications. The upcoming kdbus transport can benefit from
> sealing.". This rings a bell with problem #1. Perhaps memfd is a
> solution to Andy's concerns?

> Overall, I think the CAP_SYS_ADMIN map_files/ extra check compared to
> fd/ does not improve security in practice. Fds will be given to
> insecure programs. Better security can be achieved with memfd seals,
> and sane permissioning on files, regardless if they were once closed.

I would love to see the work put in to safely relax the permission check
from capable to ns_capable.  Which is just dealing with point 1.

There might be some other assumptions that a process can't get at mmaped
regions.

Eric



