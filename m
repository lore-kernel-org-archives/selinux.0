Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BLxnnZ005668
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 17:59:49 -0400
Message-ID: <48504AD4.2020109@tycho.nsa.gov>
Date: Wed, 11 Jun 2008 17:59:48 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: Chad Hanson <chanson@TrustedCS.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: X in MLS enforcing problem
References: <cadfc0e40806091430j7d4734c6l7af3cfbce395eeae@mail.gmail.com>	 <D709A20F2164C84E8B7014B0301F5EF8012E7F32@HAVOC.tcs-sec.com>	 <cadfc0e40806091535k1929bbc8gd4eebefb4b6069ff@mail.gmail.com>	 <484DC4D2.7050201@tycho.nsa.gov> <484FD7A5.5070806@gmail.com> <cadfc0e40806111442j5c7ec784k7c65c4df67214571@mail.gmail.com>
In-Reply-To: <cadfc0e40806111442j5c7ec784k7c65c4df67214571@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> On Wed, Jun 11, 2008 at 8:48 AM, Ted X Toth <txtoth@gmail.com> wrote:
>   
>> Eamon Walsh wrote:
>>     
>>> Xavier Toth wrote:
>>>
>>> [snip]
>>>
>>>       
>>>> Now I looking at the USER_AVCs and trying to figure out how to
>>>> translate those into policy. Will audit2allow be updated to help with
>>>> generating rules for the X USER_AVCs?
>>>>
>>>>         
>>> The stock audit2allow parses my audit.log just fine.  It doesn't work for
>>> you?
>>>
>>>
>>>       
>>>> For those who haven't seen the X user space object manager AVCs here
>>>> are some examples:
>>>> type=USER_AVC msg=audit(1213049927.142:132): user pid=2636 uid=0
>>>> auid=4294967295 ses=4294967295
>>>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>>>  { blend } for request=X11:CreateWindow comm=dbus-launch resid=800001
>>>> restype=WINDOW scontext=user_u:user_r:user_t:s0
>>>> tcontext=user_u:object_r:user_t:s0 tclass=x_drawable :
>>>> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
>>>>
>>>>         
>>> This is a program attempting to create a window with no background.  The
>>> denial will cause the window background to be filled in with a solid color.
>>>
>>> Dontaudit should work here.
>>>
>>> However, window managers do need the blend permission (on all windows).
>>>  The "compositing" feature requires this permission.
>>>
>>>
>>>       
>>>> type=USER_AVC msg=audit(1213049927.144:133): user pid=2636 uid=0
>>>> auid=4294967295 ses=4294967295
>>>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>>>  { setattr } for request=X11:SetSelectionOwner comm=dbus-launch
>>>>
>>>> selection=_DBUS_SESSION_BUS_SELECTION_tedx_caa2282936b539cb3e36c2ae4845ed0b
>>>> scontext=user_u:user_r:user_t:s0
>>>> tcontext=system_u:object_r:xselection_t:s0 tclass=x_selection :
>>>> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
>>>>
>>>>         
>>> This is a known issue.  I have not found an explanation yet for the
>>> purpose of these D-BUS selections.
>>>
>>> There is no easy solution here.  The selabel system cannot handle these
>>> funky names.  Even if there was regexp support, as Chris has indicated the
>>> name contains a username, implying that it should be labeled with a derived
>>> type.
>>>
>>> I think the "dbus-launch" program needs to undergo surgery to either not
>>> create these things or to label them explicitly.
>>>       
>> If I were to do this I'd use either SetSelectionCreateContext or
>> SetSelectionUseContext, could you explain the difference between them and
>> which I should use?
>>     
>
> I also will need to compute a new context from the process and default
> selection contexts but I'd need an object class definition
> (SECCLASS_XSELECTION?) which I don't think exists yet does it?
>   


Use class x_selection.  To find it's value dynamically, you can use the 
following code.

#define THE_CLASS 1

    security_class_mapping map[] = { { "x_drawable", { NULL } }, { NULL } };

    if (selinux_set_mapping(map) < 0)
	/* probably don't have class - skip SELinux stuff */


Then use THE_CLASS (or just "1") as the class value in your code.

Lots of questions about these interfaces lately - I need to write man 
pages for them.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
