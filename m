Return-Path: <SRS0=B9fV=UY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57DBC4646B
	for <selinux@archiver.kernel.org>; Tue, 25 Jun 2019 02:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB66205F4
	for <selinux@archiver.kernel.org>; Tue, 25 Jun 2019 02:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="eymxPmIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfFYCm2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 22:42:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45452 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfFYCm1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 22:42:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so14558997lje.12
        for <selinux@vger.kernel.org>; Mon, 24 Jun 2019 19:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKBE8eaoco4pGI763kC/y95/qX1Cg9WszVwNQiVM23M=;
        b=eymxPmIScDKLhyJTp2mEkUmTZp/oEzH5x6rUE6KoNYoVY6rRSLkd6UztBZnDlPUsT6
         Adara3v74FkG48l0SfVaDVjJjjWd2mjJ85XuRW42uD3bZx8WeaZmb4nfb/F/Al2RWagH
         n0m5vmZoySDwY6VZlyFAnxP4SSpWtPjJYpPR9jj66UuhG00QXsNLCaS+AGdT3raxwYNf
         TkQKKxteXJ3ZNGyl6Ro5K2FYpQr1OgFdg4oKZtjf6LoW6BTjJioLWXvI/WVKFz/w8RAo
         9EFeT3stuOS1Ioooh44u3gSc9uvWrYexzdeUgm0ptpcYVq13+PrZLYK1XLZc64H7LeGv
         IjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKBE8eaoco4pGI763kC/y95/qX1Cg9WszVwNQiVM23M=;
        b=mKMLQiuCvd/pVQAwACq0BR3Tp3Yswh5S1fbLRljJeHX/xrT/y1fR4tDm9ry0huEH7+
         ksdHuXNXWJkQXanTE1zviNvQKtIFKgGxkq4vg5B2+NjJFIRtYstzUL6ojELMvKparuUq
         5KMoBYF90Ym72FN8pmVX+Df7qTzWLYF9+Sa8Q+RMgTTf9J4qNOFBB+SkMTc+DMUNRCo4
         3P4KIsKl9quEOdWXAHL3u1ku5t4hfvlpaoQ5X1PHGiU3GhrfGTwDrP3pj2DtP8nKhkJ9
         CosxdQGIgOux0nRhzvww3Nid2baR9L6q7MVZ2I9HYd0j41GTD5+bddRI0CLmQAb9ThV8
         x/xw==
X-Gm-Message-State: APjAAAWn30eznb49GOpKuEjbfk6kBJFm4o0F34/MyA5chJLaOrvMiZKQ
        iG7T1mvGM3zJDF8oyHgX9uE0JP2EqK16ME/JiSka
X-Google-Smtp-Source: APXvYqwXYECY5QYIKYlztS3Bw6N8um6jtDalK1khlT0nS84vFu+q+1zZgG/gvAAY6THtOhE425wHJMqvGSwg1eKRB2g=
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr16720717ljk.158.1561430544600;
 Mon, 24 Jun 2019 19:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190621185233.6766-1-casey@schaufler-ca.com> <20190621185233.6766-22-casey@schaufler-ca.com>
 <79cd4a92-c221-eda4-58ba-730b5c2680d7@canonical.com> <0ad8f906-16ff-61af-ce7c-0ea1e9760d03@schaufler-ca.com>
 <CAHC9VhSSwCY8L71x4WTr7kJhF1f_oyQ1NcwyXCAgW7ruKACQdQ@mail.gmail.com> <41f99313-1aa4-bacc-6767-8ee1389ca220@canonical.com>
