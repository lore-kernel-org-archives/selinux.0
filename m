Message-ID: <4D8C09A3.5090304@windriver.com>
Date: Fri, 25 Mar 2011 11:18:59 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: qingtao.cao@windriver.com
MIME-Version: 1.0
To: "Justin P. Mattock" <justinmattock@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
Subject: Re: SELinux: avc_has_perm: unexpected error 22
References: <4D878244.4060502@gmail.com> <4D8A36E9.3070601@gmail.com>	 <4D8AACD9.60505@gmail.com> <1300975137.8157.38.camel@moss-pluto>	 <4D8B70C8.3000800@gmail.com> <1300997637.8157.44.camel@moss-pluto>	 <4D8BA7F0.5090307@gmail.com> <1300998293.8157.48.camel@moss-pluto> <4D8BACFD.6090400@gmail.com>
In-Reply-To: <4D8BACFD.6090400@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Justin,

Justin P. Mattock 写道:
> On 03/24/2011 01:24 PM, Stephen Smalley wrote:
>> On Thu, 2011-03-24 at 13:22 -0700, Justin P. Mattock wrote:
>>> On 03/24/2011 01:13 PM, Stephen Smalley wrote:
>>>> On Thu, 2011-03-24 at 09:26 -0700, Justin P. Mattock wrote:
>>>>> On 03/24/2011 06:58 AM, Stephen Smalley wrote:
>>>>>> On Wed, 2011-03-23 at 19:30 -0700, Justin P. Mattock wrote:
>>>>>>> On 03/23/2011 11:07 AM, Justin P. Mattock wrote:
>>>>>>>> On 03/21/2011 09:52 AM, Justin P. Mattock wrote:
>>>>>>>>> this is showing up with the latest Mainline kernel.
>>>>>>>>> gdm craps out..:
>>>>>>>>>
>>>>>>>>> [ 60.817] (II) Unloading synaptics
>>>>>>>>> [ 60.822] SELinux: avc_has_perm: unexpected error 22
>>>>>>>>> [ 60.822] SELinux: avc_has_perm: unexpected error 22
>>>>>>>>> [ 60.828] SELinux: avc_has_perm: unexpected error 22
>>>>>>>>> [ 60.831] SELinux: avc_has_perm: unexpected error 22
>>>>>>>>> [ 60.871] SELinux: avc_has_perm: unexpected error 22
>>>>>>>>> [ 60.871] SELinux: avc_has_perm: unexpected error 22
>>>>>>>>> [ 60.881] (II) UnloadModule: "mouse"
>>>>>>>>> [ 60.881] (II) Unloading mouse
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> full xorg.0.log is here:
>>>>>>>>> http://fpaste.org/OOM2/
>>>>>>>>>
>>>>>>>>> Justin P. Mattock
>>>>>>>>
>>>>>>>> seems doing a bisect right now during the merge window is
>>>>>>>> breaking,
>>>>>>>> anyways looking through the commits I think this:
>>>>>>>>
>>>>>>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c53fa1ed92cd671a1dfb1e7569e9ab672612ddc6;hp=06dc94b1ed05f91e246315afeb1c652d6d0dc9ab
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> might be what I am hitting, causing gdm to die out, as it starts.
>>>>>>>>
>>>>>>>> any ideas?
>>>>>>>>
>>>>>>>> Justin P. Mattock
>>>>>>>
>>>>>>> not sure if anybody is seeing this or hitting this with the
>>>>>>> current,
>>>>>>> but reverting the above commit does not fix the problem.
>>>>>>> will try another bisect(hopefully)
>>>>>>
>>>>>> Are you sure it is a kernel issue? Seems more likely that it
>>>>>> would be a
>>>>>> policy problem. What AVC denials are you getting?
>>>>>>
>>>>>
>>>>>
>>>>> strange.. was not even thinking of the avc's because the policy has
>>>>> already been customized and has been working for a while now without
>>>>> adding any rules.
>>>>>
>>>>> Anyways your right, seems the labels get changed or something with
>>>>> this
>>>>> kernel or something:
>>>>> http://fpaste.org/w4nK/
>>>>
>>>> audit(1300983537.941:34): security_compute_sid: invalid context
>>>> system_u:system_r:root_xdrawable_t:s0-s0:c0.c1023 for
>>>> scontext=system_u:system_r:xserver_t:s0-s0:c0.c1023
>>>> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_drawable
>>>>
>>>> This looks like it might be a kernel regression after all.
>>>> security_compute_sid should return object_r for tclass x_drawable, not
>>>> system_r. Likely due to the recent changes there to support socket
>>>> type
>>>> transitions. Not sure exactly what is going wrong, as it should only
>>>> happen on the socket classes.
>>>>
>>>
>>> alright!!
>>>
>>> as for good kernel:
>>> 2.6.38-00071-g5a69473
>>> is the last good one I have, so bisecting wont be too much but if I hit
>>> the breakage like last time it might slow things down and/or ruin the
>>> bisect.
>>
>> If it is what I think it is, then the breakage would be commit
>> 6f5317e730505d5cbc851c435a2dfe3d5a21d343
>>
>
> yep!
>
> reverting that commit gets gdm to not crap out.
> full dmesg here:
> http://fpaste.org/34DC/
>
> Justin P. Mattock
>
So far I have not got an environment as your to reproduce this problem.
Could you please kindly print the orig_class and the sock boolean in
your case? It's weird since so far only the process and socket classes
could retain the creator's role, any other classes object should have
"object_r" as usual.

Many thanks for your help!

Best regards,
Harry

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
