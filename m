Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE557C4332F
	for <selinux@archiver.kernel.org>; Mon, 17 Oct 2022 12:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJQMAi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJQMAH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Oct 2022 08:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B79275E3
        for <selinux@vger.kernel.org>; Mon, 17 Oct 2022 05:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666008004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MvPpfomsgvZnZ7vBer1zgWV4wPg9G3zOFyUwWHsExjk=;
        b=S4fhhR42PqQZBv0XrVzaRtbUUbg6UciAV/nCj5htsuGbnwq0Rpp1I/Nr/qFdfbp7vS6/cq
        F/ghZysrXmLn56f2Xbzp+cK421FrMCZQjjSUEsF6F2GMfUGGUE9GCCNohaAN4B78h8LWc0
        cy53I5fflgIotzSMQfmsyKBMM0tmE00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-GRrpkDOBMN6e-5Yvc5PlJw-1; Mon, 17 Oct 2022 08:00:00 -0400
X-MC-Unique: GRrpkDOBMN6e-5Yvc5PlJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D34C833A06;
        Mon, 17 Oct 2022 12:00:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC4B640CA40C;
        Mon, 17 Oct 2022 11:59:59 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Daniel Burgener <dburgener@linux.microsoft.com>
Subject: Re: [PATCH] libselinux: Add missing '\n' to avc_log() messages
In-Reply-To: <CAJ2a_DeMFWTmZLQhekME+Qr9VDYaknq+vvDjrP=5qA25PeV1Bg@mail.gmail.com>
References: <20221011112733.194079-1-plautrba@redhat.com>
 <877d12sn5v.fsf@redhat.com>
 <3e5a0cb1-73e5-6268-2c0b-4f470080073e@linux.microsoft.com>
 <87wn92qxmq.fsf@redhat.com>
 <CAJ2a_DeMFWTmZLQhekME+Qr9VDYaknq+vvDjrP=5qA25PeV1Bg@mail.gmail.com>
