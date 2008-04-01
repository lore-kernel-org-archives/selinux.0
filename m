Message-ID: <47F18500.3030201@tycho.nsa.gov>
Date: Mon, 31 Mar 2008 20:42:40 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: copy&paste security_compute_av from python
References: <cadfc0e40803311235h3e3440fbn395dd55b8ab0e534@mail.gmail.com>
In-Reply-To: <cadfc0e40803311235h3e3440fbn395dd55b8ab0e534@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> I'm working on the code for the selection request where I've got the
> source context and the destination context and I've got to decide if I
> need to popup the downgrade dialog. The class for the
> security_compute_av call should probably be SECCLASS_PROPERTY, right?
> But what about the av bits?
>   

If we want to use a permission check in the selection manager 
application to decide whether to pop up the confirmation dialog, then I 
think we need a new security class to express the concept of "clipboard 
data".  The existing set of classes and permissions is oriented towards 
the low-level mechanics of the X selection mechanism: the individual 
property objects where data is written and the selection objects that 
are used for the IPC.  Neither of those really captures the notion of 
actually reading or writing the clipboard data itself.

This concept is already implemented in the X server; you can call 
SetSelectionCreateContext to set a context on the "data" when you take 
ownership of a selection, and the GetSelectionDataContext request 
returns this context for the current selection owner.  The server itself 
doesn't perform any checks on this data context at present.

But, is there a different way to decide whether the paste operation 
would be a downgrade?  Some type of context dominance call?

> Dan have you ever called security_compute_av from Python?
>
> Ted
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
