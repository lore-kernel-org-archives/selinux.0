Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0AHYkRb005810
	for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 12:34:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0AHYjiV012654
	for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 17:34:45 GMT
Received: from mutemail.com ([24.244.170.124])
        by jazzband.ncsc.mil  with SMTP id i0AHYi06012643 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 17:34:44 GMT
Date: Sat, 10 Jan 2004 09:32:39 -0800
From: Bill McCarty <bmccarty@pt-net.net>
To: SE Linux <selinux@tycho.nsa.gov>
cc: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: GDM for RHEL 3
Message-ID: <67358546.1073727158@[192.168.0.2]>
In-Reply-To: <400034BE.6040108@redhat.com>
References: <27010669.1073686811@[192.168.0.2]>
 <400034BE.6040108@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Dan,

Bless you, thanks!

FYI, I installed the old package by using --nodep and did not experience 
immediate, catastrophic failure <g>.

Cheers,

--On Saturday, January 10, 2004 12:22 PM -0500 Daniel J Walsh 
<dwalsh@redhat.com> wrote:

> Bill McCarty wrote:
>
>> Hi all,
>>
>> I'm installing SELinux for RHEL 3, including graphical mode support,
>> using the RPM packages available on Dan Walsh's web site. When I try
>> to install gdm, RPM complains that xinitrc 3.33-1 or greater is
>> needed. However, I don't find a binary or source package for xinitrc
>> bearing an appropriate version number. Can someone direct me to one,
>> or otherwise suggest how I can install gdm?
>>
>> Thanks!
>>
>> ---------------------------------------------------
>> Bill McCarty
>
> I added xinitrc from Fedora Core to the RHEL3 tree on People.  Hopefully
> this will solve the problem.  I will check a RHEL3 install on Monday.
>
> Dan
>
>>
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>
>



---------------------------------------------------
Bill McCarty


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
