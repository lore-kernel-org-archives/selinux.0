Message-ID: <4B042666.1020805@tycho.nsa.gov>
Date: Wed, 18 Nov 2009 11:52:54 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Bill Chimiak <wch1m1@gmail.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: WIndow Managers
References: <200911181108.37883.w.chimiak@ieee.org>
In-Reply-To: <200911181108.37883.w.chimiak@ieee.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/18/2009 11:08 AM, Bill Chimiak wrote:
> If one is trying to move closer to strict mode for their system,
> Does it matter if one uses gnome as the window manager,  KDE,
> or TWM (realizing that window managers make locking systems
> down very difficult)?
>
> I notice there is the xace project and the online video presentation
> of the Plumber's conference was helpful - but that seems gnome-centric,
> unless I misinterpet something.
>
> Thanks in advance.
>
>   

The policy I showed at Plumber's had a window manager that was
unconfined on X, and I think this pretty much required, as the window
manager needs to touch everything on the display to manage it. 

Given this, if you are building a secure system and you have a choice of
WM, choosing a basic bare-bones one would minimize the chance of
vulnerability in the WM.  Certainly the desktop seems to be moving
towards a monolithic all-powerful manager application (e.g. gnome-shell)
which may be problematic going forward.

One thing you want to avoid with the WM is the ability to run programs
from it (such as through a context menu) because those programs then run
in the WM's context unless you take some policy action.  I note that TWM
does allow this.

The WM in the demo was compiz, which is a good choice because it doesn't
try to do anything except manage windows.

Hope this helps.


-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