Date:   Mon, 17 Oct 2022 13:59:58 +0200
Message-ID: <87sfjmr77l.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> On Fri, 14 Oct 2022 at 16:37, Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Daniel Burgener <dburgener@linux.microsoft.com> writes:
>>
>> > On 10/14/2022 6:41 AM, Petr Lautrbach wrote:
>> >> Petr Lautrbach <plautrba@redhat.com> writes:
>> >>
>> >>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> >>> ---
>> >>>   libselinux/src/avc.c          | 2 +-
>> >>>   libselinux/src/avc_internal.c | 4 ++--
>> >>>   libselinux/src/checkAccess.c  | 4 ++--
>> >>>   3 files changed, 5 insertions(+), 5 deletions(-)
>> >>>
>> >>> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
>> >>> index 8d5983a2fe0c..98a3fcae41c8 100644
>> >>> --- a/libselinux/src/avc.c
>> >>> +++ b/libselinux/src/avc.c
>> >>> @@ -725,7 +725,7 @@ void avc_audit(security_id_t ssid, security_id_t=
 tsid,
>> >>>     if (denied)
>> >>>             log_append(avc_audit_buf, " permissive=3D%u", result ? 0=
 : 1);
>> >>>
>> >>> -   avc_log(SELINUX_AVC, "%s", avc_audit_buf);
>> >>> +   avc_log(SELINUX_AVC, "%s\n", avc_audit_buf);
>> >>
>> >>
>> >> There is a conflict between this change and commit 142372522c7e ("lib=
selinux: avoid
>> >> newline in avc message").
>> >>
>> >> I'll send another version without it.
>> >
>> > Now that you've pointed out Christian's patch, this feels like
>> > potentially the wrong level to solve this.
>> >
>> > As I understand it, the issue Christian was trying to solve is that
>> > audit doesn't parse as we intend if there is a newline in the middle of
>> > the message, and userspace object managers append additional material =
to
>> > USER_AVC messages.  Hence his removal of newline above.
>> >
>> > The problem this patch is trying to solve is that when SELinux aware
>> > applications call logging functions in libselinux, they get printed
>> > directly to standard error, and in that case really should end in a ne=
wline.
>> >
>> > Secondarily, this patch solves the fact that previously the messages
>> > logged by SELinux were just inconsistent with regards to final newline=
s.
>> >
>> > It happens that in the current state of things, userspace object
>> > managers append to AVCs above, and rpm had issues with setenforce and
>> > policyload, so segregating newlines based on message type as this patch
>> > with the above hunk dropped would do addresses all the issues.
>> >
>> > I feel like that's sort of a happenstance that this is the current sta=
te
>> > of the code though, and if a future change results in SELinux aware
>> > applications dumping AVCs directly to standard error for example, then
>> > there won't be a good solution in the current approach.
>> >
>> > Would it be perhaps a cleaner solution to standardize all libselinux
>> > messages on no newline and then changing default_selinux_log() to appe=
nd
>> > a newline since that's writing directly to stderr and relying on calle=
rs
>> > into libselinux to add a newline if needed?
>>
>> This is exactly my thoughts and reason why I haven't sent the new patch
>> yet.
>>
>> If we do this we would need to check all main consumers whether they
>> depend on the new line or not.
>
> First of all I agree that log messages should fbe consistent in
> whether they end with a newline or not, and that bahavior should be
> documented (probably in selinux_set_callback(3)).
>
> Looking at some callers of selinux_set_callback(3):
>
>
> I. systemd
>
> log_callback() [1] forwards the message either to
> audit_log_user_avc_message(3), which does not expect a trailing
> newline, or to the internal function log_internalv(), which to my
> analysis also do not.
>
> [1]: https://github.com/systemd/systemd/blob/3e15bed410ff616f5015b4e87eb2=
5d1fee8828e5/src/core/selinux-access.c#L97
>
>
> II. dbus-broker
>
> bus_selinux_log() [2] forwards the message to the internal function
> util_audit_log() [3], which either forwards it to
> audit_log_user_avc_message(3) or explitcitly add a newline when
> printing to stderr.
>
> [2]: https://github.com/bus1/dbus-broker/blob/ef1c9f03a6be40474486044b6a2=
8780d12107d9b/src/util/selinux.c#L288
> [3]: https://github.com/bus1/dbus-broker/blob/ef1c9f03a6be40474486044b6a2=
8780d12107d9b/src/util/audit.c#L104
>
>
> III. dbus
>
> log_callback() [4] forwards the message either to
> audit_log_user_avc_message(3) or vsyslog(3), which both do not expect
> a trailing newline.
>
> [4]: https://gitlab.freedesktop.org/dbus/dbus/-/blob/master/bus/selinux.c=
#L95
>
>
> IV. pam
>
> log_callback() [5] forwards the message either to
> audit_log_user_avc_message(3) or vsyslog(3), which both do not expect
> a trailing newline.
>
> [5]: https://github.com/linux-pam/linux-pam/blob/f69a6042da801096c94b3046=
5c118e17c803f5c2/modules/pam_rootok/pam_rootok.c#L54
>
>
> V. shadow
>
> selinux_log_cb() [6] forwards the message either to
> audit_log_user_avc_message(3) or via a SYSLOG wrapper to syslog(3),
> which both do not expect a trailing newline.
>
> [6]: https://github.com/shadow-maint/shadow/blob/16afe18142bf8e0ba8b315aa=
c10526b8998fa98e/lib/selinux.c#L113
>
>
> Summary:
>
> All of the checked applications expect a message without a trailing
> newline, so I would favor dropping all newlines from existing
> libselinux log messages and explicitly add a newline in the default
> handler, default_selinux_log(), printing to stderr.
>

Thanks!

I will prepare a patch that removes all newline characters from
avc_log() messages, adds a newline character to the default handler, and
adds a note to the selinux_set_callback() man page stating that messages
do not contain newline characters.


Petr





>>
>> Or given the number of avc_log() with "\n" vs those without, we could
>> revert Christian's patch, document that messages are always ended with
>> "\n" and let consumers strip it.
>>
>>
>> Petr
>>
>>
>>
>> >
>> > -Daniel
>> >
>> >>
>> >>
>> >>>
>> >>>     avc_release_lock(avc_log_lock);
>> >>>   }
>> >>> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_inte=
rnal.c
>> >>> index 71a1357bc564..c550e5788527 100644
>> >>> --- a/libselinux/src/avc_internal.c
>> >>> +++ b/libselinux/src/avc_internal.c
>> >>> @@ -59,7 +59,7 @@ int avc_process_setenforce(int enforcing)
>> >>>     int rc =3D 0;
>> >>>
>> >>>     avc_log(SELINUX_SETENFORCE,
>> >>> -           "%s:  op=3Dsetenforce lsm=3Dselinux enforcing=3D%d res=
=3D1",
>> >>> +           "%s:  op=3Dsetenforce lsm=3Dselinux enforcing=3D%d res=
=3D1\n",
>> >>>             avc_prefix, enforcing);
>> >>>     if (avc_setenforce)
>> >>>             goto out;
>> >>> @@ -81,7 +81,7 @@ int avc_process_policyload(uint32_t seqno)
>> >>>     int rc =3D 0;
>> >>>
>> >>>     avc_log(SELINUX_POLICYLOAD,
>> >>> -           "%s:  op=3Dload_policy lsm=3Dselinux seqno=3D%u res=3D1",
>> >>> +           "%s:  op=3Dload_policy lsm=3Dselinux seqno=3D%u res=3D1\=
n",
>> >>>             avc_prefix, seqno);
>> >>>     rc =3D avc_ss_reset(seqno);
>> >>>     if (rc < 0) {
>> >>> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAcce=
ss.c
>> >>> index 022cd6b5ecab..319af267c6a7 100644
>> >>> --- a/libselinux/src/checkAccess.c
>> >>> +++ b/libselinux/src/checkAccess.c
>> >>> @@ -44,7 +44,7 @@ int selinux_check_access(const char *scon, const c=
har *tcon, const char *class,
>> >>>          sclass =3D string_to_security_class(class);
>> >>>          if (sclass =3D=3D 0) {
>> >>>            rc =3D errno;
>> >>> -          avc_log(SELINUX_ERROR, "Unknown class %s", class);
>> >>> +          avc_log(SELINUX_ERROR, "Unknown class %s\n", class);
>> >>>            if (security_deny_unknown() =3D=3D 0)
>> >>>                    return 0;
>> >>>            errno =3D rc;
>> >>> @@ -54,7 +54,7 @@ int selinux_check_access(const char *scon, const c=
har *tcon, const char *class,
>> >>>          av =3D string_to_av_perm(sclass, perm);
>> >>>          if (av =3D=3D 0) {
>> >>>            rc =3D errno;
>> >>> -          avc_log(SELINUX_ERROR, "Unknown permission %s for class %=
s", perm, class);
>> >>> +          avc_log(SELINUX_ERROR, "Unknown permission %s for class %=
s\n", perm, class);
>> >>>            if (security_deny_unknown() =3D=3D 0)
>> >>>                    return 0;
>> >>>            errno =3D rc;
>> >>> --
>> >>> 2.37.3
>>

