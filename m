Date: Thu, 22 Nov 2007 14:43:36 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: SELinux@tycho.nsa.gov
Subject: reference policy: init_system_domain(setfiles_t,setfiles_exec_t) duplicity
Message-ID: <20071122134336.GA1052@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
macro call seems to be duplicit for Redhat. It is already two lines
above...
-- 
Zito

--zYM0uCDKw75PZbzx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="selinuxutil.duplicity.patch"

--- policy/modules/system/selinuxutil.te.orig	2007-11-19 15:58:33.000000000 +0100
+++ policy/modules/system/selinuxutil.te	2007-11-22 14:34:04.000000000 +0100
@@ -109,10 +109,6 @@
 init_system_domain(setfiles_t,setfiles_exec_t)
 domain_obj_id_change_exemption(setfiles_t)
 
-ifdef(`distro_redhat',`
-	init_system_domain(setfiles_t,setfiles_exec_t)
-')
-
 ########################################
 #
 # Checkpolicy local policy

--zYM0uCDKw75PZbzx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
