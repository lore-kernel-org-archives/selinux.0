To: Mike Hughes <mike@visionary.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <DM6PR19MB22817204E97BC6C6F1F71870D1710@DM6PR19MB2281.namprd19.prod.outlook.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <91831205-cf9f-e8df-7019-aa1fffe54051@tycho.nsa.gov>
Date: Mon, 18 Jun 2018 16:27:55 -0400
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB22817204E97BC6C6F1F71870D1710@DM6PR19MB2281.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: 'setsebool -P' works but throws errors; changes not permanent
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/18/2018 03:44 PM, Mike Hughes wrote:
> We use Yubikey for two-factor ssh authentication which requires enabling a Boolean called “authlogin_yubikey”. It has been working fine until a few weeks ago. Errors appear when attempting to set the policy:
> 
>  
> 
> --
> 
> [Cent-7:root@my_server home]# getsebool authlogin_yubikey
> 
> authlogin_yubikey --> off
> 
>  
> 
> [Cent-7:root@my_server home]# setsebool -P authlogin_yubikey on
> 
> libsepol.context_from_record: type gpio_device_t is not defined
> 
> libsepol.context_from_record: could not create context structure
> 
> libsepol.context_from_string: could not create context structure
> 
> libsepol.sepol_context_to_sid: could not convert system_u:object_r:gpio_device_t:s0 to sid
> 
> invalid context system_u:object_r:gpio_device_t:s0

Sounds like your policy is in an inconsistent internal state (somewhere you have a context with gpio_device_t but the type isn't defined in the policy).

What's your policy version?  And did it perhaps fail during %post when it was updated - check yum.log?

Does semodule -B fail?

Might have to move aside your policy and reinstall it.

> 
>  
> 
> [Cent-7:root@my_server home]# getsebool authlogin_yubikey
> 
> authlogin_yubikey --> on
> 
> ---
> 
>  
> 
> The system accepts two-factor while the above is set to “on”. After some undetermined time (or immediately after a reboot) the Boolean toggles off. This can be confirmed since semanage shows that the default is still set to “off”:
> 
>  
> 
> --
> 
> [Cent-7:root@my_server ~]# semanage boolean -l | grep "authlogin_yubikey"
> 
> SELinux boolean                State  Default Description
> 
> ...
> 
> authlogin_yubikey              (on   ,  off)  Allow authlogin to yubikey
> 
> --
> 
>  
> 
> It looks similar to the following bug on Fedora:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1559174
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
