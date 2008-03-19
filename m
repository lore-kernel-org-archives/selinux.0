Subject: Re: selection labeling
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <47E01BF2.80200@tycho.nsa.gov>
References: <1205849784.16113.11.camel@gorn>  <47E01BF2.80200@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 19 Mar 2008 08:27:39 -0400
Message-Id: <1205929659.16113.31.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-03-18 at 15:45 -0400, Eamon Walsh wrote:
> Christopher J. PeBenito wrote:
> > I ran into an interesting denial:
> >
> > avc:  denied  { setattr setattr } for request=X11:SetSelectionOwner
> > comm=dbus-launch
> > selection=_DBUS_SESSION_BUS_SELECTION_root_3c39a16f05862d57c3d6ef0047356754
> > scontext=root:staff_r:staff_t
> > tcontext=system_u:object_r:xselection_t
> > tclass=x_selection
> >
> > Other than the double setattr in the permissions, trying to label this
> > selection for anything but the default doesn't seem possible.  It seems
> > that this should be type_transitioned, but it didn't seem to work.
> >   
> 
> Whoops, I know why the double setattr is there.  I'll get that fixed, 
> ignore that for now.
> 
> We probably need to have wildcarding in the X label support, like the 
> way filenames work.  Do you agree?

This is the role's session bus, not the system bus, so the preference
would be to have a type_transition so the selection would be
staff_dbus_xselection_t.  I don't see how we could get this behavior in
x_contexts except by putting in entries for all of the users, which
would be suboptimal.  Especially since in this case where I logged in as
root/staff_r; I could also log in as root/sysadm_r and then in that case
we have a problem since the label would be wrong in one of those cases.

> But I don't have a clue why D-BUS is creating selections with those 
> insane names.  It looks like abuse of the selection mechanism to me.  
> Selections are used for IPC, hence they're supposed to have fixed, 
> standard names.  Actually it doesn't make sense to me that D-BUS is 
> using selections at all.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
