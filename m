Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B347C433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E38D207D8
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 14:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKAalPVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbgE0OO2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 10:14:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51037 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388376AbgE0OOY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 10:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590588863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dctxeA759qsefX6QIwxwGGafAWwHT3wkT86+72lNh4I=;
        b=AKAalPVw95f6tS/LjkeMRs7EQTvwPOYH6Ld7pzfqGuV9LFc6zNUjDiq/N7UKuWGJDi2wf4
        VArN/XLl+/no47mes2Pe1SQuxaEKfk+hUstvCD1pw5zpuRdDwKWBO8XvPD/Vp9Ks0heFxE
        fFolfgLpBxDS/Sr4MXThb+/zgvani98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-cCwpMpz8MJGNDHIv5dmS8w-1; Wed, 27 May 2020 10:14:19 -0400
X-MC-Unique: cCwpMpz8MJGNDHIv5dmS8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7862C8018A7;
        Wed, 27 May 2020 14:14:16 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-113-73.ams2.redhat.com [10.36.113.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4C705C1B0;
        Wed, 27 May 2020 14:14:05 +0000 (UTC)
Date:   Wed, 27 May 2020 16:14:03 +0200
From:   Adrian Reber <areber@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
Message-ID: <20200527141403.GC250149@dcbz.redhat.com>
References: <20200522055350.806609-1-areber@redhat.com>
 <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com>
 <877dwybxvi.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dwybxvi.fsf@x220.int.ebiederm.org>
X-Operating-System: Linux (5.6.11-300.fc32.x86_64)
X-Load-Average: 0.82 0.68 0.60
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 26, 2020 at 08:59:29AM -0500, Eric W. Biederman wrote:
> Adrian Reber <areber@redhat.com> writes:
> 
> > On Fri, May 22, 2020 at 09:40:37AM -0700, Casey Schaufler wrote:
> 
> >> What are the other blockers? Are you going to suggest additional new
> >> capabilities to clear them?
> >
> > As mentioned somewhere else access to /proc/<pid>/map_files/ would be
> > helpful. Right now I am testing with a JVM and it works without root
> > just with the attached patch. Without access to /proc/<pid>/map_files/
> > not everything CRIU can do will actually work, but we are a lot closer
> > to what our users have been asking for.
> 
> The current permission checks on /proc/<pid>/map_files/ are simply
> someone being over-cautious.
> 
> Someone needs to think through the threat landscape and figure out what
> permission checks are actually needed.
> 
> Making the permission check ns_capable instead of capable is a
> no-brainer.  Figuring out which user_ns to test against might be a
> we bit harder.
> 
> We could probably even allow the owner of the process to open the files
> but that requires someone doing the work of thinking through how
> being able to opening files that you have mmaped might be a problem.

As mentioned in the other thread, CRIU can work with read access to
map_files.

> >> > There are probably a few more things guarded by CAP_SYS_ADMIN required
> >> > to run checkpoint/restore as non-root,
> >> 
> >> If you need CAP_SYS_ADMIN anyway you're not gaining anything by
> >> separating out CAP_RESTORE.
> >
> > No, as described we can checkpoint and restore a JVM with this patch and
> > it also solves the problem the set_ns_last_pid fork() loop daemon tries
> > to solve. It is not enough to support the full functionality of CRIU as
> > map_files is also important, but we do not need CAP_SYS_ADMIN and
> > CAP_RESTORE. Only CAP_RESTORE would be necessary.
> >
> > With a new capability users can enable checkpoint/restore as non-root
> > without giving CRIU access to any of the other possibilities offered by
> > CAP_SYS_ADMIN. Setting a PID and map_files have been introduced for CRIU
> > and used to live behind CONFIG_CHECKPOINT_RESTORE. Having a capability
> > for checkpoint/restore would make it easier for CRIU users to run it as
> > non-root and make it very clear what is possible when giving CRIU the
> > new capability. No other things would be allowed than necessary for
> > checkpoint/restore. Setting a PID is most important for the restore part
> > and reading map_files would be helpful during checkpoint. So it actually
> > should be called CAP_CHECKPOINT_RESTORE as Christian mentioned in
> > another email.
> 
> Please if one is for checkpoint and one is for restore asking for a pair
> of capabilities is probably more appropriate.

I will send out a v2 with a renamed capability soon and also include
map_files to be readable with that capability.

> >> >  but by applying this patch I can
> >> > already checkpoint and restore processes as non-root. As there are
> >> > already multiple workarounds I would prefer to do it correctly in the
> >> > kernel to avoid that CRIU users are starting to invent more workarounds.
> >> 
> >> You've presented a couple of really inappropriate implementations
> >> that would qualify as workarounds. But the other two are completely
> >> appropriate within the system security policy. They don't "get around"
> >> the problem, they use existing mechanisms as they are intended.
> >
> > I agree with the user namespace approach to be appropriate, but not the
> > CAP_SYS_ADMIN approach as CRIU only needs a tiny subset (2 things) of
> > what CAP_SYS_ADMIN allows.
> 
> 
> If we are only talking 2 things can you please include in your patchset
> a patch enabling those 2 things?

The two things are setting a PID via ns_last_pid/clone3() and reading
map_files.

> But even more than this we need a request that asks not for the least
> you can possibly ask for but asks for what you need to do a good job.

Also in this thread Kamil mentioned that they also need calling prctl
with PR_SET_MM during restore in their production setup.

> I am having visions of a recurring discussion that says can we add one
> more permission check to CAP_RESTORE or CAP_CHECKPOINT when they are
> things we could know today.

I will prepare a new version of this patch using CAP_CHECKPOINT_RESTORE
for ns_last_pid/clone3(), map_files, and prctl with PR_SET_MM.

		Adrian

