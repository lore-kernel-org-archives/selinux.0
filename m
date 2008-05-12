Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4CDX4mq023942
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2008 09:33:04 -0400
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4CDX2C7001219
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2008 13:33:03 GMT
Date: Mon, 12 May 2008 15:32:56 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: patch for gpg-agent
Message-ID: <20080512133256.GA20569@bobek.pm.i.cz>
References: <1206544272.16113.228.camel@gorn> <20080415132602.GA6685@bobek.pm.i.cz> <1210095215.12360.10.camel@gorn> <20080220170300.GA13312@bobek.pm.i.cz> <1204660301.14217.26.camel@gorn> <20080321130315.GA21980@bobek.pm.i.cz> <1206544272.16113.228.camel@gorn> <20080415132602.GA6685@bobek.pm.i.cz> <20080424081407.GA20611@bobek.pm.i.cz> <4810D0AC.7060006@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <1210095215.12360.10.camel@gorn> <4810D0AC.7060006@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Apr 24, 2008 at 02:25:48PM -0400, Daniel J Walsh wrote:
...
> Current Fedora allows gpg_t to manage files in the homedirs, since it
> needs to be able to read/write files in the homedir.  No reason to
> isolate it.
> 
> The reason for this patch being large is that Fedora no longer separates
> homedir labeling via Prefix, since this concept will not work in a
> distributed homedir environment.
...

My patch was about gpg-agent (gpg_agent_t) and not gpg itself (gpg_t).
Thanks for the Fedora gpg patch. It is quite big. I must keep the change
small to be acceptable by Christopher :).


On Tue, May 06, 2008 at 01:33:35PM -0400, Christopher J. PeBenito wrote:
... 
> I've been kicking this one around in my head for a while since this
> doesn't seem clear cut.  I think adding another type is too much for
> such a file, so I still think the best choice is to have a tunable that
> allows writing to $1_home_t files, as I suggested before.

OK. This time I attached a patch with a tunable (shared by all roles).
The tunable (gpg_agent_manage_user_files) defaults to false.
Maybe names should be corrected.


> Another suggestion that was made to me would be to use the same type
> used by the socket ($1_gpg_agent_tmp_t).  I'm not convinced there
> actually a security equivalence, but if you can come up with a good
> argument, then I'm open to it.  If that happens the type will have to be
> renamed since creating a *_tmp_t file in a user home directory is
> confusing.

I hope the above will be sufficient. My original meaning was less
tunables the better (less possibility to miss-configure something...)
and therefore I wrote the patch without tunable first.

Best Regards
-- 
Zito

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gpg-agent

Index: policy/modules/apps/gpg.if
===================================================================
--- policy/modules/apps/gpg.if.orig	2008-05-12 09:14:15.000000000 +0200
+++ policy/modules/apps/gpg.if	2008-05-12 14:51:23.000000000 +0200
@@ -212,6 +212,15 @@
 	manage_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
 	manage_lnk_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
 
+	tunable_policy(`gpg_agent_manage_user_files',`
+	    # write ~/.gpg-agent-info or a similar to the users home dir
+	    # or subdir (gpg-agent --write-env-file option)
+	    #
+	    userdom_user_home_dir_filetrans_user_home_content($1,$1_gpg_agent_t,file)
+	    userdom_manage_user_home_content_dirs($1,$1_gpg_agent_t)
+	    userdom_manage_user_home_content_files($1,$1_gpg_agent_t)
+	')
+
 	# allow gpg to connect to the gpg agent
 	stream_connect_pattern($1_gpg_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t,$1_gpg_agent_t)
 
@@ -219,11 +228,18 @@
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
Index: policy/modules/apps/gpg.te
===================================================================
--- policy/modules/apps/gpg.te.orig	2008-05-12 09:14:15.000000000 +0200
+++ policy/modules/apps/gpg.te	2008-05-12 09:14:28.000000000 +0200
@@ -6,6 +6,13 @@
 # Declarations
 #
 
+## <desc>
+## <p>
+## Allow gpg-agent to manage user files.
+## </p>
+## </desc>
+gen_tunable(gpg_agent_manage_user_files,false)
+
 # Type for gpg or pgp executables.
 type gpg_exec_t;
 type gpg_helper_exec_t;

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gpg-agent-nouser

Index: refpolicy-svn/policy/modules/apps/gpg.if
===================================================================
--- refpolicy-svn.orig/policy/modules/apps/gpg.if	2008-05-12 14:51:48.000000000 +0200
+++ refpolicy-svn/policy/modules/apps/gpg.if	2008-05-12 14:51:48.000000000 +0200
@@ -230,11 +230,6 @@
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

--sm4nu43k4a2Rpi4c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
