Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4U14G3V031429
	for <selinux@tycho.nsa.gov>; Thu, 29 May 2008 21:04:16 -0400
Message-ID: <483F528B.9090802@tycho.nsa.gov>
Date: Thu, 29 May 2008 21:04:11 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Xavier Toth <txtoth@gmail.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joe Nall <joe@nall.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rbacsep: collapsing xserver
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>	 <1211990530.5008.127.camel@gorn.columbia.tresys.com>	 <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>	 <1211998598.5008.138.camel@gorn.columbia.tresys.com>	 <483DAB87.7090401@tycho.nsa.gov> <cadfc0e40805290918v55be6a5cn5b6da493185c7ca3@mail.gmail.com> <483F090F.2070109@redhat.com>
In-Reply-To: <483F090F.2070109@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Xavier Toth wrote:
>   
>> On Wed, May 28, 2008 at 1:59 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>>     
>>> Christopher J. PeBenito wrote:
>>>       
>>>> On Wed, 2008-05-28 at 11:42 -0500, Joe Nall wrote:
>>>>
>>>>         
>>>>> On Wed, May 28, 2008 at 11:02 AM, Christopher J. PeBenito
>>>>> <cpebenito@tresys.com> wrote:
>>>>>
>>>>>           
>>>>>> On Wed, 2008-05-28 at 10:16 -0500, Joe Nall wrote:
>>>>>>
>>>>>>             
>>>>>>> On Wed, May 28, 2008 at 9:38 AM, Christopher J. PeBenito
>>>>>>> <cpebenito@tresys.com> wrote:
>>>>>>>
>>>>>>>               
>>>>>>>> I've got to the point where I am collapsing the derived types in the
>>>>>>>> xserver module.  It would be nice to collapse all of the X server
>>>>>>>> domains into xserver_t, but we have xdm_xserver_t which has
>>>>>>>> permissions
>>>>>>>> greater than user_xserver_t, staff_server_t, etc.  However, just about
>>>>>>>> everyone runs their xserver in xdm_xserver_t due to logging in via
>>>>>>>> xdm.
>>>>>>>> Thoughts on collapsing all of the xservers anyway?
>>>>>>>>
>>>>>>>>                 
>>>>>>> Why is the way the xserver gets launched important once it is running?
>>>>>>>
>>>>>>>               
>>>>>> If you log into the console and run startx, your xserver is
>>>>>> user_xserver_t, staff_xserver_t, etc.  ﻿If you log in via a display
>>>>>> manager, your xserver is xdm_xserver_t, since the server is started by
>>>>>> xdm before a user logs in.  So you lose separation if you log in via
>>>>>> xdm.
>>>>>>
>>>>>>             
>>>>> Understood.
>>>>>
>>>>>
>>>>>           
>>>>>> There have been suggestions about either restarting the xserver or
>>>>>> dyntransitioning it to the correct context after logging in, but nothing
>>>>>> materialized on that.
>>>>>>
>>>>>>
>>>>>>             
>>>>>>> Does that change when X is an object manager?
>>>>>>>
>>>>>>>               
>>>>>> No.
>>>>>>
>>>>>>             
>>>>> Poorly worded question. _Should_ that change when X is a object manager?
>>>>>
>>>>>           
>>>> We would certainly prefer that each role always has their derived type
>>>> xserver (or role is set on xserver, if rbacsep succeeds), regardless if
>>>> its an object manager or not.
>>>>
>>>>         
>>> I have always disliked xdm_xserver_t and its associated policy shenanigans
>>> (what if someone creates a role named "xdm"?)
>>>
>>> The problem has always been the display manager behavior described above.
>>>  However this can be solved in at least three ways: 1) Restart the X server
>>> after the user logs in.  2) Have the X server setcon itself to the new
>>> context.  3) Multi-user switching where xdm stays up all the time and users
>>> get new X servers on different consoles.
>>>
>>> The easiest solution for me to work on is 2) because I don't have to touch
>>> the GDM code.  I'd like to see rbacsep succeed though.
>>>
>>>       
>>>>> What is the driver for the derived types? User preference files in
>>>>> their home directory?
>>>>>
>>>>>           
>>> There's some argument to be made that the X server is part of the user's
>>> session.  For example, in mulit-user switching there is more than one server
>>> running, one for each user.
>>>
>>> If rbacsep succeeds then the derived types will go away regardless.
>>>
>>>       
>>>>>>> On a related topic, what is the type enforcement strategy for window
>>>>>>> managers?
>>>>>>>
>>>>>>>               
>>>>>> They currently run in the user's context.  The basic templates in the
>>>>>> policy should still allow for separations.  The policy for X objects is
>>>>>> still immature, so I'm definitely open to suggestions.
>>>>>>
>>>>>>             
>>>>> I did some brief experiments with the X server in MLS enforcing mode a
>>>>> while back and it looked like a separate type would be required to
>>>>> avoid giving the user silly levels of privilege. I'll try to get back
>>>>> to those experiments next week.
>>>>>
>>>>>           
>>> The window manager must have full access to all windows on the screens that
>>> it's managing.  In non-MLS this means at least full privileges on the role
>>> and probably for other roles too, if you're going to be popping up sysadm
>>> windows.  In MLS this means access across all levels, there's really no way
>>> around this.
>>>
>>>
>>>       
>>>>> Any opinions on spitting the display manager (gdm/xdm) policy out of
>>>>> the xserver policy? The current xserver policy is quite a bit bigger
>>>>> than apache and several times the average policy size (te + if).
>>>>>
>>>>>           
>>>> You can blame me for that.  The xdm policy used to be separate before
>>>> refpolicy, but it was so intertwined with the xserver policy that there
>>>> wasn't a sane way to write the policies separately and still keep the
>>>> refpolicy encapsulation.  If we collapse all xservers into xserver_t, it
>>>> may be possible to separate xdm again.  If not, xdm will be put into a
>>>> tunable when we get real tunable support in the compiler.
>>>>
>>>>         
>>> --
>>> Eamon Walsh <ewalsh@tycho.nsa.gov>
>>> National Security Agency
>>>
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>
>>>       
>> From http://www.gnome.org/projects/gdm/docs/2.20/overview.html:
>>
>> "On Solaris, GDM (since version 2.8.0.3) uses the SDTLOGIN interface
>> after user authentication to tell the X server to be restarted as the
>> user instead of as root for added security. When the user's session
>> exits, the GDM daemon will run the PostSession script as root."
>>
>> Couldn't we utilize the same functionality on Fedora?
>>     

I've got no problem with doing something like this.  I've already 
written support for communicating with the X server from pam_selinux.so 
to set up the user's device labels, so it could also tell the server to 
setcon itself.  That work has stalled because of dependency issues (pam 
depending on libxcb), getting PAM_XAUTH_DATA support into gdm, and 
waiting for the next release of libxcb.  But, I can pick up work on it 
once I finish the X Python stuff.

With regards to SDTLOGIN, it doesn't look like it restarts the server, 
only causes it to drop privileges; see 
http://osdir.com/ml/gnome.gdm.general/2007-10/msg00080.html dated Oct 
2007.  The current gdm upstream seems to have dropped support for it.  I 
did some grepping in the gdm source and couldn't find anything.  It's 
probably a temporary result of the gdm rewrite.


>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>     
> Probably better asked on the Fedora List.
>
>   

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
