Subject: Re: SE-DBUS policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Colin Walters <walters@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <471E1387.40100@redhat.com>
References: <1193143580.9466.47.camel@gorn>
	 <1193145875.2179.21.camel@moss-spartans.epoch.ncsc.mil>
	 <471E1387.40100@redhat.com>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 17:15:10 +0000
Message-Id: <1193159710.9466.86.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-23 at 11:30 -0400, Colin Walters wrote:
> Stephen Smalley wrote:
> > On Tue, 2007-10-23 at 12:46 +0000, Christopher J. PeBenito wrote:
> >   
> >> Is there any documentation on the SELinux behavior on dbus?  From some
> >> discussion in the IRC channel, the policy templates (which is still
> >> basically the NSA example policy stuff) don't match the code.
> >>
> >> The templates creates a type:
> >>
> >> type [connector domain prefix]_dbusd_[bus owner prefix]_t;
> >>
> >> so if you have staff_r's connection to the system bus, you get
> >> staff_dbusd_system_t.  Then there is a type_change so dbus knows what
> >> label to give the connection:
> >>
> >> type_change [domain] [bus owner prefix]_dbusd_t:dbus [connector type];
> >>
> >> which results in something like this:
> >>
> >> type user_mozilla_dbusd_system_t;
> >> type_change user_mozilla_t system_dbusd_t:dbus user_mozilla_dbusd_system_t;
> >>
> >> Then based on the template, I believe the premise was that the dbus
> >> permissions would be between these derived types.  However, in the
> >> policy there are no dbus:send_msg rules for these types (except for the
> >> ones given in the templates), and instead rules are against the real
> >> domains, (e.g. allow NetworkManager_t dhcpd_t:dbus send_msg;).  So I
> >> looked in the dbus code, and I didn't see any calls to
> >> security_compute_relabel().  It looks like this bit of policy is dead,
> >> and the templates need to be revised.
> >>     
> >
> > Hmm...I see a post by Colin Walters back in Oct 2004 to add such logic
> > to dbusd along with the corresponding policy patches, but no evidence
> > that the code was ever merged.  I also see at least one other patch from
> > Colin that added further dbus permissions, again with no evidence that
> > it was ever merged.
> >
> > As far as I know, the dbus-daemon man page is the best documentation on
> > the SELinux behavior in dbus - it has a description of the configuration
> > for dbus contexts as well as the checks applied by SELinux.  Hopefully
> > it is still up to date.
> >
> >   
> I vaguely recall that at the time I was prototyping things out, and 
> seeing what interest there was in the patches.  It could probably be 
> revived if there was sufficient interest; we should step through the use 
> cases for them.  The current :dbus object class is coarse but you can do 
> quite a bit with it.

I think it boils down to if we want to be able to enforce over which bus
the message is sent.  Since the type of the bus is encoded in the types
you could say something like

allow staff_mozilla_dbusd_staff_t staff_dbusd_staff_t:dbus send_msg;

which says staff's mozilla can only send to the user domain over staff's
dbus.  With the direct domain to domain (what we have right now) it says
nothing about which bus the message goes over.

That being said, I'm not sure that it matters which bus a message goes
over.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
