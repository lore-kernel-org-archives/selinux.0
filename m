Subject: Re: I am concerned about putting genhomedircon changes
	inlibsemanage into Fedora 8.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1190836803.15779.159.camel@moss-spartans.epoch.ncsc.mil>
References: <200709262001.l8QK1Skx029939@tex.courtesan.com>
	 <1190836803.15779.159.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 26 Sep 2007 16:20:18 -0400
Message-Id: <1190838018.15779.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 16:00 -0400, Stephen Smalley wrote:
> On Wed, 2007-09-26 at 16:01 -0400, Todd C. Miller wrote:
> > I've added the checks Steve suggested.  It doesn't appear to cause
> > any new regressions.  I didn't do a real parse of the contexts file
> > line--I just grab the last whitespace-delimited field.  This should
> > be sufficient since the line comes from the template file and the
> > added checks will reject a bogus context, should it occur.
> > 
> >  - todd
> > 
> > Index: libsemanage/src/genhomedircon.c
> > ===================================================================
> > --- libsemanage/src/genhomedircon.c	(revision 2587)
> > +++ libsemanage/src/genhomedircon.c	(working copy)
> > @@ -1,5 +1,6 @@
> > -/* Author: Mark Goldman   <mgoldman@tresys.com>
> > - * 			Paul Rosenfeld	<prosenfeld@tresys.com>
> > +/* Author: Mark Goldman	  <mgoldman@tresys.com>
> > + * 	   Paul Rosenfeld <prosenfeld@tresys.com>
> > + * 	   Todd C. Miller <tmiller@tresys.com>
> >   *
> >   * Copyright (C) 2007 Tresys Technology, LLC
> >   *
> > @@ -23,6 +24,9 @@
> >  #include <semanage/seusers_policy.h>
> >  #include <semanage/users_policy.h>
> >  #include <semanage/user_record.h>
> > +#include <sepol/context.h>
> > +#include <sepol/context_record.h>
> > +#include <sepol/policydb/context.h>
> 
> That last include shouldn't be necessary - the headers under
> sepol/policydb/ are private to the static lib.

Other tidbits:
- Running semodule -B with this patch applied yields error messages from
libsepol on the invalid contexts.  Quiet it via something like:
  sepol_msg_set_callback(s->h_semanage->sepolh, NULL, NULL);
  result = sepol_context_check(...);
  sepol_msg_set_callback(s->h_semanage->sepolh, semanage_msg_relay_handler, NULL);

- A diff of file_contexts.homedirs generated via libsemanage vs. the
old /usr/sbin/genhomedircon script shows differences on rawhide.  Not
sure who is right.  Diff below.

diff -bwru files.0/file_contexts.homedirs files/file_contexts.homedirs
--- files.0/file_contexts.homedirs	2007-09-25 19:49:39.000000000 -0400
+++ files/file_contexts.homedirs	2007-09-25 19:50:09.000000000 -0400
@@ -1,30 +1,53 @@
-
 #
 #
-# User-specific file contexts, generated via /usr/sbin/genhomedircon
-# use semanage command to manage system users in order to change the file_context
+# User-specific file contexts, generated via libsemanage
+# use semanage command to manage system users to change the file_context
 #
 #
 
 
 #
-# Home Context for user system_u
+# Home Context for user user_u
 #
 
-/home/[^/]*/.+	system_u:object_r:user_home_t:s0
-/home/[^/]*/.*/plugins/nprhapengine\.so.*	--	system_u:object_r:textrel_shlib_t:s0
-/home/[^/]*/.*/plugins/libflashplayer\.so.*	--	system_u:object_r:textrel_shlib_t:s0
-/home/[^/]*/((www)|(web)|(public_html))(/.+)?	system_u:object_r:httpd_user_content_t:s0
-/home/[^/]*/\.mozilla(/.*)?/plugins/libflashplayer\.so.*	--	system_u:object_r:textrel_shlib_t:s0
-/home/[^/]*/\.config/gtk-.*	system_u:object_r:user_gnome_home_t:s0
-/home/[^/]*	-d	system_u:object_r:user_home_dir_t:s0
+/home/[^/]*/.+	user_u:object_r:user_home_t:s0
+/home/[^/]*/.gnome2(/.*)?	user_u:object_r:user_gnome_home_t:s0
+/home/[^/]*/.*/plugins/nprhapengine\.so.*	--	user_u:object_r:textrel_shlib_t:s0
+/home/[^/]*/.*/plugins/libflashplayer\.so.*	--	user_u:object_r:textrel_shlib_t:s0
+/home/[^/]*/((www)|(web)|(public_html))(/.+)?	user_u:object_r:httpd_user_content_t:s0
+/home/[^/]*/\.ssh(/.*)?	user_u:object_r:user_home_ssh_t:s0
+/home/[^/]*/\.uml(/.*)?	user_u:object_r:user_uml_rw_t:s0
+/home/[^/]*/\.java(/.*)?	user_u:object_r:user_mozilla_home_t:s0
+/home/[^/]*/\.xauth.*	--	user_u:object_r:user_xauth_home_t:s0
+/home/[^/]*/\.fonts(/.*)?	user_u:object_r:user_fonts_t:s0
+/home/[^/]*/\.pyzor(/.*)?	user_u:object_r:user_pyzor_home_t:s0
+/home/[^/]*/\.razor(/.*)?	user_u:object_r:user_razor_home_t:s0
+/home/[^/]*/vmware(/.*)?	user_u:object_r:user_vmware_file_t:s0
+/home/[^/]*/\.galeon(/.*)?	user_u:object_r:user_mozilla_home_t:s0
+/home/[^/]*/\.vmware(/.*)?	user_u:object_r:user_vmware_file_t:s0
+/home/[^/]*/\.vmware[^/]*/.*\.cfg	--	user_u:object_r:user_vmware_conf_t:s0
+/home/[^/]*/\.mozilla(/.*)?	user_u:object_r:user_mozilla_home_t:s0
+/home/[^/]*/\.phoenix(/.*)?	user_u:object_r:user_mozilla_home_t:s0
+/home/[^/]*/\.mplayer(/.*)?	user_u:object_r:user_mplayer_home_t:s0
+/home/[^/]*/\.mozilla(/.*)?/plugins/libflashplayer\.so.*	--	user_u:object_r:textrel_shlib_t:s0
+/home/[^/]*/\.ethereal(/.*)?	user_u:object_r:user_ethereal_home_t:s0
+/home/[^/]*/\.netscape(/.*)?	user_u:object_r:user_mozilla_home_t:s0
+/home/[^/]*/\.Xauthority.*	--	user_u:object_r:user_xauth_home_t:s0
+/home/[^/]*/\.fonts/auto(/.*)?	user_u:object_r:user_fonts_cache_t:s0
+/home/[^/]*/\.config/gtk-.*	user_u:object_r:user_gnome_home_t:s0
+/home/[^/]*/\.fonts\.cache-.*	--	user_u:object_r:user_fonts_cache_t:s0
+/home/[^/]*/\.ICEauthority.*	--	user_u:object_r:user_iceauth_home_t:s0
+/home/[^/]*/\.spamassassin(/.*)?	user_u:object_r:user_spamassassin_home_t:s0
+/home/[^/]*	-d	user_u:object_r:user_home_dir_t:s0
+/home/[^/]*	-l	user_u:object_r:user_home_dir_t:s0
+/home/[^/]*/\.ircmotd	--	user_u:object_r:user_irc_home_t:s0
+/home/[^/]*/\.screenrc	--	user_u:object_r:user_screen_ro_home_t:s0
+/home/[^/]*/\.fonts\.conf	--	user_u:object_r:user_fonts_config_t:s0
 /home/lost\+found/.*	<<none>>
 /home	-d	system_u:object_r:home_root_t:s0
 /home/\.journal	<<none>>
 /home/lost\+found	-d	system_u:object_r:lost_found_t:s0
