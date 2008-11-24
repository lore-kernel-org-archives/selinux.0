Subject: Re: Problem Setting Policy To Enforcing Mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: erahul29@yahoo.com
Cc: selinux@tycho.nsa.gov, justinmattock@gmail.com, dwalsh@redhat.com
In-Reply-To: <674101.15460.qm@web50212.mail.re2.yahoo.com>
References: <674101.15460.qm@web50212.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 24 Nov 2008 08:47:56 -0500
Message-Id: <1227534476.28401.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-11-22 at 03:09 -0800, Rahul Jain wrote:
> Thankyou all for your kind help.
>  
> Finally I was able to boot my policy. As suggested, I removed
> dontaudit rules from my policy by doing "make enableaudit". Then I did
> some quick fixes and was finally able to boot the policy. However I am
> still facing some issues:
> Firstly - My syslog daemon takes too long to start almost 10 min.
> Please note my test systems are high end multiprocessor express
> servers with 8 GB of RAM.
> Secondly: I am not able to come back to permissive mode, not even
> by login as sysadm_r role. My file system is read only and so I am not
> able to edit the /etc/selinux/config file. "setenforce" command
> temperoraly puts the policy in permissive mode but still config file
> could not be edited. I even tried it in linux single user mode,
> but the problem persists. Is it the property of the tresys reference
> policy or my policy is still not behaving properly?
> I reallly appreciate your kind help
>  
> Thanks 
> Rahul    
> 

Boot with enforcing=0 on the kernel command line, resolve any denials by
fixing your filesystem labeling and/or your policy configuration, then
reboot.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
