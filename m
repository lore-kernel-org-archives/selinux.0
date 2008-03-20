Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2K3BMSm017501
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 23:11:22 -0400
Message-ID: <47E1D5D8.30901@tycho.nsa.gov>
Date: Wed, 19 Mar 2008 23:11:20 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: selection labeling
References: <1205849784.16113.11.camel@gorn>  <47E01BF2.80200@tycho.nsa.gov> <1205929659.16113.31.camel@gorn>
In-Reply-To: <1205929659.16113.31.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2008-03-18 at 15:45 -0400, Eamon Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> I ran into an interesting denial:
>>>
>>> avc:  denied  { setattr setattr } for request=X11:SetSelectionOwner
>>> comm=dbus-launch
>>> selection=_DBUS_SESSION_BUS_SELECTION_root_3c39a16f05862d57c3d6ef0047356754
>>> scontext=root:staff_r:staff_t
>>> tcontext=system_u:object_r:xselection_t
>>> tclass=x_selection
>>>
>>> Other than the double setattr in the permissions, trying to label this
>>> selection for anything but the default doesn't seem possible.  It seems
>>> that this should be type_transitioned, but it didn't seem to work.
>>>   
>>>       
>> Whoops, I know why the double setattr is there.  I'll get that fixed, 
>> ignore that for now.
>>
>> We probably need to have wildcarding in the X label support, like the 
>> way filenames work.  Do you agree?
>>     
>
> This is the role's session bus, not the system bus, so the preference
> would be to have a type_transition so the selection would be
> staff_dbus_xselection_t.  I don't see how we could get this behavior in
> x_contexts except by putting in entries for all of the users, which
> would be suboptimal.  Especially since in this case where I logged in as
> root/staff_r; I could also log in as root/sysadm_r and then in that case
> we have a problem since the label would be wrong in one of those cases.
>
>   


Two thoughts:

1. Do this through D-BUS not X, by modifying the D-BUS daemon to set the 
selection create context when it creates these selections.

or better yet:

2. Fix D-BUS to provide some other way for people to find out the name 
of the session bus (if that's what in fact this is for, which I'm still 
unclear on).  Like maybe through a D-BUS service.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
