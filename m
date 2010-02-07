Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o178eSZq027737
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 03:40:28 -0500
Received: from mail-iw0-f173.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o178eYW6024859
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 08:40:34 GMT
Received: by iwn3 with SMTP id 3so2510543iwn.23
        for <selinux@tycho.nsa.gov>; Sun, 07 Feb 2010 00:40:26 -0800 (PST)
Message-ID: <4B6E7CE0.1050107@gmail.com>
Date: Sun, 07 Feb 2010 00:42:08 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Elko Kuric <elkokuric@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Selinux in enforcing mode prevent network interface to be configured
 	at boot for Debian stable ( 5.0)
References: <bf30b281002070012q1d9a33ffsc90781d217e05f9b@mail.gmail.com>
In-Reply-To: <bf30b281002070012q1d9a33ffsc90781d217e05f9b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/07/10 00:12, Elko Kuric wrote:
> Hi all,
>
> I decided to move my debian installation to use Selinux, and I
> installed it using
>
> http://wiki.debian.org/SELinux  howto ( Debian 5 )
>
>
> When Selinux is in "permissive" mode, network connection is up and it works
> but when I switch Selinux to "enforcing" mode network interface is
> down after reboot.
>
> seaudit-report report the following output:
>
> Feb 07 08:36:58 firewall kernel: avc: denied pid=1290 comm=ifup
> name=ifstate ino=4103 dev=hda1 \
> scontext=system_u:system_r:udev_t
> tcontext=system_u:object_r:etc_runtime_t tclass=file
>
> Feb 07 08:36:58 firewall kernel: avc: denied pid=1297 comm=ifup
> name=ifstate ino=4103 dev=hda1 \
> scontext=system_u:system_r:udev_t
> tcontext=system_u:object_r:etc_runtime_t tclass=file
>
> I can understand that selinux is preventing ifup to be executed, but I
> still do not have counterpart in debian
> for RedHat's
>
> sealert -a audit.log
>
> , where it suggest what is necessary to do in order to allow access.
>
> I can bring interface up when logged as rood and using "ifconfig "
>
> Any comment is welcome and thank you in advance,
>
> Regards,
>
> Elko
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

not sure what policy debian is using.
if it's regular targeted(binary), you should be able
to just do a audit2allow -dM modulename(to build the module)
then sudo semodule -i modulename(to install the module)
(if an error happens then you need to manually
edit the *.te file then use sepackage(I think),and/or
semodule to build the *.pp).
(there is a kernelparameter for network for SELinux
but last I remember that was for policy-default(many moon ago));


Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
