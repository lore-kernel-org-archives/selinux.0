Subject: Re: setroubleshoot var types
From: Stephen Smalley <sds@tycho.nsa.gov>
To: warner@rubix.com
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <48137.78.3.234.122.1225884520.squirrel@www.rubix.com>
References: <48137.78.3.234.122.1225884520.squirrel@www.rubix.com>
Content-Type: text/plain
Date: Wed, 05 Nov 2008 08:40:47 -0500
Message-Id: <1225892447.19111.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-11-05 at 03:28 -0800, warner@rubix.com wrote:
> I am running Fedora 9 with the mls policy and was investigating why my
> setroubleshoot was not working. I found the following in
> /var/log/messages:
> 
> Nov  3 09:27:39 localhost kernel: SELinux: inode_doinit_with_dentry: 
> context_to_sid(system_u:object_r:setroubleshoot_var_lib_t:s0) returned 22
> for dev=dm-2 ino=23923693
> Nov  3 09:27:40 localhost kernel: SELinux: inode_doinit_with_dentry: 
> context_to_sid(system_u:object_r:setroubleshoot_var_log_t:s0) returned 22
> for dev=dm-2 ino=23923743
> Nov  3 09:27:40 localhost kernel: SELinux: inode_doinit_with_dentry: 
> context_to_sid(system_u:object_r:setroubleshoot_var_run_t:s0) returned 22
> for dev=dm-2 ino=23923744
> ...
> Nov  3 18:22:55 localhost setroubleshoot: [program.ERROR] setroubleshoot
> generated AVC, exiting to avoid recursion,
> context=system_u:system_r:initrc_t:SystemLow:SystemLow-SystemHigh, AVC
> scontext=system_u:system_r:initrc_t:s0-s15:c0.c1023
> 
> 
> Upon using the Policy Analysis tool I found that none of the
> setroubleshoot_var_*_t types were associated with the object_r role. Is
> this an issue with the setroubleshoot policy?

object_r is implicitly allowed to be associated with all types.

The issue here is not the role:type relation but rather that the types
aren't defined in the mls policy.  The shipped mls policy tends to only
support a subset of the distribution, and I doubt setroubleshoot was
included in the target of evaluation.  You can of course build a more
complete mls policy if you wish.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
