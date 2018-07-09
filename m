Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w69J5xES024310
 for <selinux@tycho.nsa.gov>; Mon, 9 Jul 2018 15:06:00 -0400
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id C97905646C8
 for <selinux@tycho.nsa.gov>; Mon,  9 Jul 2018 21:03:41 +0200 (CEST)
Received: by mail-oi0-f52.google.com with SMTP id k12-v6so37875445oiw.8
 for <selinux@tycho.nsa.gov>; Mon, 09 Jul 2018 12:03:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180709182940.32725-1-vmojzis@redhat.com>
References: <20180709182940.32725-1-vmojzis@redhat.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Mon, 9 Jul 2018 21:03:39 +0200
Message-ID: <CAJfZ7=nuYJ-=RHzCkiTkvt5-T+hG9GJgQtiz7X6AYHoorYwGsQ@mail.gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] python/semanage: Fix logger class definition
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jul 9, 2018 at 8:29 PM, Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Test if audit module is enabled so that logger class is defined
> correctly.
>
> Fixes:
> "semanage fcontext -l" fails with "OSError: Protocol not supported" when
> booting with audit=0
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/semanage/seobject.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index e5c81a7d..29b4afe0 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -101,6 +101,8 @@ ftype_to_audit = {"": "any",
>
>  try:
>      import audit
> +    #test if audit module is enabled
> +    audit.audit_close(audit.audit_open())
>
>      class logger:
>

This looks good to me (Ack). For future reference, I was wondering
whether audit.audit_open() returns -1 or raises an exception if it
fails to open the audit log, and found the answer in audit's source
code (it raises an OSError, as expected [1], so the new code is fine).

While reviewing your patch, I encountered the bare "except:" right
after the definition of class logger. The exceptions which cause the
use of the fail-over logger class are not explicitly written and this
could cause issues, for example when someone tries to interrupt the
program with Ctrl-C while the code executes. Would it be possible to
replace this "except:" with "except ImportError, OSError:"? (This
could be done in another patch).

Thanks,
Nicolas

[1] https://github.com/linux-audit/audit-userspace/blob/v2.8.4/bindings/swig/src/auditswig.i#L27-L33)
