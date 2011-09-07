Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p87LY32h031265
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2011 17:34:03 -0400
Received: from mail-gy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p87LY24b019030
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2011 21:34:02 GMT
Received: by gyd10 with SMTP id 10so124177gyd.12
        for <selinux@tycho.nsa.gov>; Wed, 07 Sep 2011 14:34:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1314682304-21607-1-git-send-email-qingtao.cao@windriver.com>
References: <1314682304-21607-1-git-send-email-qingtao.cao@windriver.com>
Date: Wed, 7 Sep 2011 17:34:01 -0400
Message-ID: <CACLa4pszTDTRH2EO5Eosr8On4Fab_UA7VeTvbvmVGK0bpj3kXQ@mail.gmail.com>
Subject: Re: [v0 PATCH 1/1] Fix compile errors when DEBUG is turned on.
From: Eric Paris <eparis@parisplace.org>
To: Harry Ciao <qingtao.cao@windriver.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Not applied to queue branch of the upstream tree as all of these
appear to already be fixed.

-Eric

On Tue, Aug 30, 2011 at 1:31 AM, Harry Ciao <qingtao.cao@windriver.com> wrote:
> Fix below compile errors if DEBUG is turned on:
>
> matchpathcon.c:110: error: declaration of ‘rc’ shadows a previous local
> matchpathcon.c:48: error: shadowed declaration is here
> matchpathcon.c:48: error: unused variable ‘rc’
>
> seunshare.c:346: error: too many arguments for format
> seunshare.c:275: error: unused variable ‘flag_index’
>
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> ---
>  libselinux/utils/matchpathcon.c     |    2 +-
>  policycoreutils/sandbox/seunshare.c |    4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
> index 2fa21bc..892e33d 100644
> --- a/libselinux/utils/matchpathcon.c
> +++ b/libselinux/utils/matchpathcon.c
> @@ -107,7 +107,7 @@ int main(int argc, char **argv)
>                }
>        }
>        for (i = optind; i < argc; i++) {
> -               int rc, mode = 0;
> +               int mode = 0;
>                struct stat buf;
>                char *path = argv[i];
>                int len = strlen(path);
> diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
> index f9bf12c..a640c56 100644
> --- a/policycoreutils/sandbox/seunshare.c
> +++ b/policycoreutils/sandbox/seunshare.c
> @@ -272,7 +272,6 @@ int main(int argc, char **argv) {
>
>        security_context_t scontext = NULL;
>
> -       int flag_index;         /* flag index in argv[] */
>        int clflag;             /* holds codes for command line flags */
>        char *tmpdir_s = NULL;  /* tmpdir spec'd by user in argv[] */
>        char *homedir_s = NULL; /* homedir spec'd by user in argv[] */
> @@ -342,8 +341,7 @@ int main(int argc, char **argv) {
>        }
>
>        if (! homedir_s && ! tmpdir_s) {
> -               fprintf(stderr, _("Error: tmpdir and/or homedir required \n"),
> -                       "%s\n", USAGE_STRING);
> +               fprintf(stderr, _("Error: tmpdir and/or homedir required \n %s\n"), USAGE_STRING);
>                return -1;
>        }
>
> --
> 1.7.0.4
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
