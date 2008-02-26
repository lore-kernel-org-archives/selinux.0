Subject: Re: [PATCH][RFC] Unify printk messgaes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@redhat.com>
In-Reply-To: <1204038485.32061.183.camel@gorn>
References: <Xine.LNX.4.64.0802262049370.10387@us.intercode.com.au>
	 <1204029408.2804.257.camel@moss-spartans.epoch.ncsc.mil>
	 <1204038485.32061.183.camel@gorn>
Content-Type: text/plain
Date: Tue, 26 Feb 2008 12:23:39 -0500
Message-Id: <1204046619.2804.307.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-26 at 10:08 -0500, Christopher J. PeBenito wrote:
> On Tue, 2008-02-26 at 07:36 -0500, Stephen Smalley wrote:
> > On Tue, 2008-02-26 at 20:53 +1100, James Morris wrote:
> > > I noticed that we had a mix of "SELinux:" and "security:" prefixes in our 
> > > kernel boot messages, so I've unified these to "SELinux:" with the patch 
> > > below to reduce user confusion.  (It doesn't try and fix every printk, 
> > > just the ones with "security:").
> > > 
> > > Also simplified the avtab hash message, from:
> > > 
> > >   SELinux:8192 avtab hash slots allocated. Num of rules:163922
> > > 
> > > to
> > > 
> > >   SELinux: 8192 avtab hash slots, 163922 rules.
> > > 
> > > 
> > > Comments?
> > 
> > Makes sense from a user perspective - reflects further nativization of
> > the Flask code for the Linux implementation, but will yield a difference
> > in output between SELinux and e.g. SEBSD.  Only question I have is
> > whether any userspace tools are looking for the security: prefix today.
> 
> Seaudit/libseaudit does look for the security prefix so that it can
> report that there is a policy load, for example.  Since the patch just
> changes "security" into "SELinux", it shouldn't be much of a problem for
> updating libseaudit's parser.

I'd suggest switching over to looking for the MAC_STATUS audit messages
instead.  Of course, that only works for newer kernels/distros (e.g.
RHEL5, but not RHEL4).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
