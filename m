Subject: Re: Recent /proc/pid/mem exploit
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Quigley <selinux@davequigley.com>
Cc: selinux@lists.fedoraproject.org, selinux@tycho.nsa.gov
In-Reply-To: <a2c83875882386021eb7ccd57df283ee@countercultured.net>
References: <a2c83875882386021eb7ccd57df283ee@countercultured.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Jan 2012 08:07:20 -0500
Message-ID: <1327496840.9607.8.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-01-24 at 11:22 -0500, David Quigley wrote:
> So I read through the recent privilege escalation vulnerability using 
> su and gpasswd which exploits weak permission checks in /proc/pid/mem 
> and tried to figure out why we didn't stop it. What it comes down to is 
> that /proc/pid and everything under it is given the same type as the 
> process itself. In the case of the gpasswd that type is groupadd_t. 
> Looking at the kernel code for /proc/pid/mem and its read/write 
> functions it seems that the only permission checking we do on that node 
> is done by the vfs. So from the SELinux perspective you would need allow 
> groupadd_t groupadd_t file:{open read write} to have access to 
> /proc/pid/mem. For some odd reason tons and tons of applications have 
> file:{open read and write} on itself.
> 
> One question that should be asked is why is is that we have so many 
> rules that contain sometype_t sometype_t file: {open read write}. Is it 
> necessary or something that is just being pulled in from a macro. If 
> this is necessary for other reasons the followup to this would be should 
> /proc/pid/mem have the same type as the process or should we have some 
> additional requirements permission wise for a process to read and write 
> to its own memory through /proc/pid/mem. What are the valid reasons for 
> a process to be poking around through its memory using /proc/pid/mem?

The /proc/pid files are labeled with the same security context as the
associated task via security_task_to_inode() -> selinux_task_to_inode().
There is presently no support for distinguishing /proc/pid files in
policy, unlike other files in /proc.  As processes are expected to be
able to write to various files under /proc/self, this is allowed by
policy.

Implementing support for labeling different /proc/pid inodes differently
might be an interesting project.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
