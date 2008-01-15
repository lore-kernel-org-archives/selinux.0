Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0FMlFZ2027325
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2008 17:47:15 -0500
Message-ID: <478D37F2.6030906@tycho.nsa.gov>
Date: Tue, 15 Jan 2008 17:47:14 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: X avcs
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>	 <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com>	 <47754FCB.1070307@tycho.nsa.gov>	 <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com>	 <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com>	 <477BEFF1.2090507@sun.com> <47867FCA.50408@tycho.nsa.gov> <cadfc0e40801141214ldceac3ftef8a28a71c3fd9f4@mail.gmail.com>
In-Reply-To: <cadfc0e40801141214ldceac3ftef8a28a71c3fd9f4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> On Jan 10, 2008 2:27 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>   
>> Glenn Faden wrote:
>>     
>>> This is my first posting to this alias, so let me start by introducing
>>> myself. I'm a Distinguished Engineer in the Solaris security
>>> organization, and I'm the original architect for Sun's multilevel X11
>>> server. I have worked on this problem since 1990, and have designed
>>> three multilevel desktops (Open Look, CDE, and GNOME)
>>>
>>> One of the biggest challenges in adding fine-grained policy to the X11
>>> server is to make the policy transparent to existing X11 clients.
>>> Probably the most critical design decision we made was with respect to
>>> root window resources. By default, all root window properties are
>>> polyinstantiated by both label and uid. For SELinux, the equivalent
>>> policy would be polyinstantiation by security context (not just MLS
>>> label). An exception list of single-instance root-window properties is
>>> enumerated in a policy file.
>>> We have found that the list of exceptions is much smaller than the list
>>> that should be polyinstantiated.
>>>
>>>       
>> Hello.  I am not opposed to the idea of polyinstantiated properties.
>> Although our approach has always been to attempt to fix applications to
>> work within the secure environment first, it looks like this is a case
>> where polyinstantiated is needed.
>>
>> My first thought on the implementation is that a value-return parameter
>> could be added to the PROPERTY_ACCESS hook so that security modules can
>> return the actual PropertyPtr object they wish to be used.  The
>> FindProperty function would then have to be upgraded to a general lookup
>> function similar to dixLookupResource(), dixLookupDrawable(), etc. and
>> the property code would have to be refactored to use it everywhere when
>> looking up a property.  The semantics of the various property requests,
>> in particular RotateProperties, might make this a little more difficult.
>>
>>     
>
> Yep, rotate, list, anything that traverses the property list, is a
> problem. It seems like it would be better to have a property list per
> context. How about a dixLookupProperties function on window that would
> return a linked list (PropertyPtr) of properties that it gets from an
> xace hook call?
>   

It would be a lot of work for security modules to put this list 
together.  I think it would be best to just use the singular 
dixLookupProperty() and modify the list traversal code to use it.  The 
awkward case is ProcListProperty where the lookup function would have to 
be called, and if it returns BadValue that can mean "this PropertyPtr 
doesn't really exist, move along."  But the rotate code already uses 
FindProperty and I think the other cases can be handled without any 
difficulties.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
