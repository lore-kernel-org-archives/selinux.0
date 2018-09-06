Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8660J1X015781
 for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2018 02:00:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id b30-v6so2160556pla.0
 for <selinux@tycho.nsa.gov>; Wed, 05 Sep 2018 23:00:11 -0700 (PDT)
Date: Thu, 6 Sep 2018 14:00:07 +0800
From: Jason Zaman <jason@perfinion.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180906060007.GA34188@baraddur.perfinion.com>
References: <20180905214906.11016-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905214906.11016-1-nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/2] semanage: "semanage user" does not use -s,
 fix documentation
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 05, 2018 at 11:49:05PM +0200, Nicolas Iooss wrote:
> Both "semanage user --help" and "man 8 semanage-user" state that
> "semanage user" accepts option -s, but this is incorrect: -s is not
> needed to specify the SELinux user on the command line, contrary to
> "semanage login" for example. Fix the documention.
> 
> While at it, remove many spaces from the helptext of option --roles. I
> do not know where they came from, but they were reduced to a single
> space when displayed anyway.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Both looks good to me, go ahead and merge if there are no other comments
:)

Acked-by: Jason Zaman <jason@perfinion.com>


> ---
>  python/semanage/semanage        | 4 ++--
>  python/semanage/semanage-user.8 | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 8d8a086094c9..e32d1e8ad387 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -53,7 +53,7 @@ usage_fcontext = "semanage fcontext [-h] [-n] [-N] [-S STORE] ["
>  usage_fcontext_dict = {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --delete': ('(', '-t TYPE', '-f FTYPE', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --modify': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), ' --deleteall': ('',)}
>  
>  usage_user = "semanage user [-h] [-n] [-N] [-S STORE] ["
> -usage_user_dict = {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'selinux_name'')'), ' --delete': ('selinux_name',), ' --modify': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'selinux_name', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
> +usage_user_dict = {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', 'SEUSER', ')'), ' --delete': ('SEUSER',), ' --modify': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'SEUSER', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
>  
>  usage_port = "semanage port [-h] [-n] [-N] [-S STORE] ["
>  usage_port_dict = {' --add': ('-t TYPE', '-p PROTOCOL', '-r RANGE', '(', 'port_name', '|', 'port_range', ')'), ' --modify': ('-t TYPE', '-p PROTOCOL', '-r RANGE', '(', 'port_name', '|', 'port_range', ')'), ' --delete': ('-p PROTOCOL', '(', 'port_name', '|', 'port_range', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
> @@ -421,7 +421,7 @@ def setupUserParser(subparsers):
>      userParser.add_argument('-R', '--roles', default=[],
>                              action=CheckRole,
>                              help=_('''
> -SELinux Roles.  You must enclose multiple roles within quotes,                  separate by spaces. Or specify -R multiple times.
> +SELinux Roles.  You must enclose multiple roles within quotes, separate by spaces. Or specify -R multiple times.
>  '''))
>      userParser.add_argument('-P', '--prefix', default="user", help=argparse.SUPPRESS)
>      userParser.add_argument('selinux_name', nargs='?', default=None, help=_('selinux_name'))
> diff --git a/python/semanage/semanage-user.8 b/python/semanage/semanage-user.8
> index 30bc67052ed7..23fec698e042 100644
> --- a/python/semanage/semanage-user.8
> +++ b/python/semanage/semanage-user.8
> @@ -2,7 +2,7 @@
>  .SH "NAME"
>  .B semanage\-user \- SELinux Policy Management SELinux User mapping tool
>  .SH "SYNOPSIS"
> -.B  semanage user [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-L LEVEL \-R ROLES \-r RANGE \-s SEUSER selinux_name) | \-\-delete selinux_name | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-L LEVEL \-R ROLES \-r RANGE \-s SEUSER selinux_name ) ]
> +.B  semanage user [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-L LEVEL \-R ROLES \-r RANGE SEUSER) | \-\-delete SEUSER | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-L LEVEL \-R ROLES \-r RANGE SEUSER ) ]
>  
>  .SH "DESCRIPTION"
>  semanage is used to configure certain elements of
> -- 
> 2.18.0
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
