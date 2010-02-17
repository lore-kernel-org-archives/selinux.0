Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1HE3r7G006220
	for <selinux@tycho.nsa.gov>; Wed, 17 Feb 2010 09:04:11 -0500
Received: from moutng.kundenserver.de (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1HE3uUa009419
	for <selinux@tycho.nsa.gov>; Wed, 17 Feb 2010 14:03:56 GMT
To: "Justin P. mattock" <justinmattock@gmail.com>
Subject: Re: SELinux Policy in OpenSUSE 11.2
Cc: Alan Rouse <alan.rouse@ericsson.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
From: Thomas <tom@electric-sheep.org>
Date: Wed, 17 Feb 2010 15:04:01 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201002171504.01849.tom@electric-sheep.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
I am happy to see someone is working on SELinux for openSUSE.

To make this changes permanent, file the bug and findings in
our bugzilla (https://bugzilla.novell.com) please and put my
address (thomas@novell.com) into the CC list.

If you like to get more control and be more active I encourage
you to join the openSUSE community 
(http://en.opensuse.org/How_to_Participate).

We definitely lack skilled SELinux developers! :)

Thanks,
Thomas

Am Mittwoch 17 Februar 2010 08:16:36 schrieb Justin P. mattock:
> o.k. I think I thought too much on the subject
> (I need to stop building systems from scratch
> i.g. all I can think of is/are switches to enable).
> 
> Anyways I figured out the problem seems easier
> than I had expected:
> 
> with a fresh build of suse 11.2, then
> under yast adding the correct SELinux
> apps/libs, then adjusting grub(in the control
> center thing).
> 
> reboot
> 
> you hit a broken gdm dbus thing.
> 
> under /var/log/gdm/:5-greeter.log
> 
> there is an error message with dbus:
> 
> Failed to start message bus: Failed to open
> "/etc/selinux/targeted/contexts/dbus_contexts": No such file or directory
> EOF in dbus-launch reading address from dbus daemon.
> 
> so after reading that then looking at /etc/selinux/refpolicy-standard
> I decided to just cp -R refpolicy-standard targeted(reboot)
> and voila the system boots gdm starts, life is good with suse
> (I guess there not the darkside after all!!).
> 
> as for the real problem I'm guessing whatever is telling
> dbus-launch to look for /etc/selinux/targeted
> is the problem.
> 
> Alan does just a simple renaming of refpolicy to targeted
> at least get you up and running(if not use suses policy,
> and rename it to targeted, until I can find what dbus launch script is
> calling for that policy name).
> 
> Justin P. Mattock
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>  with the words "unsubscribe selinux" without quotes as the message.
> 

-- 
 Thomas Biege <thomas@suse.de>, SUSE LINUX, Security Support & Auditing
 SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG Nuernberg)
--
  Wer aufhoert besser werden zu wollen, hoert auf gut zu sein.
                            -- Marie von Ebner-Eschenbach

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
