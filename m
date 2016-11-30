Subject: Re: [PATCH] python/semanage/semanage: Unify argument handling
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <1480513675-18212-1-git-send-email-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d867920d-5a83-d1cd-f5c9-8d3415c479e9@tycho.nsa.gov>
Date: Wed, 30 Nov 2016 09:36:54 -0500
MIME-Version: 1.0
In-Reply-To: <1480513675-18212-1-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/30/2016 08:47 AM, Vit Mojzis wrote:
> Missing argument checks for "fcontext" and "boolean" were performed
> outside of "argparse", resulting in shortened help message (without
> argument details) and no error description.
> Fix: perform these checks using "argparse" as is the case with other
> semanage options.
> 
> Some "required argument" check were performed outside of "handle_opts"
> obscuring the code.
> Fix: Add required arguments to {fcontext boolean}_args and remove the
> checks from handle{Fcontext Boolean}.
> 
> Remove unpaired parentheses from "semanage fcontext" usage message.

Thanks, applied.

> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/semanage/semanage | 31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index a445d56..9659aac 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -50,7 +50,7 @@ usage_login = "semanage login [-h] [-n] [-N] [-S STORE] ["
>  usage_login_dict = {' --add': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' --modify': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' --delete': ('LOGIN',), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
>  
>  usage_fcontext = "semanage fcontext [-h] [-n] [-N] [-S STORE] ["
> -usage_fcontext_dict = {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC', ')',), ' --delete': ('(', '-t TYPE', '-f FTYPE', '|', '-e EQUAL', ')', 'FILE_SPEC', ')',), ' --modify': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC )',), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
> +usage_fcontext_dict = {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --delete': ('(', '-t TYPE', '-f FTYPE', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --modify': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), ' --deleteall': ('',)}
>  
>  usage_user = "semanage user [-h] [-n] [-N] [-S STORE] ["
>  usage_user_dict = {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'selinux_name'')'), ' --delete': ('selinux_name',), ' --modify': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'selinux_name', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
> @@ -99,8 +99,8 @@ class seParser(argparse.ArgumentParser):
>      def error(self, message):
>          if len(sys.argv) == 2:
>              self.print_help()
> -            sys.exit(2)
> -        self.print_usage()
> +        else:
> +            self.print_usage()
>          self.exit(2, ('%s: error: %s\n') % (self.prog, message))
>  
>  
> @@ -346,10 +346,7 @@ def handleFcontext(args):
>      # we can not use mutually for equal because we can define some actions together with equal
>      fcontext_equal_args = {'equal': [('list', 'locallist', 'type', 'ftype', 'seuser', 'deleteall', 'extract'), ()]}
>  
> -    if args.action is None:
> -        print("usage: " + "%s" % generate_custom_usage(usage_fcontext, usage_fcontext_dict))
> -        sys.exit(2)
> -    elif args.action and args.equal:
> +    if args.action and args.equal:
>          handle_opts(args, fcontext_equal_args, "equal")
>      else:
>          handle_opts(args, fcontext_args, args.action)
> @@ -398,7 +395,7 @@ If you do not specify a file type, the file type will default to "all files".
>      parser_add_noreload(fcontextParser, "fcontext")
>      parser_add_store(fcontextParser, "fcontext")
>  
> -    fcontext_action = fcontextParser.add_mutually_exclusive_group(required=False)
> +    fcontext_action = fcontextParser.add_mutually_exclusive_group(required=True)
>      parser_add_add(fcontext_action, "fcontext")
>      parser_add_delete(fcontext_action, "fcontext")
>      parser_add_modify(fcontext_action, "fcontext")
> @@ -645,19 +642,9 @@ def setupNodeParser(subparsers):
>  
>  
>  def handleBoolean(args):
> -    boolean_args = {'list': [('state', 'boolean'), ('')], 'modify': [('localist'), ('')], 'extract': [('locallist', 'state', 'boolean'), ('')], 'deleteall': [('locallist'), ('')], 'state': [('locallist', 'list', 'extract', 'deleteall'), ('modify')]}
> -    if args.action is None:
> -        print("Usage: " + "%s" % generate_custom_usage(usage_boolean, usage_boolean_dict))
> -        sys.exit(2)
> -    # TODO: should be added to handle_opts logic
> -    elif args.action is "modify" and not args.boolean:
> -        print("boolean name required ")
> -        sys.exit(1)
> -    elif args.action is "modify" and args.boolean and not args.state:
> -        print("state option is needed")
> -        sys.exit(1)
> -    else:
> -        handle_opts(args, boolean_args, args.action)
> +    boolean_args = {'list': [('state', 'boolean'), ('')], 'modify': [('localist'), ('boolean', 'state')], 'extract': [('locallist', 'state', 'boolean'), ('')], 'deleteall': [('locallist'), ('')], 'state': [('locallist', 'list', 'extract', 'deleteall'), ('modify')]}
> +
> +    handle_opts(args, boolean_args, args.action)
>  
>      OBJECT = object_dict['boolean']()
>      OBJECT.set_reload(args.noreload)
> @@ -683,7 +670,7 @@ def setupBooleanParser(subparsers):
>      parser_add_store(booleanParser, "boolean")
>      booleanParser.add_argument('boolean', nargs="?", default=None, help=_('boolean'))
>  
> -    boolean_action = booleanParser.add_mutually_exclusive_group(required=False)
> +    boolean_action = booleanParser.add_mutually_exclusive_group(required=True)
>      #add_add(boolean_action)
>      parser_add_modify(boolean_action, "boolean")
>      parser_add_list(boolean_action, "boolean")
> 
