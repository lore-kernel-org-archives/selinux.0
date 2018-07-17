Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6HMeCjh007447
 for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2018 18:40:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 41VZwX4Rtbz19Ytd
 for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2018 22:39:56 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 41VZwX1Qbhz19Ytc
 for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2018 22:39:56 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id f18-v6so2010900lfc.2
 for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2018 15:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180717174356.116660-1-ebiggers@google.com>
In-Reply-To: <20180717174356.116660-1-ebiggers@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Jul 2018 18:39:42 -0400
Message-ID: <CAHC9VhRFaAAaVB23183W152WRYj8TJ1Eq7FBTvuQ5+=_uJsYqg@mail.gmail.com>
To: ebiggers@google.com
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: constify write_op[]
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jul 17, 2018 at 1:45 PM Eric Biggers <ebiggers@google.com> wrote:
>
> write_op[] is never modified, so make it 'const'.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  security/selinux/selinuxfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index ab77da649b77..fb25396d2966 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -767,7 +767,7 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size);
>  static ssize_t sel_write_user(struct file *file, char *buf, size_t size);
>  static ssize_t sel_write_member(struct file *file, char *buf, size_t size);
>
> -static ssize_t (*write_op[])(struct file *, char *, size_t) = {
> +static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
>         [SEL_ACCESS] = sel_write_access,
>         [SEL_CREATE] = sel_write_create,
>         [SEL_RELABEL] = sel_write_relabel,
> --
> 2.18.0.203.gfac676dfb9-goog

-- 
paul moore
www.paul-moore.com
