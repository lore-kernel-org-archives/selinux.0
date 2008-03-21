Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2LDUYtI005286
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2008 09:30:35 -0400
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2LDUXl2001743
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2008 13:30:34 GMT
Date: Fri, 21 Mar 2008 14:03:15 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: patch for gpg-agent
Message-ID: <20080321130315.GA21980@bobek.pm.i.cz>
References: <20080220170300.GA13312@bobek.pm.i.cz> <1204660301.14217.26.camel@gorn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
In-Reply-To: <1204660301.14217.26.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
sorry for a delay...

On Tue, Mar 04, 2008 at 02:51:41PM -0500, Christopher J. PeBenito wrote:
> On Wed, 2008-02-20 at 18:03 +0100, Václav Ovsík wrote:
> > I'm running HEAD refpolicy on Debian Sid, but this patch is not
> > Debian-specific this time.
> > Having a copy of my std bash profile on the testing machine with
> > a snippet (from gpg-agent man page):
> > 
> >     if test -f $HOME/.gpg-agent-info \
> >              && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info`
> > 2>/dev/null
> >     then
> >         . $HOME/.gpg-agent-info
> >         export GPG_AGENT_INFO
> >         export SSH_AUTH_SOCK
> >         export SSH_AGENT_PID
> >     else
> >         eval `gpg-agent --daemon --write-env-file`
> >     fi
> > 
> > I got a number of denials for this snippet of commands.
> > 
> > 1. Found a typo for permissions to create socket in the /tmp.
> > 2. Added permission to send signal 0 by the user (see above).
> > 3. Added permissions for writing agent info file into users home
> >    directory.
> 
> 
> > 
> > Index: policy/modules/apps/gpg.if
> > ===================================================================
> > --- policy/modules/apps/gpg.if  (revision 2617)
> > +++ policy/modules/apps/gpg.if  (working copy)
> > @@ -212,6 +212,12 @@
> >         manage_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
> >         manage_lnk_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
> >  
> > +       # write ~/.gpg-agent-info (gpg-agent --write-env-file option)
> > +       allow $1_gpg_agent_t { $1_home_dir_t $1_home_t }:dir add_entry_dir_perms;
> > +       type_transition $1_gpg_agent_t $1_home_dir_t:file $1_home_t;
> > +       allow $1_gpg_agent_t $1_home_t:file create_file_perms;
> > +       allow $1_gpg_agent_t $1_home_t:file write_file_perms;
> 
> I'm a little hesitant to add this unconditionally, I don't think we want
> gpg-agent to write out to general home dir content.  Perhaps we should
> have a tunable, or a specific type for this.

I added this rules, so an example from gpg-agent manpage can work
out-of-the-box. Adding a tunable (with the default to disallow) will not
satisfy this. Maybe the later - specific type, but what security risk
poses this rules?
I thought, that domain X_gpg_agent_t is very trusted domain, that
manages my secret keys and should be shielded against the world around
and not the opposite.


> >         # allow gpg to connect to the gpg agent
> >         stream_connect_pattern($1_gpg_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t,$1_gpg_agent_t)
> >  
> > @@ -219,11 +225,11 @@
> >         ps_process_pattern($2,$1_gpg_agent_t)
> >  
> >         # Allow the user shell to signal the gpg-agent program.
> > -       allow $2 $1_gpg_agent_t:process { signal sigkill };
> > +       allow $2 $1_gpg_agent_t:process { signal sigkill signull };
> >  
> > -       manage_dirs_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> > -       manage_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> > -       manage_sock_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> > +       manage_dirs_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> > +       manage_files_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> > +       manage_sock_files_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
> >         files_tmp_filetrans($1_gpg_agent_t, $1_gpg_agent_tmp_t, { file sock_file dir })
> 
> This isn't a typo, the user domain should still be able to manage
> gpg-agent's tmp files.

Yes, you are right. I looked at ssh-agent rules just and considered it
more or less equivalent to gpg-agent. Gpg-agent should do clean-up of
its socket, but maybe some crash.

Ok, what about ssh-agent? Shoul be these rules for userdomain added for
it too?

zito@sid:/tmp$ rm -rf ssh-*

audit(1206101398.028:16): avc:  denied  { write } for  pid=2155 comm="rm" name="ssh-IgYHrr2122" dev=sda1 ino=49168 scontext=staff_u:staff_r:staff_t:s0 tcontext=system_u:object_r:sshd_tmp_t:s0 tclass=dir
audit(1206101398.028:17): avc:  denied  { remove_name } for  pid=2155 comm="rm" name="agent.2122" dev=sda1 ino=49169 scontext=staff_u:staff_r:staff_t:s0 tcontext=system_u:object_r:sshd_tmp_t:s0 tclass=dir
audit(1206101398.028:18): avc:  denied  { unlink } for  pid=2155 comm="rm" name="agent.2122" dev=sda1 ino=49169 scontext=staff_u:staff_r:staff_t:s0 tcontext=system_u:object_r:sshd_tmp_t:s0 tclass=sock_file
audit(1206101398.028:19): avc:  denied  { rmdir } for  pid=2155 comm="rm" name="ssh-IgYHrr2122" dev=sda1 ino=49168 scontext=staff_u:staff_r:staff_t:s0 tcontext=system_u:object_r:sshd_tmp_t:s0 tclass=dir


Thanks for suggestions.
Regards
-- 
Zito

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gpg-agent

Index: policy/modules/apps/gpg.if
===================================================================
--- policy/modules/apps/gpg.if.orig	2008-03-20 12:00:48.000000000 +0100
+++ policy/modules/apps/gpg.if	2008-03-21 13:18:29.000000000 +0100
@@ -212,6 +212,12 @@
 	manage_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
 	manage_lnk_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
 
+	# write ~/.gpg-agent-info (gpg-agent --write-env-file option)
+	allow $1_gpg_agent_t { $1_home_dir_t $1_home_t }:dir add_entry_dir_perms;
+	type_transition $1_gpg_agent_t $1_home_dir_t:file $1_home_t;
+	allow $1_gpg_agent_t $1_home_t:file create_file_perms;
+	allow $1_gpg_agent_t $1_home_t:file write_file_perms;
+
 	# allow gpg to connect to the gpg agent
 	stream_connect_pattern($1_gpg_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t,$1_gpg_agent_t)
 
@@ -219,11 +225,18 @@
 	ps_process_pattern($2,$1_gpg_agent_t)
 
 	# Allow the user shell to signal the gpg-agent program.
-	allow $2 $1_gpg_agent_t:process { signal sigkill };
+	allow $2 $1_gpg_agent_t:process { signal sigkill signull };
 
+	# Allow the user to manage gpg-agent tmp files (socket)
 	manage_dirs_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
 	manage_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
 	manage_sock_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
+
+	# Allow the gpg-agent to manage its tmp files (socket)
+	manage_dirs_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
+	manage_files_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
+	manage_sock_files_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
+
 	files_tmp_filetrans($1_gpg_agent_t, $1_gpg_agent_tmp_t, { file sock_file dir })
 
 	# Transition from the user domain to the derived domain.

--mP3DRpeJDSE+ciuQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
