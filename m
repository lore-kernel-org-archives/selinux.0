Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JHUlm7008123
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 13:30:47 -0400
Received: by mail-lf0-f47.google.com with SMTP id u5-v6so679375lff.13
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 10:30:43 -0700 (PDT)
Date: Tue, 19 Jun 2018 12:30:39 -0500
From: Jalus Bilieyich <countolaf17@gmail.com>
To: Mike Hughes <mike@visionary.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-Id: <20180619123039.7d93a4eeaeadc8ea8ab02058@gmail.com>
In-Reply-To: <DM6PR19MB22817204E97BC6C6F1F71870D1710@DM6PR19MB2281.namprd19.prod.outlook.com>
References: <DM6PR19MB22817204E97BC6C6F1F71870D1710@DM6PR19MB2281.namprd19.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: 'setsebool -P' works but throws errors;
 changes not permanent
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 18 Jun 2018 19:44:10 +0000
Mike Hughes <mike@visionary.com> wrote:

> We use Yubikey for two-factor ssh authentication which requires enabling a Boolean called "authlogin_yubikey". It has been working fine until a few weeks ago. Errors appear when attempting to set the policy:
> 
> --
> [Cent-7:root@my_server home]# getsebool authlogin_yubikey
> authlogin_yubikey --> off
> 
> [Cent-7:root@my_server home]# setsebool -P authlogin_yubikey on
> libsepol.context_from_record: type gpio_device_t is not defined
> libsepol.context_from_record: could not create context structure
> libsepol.context_from_string: could not create context structure
> libsepol.sepol_context_to_sid: could not convert system_u:object_r:gpio_device_t:s0 to sid
> invalid context system_u:object_r:gpio_device_t:s0
> 
> [Cent-7:root@my_server home]# getsebool authlogin_yubikey
> authlogin_yubikey --> on
> ---
> 
> The system accepts two-factor while the above is set to "on". After some undetermined time (or immediately after a reboot) the Boolean toggles off. This can be confirmed since semanage shows that the default is still set to "off":
> 
> --
> [Cent-7:root@my_server ~]# semanage boolean -l | grep "authlogin_yubikey"
> SELinux boolean                State  Default Description
> ...
> authlogin_yubikey              (on   ,  off)  Allow authlogin to yubikey
> --
> 
> It looks similar to the following bug on Fedora:
> https://bugzilla.redhat.com/show_bug.cgi?id=1559174


-- 
Jalus Bilieyich <countolaf17@gmail.com>
