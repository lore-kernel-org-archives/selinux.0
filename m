Subject: Re: [PATCH] refpolicy: Add GConf policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1159295299.18973.74.camel@moss-lions.epoch.ncsc.mil>
References: <1159295299.18973.74.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 10:52:48 -0400
Message-Id: <1159455168.2850.19.camel@sgc.columbia.tresys.com>
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

So to make a gconf object manager more useful, it seems like we would
want more confined desktop apps.  Do you think more core pieces of gnome
will be confined, such as gnome vfs and bonobo?  The group of gnome
modules in the example policy didn't seem to gain anything and also
seemed overengineered.  Do you anticipate a need to bring back some of
this?  If so, I think it would be better to have this as a start of a
gnome refpolicy module, which would have all the core pieces of gnome
policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
