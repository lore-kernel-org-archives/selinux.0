Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o17HMhP0032167
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 12:22:43 -0500
Received: from mail-yx0-f183.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o17HMp1b029486
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 17:22:51 GMT
Received: by yxe13 with SMTP id 13so3740395yxe.18
        for <selinux@tycho.nsa.gov>; Sun, 07 Feb 2010 09:22:42 -0800 (PST)
Message-ID: <4B6EF749.8070503@gmail.com>
Date: Sun, 07 Feb 2010 09:24:25 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Selinux in enforcing mode prevent network interface to be configured
 at boot for Debian stable ( 5.0)
References: <bf30b281002070012q1d9a33ffsc90781d217e05f9b@mail.gmail.com> <4B6E7CE0.1050107@gmail.com> <bf30b281002070131l4821a6abg45a3cbc3d01a08e6@mail.gmail.com> <4B6E8EF5.3010608@gmail.com> <20100207162358.GR1750@myhost.felk.cvut.cz>
In-Reply-To: <20100207162358.GR1750@myhost.felk.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/07/10 08:23, Michal Svoboda wrote:
> Justin P. Mattock wrote:
>> if nothing the do a
>> sudo /usr/sbin/semodule -DB
>> (reboot)
>> then what does audit2allow say?
>> should give you some allow rules
>> if so add them to your policy.
>
> This will most likely output a very large number of rules that don't
> make sense, ie. they would do more bad than good.
>

  true.. well if there's a better idea to help this person out,
then please add..(I figured the most simplest way to do so
without having to do brain surgery).

> The basic problem is that the network scripts don't have their own
> restricted domain in which they could run. Running them from udev on
> 'network hotplug event' will copy the udev context, which doesn't have
> enough privileges to configure network. Giving these privileges to udev
> directly would be sub-optimal.
>
> Michal Svoboda

in this case if this is ifup, then it should be a no brainer(but could 
be wrong).

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