-/tmp/\.exchange-.*(/.*)?	system_u:object_r:user_evolution_exchange_tmp_t:s0
-/tmp/gconfd-.*	-d	system_u:object_r:user_tmp_t:s0
-
+/tmp/gconfd-.*	-d	user_u:object_r:user_tmp_t:s0
 
 
 #
@@ -32,12 +55,36 @@
 #
 
 /root/.+	root:object_r:sysadm_home_t:s0
+/root/.gnome2(/.*)?	root:object_r:sysadm_gnome_home_t:s0
 /root/.*/plugins/nprhapengine\.so.*	--	root:object_r:textrel_shlib_t:s0
 /root/.*/plugins/libflashplayer\.so.*	--	root:object_r:textrel_shlib_t:s0
 /root/((www)|(web)|(public_html))(/.+)?	root:object_r:httpd_sysadm_content_t:s0
+/root/\.ssh(/.*)?	root:object_r:sysadm_home_ssh_t:s0
+/root/\.uml(/.*)?	root:object_r:sysadm_uml_rw_t:s0
+/root/\.java(/.*)?	root:object_r:sysadm_mozilla_home_t:s0
+/root/\.xauth.*	--	root:object_r:sysadm_xauth_home_t:s0
+/root/\.fonts(/.*)?	root:object_r:sysadm_fonts_t:s0
+/root/\.pyzor(/.*)?	root:object_r:sysadm_pyzor_home_t:s0
+/root/\.razor(/.*)?	root:object_r:sysadm_razor_home_t:s0
+/root/vmware(/.*)?	root:object_r:sysadm_vmware_file_t:s0
+/root/\.galeon(/.*)?	root:object_r:sysadm_mozilla_home_t:s0
+/root/\.vmware(/.*)?	root:object_r:sysadm_vmware_file_t:s0
+/root/\.vmware[^/]*/.*\.cfg	--	root:object_r:sysadm_vmware_conf_t:s0
+/root/\.mozilla(/.*)?	root:object_r:sysadm_mozilla_home_t:s0
+/root/\.phoenix(/.*)?	root:object_r:sysadm_mozilla_home_t:s0
+/root/\.mplayer(/.*)?	root:object_r:sysadm_mplayer_home_t:s0
 /root/\.mozilla(/.*)?/plugins/libflashplayer\.so.*	--	root:object_r:textrel_shlib_t:s0
