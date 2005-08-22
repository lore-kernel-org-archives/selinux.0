Subject: Re: [PATCH] libsemanage: fix resource leaks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: Jason Tang <jtang@tresys.com>, Joshua Brindle <jbrindle@tresys.com>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050822114602.GC24949@sergelap.austin.ibm.com>
References: <20050822114602.GC24949@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 22 Aug 2005 12:56:11 -0400
Message-Id: <1124729771.3025.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-22 at 06:46 -0500, serue@us.ibm.com wrote:
> This is the last of three patches against libsemanage.  Just needed
> to hit these on my way to checking policycoreutils.
> 
> The following fixes a bug found by Coverity in libsemanage:
> 
> 	In both semod_get_active_modules_list() and
> 	semod_get_sandbox_modules_list() it is possible to return
> 	-1 after names and versions have been defined (if asprintf
> 	fails).  In addition it is obviously possible for names to be
> 	malloced and the versions malloc to fail.
> 
> Index: src/module_direct_api.c
> ===================================================================
> --- src.orig/module_direct_api.c
> +++ src/module_direct_api.c
> @@ -260,6 +260,10 @@ int semod_direct_list_modules(char **res
>          char **names, **versions;
>          *results = NULL;
>          if ((retval = semod_get_active_modules_list (&names, &versions, &len)) < 0) {
> +		if (names)
> +			free(names);
> +		if (versions)
> +			free(versions);
>                  return retval;
>          }
>          return list_modules_common (results, names, versions, len);
> @@ -278,6 +282,10 @@ int semod_direct_list_sandbox(char *sand
>          *results = NULL;
>          if ((retval = semod_get_sandbox_modules_list (sandbox,
>                                                        &names, &versions, &len)) < 0) {
> +		if (names)
> +			free(names);
> +		if (versions)
> +			free(versions);
>                  return retval;
>          }
>          return list_modules_common (results, names, versions, len);

Looks like we need to free the individual elements as well.  Any reason
this isn't handled internally by semod_build_modules_list upon an error?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
