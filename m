Date: Wed, 02 Jan 2008 12:11:29 -0800
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: X avcs
In-reply-to: <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Message-id: <477BEFF1.2090507@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
 <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com>
 <47754FCB.1070307@tycho.nsa.gov>
 <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com>
 <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is my first posting to this alias, so let me start by introducing 
myself. I'm a Distinguished Engineer in the Solaris security 
organization, and I'm the original architect for Sun's multilevel X11 
server. I have worked on this problem since 1990, and have designed 
three multilevel desktops (Open Look, CDE, and GNOME)

One of the biggest challenges in adding fine-grained policy to the X11 
server is to make the policy transparent to existing X11 clients. 
Probably the most critical design decision we made was with respect to 
root window resources. By default, all root window properties are 
polyinstantiated by both label and uid. For SELinux, the equivalent 
policy would be polyinstantiation by security context (not just MLS 
label). An exception list of single-instance root-window properties is 
enumerated in a policy file.
We have found that the list of exceptions is much smaller than the list 
that should be polyinstantiated.

With respect to the root window drawable, it is protected at the lowest 
label, so it is never modified. Applications like Nautilus are 
polyinstantiated, too, and render their own background windows.

Our implementation is all open-sourced using the Xorg license. A summary 
of the X11 security policy implemented by Solaris Trusted Extensions is 
described in Chapter 6 of the Developer's Guide,  
http://docs.sun.com/app/docs/doc/819-0869/6n391u3ru?a=view

The configuration file for the polyinstantiation policy is described in 
the TrustedExtensionsPolicy man page, 
http://docs.sun.com/app/docs/doc/819-7307/trustedextensionspolicy-4?a=view

The source code which implements this policy can be viewed in the 
OpenSolaris browser using this link:
http://src.opensolaris.org/source/xref/fox/fox-gate/XW_NV/open-src/xserver/xorg/sun-src/tsol/

The hooks to the XACE extension layer (also used by SELinux) are in the 
file tsolCompat.c, which can be viewed here:
http://src.opensolaris.org/source/xref/fox/fox-gate/XW_NV/open-src/xserver/xorg/sun-src/Xext/tsolCompat.c

Although Trusted Extensions and SELinux have significant differences 
with respect to their security models, both systems attempt to implement 
MAC policy in a manner that is transparent to applications. This should 
apply to the desktop, as well. In general, the user experience running 
GNOME on Solaris (with or without Trusted Extensions) or on Linux (with 
or without SELinux) should be almost identical. So the underlying 
policies enforced by the X11 server should follow the same general 
principles.

--Glenn


Xavier Toth wrote:
> Ok that helped the issue with the notification-daemon. Now I'm looking
> at some avcs generated while running one of our apps and have some
> more questions. I first ran QBrowser at CONFIDENTIAL(s2:c0.c253) then
> later ran it at TS(s4:c0.c253). CUT_BUFFER0 and _MOTIF_DRAG_TARGETS
> got created at CONFIDENTIAL and then the TS instance of the app tried
> to use them, do we need polyinstantiated properties? Or maybe the type
> should change on write.
>
> avc:  denied  { write } for request=X11:ChangeProperty
> comm=/opt/jcdx/bin/QBrowser property=CUT_BUFFER0
> scontext=swo_u:user_r:user_t:s4:c0.c253
> tcontext=swo_u:object_r:clipboard_xproperty_t:s2:c0.c253
> tclass=x_property
> avc:  denied  { write } for request=X11:ChangeProperty
> comm=/opt/jcdx/bin/QBrowser property=_MOTIF_DRAG_TARGETS
> scontext=swo_u:user_r:user_t:s4:c0.c253
> tcontext=swo_u:object_r:user_default_xproperty_t:s2:c0.c253
> tclass=x_property
>
> Why are the root window drawable and root color map s0?
>
> avc:  denied  { send } for request=X11:SendEvent
> comm=/opt/jcdx/bin/QBrowser resid=76 restype=WINDOW
> scontext=swo_u:user_r:user_t:s4:c0.c253
> tcontext=system_u:object_r:x_rootwindow_t:s0 tclass=x_drawable
> avc:  denied  { remove_color } for request=X11:FreeColors
> comm=/opt/jcdx/bin/QBrowser resid=20 restype=COLORMAP
> scontext=swo_u:user_r:user_t:s4:c0.c253
> tcontext=system_u:object_r:x_rootcolormap_t:s0 tclass=x_colormap
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
