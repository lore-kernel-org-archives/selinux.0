Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6MJpeh4001218
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2011 15:51:40 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6MJpdMv018014
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2011 19:51:39 GMT
Message-ID: <4E29D4C9.3000903@tresys.com>
Date: Fri, 22 Jul 2011 15:51:37 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: HarryCiao <harrytaurus2002@hotmail.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, <method@manicmethod.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: v3 Add role attribute support to libsepol
References: <1309249126-5224-1-git-send-email-qingtao.cao@windriver.com> <SNT139-w61848BC20E4E7F40D1E43DAB560@phx.gbl>,<4E0AD0BC.8040708@windriver.com> <SNT139-w20B1A1E8C4A8738E18E36AB580@phx.gbl>
In-Reply-To: <SNT139-w20B1A1E8C4A8738E18E36AB580@phx.gbl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--snip--

>>
>>>  > 2. The policy.X's binary representation and SELinux kernel role_datum_t
>>>  > structure don't have to be changed, so the max version number for 
>>> policy.X
>>>  > won't have to be bumped.
>>>  >
>>>  > But it may be desirable to bump the max module version number.
>>>  >
> 
> Write flavor flag and roles ebitmap into a pp file and read them out unconditionally, this would only run into problem only under one condition, that libsepol/checkpolicy are upgraded with this patchset but the pp files are built before the upgrade took place, which I think could be easily fixed by re-building all pp files by the upgraded libsepol/checkpolicy.
> 
> So I think we don't have to bump MOD_POLICYDB_VERSION_MAX higher.
> 
> Am I right?
> 
> BTW, how do we trigger a pp downgrade? Anything like OUTPUT_POLICY or policy-version to trigger policy downgrade?
> 
> Thanks,
> Harry
> 

There isn't a tool that can force a policy module downgrade, but it can
be done programmatically, so it should be supported. Additionally, it
shouldn't require that modules be rebuilt if the toolchain is updated.
So please add a new module version and check that before reading/writing
the new role attribute information.

Aside from that, I've reviewed this patchset and everything looks
reasonable. I still want to test this a little more, but assuming I
don't see any any issues with a little more testing, and pending a fix
for a module version bump, I'm fine with merging this.

- Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
