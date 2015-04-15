Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3FMMTxG023551
 for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2015 18:22:29 -0400
Received: by qku63 with SMTP id 63so108293409qku.3
 for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2015 15:22:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1429135642-25619-1-git-send-email-nnk@google.com>
References: <1429135642-25619-1-git-send-email-nnk@google.com>
Date: Wed, 15 Apr 2015 15:22:27 -0700
Message-ID: <CABXk95AkS_f2J1W00XeP7x1e_YhZS-YXU_Ftk6rhqqcfSnX+jQ@mail.gmail.com>
Subject: Re: [PATCH] Add empty top level Android.mk / CleanSpec.mk files
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Acked-by:  Jeff Vander Stoep <jeffv@google.com>

On Wed, Apr 15, 2015 at 3:07 PM, Nick Kralevich <nnk@google.com> wrote:
> Needed to allow Android to keep building with a copy of the SELinux
> source code checked into external/selinux
>
> Bug: 19963152
> Change-Id: I4e192bb6ca5d185e11540aca7253e729d92a00c1
> ---
>  Android.mk   | 2 ++
>  CleanSpec.mk | 2 ++
>  2 files changed, 4 insertions(+)
>  create mode 100644 Android.mk
>  create mode 100644 CleanSpec.mk
>
> diff --git a/Android.mk b/Android.mk
> new file mode 100644
> index 0000000..02f35a9
> --- /dev/null
> +++ b/Android.mk
> @@ -0,0 +1,2 @@
> +# This empty Android.mk file will prevent the build system
> +# from building anything below this point.
> diff --git a/CleanSpec.mk b/CleanSpec.mk
> new file mode 100644
> index 0000000..1ac5a62
> --- /dev/null
> +++ b/CleanSpec.mk
> @@ -0,0 +1,2 @@
> +# This empty CleanSpec.mk file will prevent the build system
> +# from descending into subdirs.
> --
> 2.2.0.rc0.207.ga3a616c
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
