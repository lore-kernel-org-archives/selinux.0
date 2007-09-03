Subject: Re: Time to remove compat_net?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
In-Reply-To: <200708301633.33632.paul.moore@hp.com>
References: <200708301607.42110.paul.moore@hp.com>
	 <1188504744.26572.361.camel@moss-spartans.epoch.ncsc.mil>
	 <200708301633.33632.paul.moore@hp.com>
Content-Type: text/plain
Date: Mon, 03 Sep 2007 11:02:26 -0400
Message-Id: <1188831746.2876.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-30 at 16:33 -0400, Paul Moore wrote:
> On Thursday, August 30 2007 4:12:24 pm Stephen Smalley wrote:
> > On Thu, 2007-08-30 at 16:07 -0400, Paul Moore wrote:
> > > Does anyone have any objections to placing the compat_net code on the
> > > kernel's "feature removal schedule" (I'd go for removal in 2/2008, six
> > > months from now)?  SECMARK can do everything that the older compat_net
> > > controls can do, and it does it with less overhead and a cleaner
> > > implementation.
> >
> > I'd be happy to see it go (conditional checks considered harmful), but a
> > good starting point would be to get secmark turned on in Fedora (it was
> > still off last I looked) and verify that nothing breaks.
> >
> > We also don't have any tools capable of managing secmark today; with the
> > legacy controls, we could labels ports and netifs via semanage.  Only
> > secmark userland integration to date has been the basic iptables command
> > line support.
> 
> Okay RedHat guys ... are there any plans to migrate semanage over to using the 
> SECMARK controls?

I have argued in the past that making semanage handle secmark is the
wrong approach. Basically - the whole point of using secmark is that you
get the full power of iptables. If we force updates through semanage
then you either a) recreate all of iptables in semanage or b) seriously
cripple the mechanism through a restricted interface.

>   If not, what do you need (besides patches to semanage) to 
> make the transition?
> 

What more do you mean other than setting compat_net to 0?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
