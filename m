Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0LMXc0u032023
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 17:33:38 -0500
Received: by mail-ee0-f44.google.com with SMTP id l10so3214046eei.31
        for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 14:33:35 -0800 (PST)
Message-ID: <1358807160.2986.7.camel@d30>
Subject: Re: ERROR 'type staff_java_t is not within scope' at token
From: Dominick Grift <dominick.grift@gmail.com>
To: Hung Truong <hung.truong@tridsys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Mon, 21 Jan 2013 23:26:00 +0100
In-Reply-To: <bf19e346e82ccd053990b576f4058a61@mail.gmail.com>
References: 
	3086262d0228a121663cb87f5d77a07a@mail.gmail.com <bf19e346e82ccd053990b576f4058a61@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2013-01-21 at 13:40 -0500, Hung Truong wrote:
> I have this rule in my policy:
> 
> 
> 
> gen_require(`
> 
>                 type staff_java_t;
> 
>                 type cdvoip_sysadmcat_pki_cdvaserver_pem_t;
> 
> ')
> 
> allow staff_java_t cdvoip_sysadmcat_pki_cdvaserver_pem_t: file { read open
> };
> 
> 
> 
> 
> 
> and get error 'type staff_java_t is not within scope'  when compile it.
> 
> 
> 
> 
> 
> policy/modules/cdvoip/cdvoip_sysadmcat.te":306:ERROR 'type staff_java_t is
> not within scope' at token ';' on line 1684769:
> 
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> 
> allow staff_java_t cdvoip_sysadmcat_pki_cdvaserver_pem_t: file { read open
> };
> 
> 
> 
> checkpolicy:  error(s) encountered while parsing configuration
> 
> make: ***
> [/home/cdvadmin/workspace/cdvoip/rpms/BUILDROOT/selinux-policy-3.7.19-155el6.4.x86_64/etc/selinux/targeted/policy/policy.24]
> Error 1
> 
> 
> 
> 
> 
> Does anyone know why I get this error and how to fix it?  BTW, if it does
> matter, I modified the *.spec file to build a monolithic and strict policy.
> 

I think this policy needs to be nested properly

Its a dependency thing

so for example:

optional_policy(`
  java_per_role_template(staff, staff_r, staff_t)

  optional_policy(`
    allow staff_java_t cdvoip_sysadmcat_pki_cdvaserver_pem_t: file
read_file_perms;
  ')
')

This is just a quick example, it is missing requires and it might have
errors.

The point is that this is about dependencies and proper nesting. This
can get very complicated depending on the complexity of the policy.

The issue is that the type you are using (staff_java_t) depends on the
java_per_role_template so it needs to be nested in that call else it is
out of scope.

Welcome to the wonderful world of optional policy and role prefixed
domains

> 
> Many thanks,
> 
> Hung Truong
> I have this rule in my policy:
> 
>  
> 
> gen_require(`
> 
>                 type staff_java_t;
> 
>                 type cdvoip_sysadmcat_pki_cdvaserver_pem_t;
> 
> ')
> 
> allow staff_java_t cdvoip_sysadmcat_pki_cdvaserver_pem_t: file { read
> open };
> 
>  
> 
>  
> 
> and get error 'type staff_java_t is not within scope'  when compile
> it.
> 
>  
> 
>  
> 
> policy/modules/cdvoip/cdvoip_sysadmcat.te":306:ERROR 'type
> staff_java_t is not within scope' at token ';' on line 1684769:
> 
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> 
> allow staff_java_t cdvoip_sysadmcat_pki_cdvaserver_pem_t: file { read
> open };
> 
>  
> 
> checkpolicy:  error(s) encountered while parsing configuration
> 
> make: ***
> [/home/cdvadmin/workspace/cdvoip/rpms/BUILDROOT/selinux-policy-3.7.19-155el6.4.x86_64/etc/selinux/targeted/policy/policy.24] Error 1
> 
>  
> 
>  
> 
> Does anyone know why I get this error and how to fix it?  BTW, if it
> does matter, I modified the *.spec file to build a monolithic and
> strict policy.
> 
>  
> 
> Many thanks,
> 
> Hung Truong
> 
>  
> 
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
