Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PKHV55030867
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 15:17:31 -0500
Message-ID: <47C32259.10505@tycho.nsa.gov>
Date: Mon, 25 Feb 2008 15:17:29 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I have begun merging XWindows Controls into Rawhide.
References: <47C2CBA1.5040807@redhat.com> <1203957368.32061.74.camel@gorn>
In-Reply-To: <1203957368.32061.74.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2008-02-25 at 09:07 -0500, Daniel J Walsh wrote:
>   
>> But the complexity of this stuff is just getting nuts.
>>
>> I don't thing we should have more then one type for xserver.  Allowing a
>> confined user to transition to user_xserver_t is just nuts and ends up
>> having awful policy for getting xdm_xserver_t to work.  Why in the world
>> would we allow a confined user to start and XServer?  And if they can,
>> why not just allow them to start xdm_xserver_t?  In Rawhide right now no
>> users can start and Xserver except unconfined_t and he starts
>> xdm_xserver_t to make sure the transitions work properly.  If someone
>> actually has a use case where they need user separated xservers then I
>> say write that policy off the main stream.  You can still theoretically
>> run multiple xdm_xserver_t at different MLS levels.
>>     

I would be fine with only having one type for the X server; this would 
certainly simplify the policy that currently has all kinds of kludgery 
to support both "xdm_" and "$1_".

On a locked-down strict system like an MLS box, the user wouldn't be 
allowed to run startx anyway.  So I agree that the current constructions 
are unnecessary.


>> Having four macro parameters is confusing as hell, and needs to go.
>>     
>
> This comes back to forthcoming effort for trying to use RBAC for role
> separation.  That would eliminate the structural complexity we see due
> to using TE for the role separation

Is work being done on this?  I recall you said you were interested in 
taking on this task.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
