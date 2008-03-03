Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m23N2t1W006307
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 18:02:55 -0500
Message-ID: <47CC839B.80005@tycho.nsa.gov>
Date: Mon, 03 Mar 2008 18:02:51 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Ok I am trying to build interfaces using X Controls.
References: <47CC6061.6090707@redhat.com> <47CC6FF7.7010409@redhat.com>
In-Reply-To: <47CC6FF7.7010409@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Daniel J Walsh wrote:
>> What are these doing?  Why do I need these?
>>
>> type_transition $2_t default_xproperty_t:x_property
>> 	$2_default_xproperty_t;
>>
>> 	type_transition $2_t property_xevent_t:x_event $2_property_xevent_t;
>> 	type_transition $2_t focus_xevent_t:x_event $2_focus_xevent_t;
>> 	type_transition $2_t manage_xevent_t:x_event $2_manage_xevent_t;
>> 	type_transition $2_t default_xevent_t:x_event $2_default_xevent_t;
>>
> Looking at this further, I think these should be classes.
> 
> allow staff_t self:property_xevent_t send;
> 
> Have all xevent with the same class is similar to having  blk_file,
> chr_file, sock_file all class file and defining transitions.
> 

This makes sense, and it's something I considered, however I couldn't 
get the set of classes nailed down firmly enough to make a decision. 
The class structure was too rigid, in my opinion, to support this kind 
of categorization.

It's even worse with window properties, which are based on an open-ended 
namespace.  All kinds of zany conventions have been established 
regarding the use of this or that property, and who knows what other 
ones might come along.



>> I want to refer to all of the XClass via the main type.
>>
>> Lets take an example.
>>
>> I write policy for all X Apps that staff_t runs without a transition to
>> stay staff_t.
>>
>> Now I write a transition rule for staff_mozilla_t.
>>
>> So I want to say something like
>>
>> xserver_paste_pattern(staff_mozilla_t, staff_t)
>>
>> I would like to then write something like
>>
>> allow staff_mozilla_t staff_t:x_property read;
>>
>> But you make me write.
>>
>> allow staff_mozilla_t staff_default_x_property_t:x_property read;
>>
>> Which screws up the interface and I end up having to pass around staff
>> and staff_mozilla.
>>
>> Is this necessary?
>>
>> Is this legal?
>> 	type_transition $2_t input_xevent_t:x_event $2_t;
>>
>> Or is it even necessary?
>>
>> I really want to build an interface that says
>>
>> xserver_application(staff, staff_t)
>>
>> xserver_application(staff, staff_mozilla_t)
>>
>> Then define any interactions between staff_t and staff_mozilla_t via
>> simple interfaces.

If you're already passing (staff, staff_t) around then why not just pass 
the prefixes to your interaction function?

xserver_interact(staff, staff_t, staff_mozilla, staff_mozilla_t)

doesn't look that bad to me.

It's not my fault that we have all these complex constructions just to 
make sure everything has a "_t" on the end of it.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
