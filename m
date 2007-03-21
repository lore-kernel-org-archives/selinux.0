Subject: Re: [PATCH] refpolicy: experimental X policy -v2
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46018E64.2080704@tycho.nsa.gov>
References: <45B938EE.8010303@tycho.nsa.gov>
	 <cadfc0e40702131226y3cef4a81h626bcdb264c563ee@mail.gmail.com>
	 <45D2498C.3090902@tycho.nsa.gov> <1172602429.11157.48.camel@sgc>
	 <46005FD3.8020203@tycho.nsa.gov> <1174496088.30666.11.camel@sgc>
	 <46018E64.2080704@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 16:53:30 -0400
Message-Id: <1174510410.19924.23.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-21 at 15:58 -0400, Eamon Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Tue, 2007-03-20 at 18:27 -0400, Eamon Walsh wrote: 
> >> Christopher J. PeBenito wrote:
> >>> On Tue, 2007-02-13 at 18:28 -0500, Eamon Walsh wrote:
> >>>> This is an experimental policy for use with the X userspace object 
> >>>> manager.  It includes both unconfined and strict policy and is 
> >>>> controlled by a tunable, xwindows_object_manager.  The labeling conf 
> >>>> file in the X.org xserver git (XACE-SELINUX branch) assumes that this 
> >>>> policy is loaded, i.e. the types listed in that file are defined in this 
> >>>> policy.
> >>> Unfortunately I didn't get a chance to look at this until today.  It'll
> >>> take some time to fully understand all this, but I have some notes from
> >>> my initial review inline:
> >>>
> >>>>  modules/services/xwindows.fc |   13 +
> >>>>  modules/services/xwindows.if |  521 +++++++++++++++++++++++++++++++++++++++++++
> >>>>  modules/services/xwindows.te |   65 +++++
> >>> Eventually this should probably be merged into the xserver module.
> >>> Potentially in a tunable, when that support becomes available.  However,
> >>> for the purposes of vetting the design, a separate module is fine.
> >> I think it's important to distinguish between the policy that governs 
> >> the operation of the X server itself and the policy that governs X 
> >> applications.  Putting everything into xserver may blur that distinction.
> > 
> > These are common rules among X client programs that are tied to how the
> > enforcement of the X server works, which is why I think it belongs in
> > the xserver module.
> 
> Look at the example of the /dev/mem access denial.  This issue was 
> reported to me even though it's an X server issue, not an X application 
> issue.  If I were in charge of managing X application policy on some 
> installation, I wouldn't want the kernel policy for the X server jumbled 
> in with it.
> 
> Just like how we're separating userspace object manager Flask 
> definitions from the kernel ones.  In fact, I had originally created an 
> entire separate directory "userspace" to use instead of services/. 
> Reconsidered that, but still like the idea of separate modules.

I'm not saying that all the X object class rules are supposed to go in
xserver, just the common ones.  Consider dbus, it has a template that
other modules use for being client to a dbus, but the rules for sending
dbus messages to other domains follows the same refpolicy conventions as
kernel object classes, and thus are put in the relevant interface, eg
hal_dbus_send().  I think the distinction between server and
applications here is clear, and also I think its an analogue to the X
server (there is a system dbus and also user dbuses).

> >> I think a deeper question somewhat related to this is what the prefix on 
> >> the X server's domain should be.  In the policy as written I'm assuming 
> >> that the user domain prefix $2 and X server domain prefix $1 are 
> >> independent.  This is because 1) the xserver runs as xdm_xserver_t when 
> >> started from gdm but user_xserver_t when started by user with startx, 
> >> and
> > 
> > Well thats because with startx the user itself is starting up the
> > xserver, whereas with a display manager, you don't know the user until
> > after the xserver is already running.
> 
> Maybe gdm should restart the X server after the user has logged in, or 
> the xserver should change its own context.  Both programs already have 
> SELinux patches, adding this functionality could be done.

Yes, though I don't know the pros and cons, other than the latter option
would be a dyntransition.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
