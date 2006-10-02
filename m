Subject: Re: [PATCH] refpolicy: Add GConf policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1159295299.18973.74.camel@moss-lions.epoch.ncsc.mil>
References: <1159295299.18973.74.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 11:22:31 -0400
Message-Id: <1159802551.14831.32.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-26 at 14:28 -0400, James Carter wrote:
> This patch adds a GConf policy to refpolicy.  
> 
> This policy is much tighter than the GConf policy from the old example
> policy.  It only allows gconfd to access configuration data stored by
> GConf.  Users can modify configuration data using gconftool-2 or
> gconf-editor, both of which use gconfd.  GConf manages multiple
> configuration sources, so gconfd should be used to make any changes
> anyway.  Normal users who aren't trying to directly edit the
> configuration data of GConf won't notice anything different.
> 
> There is also a difference between this policy and the old example
> policy in handling directories in /tmp.  The old example policy
> labeled /tmp/gconfd-USER with ROLE_gconfd_tmp_t, but, since there was no
> use of the file_type_auto_trans macro, if that directory was deleted
> gconfd would create one labeled as tmp_t.  This policy uses the
> files_tmp-filetrans macro to cause a directory in /tmp created by gconfd
> to be labeled as $1_tmp_t.  It is not labeled with $1_gconf_tmp_t,
> because if /tmp/orbit-USER is deleted, gconfd will create it (through
> use of ORBit) and it would get the $1_gconf_tmp_t label.  By having
> gconfd create $1_tmp_t directories in /tmp and $1_gconf_tmp_t files and
> directories in directories labeled with $1_tmp_t, it can control its
> data without requiring any future bonobo or Gnome policies to have
> access to $1_gconf_tmp_t.
> 
> This patch is related to work that I am doing in making gconfd an
> userspace object manager.  If any user program can modify the
> configuration data that GConf stores, than making gconfd an userspace
> object manager would be useless.

Merged as the gnome module, with some reordering.  Also converted
$1_tmp_t lines to interfaces.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
