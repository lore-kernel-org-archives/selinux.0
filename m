Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24KGfIF003846
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 15:16:41 -0500
Message-ID: <47CDAE17.4020809@tycho.nsa.gov>
Date: Tue, 04 Mar 2008 15:16:23 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Ok I am trying to build interfaces using X Controls.
References: <47CC6061.6090707@redhat.com> <47CC6FF7.7010409@redhat.com> <47CC839B.80005@tycho.nsa.gov> <47CD53DB.8050101@redhat.com>
In-Reply-To: <47CD53DB.8050101@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Eamon Walsh wrote:
>   
>> Daniel J Walsh wrote:
>>     
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Daniel J Walsh wrote:
>>>       
>>>> What are these doing?  Why do I need these?
>>>>
>>>> type_transition $2_t default_xproperty_t:x_property
>>>>     $2_default_xproperty_t;
>>>>
>>>>     type_transition $2_t property_xevent_t:x_event $2_property_xevent_t;
>>>>     type_transition $2_t focus_xevent_t:x_event $2_focus_xevent_t;
>>>>     type_transition $2_t manage_xevent_t:x_event $2_manage_xevent_t;
>>>>     type_transition $2_t default_xevent_t:x_event $2_default_xevent_t;
>>>>
>>>>         
>>> Looking at this further, I think these should be classes.
>>>
>>> allow staff_t self:property_xevent_t send;
>>>
>>> Have all xevent with the same class is similar to having  blk_file,
>>> chr_file, sock_file all class file and defining transitions.
>>>
>>>       
>> This makes sense, and it's something I considered, however I couldn't
>> get the set of classes nailed down firmly enough to make a decision. The
>> class structure was too rigid, in my opinion, to support this kind of
>> categorization.
>>
>> It's even worse with window properties, which are based on an open-ended
>> namespace.  All kinds of zany conventions have been established
>> regarding the use of this or that property, and who knows what other
>> ones might come along.
>>
>>
>>     
> But are any of these worth anything from a security perspective?  Are we
> adding huge complexity for any reason.  Is xevent enough or x_property
> in most cases.  If I can set one x_property will I need to set them all.
>    I hate type explosions, because it just generates AVC errors and
> unexpected errors.
>   

The two properties that hold the selinux contexts should be read-only to 
everyone since only the server sets them.  Actually I'm going to 
deprecate these shortly in favor of the GetWindowContext X protocol 
request anyway.  If you don't care about the others, just collapse them 
down to one type and transition them to staff_f in your policy.  The 
stuff that is there now is an example of how you might separate window 
hint properties from globally writable properties like the cut buffers.

For events, too, you could probably collapse them down to staff_t.  
Again, the stuff that is there now is an example of how to separate 
input events, property notify events, and other types of event.  Other 
people doing stricter separation might need this functionality.


> I think we should think of the interactions we are trying to stop and
> then only generate the types necessary to prevent these interactions.
>
> If all we want to stop is
>
> cut/paste
> screencapture
> keyboard sniffing
> focus grab
> ...
>   
> Lets build up the limited types to control this interaction.
>
> Another way to look at it would be the way we have labeled /proc.  We
> only add a new type when there is a justifiable security difference.
>
>   
>>>> I want to refer to all of the XClass via the main type.
>>>>
>>>> Lets take an example.
>>>>
>>>> I write policy for all X Apps that staff_t runs without a transition to
>>>> stay staff_t.
>>>>
>>>> Now I write a transition rule for staff_mozilla_t.
>>>>
>>>> So I want to say something like
>>>>
>>>> xserver_paste_pattern(staff_mozilla_t, staff_t)
>>>>
>>>> I would like to then write something like
>>>>
>>>> allow staff_mozilla_t staff_t:x_property read;
>>>>
>>>> But you make me write.
>>>>
>>>> allow staff_mozilla_t staff_default_x_property_t:x_property read;
>>>>
>>>> Which screws up the interface and I end up having to pass around staff
>>>> and staff_mozilla.
>>>>
>>>> Is this necessary?
>>>>
>>>> Is this legal?
>>>>     type_transition $2_t input_xevent_t:x_event $2_t;
>>>>
>>>> Or is it even necessary?
>>>>
>>>> I really want to build an interface that says
>>>>
>>>> xserver_application(staff, staff_t)
>>>>
>>>> xserver_application(staff, staff_mozilla_t)
>>>>
>>>> Then define any interactions between staff_t and staff_mozilla_t via
>>>> simple interfaces.
>>>>         
>> If you're already passing (staff, staff_t) around then why not just pass
>> the prefixes to your interaction function?
>>
>> xserver_interact(staff, staff_t, staff_mozilla, staff_mozilla_t)
>>
>> doesn't look that bad to me.
>>
>> It's not my fault that we have all these complex constructions just to
>> make sure everything has a "_t" on the end of it.
>>
>>
>>     
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.8 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkfNU9oACgkQrlYvE4MpobPAuQCdHLMeuE+kSpfNyNYQ+jzjsyO5
> UUoAn2Pxu030f6iGOCgTc79DY0NFwVm3
> =j+HT
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
