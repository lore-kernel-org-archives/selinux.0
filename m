Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6JKCOZA012814
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 16:12:29 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6JKCNfb017592
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 20:12:23 GMT
Received: by iwn37 with SMTP id 37so4964254iwn.12
        for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 13:12:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1311105066.2550.21.camel@vortex>
References: <1311105066.2550.21.camel@vortex>
Date: Tue, 19 Jul 2011 16:12:21 -0400
Message-ID: <CACLa4pt13h_GceUNbr0y_020529+KtUh3RYaaU_c_udTFZw+_Q@mail.gmail.com>
Subject: Re: [PATCH] Further clarification of the usage of run_init in the
 manual page
From: Eric Paris <eparis@parisplace.org>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Patch added to my 'soon to be in fedora' tree.  I hope to slowly move
everything from my tree into the upstream tree and review from others
is done.

side note: I tend to add pam_rootok to run_init so I don't have to be
interactive.

-Eric

On Tue, Jul 19, 2011 at 3:51 PM, Guido Trentalancia
<guido@trentalancia.com> wrote:
> It's a very minor thing really, but I believe (on the basis of an
> off-list question) that the manual page for policycoreutils/run_init can
> be improved by the following short patch which aims to further clarify
> the intended usage of such tool and mention that it caters for one
> (somewhat hidden) compile-time option.
>
> diff -pruN selinux-09062011/policycoreutils/run_init/run_init.8 selinux-09062011-run_init-auth-manpage/policycoreutils/run_init/run_init.8
> --- selinux-09062011/policycoreutils/run_init/run_init.8        2011-05-09 01:04:17.075842476 +0200
> +++ selinux-09062011-run_init-auth-manpage/policycoreutils/run_init/run_init.8  2011-06-09 23:06:53.350242852 +0200
> @@ -9,6 +9,8 @@ run_init \- run an init script in the pr
>  .PP
>  Run a init script under the proper context, which is specified in
>  /etc/selinux/POLICYTYPE/contexts/initrc_context.
> +It is generally used interactively as it requires either shadow or
> +PAM user authentication (depending on compile-time options).
>  .SH FILES
>  /etc/passwd - user account information
>  .br
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
