Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3FDQgUC009512
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 09:26:42 -0400
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3FDQejo027014
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 13:26:40 GMT
Date: Tue, 15 Apr 2008 15:26:02 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: patch for gpg-agent
Message-ID: <20080415132602.GA6685@bobek.pm.i.cz>
References: <20080220170300.GA13312@bobek.pm.i.cz> <1204660301.14217.26.camel@gorn> <20080321130315.GA21980@bobek.pm.i.cz> <1206544272.16113.228.camel@gorn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
In-Reply-To: <1206544272.16113.228.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
after a longer period of inactivity I'm back with a new try :)

On Wed, Mar 26, 2008 at 11:11:12AM -0400, Christopher J. PeBenito wrote:
> On Fri, 2008-03-21 at 14:03 +0100, Václav Ovsík wrote:
> > On Tue, Mar 04, 2008 at 02:51:41PM -0500, Christopher J. PeBenito wrote:
> > > On Wed, 2008-02-20 at 18:03 +0100, Václav Ovsík wrote:
> > > > I'm running HEAD refpolicy on Debian Sid, but this patch is not
> > > > Debian-specific this time.
> > > > Having a copy of my std bash profile on the testing machine with
> > > > a snippet (from gpg-agent man page):
> > > > 
> > > >     if test -f $HOME/.gpg-agent-info \
> > > >              && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info`
> > > > 2>/dev/null
> > > >     then
> > > >         . $HOME/.gpg-agent-info
> > > >         export GPG_AGENT_INFO
> > > >         export SSH_AUTH_SOCK
> > > >         export SSH_AGENT_PID
> > > >     else
> > > >         eval `gpg-agent --daemon --write-env-file`
> > > >     fi
> > > > 
> > > > I got a number of denials for this snippet of commands.
> > > > 
> > > > 1. Found a typo for permissions to create socket in the /tmp.
> > > > 2. Added permission to send signal 0 by the user (see above).
> > > > 3. Added permissions for writing agent info file into users home
> > > >    directory.
> > > > 
> > > > Index: policy/modules/apps/gpg.if
> > > > ===================================================================
> > > > --- policy/modules/apps/gpg.if  (revision 2617)
> > > > +++ policy/modules/apps/gpg.if  (working copy)
> > > > @@ -212,6 +212,12 @@
> > > >         manage_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
> > > >         manage_lnk_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
> > > >  
> > > > +       # write ~/.gpg-agent-info (gpg-agent --write-env-file option)
> > > > +       allow $1_gpg_agent_t { $1_home_dir_t $1_home_t }:dir add_entry_dir_perms;
> > > > +       type_transition $1_gpg_agent_t $1_home_dir_t:file $1_home_t;
> > > > +       allow $1_gpg_agent_t $1_home_t:file create_file_perms;
> > > > +       allow $1_gpg_agent_t $1_home_t:file write_file_perms;
> > > 
> > > I'm a little hesitant to add this unconditionally, I don't think we want
> > > gpg-agent to write out to general home dir content.  Perhaps we should
> > > have a tunable, or a specific type for this.
> > 
> > I added this rules, so an example from gpg-agent manpage can work
> > out-of-the-box. Adding a tunable (with the default to disallow) will not
> > satisfy this. Maybe the later - specific type, but what security risk
> > poses this rules?
> > I thought, that domain X_gpg_agent_t is very trusted domain, that
> > manages my secret keys and should be shielded against the world around
> > and not the opposite.
> 
> Its trusted for handling keys, not trusted for handling general content
> in the user's home directory.  Remember that if the rules are made
> conditional, theres nothing stopping distros from making the tunable
> default to true.
> 
> > Ok, what about ssh-agent? Shoul be these rules for userdomain added for
> > it too?
> > 
> > zito@sid:/tmp$ rm -rf ssh-*
> > 
> > audit(1206101398.028:16): avc:  denied  { write } for  pid=2155 comm="rm" name="ssh-IgYHrr2122" dev=sda1 ino=49168 scontext=staff_u:staff_r:staff_t:s0 tcontext=system_u:object_r:sshd_tmp_t:s0 tclass=dir
> > audit(1206101398.028:17): avc:  denied  { remove_name } for  pid=2155 comm="rm" name="agent.2122" dev=sda1 ino=49169 scontext=staff_u:staff_r:staff_t:s0 tcontext=system_u:object_r:sshd_tmp_t:s0 tclass=dir
> > audit(1206101398.028:18): avc:  denied  { unlink } for  pid=2155 comm="rm" name="agent.2122" dev=sda1 ino=49169 scontext=staff_u:staff_r:staff_t:s0 tcontext=system_u:object_r:sshd_tmp_t:s0 tclass=sock_file
> > audit(1206101398.028:19): avc:  denied  { rmdir } for  pid=2155 comm="rm" name="ssh-IgYHrr2122" dev=sda1 ino=49168 scontext=staff_u:staff_r:staff_t:s0 tcontext=system_u:object_r:sshd_tmp_t:s0 tclass=dir
> 
> Yes, it seems reasonable to me.
> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150


Another patch is attached with the specific type for home file
(<ROLE>_gpg_agent_home_t). I hope, this is better than general write
permission from the previous patch and without administrative overhead
of tunable.

Allowed rules for userdomain on gpg-agent tmp files (socket) are
contained, but I'm not completely certain this is needed. Gpg-agent
creates socket while starting and cleans it up when exits. The socket
file remains in /tmp only when gpg-agent is killed by SIGKILL, and there
is probably no need to remove this stuff by the userdomain either.
Tmpreaper/tmpwatch cron job should do cleanup. Although I hope including
these rules for userdomain is harmless.

Concerning SSH...
After some investigation I found, that it is a bit more complicated.
When I ssh into the host with agent forwarded, than socket is created by
sshd and it has a context:

zito@bobek:~$ ssh -A sid  
zito@sid:~$ ls -lZa $SSH_AUTH_SOCK 
srwxr-xr-x 1 zito zito system_u:object_r:sshd_tmp_t:s0 0 Apr 15 14:34 /tmp/ssh-afqvGT1954/agent.1954

The socket of ssh agent started localy has context:

zito@sid:~$ eval `ssh-agent`
Agent pid 2097
zito@sid:~$ ls -laZ $SSH_AUTH_SOCK
srw------- 1 zito zito staff_u:object_r:staff_ssh_agent_tmp_t:s0 0 Apr 15 14:48 /tmp/ssh-LgmzMU2096/agent.2096


If you consider the userdomain rules needless, than gpg-agent-nouser is
attached as addon patch.

Best Regards
-- 
Zito

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gpg-agent

---
 policy/modules/apps/gpg.if |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

Index: policy/modules/apps/gpg.if
===================================================================
--- policy/modules/apps/gpg.if.orig	2008-04-09 18:05:09.000000000 +0200
+++ policy/modules/apps/gpg.if	2008-04-09 18:29:28.000000000 +0200
@@ -56,6 +56,9 @@
 	type $1_gpg_agent_tmp_t;
 	files_tmp_file($1_gpg_agent_tmp_t)
 
+	type $1_gpg_agent_home_t;
+	userdom_user_home_content($1,$1_gpg_agent_home_t)
+
 	type $1_gpg_secret_t;
 	userdom_user_home_content($1,$1_gpg_secret_t)
 
@@ -212,6 +215,14 @@
 	manage_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
 	manage_lnk_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
 
+	# write ~/.gpg-agent-info or a similar to the users home dir or subdir
+	# (gpg-agent --write-env-file option)
+	userdom_user_home_dir_filetrans($1,$1_gpg_agent_t,$1_gpg_agent_home_t,file)
+	userdom_user_home_content_filetrans($1,$1_gpg_agent_t,$1_gpg_agent_home_t,file)
+	allow $1_gpg_agent_t $1_gpg_agent_home_t : file { create_file_perms write_file_perms };
+	# the user can manage the gpg-agent-info file
+	allow $2 $1_gpg_agent_home_t:file manage_file_perms;
+
 	# allow gpg to connect to the gpg agent
 	stream_connect_pattern($1_gpg_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t,$1_gpg_agent_t)
 
@@ -219,11 +230,18 @@
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

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gpg-agent-nouser

Index: refpolicy-svn/policy/modules/apps/gpg.if
===================================================================
--- refpolicy-svn.orig/policy/modules/apps/gpg.if	2008-04-15 14:55:36.000000000 +0200
+++ refpolicy-svn/policy/modules/apps/gpg.if	2008-04-15 14:56:00.000000000 +0200
@@ -232,11 +232,6 @@
 	# Allow the user shell to signal the gpg-agent program.
 	allow $2 $1_gpg_agent_t:process { signal sigkill signull };
 
-	# Allow the user to manage gpg-agent tmp files (socket)
-	manage_dirs_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
-	manage_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
-	manage_sock_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
-
 	# Allow the gpg-agent to manage its tmp files (socket)
 	manage_dirs_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
 	manage_files_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)

--AqsLC8rIMeq19msA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
