From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [Fwd: Latest Diff]
Date: Fri, 6 May 2005 15:33:06 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <427A757F.9040009@redhat.com>
In-Reply-To: <427A757F.9040009@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505061533.10266.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 06 May 2005 05:35, Daniel J Walsh <dwalsh@redhat.com> wrote:
> +allow cupsd_t crond_t:fd use;

Something is wrong here.  crond_t has attribute privfd, and from 
daemon_base_domain() cupsd_t gets the following:
allow cupsd_t privfd:fd use;

-daemon_domain(hald, `, fs_domain, nscd_client_domain')
+daemon_domain(hald, `, fs_domain, nscd_client_domain, privmem')

-allow hald_t self:capability { net_admin sys_admin dac_override 
dac_read_search mknod };
+allow hald_t self:capability { net_admin sys_admin dac_override 
dac_read_search mknod sys_rawio };

+allow hald_t memory_device_t:chr_file r_file_perms;

The dmidecode_t domain removes the need for those changes.

+can_unix_connect(i18n_input_t, initrc_t)

What's happening here?  Looks like a daemon running in the wrong domain.

+allow kudzu_t proc_t:lnk_file getattr;

We already have the following:
allow kudzu_t { self proc_t }:lnk_file read;

We should probably change it to:
allow kudzu_t { self proc_t }:lnk_file { getattr read };

-dontaudit lvm_t var_run_t:dir getattr;
+var_run_domain(lvm)

What is this for?  CLVM?

-allow udev_t tmpfs_t:dir rw_dir_perms;
-allow udev_t tmpfs_t:sock_file create_file_perms;
+allow udev_t tmpfs_t:dir create_dir_perms;
+allow udev_t tmpfs_t:{ sock_file file } create_file_perms;

In what situations is this required?  When udev is working correctly it will 
never try to create files or directories of type tmpfs_t.

+/etc/rhgb(/.*)?                -d              system_u:object_r:mnt_t

Why move this from rhgb.fc to distros.fc?  Surely it's more of a RHGB specific 
thing than a distribution specific thing.  Not that there are any other 
distributions using RHGB at the moment.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
