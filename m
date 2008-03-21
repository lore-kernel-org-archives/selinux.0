Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2L7W2iL024465
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2008 03:32:02 -0400
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2L7W0Vp007943
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2008 07:32:01 GMT
Date: Fri, 21 Mar 2008 08:31:58 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: [DSE-Dev] refpolicy: domains need access to the apt's pty and fifos
Message-ID: <20080321073158.GA12456@bobek.pm.i.cz>
References: <200803062346.58639.russell@coker.com.au> <20080305152322.GA9988@bobek.pm.i.cz> <1204734268.12784.124.camel@hepcat.vitavonni.de> <200803062117.20441.russell@coker.com.au> <1204805640.5885.4.camel@hepcat.vitavonni.de> <20080305152322.GA9988@bobek.pm.i.cz> <1204734268.12784.124.camel@hepcat.vitavonni.de> <200803062117.20441.russell@coker.com.au> <20080305152322.GA9988@bobek.pm.i.cz> <1204734268.12784.124.camel@hepcat.vitavonni.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
In-Reply-To: <1205170789.25555.20.camel@gorn> <1204925012.2788.5.camel@vogon> <200803062346.58639.russell@coker.com.au> <1204805640.5885.4.camel@hepcat.vitavonni.de> <200803062117.20441.russell@coker.com.au> <1204734268.12784.124.camel@hepcat.vitavonni.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
sorry for a delay. Beforehand thanks for all worth reactions. I'm very
thankful for these.

BTW: I found, that dpkg passes (and should not) to child processes
a file descriptor of apt pipe:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=471488
The access to apts fifo should not be needed for dpkg scripts.


On Wed, Mar 05, 2008 at 05:24:28PM +0100, Erich Schubert wrote:
> Hi,
> Back when I did the initial apt_t policy, I was considering to setup
> domains such as apt_script_t and run the package installation scripts in
> this domain. This would have been similar to the rpm_script_t domain.
> However getting the files in /var/lib/dpkg/info/ labeled correctly would
> probably have required some patches to dpkg. There are non-executable
> files in there as well, and I'm not sure if you'd want to mix them up.
> For example, there are files there storing reference md5sums, or listing
> package contents. apt_script_exec_t doesn't sound appropriate for them.
> But having them in the same directory means we can't use automatic file
> type transitions.
> 
> The amount of things done in postinst scripts is one of the things that
> really scares me from a security point of view. It might be very
> valuable to use a tight SELinux policy to restrict these scripts,
> however when it comes down to having a SELinux policy package update it
> becomes a Catch-22 somewhat.
> It would definitely help to have separate apt_t and apt_script_t
> domains, though, to be able to differentiate access for installation
> scripts and the package manager itself.
> 
> P.S. Thanks for the great work you've been doing on the SELinux policy
> for Debian these days! THANKS!
> 
> best regards,
> Erich Schubert
> -- 
>     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
>    There was never a good war or a bad peace. - Benjamin Franklin   //\
>           Liebe ist eine schwere Geisteskrankheit (Platon)          V_/_
> 

On Thu, Mar 06, 2008 at 09:17:16PM +1100, Russell Coker wrote:
> On Thursday 06 March 2008 03:24, Erich Schubert <erich@debian.org> wrote:
> > Back when I did the initial apt_t policy, I was considering to setup
> > domains such as apt_script_t and run the package installation scripts in
> > this domain. This would have been similar to the rpm_script_t domain.
> 
> I don't believe that it is possible to gain any security benefit from 
> splitting dpkg_t, apt_t, and a domain for the scripts.
> 
> If apt decides that a certain package is to be installed then dpkg will not 
> object, therefore granting apt less privileges than dpkg will not give any 
> real benefit.
> 
> Pre/post install/remove scripts in Debian packages may do almost anything - 
> and often do.  Any restrictions on what such scripts may do will break large 
> numbers of packages.  Unless we can get changes to Debian policy relating to 
> what such scripts may do (which seems quite unlikely) then we have to allow 
> writing to almost all files in the system.
> 
> > The amount of things done in postinst scripts is one of the things that
> > really scares me from a security point of view. It might be very
> > valuable to use a tight SELinux policy to restrict these scripts,
> > however when it comes down to having a SELinux policy package update it
> > becomes a Catch-22 somewhat.
> > It would definitely help to have separate apt_t and apt_script_t
> > domains, though, to be able to differentiate access for installation
> > scripts and the package manager itself.
> 
> What meaningful restrictions can be applied to one but not the other?
> 
> -- 
> russell@coker.com.au
> http://etbe.coker.com.au/          My Blog
> 
> http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

