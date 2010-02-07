Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o179VJNh015492
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 04:31:19 -0500
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o179V81t016360
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 09:31:08 GMT
Received: by wwc33 with SMTP id 33so1174725wwc.12
        for <selinux@tycho.nsa.gov>; Sun, 07 Feb 2010 01:31:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B6E7CE0.1050107@gmail.com>
References: <bf30b281002070012q1d9a33ffsc90781d217e05f9b@mail.gmail.com>
	 <4B6E7CE0.1050107@gmail.com>
Date: Sun, 7 Feb 2010 10:31:17 +0100
Message-ID: <bf30b281002070131l4821a6abg45a3cbc3d01a08e6@mail.gmail.com>
Subject: Re: Selinux in enforcing mode prevent network interface to be
	configured at boot for Debian stable ( 5.0)
From: Elko Kuric <elkokuric@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 7, 2010 at 9:42 AM, Justin P. Mattock
<justinmattock@gmail.com> wrote:
> On 02/07/10 00:12, Elko Kuric wrote:
>>
>> Hi all,
>>
>> I decided to move my debian installation to use Selinux, and I
>> installed it using
>>
>> http://wiki.debian.org/SELinux  howto ( Debian 5 )
>>
>>
>> When Selinux is in "permissive" mode, network connection is up and it
>> works
>> but when I switch Selinux to "enforcing" mode network interface is
>> down after reboot.
>>
>> seaudit-report report the following output:
>>
>> Feb 07 08:36:58 firewall kernel: avc: denied pid=1290 comm=ifup
>> name=ifstate ino=4103 dev=hda1 \
>> scontext=system_u:system_r:udev_t
>> tcontext=system_u:object_r:etc_runtime_t tclass=file
>>
>> Feb 07 08:36:58 firewall kernel: avc: denied pid=1297 comm=ifup
>> name=ifstate ino=4103 dev=hda1 \
>> scontext=system_u:system_r:udev_t
>> tcontext=system_u:object_r:etc_runtime_t tclass=file
>>
>> I can understand that selinux is preventing ifup to be executed, but I
>> still do not have counterpart in debian
>> for RedHat's
>>
>> sealert -a audit.log
>>
>> , where it suggest what is necessary to do in order to allow access.
>>
>> I can bring interface up when logged as rood and using "ifconfig "
>>
>> Any comment is welcome and thank you in advance,
>>
>> Regards,
>>
>> Elko
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>
> not sure what policy debian is using.
> if it's regular targeted(binary), you should be able
> to just do a audit2allow -dM modulename(to build the module)
> then sudo semodule -i modulename(to install the module)
> (if an error happens then you need to manually
> edit the *.te file then use sepackage(I think),and/or
> semodule to build the *.pp).
> (there is a kernelparameter for network for SELinux
> but last I remember that was for policy-default(many moon ago));
>
>
> Justin P. Mattock
>

Thanks for mail. I have installed following packages

dpkg -l | grep ii | grep selinux

ii  libselinux1                       2.0.65-5                 SELinux
shared libraries
ii  python-selinux                    2.0.65-5                 Python
bindings to SELinux shared libraries
ii  selinux-basics                    0.3.5                    SELinux
basic support
ii  selinux-policy-default            2:0.0.20080702-6         Strict
and Targeted variants of the SELinux policy
ii  selinux-utils                     2.0.65-5                 SELinux
utility programs


I expected some issues with setting up some specific services (
dns/mail ... ), but here I just want to get network
functional once I set selinux to "enforcing " policy.

Elko


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
