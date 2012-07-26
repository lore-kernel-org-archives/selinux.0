Message-ID: <1343304741.5186.1.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH: system/core 4.0.4] Fix an init segfault.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Nogin, Aleksey" <anogin@hrl.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Thu, 26 Jul 2012 08:12:21 -0400
In-Reply-To: <409A0E510096B044A0EE3778BB3F1F5CCD624D596F@EXMAIL.hrl.com>
References: <409A0E510096B044A0EE3778BB3F1F5CCD624D596F@EXMAIL.hrl.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-25 at 16:52 -0700, Nogin, Aleksey wrote:
> Fixes an init segfault introduced in change
> I81070ea36fd7ffcab4ee8b3ef1bb0028d4b7839c ("chown -R"). The call to fts_open 
> assumes that argv is NULL-terminated, but init parser does not NULL-terminate
> argv arrays, so we can not just point fts_open to an argv suffix.
> ---
>  init/builtins.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks, applied.  Odd that we've never encountered the segfault
ourselves.

> 
> diff --git a/init/builtins.c b/init/builtins.c
> index ab839af..693ff14 100644
> --- a/init/builtins.c
> +++ b/init/builtins.c
> @@ -672,7 +672,7 @@ int do_chown(int nargs, char **args) {
>          char *options = args[1];
>          uid_t uid = decode_uid(args[2]);
>          uid_t gid = decode_uid(args[3]);
> -        char **path_argv = &args[4];
> +        char * path_argv[] = {args[4], NULL};
>          if (strcmp(options, "-R")) {
>              ERROR("do_chown: Invalid argument: %s\n", args[1]);
>              return -EINVAL;
> --
> 1.7.1
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
