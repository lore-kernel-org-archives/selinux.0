Subject: Re: Task SID 's
From: Stephen Smalley <sds@tycho.nsa.gov>
To: I_am alone <stupid_kid_me@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20061121043021.34260.qmail@web58112.mail.re3.yahoo.com>
References: <20061121043021.34260.qmail@web58112.mail.re3.yahoo.com>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 09:00:50 -0500
Message-Id: <1164117650.13758.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-20 at 20:30 -0800, I_am alone wrote:
> 
> Hi 
> 
>   I am new to SELinux. I am planning to learn it by doing a Code
> Review. Currently I am Confused of Task SID Assignments & Binary
> Program SID to Task SID Converstions.

Have you looked at the Implementing SELinux as a Linux Security Module
technical report?  Not entirely up to date, but still a useful resource:
http://www.nsa.gov/selinux/papers/module-abs.cfm
http://www.nsa.gov/selinux/papers/module/t1.html

Document sources included in the selinux-doc tarball,
http://www.nsa.gov/selinux/archives/selinux-doc-1.26.tgz

> 1. How does SID's are assigned to the init Task in the SELinux Code .
> Which code part handles that .

selinux_init() in security/selinux/hooks.c.
Described in:
http://www.nsa.gov/selinux/papers/module/x300.html

> 2. I found that binary program SID's assigned changes in to the Task
> SID's when they are loaded. Which code part in SELinux handles this
> part.
> 
> That is when a Binary Program is loaded it is assigned SID's and once
> it is loaded it becomes as task. How does the bprm_security_structure
> SID values are transfered in to the  task_security_structure_sid
> Values ...

selinux_bprm_set_security() and selinux_bprm_apply_creds().
Described in:
http://www.nsa.gov/selinux/papers/module/x643.html

> If anyone can guide me on these it would be really helpful for me to
> learn.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
