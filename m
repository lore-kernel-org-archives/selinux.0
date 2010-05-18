Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4IDHQXi021418
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 09:17:26 -0400
Received: from mail-pz0-f178.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4IDGhTZ027275
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 13:16:43 GMT
Received: by pzk8 with SMTP id 8so422998pzk.18
        for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 06:17:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BF28A59.402@redhat.com>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
	 <4BF28A59.402@redhat.com>
Date: Tue, 18 May 2010 18:17:20 +0500
Message-ID: <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>
Subject: Re: How to cross install policy store?
From: Shaz <shazalive@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=GB2312
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2010/5/18 Daniel J Walsh <dwalsh@redhat.com>:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/18/2010 03:07 AM, TaurusHarry wrote:
>>
>> HI SELinux experts,
>>
>> I am trying to use SELinux on an ARM board with limited RAM <=128m, if I use semodule tool to create policy store on the target it will be terminated by kernel OOM killer. Normally semodule tool will install the policy store on the host, is it possible to cross-install the policy store to the target rootfs image on the host?
>>
>> Thank you very much!
>>
>> Best regards,
>> Harry
>>
>> _________________________________________________________________
>> 想知道明天天气如何？必应告诉你！
>> http://cn.bing.com/search?q=%E5%A4%A9%E6%B0%94%E9%A2%84%E6%8A%A5&form=MICHJ2
> You should be able to build the policy on a different maching and just
> install it on the ARM box.

You mean it does not require to be cross compiled on a different
machine for the target and you can just load it! I cannot agree to
this until I try it. If it means that you cross compile it on a
different machine and then load it on target seems to be what you mean
.... the policy as far as I understand is suppose to be binary when it
builds ...

Today we got modular reference policy installed and loaded
successfully after a weeks effort and crashing my special (most
stable) build system. Setfiles was giving us problem. Tomorrow we do
testing.

-- 
Shaz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
