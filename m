Subject: Re: [PATCH] selinux: new permission for chmod on suid or sgid files
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, sgrubb@redhat.com
In-Reply-To: <1224274196.19562.165.camel@moss-spartans.epoch.ncsc.mil>
References: <1224258034.3189.25.camel@paris-laptop>
	 <1224262355.19562.78.camel@moss-spartans.epoch.ncsc.mil>
	 <1224264294.19562.92.camel@moss-spartans.epoch.ncsc.mil>
	 <48F8DCE3.3000805@redhat.com>
	 <1224269637.19562.115.camel@moss-spartans.epoch.ncsc.mil>
	 <48F8E333.3060905@redhat.com>
	 <1224272365.19562.144.camel@moss-spartans.epoch.ncsc.mil>
	 <1224273875.3189.46.camel@paris-laptop>
	 <1224274196.19562.165.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 17 Oct 2008 16:38:37 -0400
Message-Id: <1224275917.3189.63.camel@paris-laptop>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-17 at 16:09 -0400, Stephen Smalley wrote:
> On Fri, 2008-10-17 at 16:04 -0400, Eric Paris wrote:

> > of the system normally controlled by dac.  This certainly doesn't lessen
> > the MAC confinement.  Lets assume an audited system in which we are
> > certain the only suid app untrusted users are allowed to run is ping.
> > So the users have the right to run suid apps.  They are protected from
> > each other by DAC.
> > 
> > Confined webadmin writes a program which is clears out other users
> > public_html when they get a spurious DMCA takedown notice.  He then
> > (because he is a lazy bumbling idiot) makes his script suid so he does
> > not have to go into his confined webadmin account constantly to delete
> > users webpages.
> 
> He could also make a daemon that runs under his uid and accepts commands
> via local socket.

I think this is our main point of contention.  I'm not making strong
claims about the uncircumventable nature of things.  But, you aren't
allowed to on one hand claim this is useless because policy is perfect
and on the other talk about how to circumvent this protection based on
what would have to be a terrible confinement of your webadmin.  I've yet
to see a confined admin that could do many useful things without having
some method to escape the confinement.  Just because it isn't perfect
doesn't mean it's useless or even a bad idea.

Anyway, I'm not arguing this is going to provide greater MAC confinement
and I'm not able to describe security goals in terms of MAC domains.
I'm merely stating that a SELinux confined admin is easily able change
DAC security policy as defined by an organization.  Yes, DAC sercurity
policy that I'm talking about is mathmatically provable and that's the
part that I'm sure you initially reject, but it doesn't make it
pointless or even detractive. 

> > Normal DAC protects user2 from being attacked by user1.  Because of the
> > bumbling incompetance of confined webadmin user1 can now use this setuid
> > app to do things which he is allow by selinux policy but denied by
> > normal DAC permissions.
> > 
> > Why did webadmin need to make a setuid app to begin with?  file caps are
> > already protected by CAP_SETFCAP.  Lets assume system policy says that
> > su should not be setuid.  Should the webadmin really be allowed to
> > easily override that system policy because he wants to use su - to get
> > to his confined domain instead of sudo?
> 
> He can't get to his confined domain via some other program unless policy
> says he can.  He can only get to some other uid that way.

Confined domain was the wrong word.  Absolutely.  Let me reword.
"should the webadmin really be allowed to easily override that system
policy because he wasnts to use su - to get to his admin account instead
of sudo" ??

Things like user seperation are the responsibility of DAC in the real
world.  Hardening DAC enforcement should be one of our goals.

> >   She bumbling idiot really be
> > allowed to say add o+x to su - when the system policy only really wanted
> > group wheel to be able to run su?  Should the bumbling idiot be able to
> > remove the suid flag from a program and not be able to fix it?
> > 
> > I think there are some real gains that can be made by limiting how
> > confined admins or untrusted users can deal with suid apps.
> > 
> > I'd probably be inclined to add changing the uid/gid/other things that
> > clear setuid to be things which require this permission.  I don't see a
> > reason to allow my webadmin to chown su to himself...
> 
> He can't do that unless he owns su (or that itself is subject to
> fowner).  And chown'ing or writing to a suid app clears the suid bit
> forcibly.

Obivously his 'web admin' job is going to require root access.  So he
would be perfectly capable of calling chown reguser:reguser /sbin/su.
(I'm not in this particular example discussing the usefullness of the
activity.)  And thats exactly my point.  chowning is going to clear the
suid.  Since suid is set I claim that clearing that bit is against the
DAC security policy and thus chown should be forbidden as well.  My
current patch doesn't do that but I said I'd be inclined to add it.

> Come on, guys, you can do better.

Come on, Stephen, exaplin why hardening systems against confined admins
being able to override DAC system security policies is a bad idea...

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