In-Reply-To: <41f99313-1aa4-bacc-6767-8ee1389ca220@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Jun 2019 22:42:12 -0400
Message-ID: <CAHC9VhSSMjCdT8gfB03gh8VvJngTHnsUsDCpseMUiEPQM9z_FQ@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] Audit: Store LSM audit information in an lsmblob
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 24, 2019 at 10:15 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 6/24/19 6:46 PM, Paul Moore wrote:
> > On Mon, Jun 24, 2019 at 9:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 6/24/2019 2:33 PM, John Johansen wrote:
> >>> On 6/21/19 11:52 AM, Casey Schaufler wrote:
> >>>> Change the audit code to store full lsmblob data instead of
> >>>> a single u32 secid. This allows for multiple security modules
> >>>> to use the audit system at the same time. It also allows the
> >>>> removal of scaffolding code that was included during the
> >>>> revision of LSM interfaces.
> >>>>
> >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>> I know Kees raised this too, but I haven't seen a reply
> >>>
> >>> Eric (Paul is already CCed): I have directly added you because of
> >>> the question below.
> >>>
> >>> In summary there isn't necessarily a single secid any more, and
> >>> we need to know whether dropping the logging of the secid or
> >>> logging all secids is the correct action.
> >>
> >> It is to be considered that this is an error case. If
> >> everything is working normally you should have produced
> >> a secctx previously, which you'll have included in the
> >> audit record. Including the secid in the record ought to
> >> be pointless, as the secid is strictly an internal token
> >> with no meaning outside the running kernel. You are providing
> >> no security relevant information by providing the secid.
> >> I will grant the possibility that the secid might be useful
> >> in debugging, but for that a pr_warn is more appropriate
> >> than a field in the audit record.
> >
> > FWIW, this probably should have been CC'd to the audit list.
> >
> hrmm indeed, sorry
>
> > I agree that this is an error case (security_secid_to_secctx() failed
> > to resolve the secid) and further that logging the secid, or a
> > collection of secids, has little value the way things currently work.
> > Since secids are a private kernel implementation detail, we don't
> > really display them outside the context of the kernel, including in
> > the audit logs.  Recording a secid in this case doesn't provide
> > anything meaningful since secids aren't recorded in the audit record
> > stream, only the secctxs, and there is no "magic decoder ring" to go
> > between the two in the audit logs, or anywhere else in userspace for
> > that matter.
>
> Okay, thanks. Casey I am good with just a pr_warn here. I just didn't
> have context of why it was going to the audit_log and didn't want
> to change that without some more input.

Hmm.  Actually, let me change my comments slightly ... perhaps what we
should do here is keep the audit_log_format(), but change it from
audit_log_format("osid=%u",...) to audit_log_format("obj=?").  The "?"
is used in audit when we can't determine a piece of information, but
we normally log it.  It wasn't used very widely originally, which is
probably why it isn't in this piece of code.

> >>>> ---
> >>>>  kernel/audit.h   |  6 +++---
> >>>>  kernel/auditsc.c | 38 +++++++++++---------------------------
> >>>>  2 files changed, 14 insertions(+), 30 deletions(-)
> >
> > ...
> >
> >>>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> >>>> index 0478680cd0a8..d3ad13f11788 100644
> >>>> --- a/kernel/auditsc.c
> >>>> +++ b/kernel/auditsc.c
> >>>> @@ -1187,21 +1184,18 @@ static void show_special(struct audit_context *context, int *call_panic)
> >>>>                              context->socketcall.args[i]);
> >>>>              break; }
> >>>>      case AUDIT_IPC: {
> >>>> -            u32 osid = context->ipc.osid;
> >>>> +            struct lsmblob *olsm = &context->ipc.olsm;
> >>>>
> >>>>              audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
> >>>>                               from_kuid(&init_user_ns, context->ipc.uid),
> >>>>                               from_kgid(&init_user_ns, context->ipc.gid),
> >>>>                               context->ipc.mode);
> >>>> -            if (osid) {
> >>>> +            if (lsmblob_is_set(olsm)) {
> >>>>                      struct lsmcontext lsmcxt;
> >>>> -                    struct lsmblob blob;
> >>>>
> >>>> -                    lsmblob_init(&blob, osid);
> >>>> -                    if (security_secid_to_secctx(&blob, &lsmcxt)) {
> >>>> -                            audit_log_format(ab, " osid=%u", osid);
> >>> I am not comfortable just dropping this I would think logging all secids is the
> >>> correct action here.
> >>>
> >>>
> >>>> +                    if (security_secid_to_secctx(olsm, &lsmcxt))
> >>>>                              *call_panic = 1;
> >>>> -                    } else {
> >>>> +                    else {
> >>>>                              audit_log_format(ab, " obj=%s", lsmcxt.context);
> >>>>                              security_release_secctx(&lsmcxt);
> >>>>                      }

-- 
paul moore
www.paul-moore.com
