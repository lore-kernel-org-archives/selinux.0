Date: Thu, 22 Nov 2007 16:32:01 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: SELinux@tycho.nsa.gov
Subject: refpolicy HEAD, Debian, restorecon from udev startup script
Message-ID: <20071122153201.GA6768@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I'm trying refpolicy r2530, policycoreutils 2.0.27 on Debian Etch.

There is restorecon called in /etc/init.d/udev script during startup
to relabel /dev tmpfs filesystem. /dev/console has context
system_u:object_r:tmpfs_t at this time, so the following message appears:

audit(1195734177.391:3): avc:  denied  { read write } for  pid=778 comm="restorecon" name="console" dev=tmpfs ino=702 scontext=system_u:system_r:setfiles_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=chr_file

With attached patch message disappears.
Can be this merged into HEAD? (Maybe only for Redhat & Debian)

Are next two macros for Redhat needed?

        fs_relabel_tmpfs_blk_file(setfiles_t)
	fs_relabel_tmpfs_chr_file(setfiles_t)

Doesn't this covered by dev_relabel_all_dev_nodes(setfiles_t) already?
-- 
Zito

--vkogqOf2sHV7VnPd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="setfiles.patch"

Index: policy/modules/system/selinuxutil.te
===================================================================
--- policy/modules/system/selinuxutil.te	(revision 2530)
+++ policy/modules/system/selinuxutil.te	(working copy)
@@ -563,9 +563,10 @@
 # for config files in a home directory
 userdom_read_all_users_home_content_files(setfiles_t)
 
+fs_rw_tmpfs_chr_files(setfiles_t)
+fs_rw_tmpfs_blk_files(setfiles_t)
+
 ifdef(`distro_redhat', `
-	fs_rw_tmpfs_chr_files(setfiles_t)
-	fs_rw_tmpfs_blk_files(setfiles_t)
 	fs_relabel_tmpfs_blk_file(setfiles_t)
 	fs_relabel_tmpfs_chr_file(setfiles_t)
 ')

--vkogqOf2sHV7VnPd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
