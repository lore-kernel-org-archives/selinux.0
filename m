Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5IKXupn017522
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 16:33:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID01.oob.disa.mil (Postfix) with SMTP id 418jVV3DJrz3tZYB
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 20:33:54 +0000 (UTC)
Received: from USFB19PA08.eemsg.mil (unknown [192.168.16.5])
 by USFBF3ID01.oob.disa.mil (Postfix) with ESMTP id 418jVT5WjMz3tZXj
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 20:33:53 +0000 (UTC)
From: Mike Hughes <mike@visionary.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Mon, 18 Jun 2018 20:33:49 +0000
Message-ID: <DM6PR19MB22810EC44C58F740003AB7EAD1710@DM6PR19MB2281.namprd19.prod.outlook.com>
References: <DM6PR19MB22817204E97BC6C6F1F71870D1710@DM6PR19MB2281.namprd19.prod.outlook.com>
 <91831205-cf9f-e8df-7019-aa1fffe54051@tycho.nsa.gov>
In-Reply-To: <91831205-cf9f-e8df-7019-aa1fffe54051@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: RE: 'setsebool -P' works but throws errors;
 changes not permanent
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> -----Original Message-----
> From: Stephen Smalley <sds@tycho.nsa.gov>
> Sent: Monday, June 18, 2018 15:28
> To: Mike Hughes <mike@visionary.com>; selinux@tycho.nsa.gov
> Subject: Re: 'setsebool -P' works but throws errors; changes not permanent
> 
> On 06/18/2018 03:44 PM, Mike Hughes wrote:
> > We use Yubikey for two-factor ssh authentication which requires enabling a Boolean
> called “authlogin_yubikey”. It has been working fine until a few weeks ago. Errors appear
> when attempting to set the policy:
> >
> >
> >
> > --
> >
> > [Cent-7:root@my_server home]# getsebool authlogin_yubikey
> >
> > authlogin_yubikey --> off
> >
> >
> >
> > [Cent-7:root@my_server home]# setsebool -P authlogin_yubikey on
> >
> > libsepol.context_from_record: type gpio_device_t is not defined
> >
> > libsepol.context_from_record: could not create context structure
> >
> > libsepol.context_from_string: could not create context structure
> >
> > libsepol.sepol_context_to_sid: could not convert system_u:object_r:gpio_device_t:s0 to
> sid
> >
> > invalid context system_u:object_r:gpio_device_t:s0
> 
> Sounds like your policy is in an inconsistent internal state (somewhere you have a context
> with gpio_device_t but the type isn't defined in the policy).
> 
> What's your policy version?  And did it perhaps fail during %post when it was updated -
> check yum.log?

Nothing stands out to me in yum.log


> Does semodule -B fail?

No, it completes without error:

--
[Cent-7:root@my_server ~]# semodule -B
[Cent-7:root@ my_server ~]# echo $?
0
[Cent-7:root@ my_server ~]#
--
> 
> Might have to move aside your policy and reinstall it.

How might one accomplish this?

> >
> > [Cent-7:root@my_server home]# getsebool authlogin_yubikey
> >
> > authlogin_yubikey --> on
> >
> > ---
> >
> >
> >
> > The system accepts two-factor while the above is set to “on”. After some undetermined
> time (or immediately after a reboot) the Boolean toggles off. This can be confirmed since
> semanage shows that the default is still set to “off”:
> >
> >
> >
> > --
> >
> > [Cent-7:root@my_server ~]# semanage boolean -l | grep "authlogin_yubikey"
> >
> > SELinux boolean                State  Default Description
> >
> > ...
> >
> > authlogin_yubikey              (on   ,  off)  Allow authlogin to yubikey
> >
> > --
> >
> >
> >
> > It looks similar to the following bug on Fedora:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1559174
