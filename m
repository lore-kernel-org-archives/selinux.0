Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3NAUkGH001423
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2008 06:30:47 -0400
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3NAUihC025941
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2008 10:30:45 GMT
Date: Wed, 23 Apr 2008 12:30:42 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: [DSE-Dev] refpolicy: domains need access to the apt's pty and fifos
Message-ID: <20080423103042.GE14827@bobek.pm.i.cz>
References: <1204734268.12784.124.camel@hepcat.vitavonni.de> <200803062117.20441.russell@coker.com.au> <1204805640.5885.4.camel@hepcat.vitavonni.de> <20080305152322.GA9988@bobek.pm.i.cz> <1204734268.12784.124.camel@hepcat.vitavonni.de> <200803062117.20441.russell@coker.com.au> <20080305152322.GA9988@bobek.pm.i.cz> <1204734268.12784.124.camel@hepcat.vitavonni.de> <20080321073158.GA12456@bobek.pm.i.cz> <1206547029.16113.272.camel@gorn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5/uDoXvLw7AC5HRs"
In-Reply-To: <1206547029.16113.272.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

On Wed, Mar 26, 2008 at 11:57:09AM -0400, Christopher J. PeBenito wrote:
> 
> On Fri, 2008-03-21 at 08:31 +0100, Václav Ovsík wrote:
> > Hi,
> > sorry for a delay. Beforehand thanks for all worth reactions. I'm very
> > thankful for these.
> > 
> > BTW: I found, that dpkg passes (and should not) to child processes
> > a file descriptor of apt pipe:
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=471488
> > The access to apts fifo should not be needed for dpkg scripts.
> 
> > On Thu, Mar 06, 2008 at 11:46:54PM +1100, Russell Coker wrote:
> > > On Thursday 06 March 2008 23:13, Erich Schubert <erich@debian.org> wrote:
> > > > > > It would definitely help to have separate apt_t and apt_script_t
> > > > > > domains, though, to be able to differentiate access for installation
> > > > > > scripts and the package manager itself.
> > > > >
> > > > > What meaningful restrictions can be applied to one but not the other?
> > > >
> > > > I agree with you that we would currently have to allow pretty much any
> > > > access by apt_script_t, unfortunately. Sorry for mixing up apt and dpkg
> > > > again in that post btw, yes, it sould be dpkg_t and dpkg_script_t,
> > > > obviously.
> > > > No, I can't really think of ways to restrict dpkg_script_t apart from
> > > > not messing with the dpkg_t state files. Maybe we could make some policy
> > > 
> > > But given that dpkg_script_t can make all manner of other changes (including 
> > > loading a SE Linux policy) it seems rather minor to restrict access to dpkg 
> > > state files.
> > > 
> > > > that /usr is to be modified by dpkg_t only whereas dynamically generated
> > > > files have to reside in /var, but I doubt this would currently hold.
> > > 
> > > It's a standard practice to convert the data files under /var in an upgrade.
> > > 
> > > > And after all, dpkg_script_t needs to be able to even add users
> > > > to /etc/passwd (although through the helper applications, not directly).
> > > 
> > > Yes.
> > > 
> > > In fact while we have unconfined_t, the benefit of having a separate dpkg_t 
> > > instead of using unconfined_t for installing packages doesn't seem 
> > > significant.
> 
> > Seems to me dpkg_script_t is not used now really.  Should be removed
> > dpkg_script_t from the refpolicy?  A part of rules should be moved from
> > the domain dpkg_script_t to the domain dpkg_t probably if such a removal
> > will take place.
> 
> As I recall it was a work in progress by either Erich or Manoj.  If it
> was never finished or abandoned, then it should probably be removed.
> 
> 
> > On Mon, Mar 10, 2008 at 01:39:49PM -0400, Christopher J. PeBenito wrote:
> > > On Fri, 2008-03-07 at 22:23 +0100, Stefan Schulze Frielinghaus wrote:
> > > > On Wed, 2008-03-05 at 16:23 +0100, Václav Ovsík wrote:
> > > > > Hi,
> > > > > running Debian Sid with HEAD refpolicy...
> > > > > I tried to install bind9 and got some further denials for access to pty
> > > > > and pipe of apt_t domain. This is a continuation of the patch from
> > > > > Martin Orr in thread "refpolicy: patch for ldconfig from glibc 2.7...",
> > > > > witch was about apt finally.
> > > > > 
> > > > > ...
> > > > > 
> > > > > Attached patch solves the most of this denials, but I doubt this is the
> > > > > right way.  Should be used some attribute for this?  I noticed attribute
> > > > > privfd and macro domain_interactive_fd(), what about it?  Rpm already
> > > > > has such macro calls
> > > > > ./policy/modules/admin/rpm.te:domain_interactive_fd(rpm_t)
> > > > > ./policy/modules/admin/rpm.te:domain_interactive_fd(rpm_script_t)
> > > > > 
> > > > > I tried to use this macro for apt_t, and all use fd denials above are
> > > > > solved with it. Should be things done in this way?
> > > > > 
> > > > > Thanks for comments.
> > > > 
> > > > I think it is not really nice to have all these allow rules directly in
> > > > the modules. A similar discussion can be found here:
> > > > http://marc.info/?l=selinux&m=118707242005853&w=2
> > > > 
> > > > Especially the first replay of Stephen Smalley pointing out how rpm
> > > > solves this via domain.if: rpm_use_fds($1) and rpm_read_pipes($1)
> > > > 
> > > > If I had to choose between the several fixes for every module or the
> > > > "rpm-way" to allow all usage of file descriptors and read permissions
> > > > then I would vote for the latter.
> > > 
> > > A better option might be to mimic the inheritance of fds and pipes.
> > 
> > I'm not certain I understood this correctly.  I understood `to mimic the
> > inheritance', that for all domains runnable from dpkg scripts should be
> > inserted appropriate rules for access explicitly.  If I'm wrong, please
> > explain it a bit further.  Sorry for my English.
> 
> No thats not what I mean.  If you do that, then it means each module has
> to know about domains that indirectly execute it.  My suggestion is if
> you have a chain of execs like this:
> 
> user -> foo -> bar -> yar
> 
> then you would want yar to inherit and use user's fds so that it can
> write out to the user's terminal.  So it seems best to structure the
> policy so that at each run interface call you put in your own fd and
> pipes and also the pipes and fds that you've inherited.  So that results
> in:
> 
> foo inherits user fds/pipes
> bar inherits user and foo fds/pipes
> yar inherits user, bar, and foo pipes
> 
> I managed to partially do this with roles and terminals, in run
> interfaces.  My initial idea is for each domain to keep an attribute of
> fds and redirections that it inherits.  Unfortunately this turns run
> interfaces ugly due to fds possibly opened to a file, pipe, or terminal
> (I suppose there could be other redirections but these are by far the
> common ones).  For example (in pseudo-policy)
> 
> interface foo_run
> 	foo_domtrans($domain)
> 	roleattribute foo_inherited_roles $role;
> 	typeattribute foo_inherited_fds $inherit_fds;
> 	typeattribute foo_inherited_terms $inherit_terms;
> 	typeattribute foo_inherited_pipes $inherit_pipes;
> 
> Then in foo.te we have
> 
> role foo_inherited_roles types foo_t;
> allow foo_t foo_inh_fds:fd use;
> allow foo_t foo_inh_files:file rw_file_perms;
> allow foo_t foo_inh_terms:chr_file rw_chr_file_perms;
> allow foo_t foo_inh_pipes:fifo_file rw_fifo_file_perms;
> 
> bar_run(foo_t,
> 	foo_inh_roles,
> 	{ foo_t foo_inh_fds },
> 	{ foo_t foo_inh_pipes },
> 	foo_inh_files,
> 	foo_inh_terms
> 	)
> 
> if foo opens up a pty for its call to bar then we could break most of
> the inheritance
> 
> bar_run(foo_t,foo_inh_roles,foo_t,,,foo_pty_t)
> 
> The problem is that not all of the constructs I used in my example are
> available in the current language, and optional parameters on interfaces
> are not currently allowed.
> 
> Its not so pretty, but thats my idea.  I'm certainly open to suggestions
> for something better.  In the mean time I suppose we just have to
> continue adding rules to the individual modules.