On Thu, Mar 06, 2008 at 01:13:59PM +0100, Erich Schubert wrote:
> Hello Russel,
> > > It would definitely help to have separate apt_t and apt_script_t
> > > domains, though, to be able to differentiate access for installation
> > > scripts and the package manager itself.
> > What meaningful restrictions can be applied to one but not the other?
> 
> I agree with you that we would currently have to allow pretty much any
> access by apt_script_t, unfortunately. Sorry for mixing up apt and dpkg
> again in that post btw, yes, it sould be dpkg_t and dpkg_script_t,
> obviously.
> No, I can't really think of ways to restrict dpkg_script_t apart from
> not messing with the dpkg_t state files. Maybe we could make some policy
> that /usr is to be modified by dpkg_t only whereas dynamically generated
> files have to reside in /var, but I doubt this would currently hold.
> And after all, dpkg_script_t needs to be able to even add users
> to /etc/passwd (although through the helper applications, not directly).
> 
> best regards,
> Erich Schubert
> -- 
>     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
>  The early bird gets the worm, but the second mouse gets the cheese.  //\
>        Ein Freund ist ein Geschenk, das man sich selbst macht.        V_/_
> 

On Thu, Mar 06, 2008 at 11:46:54PM +1100, Russell Coker wrote:
> On Thursday 06 March 2008 23:13, Erich Schubert <erich@debian.org> wrote:
> > > > It would definitely help to have separate apt_t and apt_script_t
> > > > domains, though, to be able to differentiate access for installation
> > > > scripts and the package manager itself.
> > >
> > > What meaningful restrictions can be applied to one but not the other?
> >
> > I agree with you that we would currently have to allow pretty much any
> > access by apt_script_t, unfortunately. Sorry for mixing up apt and dpkg
> > again in that post btw, yes, it sould be dpkg_t and dpkg_script_t,
> > obviously.
> > No, I can't really think of ways to restrict dpkg_script_t apart from
> > not messing with the dpkg_t state files. Maybe we could make some policy
> 
> But given that dpkg_script_t can make all manner of other changes (including 
> loading a SE Linux policy) it seems rather minor to restrict access to dpkg 
> state files.
> 
> > that /usr is to be modified by dpkg_t only whereas dynamically generated
> > files have to reside in /var, but I doubt this would currently hold.
> 
> It's a standard practice to convert the data files under /var in an upgrade.
> 
> > And after all, dpkg_script_t needs to be able to even add users
> > to /etc/passwd (although through the helper applications, not directly).
> 
> Yes.
> 
> In fact while we have unconfined_t, the benefit of having a separate dpkg_t 
> instead of using unconfined_t for installing packages doesn't seem 
> significant.
> 
> -- 
> russell@coker.com.au
> http://etbe.coker.com.au/          My Blog
> 
> http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


Seems to me dpkg_script_t is not used now really.  Should be removed
dpkg_script_t from the refpolicy?  A part of rules should be moved from
the domain dpkg_script_t to the domain dpkg_t probably if such a removal
will take place.




On Fri, Mar 07, 2008 at 10:23:32PM +0100, Stefan Schulze Frielinghaus wrote:
> 
> On Wed, 2008-03-05 at 16:23 +0100, Václav Ovsík wrote:
> > Hi,
> > running Debian Sid with HEAD refpolicy...
> > I tried to install bind9 and got some further denials for access to pty
> > and pipe of apt_t domain. This is a continuation of the patch from
> > Martin Orr in thread "refpolicy: patch for ldconfig from glibc 2.7...",
> > witch was about apt finally.
> > 
> > ...
> > 
> > Attached patch solves the most of this denials, but I doubt this is the
> > right way.  Should be used some attribute for this?  I noticed attribute
> > privfd and macro domain_interactive_fd(), what about it?  Rpm already
> > has such macro calls
> > ./policy/modules/admin/rpm.te:domain_interactive_fd(rpm_t)
> > ./policy/modules/admin/rpm.te:domain_interactive_fd(rpm_script_t)
> > 
> > I tried to use this macro for apt_t, and all use fd denials above are
> > solved with it. Should be things done in this way?
> > 
> > Thanks for comments.
> 
> I think it is not really nice to have all these allow rules directly in
> the modules. A similar discussion can be found here:
> http://marc.info/?l=selinux&m=118707242005853&w=2
> 
> Especially the first replay of Stephen Smalley pointing out how rpm
> solves this via domain.if: rpm_use_fds($1) and rpm_read_pipes($1)
> 
> If I had to choose between the several fixes for every module or the
> "rpm-way" to allow all usage of file descriptors and read permissions
> then I would vote for the latter.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