+/root/\.ethereal(/.*)?	root:object_r:sysadm_ethereal_home_t:s0
+/root/\.netscape(/.*)?	root:object_r:sysadm_mozilla_home_t:s0
+/root/\.Xauthority.*	--	root:object_r:sysadm_xauth_home_t:s0
+/root/\.fonts/auto(/.*)?	root:object_r:sysadm_fonts_cache_t:s0
 /root/\.config/gtk-.*	root:object_r:sysadm_gnome_home_t:s0
+/root/\.fonts\.cache-.*	--	root:object_r:sysadm_fonts_cache_t:s0
+/root/\.ICEauthority.*	--	root:object_r:sysadm_iceauth_home_t:s0
+/root/\.spamassassin(/.*)?	root:object_r:sysadm_spamassassin_home_t:s0
 /root	-d	root:object_r:sysadm_home_dir_t:s0
-/tmp/\.exchange-root(/.*)?	root:object_r:sysadm_evolution_exchange_tmp_t:s0
+/root	-l	root:object_r:sysadm_home_dir_t:s0
+/root/\.ircmotd	--	root:object_r:sysadm_irc_home_t:s0
+/root/\.screenrc	--	root:object_r:sysadm_screen_ro_home_t:s0
+/root/\.fonts\.conf	--	root:object_r:sysadm_fonts_config_t:s0
 /tmp/gconfd-root	-d	root:object_r:sysadm_tmp_t:s0
-

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
