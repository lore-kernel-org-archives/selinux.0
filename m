Subject: Re: problems updating /etc/shadow using strict example policy on
	Fedora Core 3
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kim Lawson-Jenkins <lawson@itd.nrl.navy.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <002501c86426$538c0800$c301000a@PC05>
References: <002501c86426$538c0800$c301000a@PC05>
Content-Type: text/plain; charset=utf-8
Date: Thu, 31 Jan 2008 12:36:48 -0500
Message-Id: <1201801008.4568.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-31 at 11:28 -0500, Kim Lawson-Jenkins wrote:
> Hi:
> 
>  
> 
> I’m updating a legacy system where due to the SELinux policy a user
> was not permitted to replace an expired password.  I gradually added
> allow statements to eliminate the AVC messages.
> 
>  
> 
> The final SELinux change which corrupts the shadow file is
> 
>  
> 
> allow system_chkpwd_t shadow_t:file { create setattr rename write
> unlink };
> 
>  
> 
> or more specifically including the write permission in the allow
> statement corrupts the shadow file.  If the write permission is not
> included, an AVC is generated indicating we need to add the write
> permission.  But when the write permission is included the shadow file
> is corrupted – the shadow file is updated without a hash of the new
> password and the user is allowed to log in without a password.  So I'm
> wondering is there a SELinux patch I need for chkpwd?  Or do I need to
> add/modify an allow statement for a process other than chkpwd to have
> the shadow file updated correctly?
> 
>  
> 
> Here is the AVC message – 
> 
>  
> 
> Jan 10 19:00:24 nrl-xml-nkm kernel: audit(1200009624.533:0): avc:
> denied  { write } for  pid=16563 exe=/sbin/unix_chkpwd
> path=/etc/nshadow dev=dm-0 ino=5275736
> scontext=system_u:system_r:system_chkpwd_t
> tcontext=system_u:object_r:shadow_t tclass=file
> 
>  
> 
> This is a SELinux problem because when the system is in permissive
> instead of enforcing mode, the user can replace the expired password
> and the shadow file is updated correctly.
> 
>  
> 
> I know most people ignored this email as soon as they saw the words
> “Fedora Core 3” in the subject heading.  Any feedback would be greatly
> appreciated.  Thanks in advance.

Have you tried performing the operation with all dontaudit rules removed
from the policy, i.e. 'make clean enableaudit load' in the policy source
directory?  That will generate a lot of avc messages, not all relevant,
but should show you all denials.  Then use 'make clean load' to restore
them afterward.

As far as I know, the policy only allows chkpwd to read the shadow file,
as that is its usual function - checking passwords, not updating them.
I didn't think the updating happened from that process.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
