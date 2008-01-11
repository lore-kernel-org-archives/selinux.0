Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0BN4G4a019489
	for <selinux@tycho.nsa.gov>; Fri, 11 Jan 2008 18:04:16 -0500
Message-ID: <4787F5EE.1090800@tycho.nsa.gov>
Date: Fri, 11 Jan 2008 18:04:14 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Ted X Toth <txtoth@gmail.com>
CC: Glenn Faden <Glenn.Faden@sun.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: X avcs
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com> <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com> <47754FCB.1070307@tycho.nsa.gov> <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com> <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com> <477BEFF1.2090507@sun.com> <47867FCA.50408@tycho.nsa.gov> <47878130.5010000@gmail.com>
In-Reply-To: <47878130.5010000@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ted X Toth wrote:
> I'll look at implementing a dixPropertyLookup function. Do any other 
> XACE hooks have value-return parameters, would it just be va_arg(ap, 
> PropertyPtr*)?
>   

No and yes, respectively.

> What about the idea of an exception list of single-instance root-window 
> properties?
>   

I'm examining the type_member policy statement to determine how we can 
use it to provide this information.  type_member was intented to support 
polyinstantiation but it's mls semantics have not been defined yet.



>   
>>> With respect to the root window drawable, it is protected at the 
>>> lowest label, so it is never modified. Applications like Nautilus are 
>>> polyinstantiated, too, and render their own background windows.
>>>
>>> Our implementation is all open-sourced using the Xorg license. A 
>>> summary of the X11 security policy implemented by Solaris Trusted 
>>> Extensions is described in Chapter 6 of the Developer's Guide,  
>>> http://docs.sun.com/app/docs/doc/819-0869/6n391u3ru?a=view
>>>
>>> The configuration file for the polyinstantiation policy is described 
>>> in the TrustedExtensionsPolicy man page, 
>>> http://docs.sun.com/app/docs/doc/819-7307/trustedextensionspolicy-4?a=view 
>>>
>>>
>>> The source code which implements this policy can be viewed in the 
>>> OpenSolaris browser using this link:
>>> http://src.opensolaris.org/source/xref/fox/fox-gate/XW_NV/open-src/xserver/xorg/sun-src/tsol/ 
>>>
>>>
>>> The hooks to the XACE extension layer (also used by SELinux) are in 
>>> the file tsolCompat.c, which can be viewed here:
>>> http://src.opensolaris.org/source/xref/fox/fox-gate/XW_NV/open-src/xserver/xorg/sun-src/Xext/tsolCompat.c 
>>>
>>>
>>> Although Trusted Extensions and SELinux have significant differences 
>>> with respect to their security models, both systems attempt to 
>>> implement MAC policy in a manner that is transparent to applications. 
>>> This should apply to the desktop, as well. In general, the user 
>>> experience running GNOME on Solaris (with or without Trusted 
>>> Extensions) or on Linux (with or without SELinux) should be almost 
>>> identical. So the underlying policies enforced by the X11 server 
>>> should follow the same general principles.
>>>   
>>>       
>> Our long-term goal is to make applications aware of and responsive to 
>> the security environment, particularly applications that could 
>> themselves be multi-level such as e-mail, web, office.
>>
>>     
>
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
