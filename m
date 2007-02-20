Subject: Re: Compile error with the SVN version of the refpolicy.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0702162219o45a8ccc9v5e5092c9e310c4bb@mail.gmail.com>
References: <e739902b0702162219o45a8ccc9v5e5092c9e310c4bb@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 09:24:46 -0500
Message-Id: <1171981486.14363.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-02-16 at 22:19 -0800, Ryan Bradetich wrote:
> Hello all,
> 
> I am having a compile problem with the latest SVN check out of the
> refpolicy.  Here is the error message:
> 
> /usr/bin/checkpolicy policy.conf -o
> /etc/selinux/refpolicy/policy/policy.21
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> policy/modules/services/zebra.te:1136:ERROR 'syntax error' at token
> 'ntfs-3g' on line 1523915:
> genfscon msdos / system_u:object_r:dosfs_t
> genfscon ntfs-3g / system_u:object_r:dosfs_t
> checkpolicy:  error(s) encountered while parsing configuration
> make: *** [/etc/selinux/refpolicy/policy/policy.21] Error 1
> 
> 
> The problem is that checkpolicy does not appear to like the '-'
> character.  I changed the '-' to a '_' in the
> policy/modules/kernel/filesystem.te file to fix the compile problem.
> 
> 
> If this change is correct, I have provided a patch to someone can apply.

No, the filesystem type string must match what the kernel module defines
it to be, and in this case, it truly is "ntfs-3g".  You need a newer
checkpolicy (1.33.1 or later).  When building refpolicy from the tresys
svn, use the latest checkpolicy from the sourceforge svn.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
