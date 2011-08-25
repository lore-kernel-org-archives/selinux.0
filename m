Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PAahga026281
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 06:36:45 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PAafpf001474
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 10:36:41 GMT
Message-ID: <4E5625C1.20908@windriver.com>
Date: Thu, 25 Aug 2011 18:36:49 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: HarryCiao <harrytaurus2002@hotmail.com>, <cpebenito@tresys.com>,
        <dwalsh@redhat.com>, <slawrence@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com> <4E53AE8C.6020707@redhat.com>,<4E53B1E8.2050508@tresys.com> <SNT139-W39AB9329AEFF0B29157316AB110@phx.gbl> <4E553C23.8050508@manicmethod.com>
In-Reply-To: <4E553C23.8050508@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle 写道:
> HarryCiao wrote:
> <snip>
>   
>> By default this handle-tunable option for semanage.conf could be set to 
>> "discard", if audit2allow/audit2why are needed to debug AVC denied messages, we 
>> could set this option to "preserve" and rebuild and reload policy.X. When the 
>> related tunable is found we could toggle its default value to true and rebuild 
>> policy.X with the option back to "discard" again.
>>
>> This way I think Dan's worries would be addressed. Right?
>>     
>
> I would say we could use the policycaps bitmap for this but since we already
> have to bump the module version to support the extra field there is no reason we
> can't just add flag.
>
>   
>> BTW, Is this the correct or best way to pass configuration options on to link 
>> process? I have created two patches for above logic(see attached), however I am 
>> pretty new to semanage and run into syntax error while parsing semanage.conf. 
>> Chris, could you please kindly take a look at what has been wrong in my 0007 
>> patch? Many thanks!
>>
>>     
>
>
> Your libsemanage would need to have the option added in order to pass that in.
> It could be passed in via the libsepol handle. See how set_disable_dontaudit
> works for an example.
>
>   
Hi Joshua,

Ok, I see your point, I would learn how disable_dontaudit is passed via
libsepol handle and follow the same path.

Thanks,
Harry

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
