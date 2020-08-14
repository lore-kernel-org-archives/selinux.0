Return-Path: <SRS0=MRHa=BY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42910C433DF
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 17:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2679C20791
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 17:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgHNRq5 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNRq4 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 14 Aug 2020 13:46:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B91CC20774;
        Fri, 14 Aug 2020 17:46:54 +0000 (UTC)
Date:   Fri, 14 Aug 2020 13:46:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?B?VGhpw6li?= =?UTF-8?B?YXVk?= Weksteen 
        <tweek@google.com>, Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] selinux: add tracepoint on denials
Message-ID: <20200814134653.0ba7f64e@oasis.local.home>
In-Reply-To: <3518887d-9083-2836-a8db-c7c27a70c990@sony.com>
References: <20200813144914.737306-1-tweek@google.com>
        <15e2e26d-fe4b-679c-b5c0-c96d56e09853@gmail.com>
        <CA+zpnLcf94HGmE=CGH6nT8ya0oax5orXc5nP1qToUgaca6FeQg@mail.gmail.com>
        <CAEjxPJ50vrauP7dd-ek15vwnMN1kvAyvYSc0fhR4xwCJEQSFxQ@mail.gmail.com>
        <ad64b5af-93de-e84e-17ca-40d8dd3cfe44@sony.com>
        <CAEjxPJ67G24T1a5WitmMqL4RUpjOgQFwpQ8unO1-OXSS=35V4Q@mail.gmail.com>
        <3518887d-9083-2836-a8db-c7c27a70c990@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 14 Aug 2020 19:22:13 +0200
peter enderborg <peter.enderborg@sony.com> wrote:

> On 8/14/20 7:08 PM, Stephen Smalley wrote:
> > On Fri, Aug 14, 2020 at 1:07 PM peter enderborg
> > <peter.enderborg@sony.com> wrote:  
> >> On 8/14/20 6:51 PM, Stephen Smalley wrote:  
> >>> On Fri, Aug 14, 2020 at 9:05 AM Thiébaud Weksteen <tweek@google.com> wrote:  
> >>>> On Thu, Aug 13, 2020 at 5:41 PM Stephen Smalley
> >>>> <stephen.smalley.work@gmail.com> wrote:  
> >>>>> An explanation here of how one might go about decoding audited and
> >>>>> tclass would be helpful to users (even better would be a script to do it
> >>>>> for them).  Again, I know how to do that but not everyone using
> >>>>> perf/ftrace will.  
> >>>> What about something along those lines:
> >>>>
> >>>> The tclass value can be mapped to a class by searching
> >>>> security/selinux/flask.h. The audited value is a bit field of the
> >>>> permissions described in security/selinux/av_permissions.h for the
> >>>> corresponding class.  
> >>> Sure, I guess that works.  Would be nice if we just included the class
> >>> and permission name(s) in the event itself but I guess you viewed that
> >>> as too heavyweight?  
> >> The class name is added in part 2. Im not sure how a proper format for permission
> >> would look like in trace terms. It is a list, right?  
> > Yes.  See avc_audit_pre_callback() for example code to log the permission names.  
> 
> I wrote about that on some of the previous sets. The problem is that trace format is quite fixed. So it is lists are not
> that easy to handle if you want to filter in them. You can have a trace event for each of them. You can also add
> additional trace event "selinux_audied_permission" for each permission. With that you can filter out tclass or permissions.
> 
> But the basic thing we would like at the moment is a event that we can debug in user space.

We have a trace_seq p helper, that lets you create strings in
TP_printk(). I should document this more. Thus you can do:

extern const char *audit_perm_to_name(struct trace_seq *p, u16 class, u32 audited);
#define __perm_to_name(p, class, audited) audit_perm_to_name(p, class, audited)

	TP_printk("tclass=%u audited=%x (%s)",
		__entry->tclass,
		__entry->audited,
		__perm_to_name(__entry->tclass, __entry->audited))


const char *audit_perm_to_name(struct trace_seq *p, u16 tclass, u32 av)
{
	const char *ret = trace_seq_buffer_ptr(p);
	int i, perm;

	( some check for tclass integrity here)

	perms = secclass_map[tclass-1].perms;

	i = 0;
	perm = 1;
	while (i < (sizeof(av) * 8)) {
		if ((perm & av) && perms[i]) {
			trace_seq_printf(p, " %s", perms[i]);
			av &= ~perm;
		}
		i++;
		perm <<= 1;
	}

	return ret;
}

Note, this wont work for perf and trace-cmd as it wouldn't know how to
parse it, but if the tclass perms are stable, you could create a plugin
to libtraceevent that can do the above as well.

-- Steve
