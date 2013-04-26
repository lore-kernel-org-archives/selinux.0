Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3QEsT0u030255
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2013 10:54:30 -0400
References: <1366925707.22597.YahooMailNeo@web163405.mail.gq1.yahoo.com> <517A6B7D.7020202@tresys.com>
Message-ID: <1366988065.21943.YahooMailNeo@web163406.mail.gq1.yahoo.com>
Date: Fri, 26 Apr 2013 07:54:25 -0700 (PDT)
From: Andy Ruch <adruch2002@yahoo.com>
Reply-To: Andy Ruch <adruch2002@yahoo.com>
Subject: Re: SELinux errors with pam_faillock
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <517A6B7D.7020202@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



>________________________________
> From: Christopher J. PeBenito <cpebenito@tresys.com>
>To: Andy Ruch <adruch2002@yahoo.com> 
>Cc: SELinux ML <selinux@tycho.nsa.gov> 
>Sent: Friday, April 26, 2013 5:56 AM
>Subject: Re: SELinux errors with pam_faillock
> 
>
>On 04/25/13 17:35, Andy Ruch wrote:
>> I'm receiving some SELinux errors related to the pam_faillock module. I'm running RHEL 6.3 with a custom policy based on the reference policy.
>> 
>> When a user enters an incorrect password, the pam faillock module will track it with a file in /var/run/faillock/<user>. This is being applied whenever the user enters their password (i.e. console login, newrole, sudo). Everything works appropriately for the console login. For newrole and sudo, I'm getting errors when the /var/run/faillock/<user> file is trying to be created. Basically, newrole_t and <role>_sudo_t don't have permission to create files in a faillog_t dir.
>> 
>> I found a rule in 'selinuxutil.te' allowing newrole_t to read/write to faillog: "auth_rw_faillog(newrole_t)". However, this rule only allows writing if the file already exists. It doesn't address if the faillock file needs to be created.
>
>faillog_t was really only oriented towards /var/log/faillog only.  It might make more sense to label it auth_cache_t, though it looks like you'll need to add perms to newrole.


This was how it was defined in the reference policy, but it seems to make sense to change it.

>
>> I'm able to address the issues with the following rules:
>> 
>> # Note that these rules would be applied in the sudo interface to support all sudo types
>> create_files_pattern( sysadm_sudo_t, faillog_t, faillog_t )
>> setattr_files_pattern( sysadm_sudo_t, faillog_t, faillog_t )
>> allow sysadm_sudo_t_t self:capability:chown;
>> 
>> create_files_pattern( newrole_t, faillog_t, faillog_t )
>> setattr_files_pattern( newrole_t, faillog_t, faillog_t )
>> allow newrole_t self:capability:chown;
>> 
>> Is this the correct solution? Or should a transition be happening when faillock executes?
>
>Is there an exec() to transition on?  Pam modules are shared libraries that are dlopened into the process, so there's typically no exec().

I'm sure you're right. I'm somewhat new to SELinux so I wasn't sure if there was something else I was missing. Primarily, I wasn't sure if it was appropriate to grant create/write permissions for these faillock files to the sudo type for a role. 


>
>-- 
>Chris PeBenito
>Tresys Technology, LLC
>www.tresys.com | oss.tresys.com
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
