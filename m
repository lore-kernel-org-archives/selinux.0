Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7OCBPYb030746
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 08:11:25 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7OCBOet014932
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 12:11:24 GMT
Message-ID: <4E54EA6B.2030900@tresys.com>
Date: Wed, 24 Aug 2011 08:11:23 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: HarryCiao <harrytaurus2002@hotmail.com>
CC: <dwalsh@redhat.com>, <qingtao.cao@windriver.com>, <slawrence@tresys.com>,
        <selinux@tycho.nsa.gov>
Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com> <4E53AE8C.6020707@redhat.com>,<4E53B1E8.2050508@tresys.com> <SNT139-W39AB9329AEFF0B29157316AB110@phx.gbl>
In-Reply-To: <SNT139-W39AB9329AEFF0B29157316AB110@phx.gbl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/24/11 06:32, HarryCiao wrote:
> Hi Chris,
> 
>> Date: Tue, 23 Aug 2011 09:58:00 -0400
>> From: cpebenito@tresys.com
>> To: dwalsh@redhat.com
>> CC: qingtao.cao@windriver.com; slawrence@tresys.com; selinux@tycho.nsa.gov
>> Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in
> expansion.
>>
>> On 08/23/11 09:43, Daniel J Walsh wrote:
>> > Eliminating booleans would be great and replacing them with tunables,
>> > but the tunables must be discoverable, and it must be easy for the
>> > administrator to discover the "tunable" and turn it on.
>> >
>> > Currently audit2allow/audit2why turns on all booleans in a policy and
>> > checks to see if an AVC would be allowed with any boolean. Then it
>> > prints out the booleans that would have allowed the access. We use
>> > this functionality within setroubleshoot. This is critical to making
>> > selinux policy usable.
>> >
> &g t; > User wants to allow ftp to access homedirs, he sets up ftp and
> SELinux
>> > blocks the access. Setroubleshoot comes up and says turn on the
>> > ftp_home_dir boolean to allow this access.
>> >
>> >
>> > If we can not duplicate this functionality then I NAK the change from
>> > booleans to tunables.
>>
>> Seems very easy to reproduce, as long as you turn on save-linked in
>> semanage.conf. The linked policy would have all the tunable
>> information, right Harry?
>>
> 
> The implementation of the save-linked option has no idea about the
> effort to separate tunables from booleans, so I am afraid  it won't help
> much.

So you're saying that when the linked policy file is written out, the
disabled tunables are already gone or all of the tunables information is
gone?

> However, you did enlighten me to create a new option "handle-tunable"
> for semanage.conf, then we can specify whether discarding tunable is
> desirable and its value would be saved into a new member
> "handle_tunable" in policydb_t. Then in the separation_tunables() in
> link .c, policydb_t.handle_tunable would be consulted about how to
> handle tunables.
> 
> By default this handle-tunable option for semanage.conf could be set to
> "discard", if audit2allow/audit2why are needed to debug AVC denied
> messages, we could set this option to "preserve" and rebuild and reload
> policy.X. When the related tunable is found we could toggle its default
> value to true and rebuild policy.X with the option back to "discard" again.
> 
> This way I think Dan's worries would be addressed. Right?
> 
> BTW, Is this the correct or best way to pass configuration options on to
> link process? I have created two patches for above logic(see attached),
> however I am pretty new to semanage and run into syntax error while
> parsing semanage.conf. Chris, could you please kindly take a look at
> what has been wrong in my 0007 patch? Many thanks!

I'll leave this up to the userspace maintainers :)

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
