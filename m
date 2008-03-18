Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2IJjuEH009239
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 15:45:56 -0400
Message-ID: <47E01BF2.80200@tycho.nsa.gov>
Date: Tue, 18 Mar 2008 15:45:54 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: selection labeling
References: <1205849784.16113.11.camel@gorn>
In-Reply-To: <1205849784.16113.11.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> I ran into an interesting denial:
>
> avc:  denied  { setattr setattr } for request=X11:SetSelectionOwner
> comm=dbus-launch
> selection=_DBUS_SESSION_BUS_SELECTION_root_3c39a16f05862d57c3d6ef0047356754
> scontext=root:staff_r:staff_t
> tcontext=system_u:object_r:xselection_t
> tclass=x_selection
>
> Other than the double setattr in the permissions, trying to label this
> selection for anything but the default doesn't seem possible.  It seems
> that this should be type_transitioned, but it didn't seem to work.
>   

Whoops, I know why the double setattr is there.  I'll get that fixed, 
ignore that for now.

We probably need to have wildcarding in the X label support, like the 
way filenames work.  Do you agree?

But I don't have a clue why D-BUS is creating selections with those 
insane names.  It looks like abuse of the selection mechanism to me.  
Selections are used for IPC, hence they're supposed to have fixed, 
standard names.  Actually it doesn't make sense to me that D-BUS is 
using selections at all.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
