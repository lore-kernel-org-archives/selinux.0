MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [rfc][patch] setfiles:  validate all file_contexts files whenusing -c
Date: Fri, 18 Jul 2008 14:37:22 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880246AF91@exchange.columbia.tresys.com>
In-Reply-To: <1216406083.17602.352.camel@moss-spartans.epoch.ncsc.mil>
References: <4880CFD1.1040102@redhat.com> <1216402063.17602.322.camel@moss-spartans.epoch.ncsc.mil> <4880D585.9000405@redhat.com> <1216403646.17602.339.camel@moss-spartans.epoch.ncsc.mil> <1216406083.17602.352.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> In ancient days of yore, setfiles could only validate the
> base file_contexts configuration because the .homedirs or
> .local configurations might include local users that weren't
> defined by the base policy since those definitions were
> brought in at policy load time.
> These days the policy.N file contains all of the definitions
> required to validate all file_contexts files and thus
> setfiles can and should validate them.
> 

I don't think that was the motivation. We want to explicitely support a
user overriding a context specified in the policy with semanage and I
think giving this cryptic warning is going to confuse people. For all
other semanage objects we allow overriding the main policy with no
warning, why would this be different?

> Before:
> # /usr/sbin/semanage fcontext -a -t httpd_sys_content_t /tmp (no
> warnings) After:
> # /usr/sbin/semanage fcontext -a -t httpd_sys_content_t /tmp
> /etc/selinux/targeted/contexts/files/file_contexts: Multiple
> different specifications for /tmp
> (system_u:object_r:httpd_sys_content_t:s0 and
> system_u:object_r:tmp_t:s0).
> 
> If we want it to be a fatal error, then libselinux should be
> patched to return an error in this case on the selabel_open()
> (requires making nodups_specs return an error to the caller and
> propagating it up). 
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
> ---
> 
> Index: trunk/policycoreutils/setfiles/setfiles.c
> ===================================================================
> --- trunk/policycoreutils/setfiles/setfiles.c	(revision 2927)
> +++ trunk/policycoreutils/setfiles/setfiles.c	(working copy) @@ -72,7
>  +72,6 @@ static int abort_on_error; /* Abort the file tree walk upon
> an error. */  static int add_assoc; /* Track inode
> associations for conflict detection. */  static int
> nftw_flags; /* Flags to nftw, e.g. follow links, follow
> mounts */ -static int base_only; /* Don't use local
> file_contexts customizations */  static int ctx_validate; /*
> Validate contexts */  static const char *altpath; /*
> Alternate path to file_contexts */
> 
> @@ -748,7 +747,6 @@
>  	char *base;
>  	struct selinux_opt opts[] = {
>  		{ SELABEL_OPT_VALIDATE, NULL },
> -		{ SELABEL_OPT_BASEONLY, NULL },
>  		{ SELABEL_OPT_PATH, NULL }
>  	};
> 
> @@ -836,10 +834,6 @@
>  				}
>  				fclose(policystream);
> 
> -				/* Only process the specified
> file_contexts file, not
> -				   any .homedirs or .local
> files, and do not perform
> -				   context translations. */
> -				base_only = 1;
>  				ctx_validate = 1;
> 
>  				break;
> @@ -972,10 +966,9 @@
> 
>  	/* Load the file contexts configuration and check it. */
>  	opts[0].value = (ctx_validate ? (char*)1 : NULL);
> -	opts[1].value = (base_only ? (char *)1 : NULL);
> -	opts[2].value = altpath;
> +	opts[1].value = altpath;
> 
> -	hnd = selabel_open(SELABEL_CTX_FILE, opts, 3);
> +	hnd = selabel_open(SELABEL_CTX_FILE, opts, 2);
>  	if (!hnd) {
>  		perror(altpath);
>  		exit(1);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
