Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5MHdM0A017105
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2010 13:39:22 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5MHf0Qj017745
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2010 17:41:00 GMT
Message-ID: <4C20F546.5020601@redhat.com>
Date: Tue, 22 Jun 2010 13:39:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: We need libselinux to lie...
References: <C8466C4B.B9512%csellers@tresys.com>
In-Reply-To: <C8466C4B.B9512%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/22/2010 01:34 PM, Chad Sellers wrote:
> On 6/22/10 1:06 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> 
>> When building packages within mock/livecd.
>>
>> We really want the processes running within the chroot to not do SELinux
>> stuff.
>>
>> We want libselinux to tell them that SELinux is disabled.
>>
>> For example if we install selinux-policy package within a mock chroot or
>> livecd we do not want it to try to load_policy.  Other rpms try chcon or
>> restorecon in post installs.  These are get turned off if the tools
>> think SELinux is disabled.  We are not doing this for security reasons.
>>
>> We have been hacking this out, but replaceing $CHROOT/proc/filesystem
>> with a version that does not include filesystem, but we have found this
>> to require large privs for mock. (mount -o bind /tmp/filesystem
>> $CHROOT/proc/filesystem; requires mock_t to read /dev/loop which is
>> labeled fixed_disk_device_t)
>>
>> We have considered playing tricks with libselinux.so but those seem a
>> little dangerous.
>>
>> Eric has come up with an idea of adding a field to
>> $CHROOT/etc/selinux/config to tell is_selinux_enabled() to return false.
>>
>> SPECIAL_ENABLED=force_off
>>
>> Then mock could just set this flag in the config file and all apps would
>> think SELinux is disabled.
>>
>> Does this seem reasonable?
>>
> Seems a bit dangerous, as there are some processes you don't want being
> wrong about whether SELinux is enabled or not (e.g. login). That said, for
> controlled uses like within a build chroot, it seems like it'd be ok.
> 
> So, I'd be fine with this, though please name the option something a little
> more obvious. Perhaps FAKEDISABLED, with values of 0 or 1 (like SETLOCALDEFS
> or REQUIRESEUSERS).
> 
> Chad
Eric came up with the dumb name.  This would only be for the chroot
enviornments and apps are free to ignore is_selinux_enabeled() output.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
