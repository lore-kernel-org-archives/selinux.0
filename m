Message-ID: <47D1EBBE.5040802@tycho.nsa.gov>
Date: Fri, 07 Mar 2008 20:28:30 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t
 when upstart runs a shell
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil>	 <1204917195.20251.51.camel@gorn.columbia.tresys.com> <1204922502.21054.18.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1204922502.21054.18.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:
> On Fri, 2008-03-07 at 14:13 -0500, Christopher J. PeBenito wrote:
>   
>> On Thu, 2008-03-06 at 16:11 -0500, James Carter wrote:
>>     
>>> Upstart spawns a shell during boot and, without this patch, it will
>>> transition to the sysadm_t domain, but remain in the system_r role.
>>> Services started by that shell will fail to start, even in permissive
>>> mode, if system_u:system_r:sysadm_someservice_t is an invalid context.
>>> We really don't want to be starting services from the sysadm_t domain
>>> during boot.
>>>       
>>

In case the severity of this problem isn't clear:

Rawhide + refpolicy trunk + enforcing mode = lockup at boot:

<permission denials from system_u:system_r:sysadm_t accessing tmpfs>
init: rc-default main program terminated with status 1


Rawhide + refpolicy trunk + permissive mode = dbus "permission denials" 
resulting from invalid contexts:

Mar  5 15:48:11 moss-charon kernel: security:  context 
system_u:system_r:sysadm_dbusd_t:s0 is invalid
Mar  5 15:48:11 moss-charon avahi-daemon[2158]: dbus_bus_get_private(): 
An SELinux policy prevents this sender from sending this message to this 
recipient (rejected message had interface "org.freedesktop.DBus" member 
"Hello" error name "(unset)" destination "org.freedesktop.DBus")
Mar  5 15:48:11 moss-charon avahi-daemon[2158]: WARNING: Failed to 
contact D-Bus daemon.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
