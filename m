Subject: Re: [PATCH] refpolicy: Add GConf policy
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1159799274.14831.29.camel@sgc>
References: <1159295299.18973.74.camel@moss-lions.epoch.ncsc.mil>
	 <1159455168.2850.19.camel@sgc.columbia.tresys.com>
	 <1159472462.3439.73.camel@moss-lions.epoch.ncsc.mil>
	 <1159474882.2850.74.camel@sgc.columbia.tresys.com>
	 <1159536230.11477.27.camel@moss-lions.epoch.ncsc.mil>
	 <1159799274.14831.29.camel@sgc>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 10:30:55 -0400
Message-Id: <1159799455.3048.5.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-02 at 10:27 -0400, Christopher J. PeBenito wrote:
> On Fri, 2006-09-29 at 09:23 -0400, James Carter wrote:
> > On Thu, 2006-09-28 at 16:21 -0400, Christopher J. PeBenito wrote:
> > > On Thu, 2006-09-28 at 15:41 -0400, James Carter wrote:
> > > >   After finishing up GConf, I'll be looking at window
> > > > managers.
> > > > 
> > > > I think that you can make a case for putting GConf in a gnome policy
> > > > since it is not being used by any other desktop. It really doesn't
> > > > matter too much to me.  It does seem, however, like a gnome policy could
> > > > become quite large.  I guess I imagined policy for a particular desktop
> > > > eventually being kept in a separate policy directory like
> > > > policy/modules/desktops/gnome to keep it organized together, but still
> > > > consisting of many smaller modules.  
> > > > 
> > > > What do you think would be part of the gnome policy?
> > > 
> > > Core pieces that are common to all gnome systems, like gnome-vfs,
> > > bonobo, orbit, etc.  Other things such as nautilus could go in their own
> > > modules.  That is, assuming any of these need policies.
> > > 
> > That makes sense.
> 
> I did some more investigating because I didn't want to add a gconf
> module and then later find out a gnome module is needed, or add a gnome
> module and then later find out it isn't needed.  It looks like
> gnome-pty-helper is a good policy to add, since it updates lastlog and
> wtmp, and was around long before the overengineered pieces were added.
> So if we have two pieces of Gnome, then gconf can be made a part of a
> gnome module.  Seem reasonable (I can do the g-p-h part)?
> 
Yes, it does.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