On Mon, Mar 10, 2008 at 01:39:49PM -0400, Christopher J. PeBenito wrote:
> On Fri, 2008-03-07 at 22:23 +0100, Stefan Schulze Frielinghaus wrote:
> > On Wed, 2008-03-05 at 16:23 +0100, Václav Ovsík wrote:
> > > Hi,
> > > running Debian Sid with HEAD refpolicy...
> > > I tried to install bind9 and got some further denials for access to pty
> > > and pipe of apt_t domain. This is a continuation of the patch from
> > > Martin Orr in thread "refpolicy: patch for ldconfig from glibc 2.7...",
> > > witch was about apt finally.
> > > 
> > > ...
> > > 
> > > Attached patch solves the most of this denials, but I doubt this is the
> > > right way.  Should be used some attribute for this?  I noticed attribute
> > > privfd and macro domain_interactive_fd(), what about it?  Rpm already
> > > has such macro calls
> > > ./policy/modules/admin/rpm.te:domain_interactive_fd(rpm_t)
> > > ./policy/modules/admin/rpm.te:domain_interactive_fd(rpm_script_t)
> > > 
> > > I tried to use this macro for apt_t, and all use fd denials above are
> > > solved with it. Should be things done in this way?
> > > 
> > > Thanks for comments.
> > 
> > I think it is not really nice to have all these allow rules directly in
> > the modules. A similar discussion can be found here:
> > http://marc.info/?l=selinux&m=118707242005853&w=2
> > 
> > Especially the first replay of Stephen Smalley pointing out how rpm
> > solves this via domain.if: rpm_use_fds($1) and rpm_read_pipes($1)
> > 
> > If I had to choose between the several fixes for every module or the
> > "rpm-way" to allow all usage of file descriptors and read permissions
> > then I would vote for the latter.
> 
> A better option might be to mimic the inheritance of fds and pipes.

I'm not certain I understood this correctly.  I understood `to mimic the
inheritance', that for all domains runnable from dpkg scripts should be
inserted appropriate rules for access explicitly.  If I'm wrong, please
explain it a bit further.  Sorry for my English.

Please, can you look at the attached patch snippet? The interface
identifier needs review.

Finaly I wrote apt_rw_pipes() to be consistent with the assignment/ident
of interface, although in our case (dpkg scripts) the access to apt pipe
should not be allowed. Maybe some regular child can comunicate with apt
through a pipe and can be run from dpkg script equally. Who knows :)
The interface apt_dontaudit_write_pipes() is useless than and may be
discarded.

If things are ok, I will try to search all possible domains runnable
from a dpkg script and will prepare the complete patch.

Thanks
-- 
Zito

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=apt

Index: policy/modules/system/libraries.te
===================================================================
--- policy/modules/system/libraries.te.orig	2008-03-20 12:01:18.000000000 +0100
+++ policy/modules/system/libraries.te	2008-03-20 15:58:45.000000000 +0100
@@ -103,9 +103,7 @@
 ')
 
 optional_policy(`
-	apt_rw_pipes(ldconfig_t)
-	apt_use_fds(ldconfig_t)
-	apt_use_ptys(ldconfig_t)
+	apt_allow_inherited_resrc(ldconfig_t)
 ')
 
 optional_policy(`
Index: policy/modules/admin/apt.if
===================================================================
--- policy/modules/admin/apt.if.orig	2008-03-20 12:00:47.000000000 +0100
+++ policy/modules/admin/apt.if	2008-03-20 15:57:47.000000000 +0100
@@ -92,6 +92,24 @@
 
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
@@ -190,3 +208,19 @@
 	dontaudit $1 apt_var_lib_t:file manage_file_perms;
 	dontaudit $1 apt_var_lib_t:lnk_file manage_lnk_perms;
 ')
+
+########################################
+## <summary>
+##	Allow use, read & write to inherited apts fds, pty & pipes.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apt_allow_inherited_resrc',`
+	apt_rw_pipes($1)
+	apt_use_fds($1)
+	apt_use_ptys($1)
+')

--SLDf9lqlvOQaIe6s--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
