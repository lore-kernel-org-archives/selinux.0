Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4V1eIOY029431
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 21:40:18 -0400
Message-ID: <4840AC80.4010109@tycho.nsa.gov>
Date: Fri, 30 May 2008 21:40:16 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>, Ted X Toth <txtoth@gmail.com>
Subject: Re: Here is my current diff on xserver policy.
References: <48406667.4030804@redhat.com>
In-Reply-To: <48406667.4030804@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> I threw away my XACe changes from my patch and decided to start again.
>
> Here is my current xserver patch
>
> I am looking at the X Server stuff and I have several questions about
> using this policy.
>
> First most X Apps will run under staff_t.
>
> Some will run in an equivalence class staff_java_t, staff_mono_t.
>
> These should have all the same access between each other
>
> staff_t == staff_java_t == staff_mono_t
>
> How do I do that with Xace policy interface.

1) Transition all the X objects created by those domains into the same 
type, or
2) Assign a common attribute to those domains, and somehow split up 
xserver_common_x_domain_template() so you can issue the allow rules once 
for the attribute.

Every object in X is labeled either through a type transition or from a 
name in the x_contexts file.

The root window and certain other objects, such as the default colormap, 
are labeled in a type transition from the server's domain.  Chris has 
these objects going to $1_rootwindow_t.  All other new windows are 
labeled in a type transition with the creating domain as the subject and 
the parent window as the related object.

Events are first labeled from the x_contexts file; for example a 
ButtonPress event would be labeled input_xevent_t.  However, each event 
is then relabeled in a type transition with the type of the window 
(where it is being delivered) as the subject and the previous type as 
the related object.  This is where the "user_input_xevent_t" types come 
from.

Window properties are first labeled from the x_contexts file, then 
relabeled in a transition with the domain creating them as the subject 
and the previous type as the related object.  This is where the 
"user_foo_xproperty_t" types come from.

I could go on but my documentation will have all of this in it.


>
> I have staff_mozilla_t, and staff_nsplugin_t what interface to I add to
> these to allow them to work with staff_t defined above?

Don't think such an interface exists, presently.

> How about if I
> want to stop nsplugin from reading the cut buffer of staff_t?  

I'm assuming you mean "I want to prevent nsplugin from accessing data 
that a staff_t application has exposed on the clipboard."

Several options here:

1) Deny nsplugin "read" access on the PRIMARY, SECONDARY, and CLIPBOARD 
selections.  These selections are labeled by name (selabel) from the 
x_contexts file, currently "clipboard_xselection_t".  In this case any 
nsplugin that calls ConvertSelection() will cause a denial and a 
BadAccess X protocol error will be sent back, which will probably abort 
the plugin, and firefox.  I kind of doubt this is what you want, as 
people do paste things into nsplugins (I'm picturing someone pasting a 
filename into some Adobe Acrobat dialog box).

3) Use an active selection manager, such as the one that Ted Toth is 
working on.  This program seizes ownership of the clipboard whenever it 
changes, so it can intercept paste requests and pop up a confirmation 
dialog or deny the request.

2) Set up selection polyinstantiation, separating staff_t from nsplugin 
using a type_member rule.  In this case nsplugin will have its own 
selection instances, and will not be able to see staff_t pastes.  To 
support pasting, you will need a selection manager that "see" across the 
polyinstantiation (using special XSELinux extension requests).



> I also
> want to stop nsplugin from sniffing the keyboard  (xspy), and doing any
> screen capture.

Deny "read" access on x_device, and deny "read" access on non-nsplugin 
x_drawable objects (including the root window).

The "read" access on devices is a problem because of common usage by 
applications of requests that require this privilege, such as 
XQueryPointer.  I am working with upstream to try and come up with new 
semantics for these requests that will prevent input from leaking 
between X clients.

>
> When I sudo to root, I use unconfined_t.  It starts X Apps up like
> system-config-selinux.  How do I define the interactions between this X
> Client and my staff_* windows?

The unconfined_t windows are labeled in a type_transition from the root 
window as described above.
The window manager will need permissions over the unconfined_t window 
objects.  This does not mean the window manager needs to run as 
unconfined itself.
The type of the x_device objects (treated as a subject when input events 
are being posted) will need to have permission to send input events to 
the unconfined_t windows.

Any other interactions are the result of nosing around by other 
applications.  For example, I have observed gnome-screensaver register 
for input events on _every_ window on the entire screen.  Other 
applications might call XQueryTree on the entire window hierarchy (the 
equivalent of "find / -print").  These behaviors will cause denials; the 
only solution is to fix the applications. 


>
> My xserver runs as xdm_xserver_t but the current interfaces look like
> they expect it to be labeled staff_xserver_t?

You'll have to ask Chris about this.  My understanding is that 
xdm_xserver_t is supported as a "special case."  I'm anxious to collapse 
these down to one type through rbac separation, fixing X server launch 
via GDM, or otherwise.

>
> Last time I went through this exercise I ended up with a maze of twisty
> little passages.
>
> I don't think that anything I asked above is all that complicated but I
> believe getting the policy correct will be difficult.

The stuff I wrote isn't the be-all and end-all, so feel free to start 
from scratch.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
