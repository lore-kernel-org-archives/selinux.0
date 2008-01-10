Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0AKRvNP018614
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2008 15:27:57 -0500
Message-ID: <47867FCA.50408@tycho.nsa.gov>
Date: Thu, 10 Jan 2008 15:27:54 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Glenn Faden <Glenn.Faden@sun.com>
CC: Xavier Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: X avcs
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com> <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com> <47754FCB.1070307@tycho.nsa.gov> <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com> <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com> <477BEFF1.2090507@sun.com>
In-Reply-To: <477BEFF1.2090507@sun.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Glenn Faden wrote:
> This is my first posting to this alias, so let me start by introducing 
> myself. I'm a Distinguished Engineer in the Solaris security 
> organization, and I'm the original architect for Sun's multilevel X11 
> server. I have worked on this problem since 1990, and have designed 
> three multilevel desktops (Open Look, CDE, and GNOME)
>
> One of the biggest challenges in adding fine-grained policy to the X11 
> server is to make the policy transparent to existing X11 clients. 
> Probably the most critical design decision we made was with respect to 
> root window resources. By default, all root window properties are 
> polyinstantiated by both label and uid. For SELinux, the equivalent 
> policy would be polyinstantiation by security context (not just MLS 
> label). An exception list of single-instance root-window properties is 
> enumerated in a policy file.
> We have found that the list of exceptions is much smaller than the list 
> that should be polyinstantiated.
>   

Hello.  I am not opposed to the idea of polyinstantiated properties.  
Although our approach has always been to attempt to fix applications to 
work within the secure environment first, it looks like this is a case 
where polyinstantiated is needed.

My first thought on the implementation is that a value-return parameter 
could be added to the PROPERTY_ACCESS hook so that security modules can 
return the actual PropertyPtr object they wish to be used.  The 
FindProperty function would then have to be upgraded to a general lookup 
function similar to dixLookupResource(), dixLookupDrawable(), etc. and 
the property code would have to be refactored to use it everywhere when 
looking up a property.  The semantics of the various property requests, 
in particular RotateProperties, might make this a little more difficult.

SELinux has a security_compute_member() interface that is intended to 
return the security context of the appropriate object for use, and this 
can be used to determine which object to return.

> With respect to the root window drawable, it is protected at the lowest 
> label, so it is never modified. Applications like Nautilus are 
> polyinstantiated, too, and render their own background windows.
>
> Our implementation is all open-sourced using the Xorg license. A summary 
> of the X11 security policy implemented by Solaris Trusted Extensions is 
> described in Chapter 6 of the Developer's Guide,  
> http://docs.sun.com/app/docs/doc/819-0869/6n391u3ru?a=view
>
> The configuration file for the polyinstantiation policy is described in 
> the TrustedExtensionsPolicy man page, 
> http://docs.sun.com/app/docs/doc/819-7307/trustedextensionspolicy-4?a=view
>
> The source code which implements this policy can be viewed in the 
> OpenSolaris browser using this link:
> http://src.opensolaris.org/source/xref/fox/fox-gate/XW_NV/open-src/xserver/xorg/sun-src/tsol/
>
> The hooks to the XACE extension layer (also used by SELinux) are in the 
> file tsolCompat.c, which can be viewed here:
> http://src.opensolaris.org/source/xref/fox/fox-gate/XW_NV/open-src/xserver/xorg/sun-src/Xext/tsolCompat.c
>
> Although Trusted Extensions and SELinux have significant differences 
> with respect to their security models, both systems attempt to implement 
> MAC policy in a manner that is transparent to applications. This should 
> apply to the desktop, as well. In general, the user experience running 
> GNOME on Solaris (with or without Trusted Extensions) or on Linux (with 
> or without SELinux) should be almost identical. So the underlying 
> policies enforced by the X11 server should follow the same general 
> principles.
>   

Our long-term goal is to make applications aware of and responsive to 
the security environment, particularly applications that could 
themselves be multi-level such as e-mail, web, office.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
