Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6B94VrT026911
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 05:04:31 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6B94RSC017299
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 09:04:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: policy to allow upgrade of nfs-utils
Date: Sun, 11 Jul 2004 19:04:24 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200407081319.05138.russell@coker.com.au> <200407092252.08749.russell@coker.com.au> <1089392030.11726.66.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1089392030.11726.66.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YKQ8ALs1orNti8d"
Message-Id: <200407111904.24856.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_YKQ8ALs1orNti8d
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 10 Jul 2004 02:53, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Fri, 2004-07-09 at 08:52, Russell Coker wrote:
> > On Thu, 8 Jul 2004 23:14, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > > On Wed, 2004-07-07 at 23:19, Russell Coker wrote:
> > > > The attached policy patch is needed to allow nfs-utils to be upgraded
> > > > to the latest version on a rawhide system.
> > >
> > > Should /etc/exports get its own type?
> >
> > I guess so.  nfsd_etc_t or exports_t?
>
> Doesn't matter to me, but it could be problematic to preserve the type
> on the file, given that it is directly edited.

A patched version of vi should solve that.  In any case if the file gets etc_t 
then it is just readable to everyone which isn't so bad.  The only potential 
problem is if you edit the file with an unpatched editor and delete all 
content so that initrc_t will want to append "#" to it.

What do you think of the attached patch?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_YKQ8ALs1orNti8d
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/domains/program/unused/rpcd.te ./domains/program/unused/rpcd.te
--- /usr/src/se/policy/domains/program/unused/rpcd.te	2004-07-11 17:37:11.000000000 +1000
+++ ./domains/program/unused/rpcd.te	2004-07-11 17:04:51.000000000 +1000
@@ -23,6 +23,8 @@
 allow $1_t var_lib_nfs_t:file create_file_perms;
 ')
 
+type exports_t, file_type, sysadmfile;
+
 # rpcd_t is the domain of rpc daemons.
 # rpcd_exec_t is the type of rpc daemon programs.
 #
@@ -51,6 +53,8 @@
 
 ifdef(`rpm.te', `
 allow rpcd_t self:capability { chown dac_override setgid setuid };
+# for /etc/rc.d/init.d/nfs to create /etc/exports
+allow initrc_t exports_t:file rw_file_perms;
 ')
 
 allow rpcd_t self:file { getattr read };
diff -ru /usr/src/se/policy/file_contexts/program/rpcd.fc ./file_contexts/program/rpcd.fc
--- /usr/src/se/policy/file_contexts/program/rpcd.fc	2004-01-24 12:15:53.000000000 +1100
+++ ./file_contexts/program/rpcd.fc	2004-07-11 17:05:33.000000000 +1000
@@ -6,3 +6,4 @@
 /usr/sbin/rpc\.mountd	--	system_u:object_r:nfsd_exec_t
 /var/run/rpc.statd.pid	--	system_u:object_r:rpcd_var_run_t
 /var/run/rpc.statd(/.*)?	system_u:object_r:rpcd_var_run_t
+/etc/exports		--	system_u:object_r:exports_t

--Boundary-00=_YKQ8ALs1orNti8d--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
