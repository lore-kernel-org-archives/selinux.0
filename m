Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4HKv9QO025806
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 16:57:09 -0400
Received: from mail-qt0-f175.google.com (mail-qt0-f175.google.com
 [209.85.216.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 4ECE8564796
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 22:57:07 +0200 (CEST)
Received: by mail-qt0-f175.google.com with SMTP id f55so19903665qta.3
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 13:57:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170517205324.18805-1-nicolas.iooss@m4x.org>
References: <20170517205324.18805-1-nicolas.iooss@m4x.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 17 May 2017 22:57:05 +0200
Message-ID: <CAJfZ7=msn7H6BXvPHeQPVeqww+3H-iFr1ZfzHSKRWcYZbkBzVg@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: remove unused attribute on a used argument
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 17, 2017 at 10:53 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> Since commit 58962eb3d847 ("libsepol,checkpolicy: add binary module
> support for xperms") function display_avrule() has been using its "p"
> argument even though it was previously marked unused. This makes clang
> report:

Of course it is function avrule_read() instead. I commited and sent
this patch too quickly. Would you like me to send a patch with a fixed
description?
Nicolas

>
>     policydb.c:3276:7: error: 'p' was marked unused but was used
>     [-Werror,-Wused-but-marked-unused].
>         if (p->policyvers < MOD_POLICYDB_VERSION_XPERMS_IOCTL) {
>             ^
>
> Remove the attribute to make the code consistent again.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/policydb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 069eb7e66540..b1530955aa39 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -3212,8 +3212,7 @@ common_read, class_read, role_read, type_read, user_read,
>
>  /************** module reading functions below **************/
>
> -static avrule_t *avrule_read(policydb_t * p
> -                            __attribute__ ((unused)), struct policy_file *fp)
> +static avrule_t *avrule_read(policydb_t * p, struct policy_file *fp)
>  {
>         unsigned int i;
>         uint32_t buf[2], len;
> --
> 2.13.0
>
