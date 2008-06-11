Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BLlvSW003923
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 17:47:57 -0400
Message-ID: <4850480C.1040406@tycho.nsa.gov>
Date: Wed, 11 Jun 2008 17:47:56 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Ted X Toth <txtoth@gmail.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: X in MLS enforcing problem
References: <cadfc0e40806091430j7d4734c6l7af3cfbce395eeae@mail.gmail.com>	 <D709A20F2164C84E8B7014B0301F5EF8012E7F32@HAVOC.tcs-sec.com> <cadfc0e40806091535k1929bbc8gd4eebefb4b6069ff@mail.gmail.com> <484DC4D2.7050201@tycho.nsa.gov> <484FD7A5.5070806@gmail.com>
In-Reply-To: <484FD7A5.5070806@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ted X Toth wrote:
> If I were to do this I'd use either SetSelectionCreateContext or 
> SetSelectionUseContext, could you explain the difference between them 
> and which I should use?
>   
>

SetSelectionCreateContext is for setting the context on the clipboard 
_data_.  This is how an SELinux-aware application could specify what 
type of data the user has made available for pasting.  The 
"x_application_data" security class represents the "object" labeled by 
this context, and the selection manager is responsible for checking 
permission on it.  The X server doesn't perform any checks on this 
context.  See earlier message [1].

SetSelectionUseContext is for setting the context of the selection 
object itself.  It was intended to be used by a selection manager that 
supports polyinstantiation.  It sets the context of the selection object 
that the client wants to "use".  So for example if there are three 
PRIMARY selections labeled foo_t, bar_t, and baz_t the selection manager 
can choose the one to operate on using SetSelectionUseContext.

In the non-polyinstantiated case, SetSelectionUseContext can be used to 
override the value from x_contexts and set the label on the one object 
that will be seen by everyone (which is what we want to do with 
dbus_launch).  This only works if the selection doesn't already exist 
because there's currently no way to change the label on an existing object.

So in summary:

Clipboard data - x_application_data object class
SetSelectionCreateContext / GetSelectionDataContext
checked by selection manager

Clipboard object - x_selection object class
SetSelectionUseContext / GetSelectionContext
checked by X server


One more note: the clipboard data context currently defaults to the 
selection's context (e.g. clipboard_xselection_t), but I think it might 
be more logical to default it to the client program's context (user_t).  
This would require a change to the X server.

[1] http://marc.info/?l=selinux&m=120701081703490&w=2

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