Thanks for the exhaustive explanation Christopher. It seemed to me, that
your idea can be done at least for types (a roleattribute keyword not
exist yet), but I was wrong about attributes :(. Attribute can't have
attribute (recursively). With an attached nonfunctional patch I ended
with:

/usr/bin/checkmodule -M -m tmp/apt.tmp -o tmp/apt.mod
/usr/bin/checkmodule:  loading policy configuration from tmp/apt.tmp
policy/modules/admin/apt.te":135:ERROR 'unknown type dpkg_inherited_fd' at token ';' on line 7686:
        typeattribute dpkg_inherited_fd apt_inherited_fd;
#line 135
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/apt.mod] Error 1

Of course dpkg_inherited_fd is the attribute and not the type, shame.
You are right, with current policy language this can't be done easily.

Maybe wee can do this job using m4. This would require an additional
pass to process sources or modification of processing a bit. My rough
idea for modular policy:
    * To include the third new parameter of interface/template macro
      used by run interfaces. This parameter will accept what and how
      should be inherited in some notation parse able fine by m4. The
      information "what" should describe the class (fd, pipe...), the
      type. The information "how" should describe passing down (to pass
      inheritance down or to stop inheritance there).
    * To split module preprocessing (m4) and compilation (checkmodule)
      (Rules.modular).
    * All modules must by m4 processed at first to create the
      meta-information about all inheritances. The compilation
      (checkmodule) of any module (with some run interface) should
      depend on meta-information from all other packages.
    * Updating of inheritance meta-information must be updated only when
      the content is really different, so Make will not restart
      rebuilding things unnecessarily.
    * To build allow rules from inheritance meta-information and append
      this rules to already preprocessed .te product and compile it by
      checkmodule.

