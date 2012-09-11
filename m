Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8BE9kq3021231
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 10:09:46 -0400
Received: from [192.168.1.16] (151.76.40.235) by cp-out9.libero.it (8.5.133)
        id 504457620152D193 for selinux@tycho.nsa.gov; Tue, 11 Sep 2012 16:09:43 +0200
Message-ID: <504F4626.7040303@trentalancia.com>
Date: Tue, 11 Sep 2012 16:09:42 +0200
From: Guido Trentalancia <guido@trentalancia.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Assertion `new_role != ((void *)0) && new_role->flavor == 1'
 when installing modules
References: <20120909191000.74e83c73@fornost.bigon.be> <1347280786.2480.3.camel@moss-pluto.epoch.ncsc.mil> <20120911011349.0ecc2f99@eldamar.bigon.be> <20120911063822.GA4390@telmora.telvanni> <20120911121903.6ba2825d@eldamar.bigon.be>
In-Reply-To: <20120911121903.6ba2825d@eldamar.bigon.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/09/2012 12:19, Laurent Bigonville wrote:
> Le Tue, 11 Sep 2012 08:38:22 +0200,
> Ole Kliemann <ole@plastictree.net> a écrit :
>
>>
>> You are building the policy without MLS/MCS, right?
>
> Yes, TYPE = standard in the build.conf
>
>>
>> Educated guess: It's the same here:
>>
>>      http://marc.info/?l=selinux&m=133003003018371
>>
>> Patch would be (helped on Ubuntu):
>>
>>      http://marc.info/?l=selinux&m=132433039902439&w=2
>
> Actually this patch is already included in the version of libsemanage
> I'm using.
>
> The patch here: http://marc.info/?l=selinux&m=132636024218187&w=2 fixed
> the segfault when loading the policy with Stephen patch.
>
> BUT, it seems that the initial assertion is not completely fixed.
>
> I'm still getting:
>
> checkmodule: expand.c:700: role_fix_callback: Assertion `new_role != ((void *)0) && new_role->flavor == 1' failed.

Are you using a recent version of the Reference Policy ?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
