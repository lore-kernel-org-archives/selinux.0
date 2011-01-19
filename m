Subject: Re: SELinux role separation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Qwyjibo Jones <qwyjibojones@gmail.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <AANLkTimSCuwayFiMTr5=M7E=_eAbYmAOuq4o6ZnUDGsW@mail.gmail.com>
References: <AANLkTimSCuwayFiMTr5=M7E=_eAbYmAOuq4o6ZnUDGsW@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Jan 2011 14:29:50 -0500
Message-ID: <1295465390.11317.7.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-01-18 at 13:03 -0500, Qwyjibo Jones wrote:
> 
> I am currently working with an Itanium2 system which has RHEL 5.3 MLS
> installed.
> I am trying to understand how separation of roles works in SELinux/MLS
> policy version 21. We have been told that we need to separate roles
> that the sys admin is no longer allowed to do.
> 
> After reading through these threads, in the archives I am still
> wondering about a couple things:
> 
> http://www.nsa.gov/research/selinux/list-archive/0504/thread_body66.shtml#11082
> 
> And this one: 
> http://www.nsa.gov/research/selinux/list-archive/0802/thread_body60.shtml
> 
> 1) Is the RHEL 5.x MLS policy version 21 capable of the following
> separation of sysadm_r and secadm_r roles:
> 
>    a) Can the secadm_r role be the only role that can assign roles via
> semanage? 
> 
>    b) Can the secadm_r role be the only role that can assign/modify
> network interface labels via semanage?
> 
>    c) Can the secadm_r role be the only role that can control files
> used in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd
> etc...
> 
> 2) Is this better accomplished with a combination of SUDO and SELinux?
> 3) How can I determine what secadm_r can do in the current
> configuration? can any of the CLI tools show me that? ( no gui tools
> available )

What you describe should be possible using the MLS policy, although I
can't speak to the specifics of the RHEL5 policy.  If you have or can
install setools, then you should be able to query the policy via
sesearch to discover what is allowed without needing any GUI.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