Please comment this. Thanks.
Best Regards
-- 
Zito

--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=apt

---
 policy/modules/admin/apt.if          |   46 ++++++++++++++++++++++++++---
 policy/modules/admin/apt.te          |    7 ++++
 policy/modules/admin/dpkg.if         |   30 +++++++++++++++----
 policy/modules/admin/dpkg.te         |   18 +++++++----
 policy/modules/admin/rpm.if          |    2 -
 policy/modules/system/libraries.if   |   27 ++++++++++++++---
 policy/modules/system/libraries.te   |   12 +++----
 policy/modules/system/selinuxutil.if |   54 +++++++++++++++++++++++++++++------
 policy/modules/system/selinuxutil.te |   10 ++++++
 policy/modules/system/unconfined.te  |    2 -
 policy/modules/system/userdomain.if  |    4 +-
 policy/modules/system/userdomain.te  |    6 +--
 policy/support/loadable_module.spt   |   41 ++++++++++++++++++++++++++
 13 files changed, 216 insertions(+), 43 deletions(-)

Index: policy/modules/system/libraries.te
===================================================================
--- policy/modules/system/libraries.te.orig	2008-04-22 16:00:22.000000000 +0200
+++ policy/modules/system/libraries.te	2008-04-22 16:00:22.000000000 +0200
@@ -42,6 +42,9 @@
 type textrel_shlib_t alias texrel_shlib_t;
 files_type(textrel_shlib_t)
 
+# declarations for inherited resources
+decl_inh_resources(ldconfig)
+
 ########################################
 #
 # ldconfig local policy
@@ -85,6 +88,9 @@
 
 userdom_use_all_users_fds(ldconfig_t)
 
