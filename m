Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KH3DJb007372
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 12:03:13 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KH39fY005347
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 17:03:09 GMT
Date: Wed, 20 Feb 2008 18:03:00 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: refpolicy: patch for gpg-agent
Message-ID: <20080220170300.GA13312@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I'm running HEAD refpolicy on Debian Sid, but this patch is not
Debian-specific this time.
Having a copy of my std bash profile on the testing machine with
a snippet (from gpg-agent man page):

    if test -f $HOME/.gpg-agent-info \
	     && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null
    then
	. $HOME/.gpg-agent-info
	export GPG_AGENT_INFO
	export SSH_AUTH_SOCK
	export SSH_AGENT_PID
    else
	eval `gpg-agent --daemon --write-env-file`
    fi

I got a number of denials for this snippet of commands.

1. Found a typo for permissions to create socket in the /tmp.
2. Added permission to send signal 0 by the user (see above).
3. Added permissions for writing agent info file into users home
   directory.

Regards
-- 
Zito

--EVF5PPMfhYS0aIcm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="gpg.patch"

Index: policy/modules/apps/gpg.if
===================================================================
--- policy/modules/apps/gpg.if	(revision 2617)
+++ policy/modules/apps/gpg.if	(working copy)
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
 
@@ -219,11 +225,11 @@
 	ps_process_pattern($2,$1_gpg_agent_t)
 
 	# Allow the user shell to signal the gpg-agent program.
-	allow $2 $1_gpg_agent_t:process { signal sigkill };
+	allow $2 $1_gpg_agent_t:process { signal sigkill signull };
 
-	manage_dirs_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
-	manage_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
-	manage_sock_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
+	manage_dirs_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
+	manage_files_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
+	manage_sock_files_pattern($1_gpg_agent_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
 	files_tmp_filetrans($1_gpg_agent_t, $1_gpg_agent_tmp_t, { file sock_file dir })
 
 	# Transition from the user domain to the derived domain.

--EVF5PPMfhYS0aIcm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
