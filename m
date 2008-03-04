Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24JsTZe000955
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 14:54:29 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m24JsS2k008848
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 19:54:28 GMT
Subject: Re: refpolicy: patch for gpg-agent
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20080220170300.GA13312@bobek.pm.i.cz>
References: <20080220170300.GA13312@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 04 Mar 2008 14:51:41 -0500
Message-Id: <1204660301.14217.26.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-02-20 at 18:03 +0100, Václav Ovsík wrote:
> I'm running HEAD refpolicy on Debian Sid, but this patch is not
> Debian-specific this time.
> Having a copy of my std bash profile on the testing machine with
> a snippet (from gpg-agent man page):
> 
>     if test -f $HOME/.gpg-agent-info \
>              && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info`
> 2>/dev/null
>     then
>         . $HOME/.gpg-agent-info
>         export GPG_AGENT_INFO
>         export SSH_AUTH_SOCK
>         export SSH_AGENT_PID
>     else
>         eval `gpg-agent --daemon --write-env-file`
>     fi
> 
> I got a number of denials for this snippet of commands.
> 
> 1. Found a typo for permissions to create socket in the /tmp.
> 2. Added permission to send signal 0 by the user (see above).
> 3. Added permissions for writing agent info file into users home
>    directory.


> 
> Index: policy/modules/apps/gpg.if
> ===================================================================
> --- policy/modules/apps/gpg.if  (revision 2617)
> +++ policy/modules/apps/gpg.if  (working copy)
> @@ -212,6 +212,12 @@
>         manage_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
>         manage_lnk_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
>  
> +       # write ~/.gpg-agent-info (gpg-agent --write-env-file option)
> +       allow $1_gpg_agent_t { $1_home_dir_t $1_home_t }:dir add_entry_dir_perms;
> +       type_transition $1_gpg_agent_t $1_home_dir_t:file $1_home_t;
> +       allow $1_gpg_agent_t $1_home_t:file create_file_perms;
> +       allow $1_gpg_agent_t $1_home_t:file write_file_perms;

I'm a little hesitant to add this unconditionally, I don't think we want
gpg-agent to write out to general home dir content.  Perhaps we should
have a tunable, or a specific type for this.

>         # allow gpg to connect to the gpg agent
>         stream_connect_pattern($1_gpg_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t,$1_gpg_agent_t)
>  
> @@ -219,11 +225,11 @@
>         ps_process_pattern($2,$1_gpg_agent_t)
>  
>         # Allow the user shell to signal the gpg-agent program.
> -       allow $2 $1_gpg_agent_t:process { signal sigkill };
> +       allow $2 $1_gpg_agent_t:process { signal sigkill signull };
>  
> -       manage_dirs_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> -       manage_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> -       manage_sock_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> +       manage_dirs_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> +       manage_files_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> +       manage_sock_files_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
>         files_tmp_filetrans($1_gpg_agent_t, $1_gpg_agent_tmp_t, { file sock_file dir })

This isn't a typo, the user domain should still be able to manage
gpg-agent's tmp files.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
