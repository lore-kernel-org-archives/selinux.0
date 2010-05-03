MIME-Version: 1.0
In-Reply-To: <20100503222931.9662.9780.stgit@paris.rdu.redhat.com>
References: <20100503222931.9662.9780.stgit@paris.rdu.redhat.com>
Date: Mon, 3 May 2010 18:46:44 -0400
Message-ID: <h2x7e0fb38c1005031546j1004b281y13dd637caa816393@mail.gmail.com>
Subject: Re: [PATCH -v3] SELinux: special dontaudit for access checks
From: Eric Paris <eparis@parisplace.org>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 3, 2010 at 6:29 PM, Eric Paris <eparis@redhat.com> wrote:

> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -90,6 +90,11 @@ struct common_audit_data {
>                        u32 requested;
>                        u32 audited;
>                        u32 denied;
> +                       /*
> +                        * auditdeny is a bit tricky and unintuitive.  See the
> +                        * comments in avc.c for it's meaning and usage.

I really do know the difference between it's and its.  I'll fix if
another patch is needed.  Else I'll leave it up to James to fix during
merge or not fix it....


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