+# allow access to inherited resources
+rules_inh_resources(ldconfig_t, ldconfig)
+
 ifdef(`distro_ubuntu',`
 	optional_policy(`
 		unconfined_domain(ldconfig_t)
@@ -103,12 +109,6 @@
 ')
 
 optional_policy(`
-	apt_rw_pipes(ldconfig_t)
-	apt_use_fds(ldconfig_t)
-	apt_use_ptys(ldconfig_t)
-')
-
-optional_policy(`
 	# When you install a kernel the postinstall builds a initrd image in tmp 
 	# and executes ldconfig on it.  If you dont allow this kernel installs 
 	# blow up.
Index: policy/modules/admin/apt.if
===================================================================
--- policy/modules/admin/apt.if.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/admin/apt.if	2008-04-22 16:15:23.000000000 +0200
@@ -34,9 +34,24 @@
 ##	The role to allow the apt domain.
 ##	</summary>
 ## </param>
-## <param name="terminal">
+## <param name="fds">
 ##	<summary>
-##	The type of the terminal allow the apt domain to use.
+##	Types of fds to allow the apt domain to use.
+##	</summary>
+## </param>
+## <param name="pipes">
+##	<summary>
+##	Types of pipes to allow the apt domain to use.
+##	</summary>
+## </param>
+## <param name="files">
+##	<summary>
+##	Types of files to allow the apt domain to use.
+##	</summary>
+## </param>
+## <param name="terminals">
+##	<summary>
+##	Types of terminals to allow the apt domain to use.
 ##	</summary>
 ## </param>
 ## <rolecap/>
@@ -44,12 +59,15 @@
 interface(`apt_run',`
 	gen_require(`
 		type apt_t;
+		decl_inh_resources(apt)
 	')
 
 	apt_domtrans($1)
-	role $2 types apt_t;
-	allow apt_t $3:chr_file rw_term_perms;
-	# TODO: likely have to add dpkg_run here.
+	role_opt_types(`$2', apt_t)
+	attribute_types_opt(apt_inherited_fd, `$3')
+	attribute_types_opt(apt_inherited_pipe, `$4')
+	attribute_types_opt(apt_inherited_file, `$5')
+	attribute_types_opt(apt_inherited_terminal, `$6')
 ')
 
 ########################################
@@ -92,6 +110,24 @@
 
 ########################################
 ## <summary>
+##	Do not audit attempts to write apt unnamed pipes.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`apt_dontaudit_write_pipes',`
+	gen_require(`
+		type apt_t;
+	')
+
+	dontaudit $1 apt_t:fifo_file write;
+')
+
+########################################
+## <summary>
 ##	Read and write an unnamed apt pipe.
 ## </summary>
 ## <param name="domain">
Index: policy/modules/admin/apt.te
===================================================================
--- policy/modules/admin/apt.te.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/admin/apt.te	2008-04-22 16:00:22.000000000 +0200
@@ -33,6 +33,9 @@
 type apt_var_log_t;
 logging_log_file(apt_var_log_t)
 
+# declarations for inherited resources
+decl_inh_resources(apt)
+
 ########################################
 #
 # apt Local policy
@@ -121,6 +124,9 @@
 
 sysnet_read_config(apt_t)
 
+# allow access to inherited resources
+rules_inh_resources(apt_t, apt)
+
 # with boolean, for cron-apt and such?
 #optional_policy(`
 #	cron_system_entry(apt_t,apt_exec_t)
@@ -131,6 +137,7 @@
 	dpkg_read_db(apt_t)
 	dpkg_domtrans(apt_t)
 	dpkg_lock_db(apt_t)
+	dpkg_run(apt_t, , apt_inherited_fd, apt_inherited_pipe, apt_inherited_file, apt_inherited_terminal)
 ')
 
 optional_policy(`
Index: policy/modules/admin/dpkg.if
===================================================================
--- policy/modules/admin/dpkg.if.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/admin/dpkg.if	2008-04-22 16:15:47.000000000 +0200
@@ -58,9 +58,24 @@
 ##	The role to allow the dpkg domain.
 ##	</summary>
 ## </param>
-## <param name="terminal">
+## <param name="fds">
 ##	<summary>
-##	The type of the terminal allow the dpkg domain to use.
+##	Types of fds to allow the dpkg domain to use.
+##	</summary>
+## </param>
+## <param name="pipes">
+##	<summary>
+##	Types of pipes to allow the dpkg domain to use.
+##	</summary>
+## </param>
+## <param name="files">
+##	<summary>
+##	Types of files to allow the dpkg domain to use.
+##	</summary>
+## </param>
+## <param name="terminals">
+##	<summary>
+##	Types of terminals to allow the dpkg domain to use.
 ##	</summary>
 ## </param>
 ## <rolecap/>
@@ -68,13 +83,16 @@
 interface(`dpkg_run',`
 	gen_require(`
 		type dpkg_t, dpkg_script_t;
+		decl_inh_resources(dpkg)
 	')
 
 	dpkg_domtrans($1)
-	role $2 types dpkg_t;
-	role $2 types dpkg_script_t;
-	seutil_run_loadpolicy(dpkg_script_t,$2,$3)
-	allow dpkg_t $3:chr_file rw_term_perms;
+	role_opt_types(`$2', dpkg_t)
+	role_opt_types(`$2', dpkg_script_t)
+	attribute_types_opt(dpkg_inherited_fd, `$3')
+	attribute_types_opt(dpkg_inherited_pipe, `$4')
+	attribute_types_opt(dpkg_inherited_file, `$5')
+	attribute_types_opt(dpkg_inherited_terminal, `$6')
 ')
 
 ########################################
Index: policy/modules/admin/dpkg.te
===================================================================
--- policy/modules/admin/dpkg.te.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/admin/dpkg.te	2008-04-22 16:00:22.000000000 +0200
@@ -47,6 +47,9 @@
 type dpkg_script_tmpfs_t;
 files_tmpfs_file(dpkg_script_tmpfs_t)
 
+# declarations for inherited resources
+decl_inh_resources(dpkg)
+
 ########################################
 #
 # dpkg Local policy
@@ -173,9 +176,8 @@
 # since the scripts aren't labeled correctly yet...
 allow dpkg_t dpkg_var_lib_t:file execute;
 
-optional_policy(`
-	apt_use_ptys(dpkg_t)
-')
+# allow access to inherited resources
+rules_inh_resources(dpkg_t, dpkg)
 
 # TODO: allow?
 #optional_policy(`
@@ -319,10 +321,12 @@
 	allow dpkg_script_t self:process execmem;
 ')
 
-optional_policy(`
-	apt_rw_pipes(dpkg_script_t)
-	apt_use_fds(dpkg_script_t)
-')
+# allow access to inherited resources
+rules_inh_resources(dpkg_script_t, dpkg)
+
+# dpkg can run (scripts)
+libs_run_ldconfig(dpkg_script_t, , dpkg_inherited_fd, dpkg_inherited_pipe, dpkg_inherited_file, dpkg_inherited_terminal)
+seutil_run_loadpolicy(dpkg_script_t, , dpkg_inherited_fd, dpkg_inherited_pipe, dpkg_inherited_file, dpkg_inherited_terminal)
 
 optional_policy(`
 	bootloader_domtrans(dpkg_script_t)
Index: policy/modules/system/libraries.if
===================================================================
--- policy/modules/system/libraries.if.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/system/libraries.if	2008-04-22 16:16:18.000000000 +0200
@@ -33,9 +33,24 @@
 ##	The role to allow the ldconfig domain.
 ##	</summary>
 ## </param>
-## <param name="terminal">
+## <param name="fds">
 ##	<summary>
-##	The type of the terminal allow the ldconfig domain to use.
+##	Types of fds to allow the ldconfig domain to use.
+##	</summary>
+## </param>
+## <param name="pipes">
+##	<summary>
+##	Types of pipes to allow the ldconfig domain to use.
+##	</summary>
+## </param>
+## <param name="files">
+##	<summary>
+##	Types of files to allow the ldconfig domain to use.
+##	</summary>
+## </param>
+## <param name="terminals">
+##	<summary>
+##	Types of terminals to allow the ldconfig domain to use.
 ##	</summary>
 ## </param>
 ## <rolecap/>
@@ -43,11 +58,15 @@
 interface(`libs_run_ldconfig',`
 	gen_require(`
 		type ldconfig_t;
+		decl_inh_resources(ldconfig)
 	')
 
 	libs_domtrans_ldconfig($1)
-	role $2 types ldconfig_t;
-	allow ldconfig_t $3:chr_file rw_term_perms;
+	role_opt_types(`$2', ldconfig_t)
+	attribute_types_opt(ldconfig_inherited_fd, `$3')
+	attribute_types_opt(ldconfig_inherited_pipe, `$4')
+	attribute_types_opt(ldconfig_inherited_file, `$5')
+	attribute_types_opt(ldconfig_inherited_terminal, `$6')
 ')
 
 ########################################
Index: policy/modules/system/unconfined.te
===================================================================
--- policy/modules/system/unconfined.te.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/system/unconfined.te	2008-04-22 16:00:22.000000000 +0200
@@ -36,7 +36,7 @@
 
 init_run_daemon(unconfined_t, unconfined_r, { unconfined_devpts_t unconfined_tty_device_t })
 
-libs_run_ldconfig(unconfined_t, unconfined_r, { unconfined_devpts_t unconfined_tty_device_t })
+libs_run_ldconfig(unconfined_t, unconfined_r, , , , { unconfined_devpts_t unconfined_tty_device_t })
 
 logging_send_syslog_msg(unconfined_t)
 logging_run_auditctl(unconfined_t, unconfined_r, { unconfined_devpts_t unconfined_tty_device_t })
Index: policy/modules/system/userdomain.te
===================================================================
--- policy/modules/system/userdomain.te.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/system/userdomain.te	2008-04-22 16:00:22.000000000 +0200
@@ -243,7 +243,7 @@
 ')
 
 optional_policy(`
-	apt_run(sysadm_t, sysadm_r, admin_terminal)
+	apt_run(sysadm_t, sysadm_r, , , , admin_terminal)
 ')
 
 optional_policy(`
@@ -313,7 +313,7 @@
 ')
 
 optional_policy(`
-	dpkg_run(sysadm_t, sysadm_r, admin_terminal)
+	dpkg_run(sysadm_t, sysadm_r, , , , admin_terminal)
 ')
 
 optional_policy(`
@@ -348,7 +348,7 @@
 ')
 
 optional_policy(`
-	libs_run_ldconfig(sysadm_t, sysadm_r, admin_terminal)
+	libs_run_ldconfig(sysadm_t, sysadm_r, , , , admin_terminal)
 ')
 
 optional_policy(`
Index: policy/support/loadable_module.spt
===================================================================
--- policy/support/loadable_module.spt.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/support/loadable_module.spt	2008-04-22 16:00:22.000000000 +0200
@@ -149,3 +149,44 @@
 		$3
 	')}
 ')
+
+##############################
+#
+# Optional role types handling
+# Argument 1 - role (optional)
+#	   2 - types
+#
+define(`role_opt_types',`ifelse(`$1',`',`',`role $1 types $2;')')
+
+##############################
+#
+# Optional typeattribute  handling
+# Argument 1 - attribute
+#	   2 - types (optional)
+#
+define(`attribute_types_opt',`ifelse(`$2',`',`',`typeattribute $1 $2;')')
+
+##############################
+#
+# Declarations for inherited resources
+# Argument 1 - prefix
+#
+define(`decl_inh_resources',`
+attribute $1_inherited_fd;
+attribute $1_inherited_pipe;
+attribute $1_inherited_file;
+attribute $1_inherited_terminal;
+')
+
+##############################
+#
+# Rules for inherited resources
+# Argument 1 - domain to control access
+#	   2 - prefix
+#
+define(`rules_inh_resources',`
+allow $1 $2_inherited_fd:fd use;
+allow $1 $2_inherited_pipe:fifo_file rw_fifo_file_perms;
+allow $1 $2_inherited_file:file rw_file_perms;
+allow $1 $2_inherited_terminal:chr_file rw_term_perms;
+')
Index: policy/modules/admin/rpm.if
===================================================================
--- policy/modules/admin/rpm.if.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/admin/rpm.if	2008-04-22 16:00:22.000000000 +0200
@@ -71,7 +71,7 @@
 	rpm_domtrans($1)
 	role $2 types rpm_t;
 	role $2 types rpm_script_t;
-	seutil_run_loadpolicy(rpm_script_t,$2,$3)
+	seutil_run_loadpolicy(rpm_script_t,$2,,,,$3)
 	seutil_run_semanage(rpm_script_t,$2,$3)
 	seutil_run_setfiles(rpm_script_t,$2,$3)
 	allow rpm_t $3:chr_file rw_term_perms;
Index: policy/modules/system/selinuxutil.if
===================================================================
--- policy/modules/system/selinuxutil.if.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/system/selinuxutil.if	2008-04-22 16:18:05.000000000 +0200
@@ -36,9 +36,24 @@
 ##	The role to be allowed the checkpolicy domain.
 ##	</summary>
 ## </param>
-## <param name="terminal">
+## <param name="fds">
+##	<summary>
+##	Types of fds to allow the checkpolicy domain to use.
+##	</summary>
+## </param>
+## <param name="pipes">
+##	<summary>
+##	Types of pipes to allow the checkpolicy domain to use.
+##	</summary>
+## </param>
+## <param name="files">
+##	<summary>
+##	Types of files to allow the checkpolicy domain to use.
+##	</summary>
+## </param>
+## <param name="terminals">
 ##	<summary>
-##	The type of the terminal allow the checkpolicy domain to use.
+##	Types of terminals to allow the checkpolicy domain to use.
 ##	</summary>
 ## </param>
 ## <rolecap/>
@@ -46,11 +61,16 @@
 interface(`seutil_run_checkpolicy',`
 	gen_require(`
 		type checkpolicy_t;
+		decl_inh_resources(checkpolicy)
+		decl_inh_resources(loadpolicy)
 	')
 
 	seutil_domtrans_checkpolicy($1)
-	role $2 types checkpolicy_t;
-	allow checkpolicy_t $3:chr_file rw_term_perms;
+	role_opt_types(`$2', checkpolicy_t)
+	attribute_types_opt(checkpolicy_inherited_fd, `$3')
+	attribute_types_opt(checkpolicy_inherited_pipe, `$4')
+	attribute_types_opt(checkpolicy_inherited_file, `$5')
+	attribute_types_opt(checkpolicy_inherited_terminal, `$6')
 ')
 
 ########################################
@@ -109,9 +129,24 @@
 ##	The role to be allowed the load_policy domain.
 ##	</summary>
 ## </param>
-## <param name="terminal">
+## <param name="fds">
+##	<summary>
+##	Types of fds to allow the load_policy domain to use.
+##	</summary>
+## </param>
+## <param name="pipes">
+##	<summary>
+##	Types of pipes to allow the load_policy domain to use.
+##	</summary>
+## </param>
+## <param name="files">
+##	<summary>
+##	Types of files to allow the load_policy domain to use.
+##	</summary>
+## </param>
+## <param name="terminals">
 ##	<summary>
-##	The type of the terminal allow the load_policy domain to use.
+##	Types of terminals to allow the load_policy domain to use.
 ##	</summary>
 ## </param>
 ## <rolecap/>
@@ -122,8 +157,11 @@
 	')
 
 	seutil_domtrans_loadpolicy($1)
-	role $2 types load_policy_t;
-	allow load_policy_t $3:chr_file rw_term_perms;
+	role_opt_types(`$2', load_policy_t)
+	attribute_types_opt(loadpolicy_inherited_fd, `$3')
+	attribute_types_opt(loadpolicy_inherited_pipe, `$4')
+	attribute_types_opt(loadpolicy_inherited_file, `$5')
+	attribute_types_opt(loadpolicy_inherited_terminal, `$6')
 ')
 
 ########################################
Index: policy/modules/system/selinuxutil.te
===================================================================
--- policy/modules/system/selinuxutil.te.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/system/selinuxutil.te	2008-04-22 16:00:22.000000000 +0200
@@ -109,6 +109,10 @@
 init_system_domain(setfiles_t,setfiles_exec_t)
 domain_obj_id_change_exemption(setfiles_t)
 
+# declarations for inherited resources
+decl_inh_resources(checkpolicy)
+decl_inh_resources(loadpolicy)
+
 ########################################
 #
 # Checkpolicy local policy
@@ -151,6 +155,9 @@
 	')
 ')
 
+# allow access to inherited resources
+rules_inh_resources(checkpolicy_t, checkpolicy)
+
 ########################################
 #
 # Load_policy local policy
@@ -204,6 +211,9 @@
 	')
 ')
 
+# allow access to inherited resources
+rules_inh_resources(load_policy_t, loadpolicy)
+
 ########################################
 #
 # Newrole local policy
Index: policy/modules/system/userdomain.if
===================================================================
--- policy/modules/system/userdomain.if.orig	2008-04-22 16:00:07.000000000 +0200
+++ policy/modules/system/userdomain.if	2008-04-22 16:00:22.000000000 +0200
@@ -1446,8 +1446,8 @@
 	logging_read_audit_config($1)
 
 	seutil_manage_bin_policy($1)
-	seutil_run_checkpolicy($1,$2,$3)
-	seutil_run_loadpolicy($1,$2,$3)
+	seutil_run_checkpolicy($1,$2,,,,$3)
+	seutil_run_loadpolicy($1,$2,,,,$3)
 	seutil_run_semanage($1,$2,$3)
 	seutil_run_setfiles($1, $2, $3)
 

--5/uDoXvLw7AC5HRs--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
