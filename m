Subject: Re: [RFC] SELinux: use SECINITSID_NETMSG instead of
	SECINITSID_UNLABELED for NetLabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Joshua Brindle <method@manicmethod.com>, dwalsh@redhat.com
In-Reply-To: <200703201734.18351.paul.moore@hp.com>
References: <20070314025023.115872483@hp.com>
	 <200703201358.05890.paul.moore@hp.com>
	 <1174416211.22565.286.camel@moss-spartans.epoch.ncsc.mil>
	 <200703201734.18351.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 08:20:35 -0400
Message-Id: <1174479635.22565.353.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-20 at 17:34 -0400, Paul Moore wrote:
> On Tuesday 20 March 2007 2:43:31 pm Stephen Smalley wrote:
> > On Tue, 2007-03-20 at 13:58 -0400, Paul Moore wrote:
> > > Yes, while it is both simple and tempting I don't see that solution as
> > > viable since it requires encoding meaning into the MLS sensitivity
> > > labels.  I understand that in certain other MLS implementations specific
> > > sensitivity labels have been given "special" meaning but I think doing so
> > > in an implementation as flexible as SELinux is a mistake.
> >
> > I wasn't actually suggesting any special or fixed meaning for a
> > particular label value in the code, just assigning the unlabeled SID a
> > level that dominates all of the levels that are legitimate for the
> > system in policy (which is actually what current policy does - unlabeled
> > sid is mapped to mls_systemhigh definition in refpolicy), and then using
> > the ordinary MLS logic to ensure that packets with such a level cannot
> > be received without network MLS overrides.  Then any non-MLS-privileged
> > application would be denied access to such "unlabeled" packets, vs. the
> > netlabel'd packets that would have a MLS value < systemhigh.
> 
> I think by creating a sensitivity label that dominates every other label on 
> the system, i.e. SystemHigh, and then restricting that label from being used 
> by the network does in fact grant some special meaning to that label.  
> Perhaps I'm using the wrong terminology but the point I am trying to make is 
> that I would prefer to see NetLabel have the ability to support every 
> sensitivity label on the system (granted some protocols may impose their own 
> restrictions but others do not).

Same issue arises for unlabeled filesystems or any other unlabeled
object, and that is why the unlabeled initial SID has the systemhigh
level - to prevent reading by untrusted processes since it may contain
data at any level.  Although in the unlabeled filesystem case, you can
use a context mount to map the entire filesystem to a given level.

> > So what is your goal?  Do you want to allow
> > non-netlabel'd packets under MLS (problematic then to use unlabeled SID
> > as the basis) or deny it?
> 
> My goal is to have the ability to specify, in SELinux policy on a per-domain 
> basis, access controls for both NetLabel'd and non-NetLabel'd traffic.  Right 
> now you can only specify access for NetLabel'd traffic using SELinux policy, 
> restricting non-NetLabel'd traffic must be done outside of the SELinux policy 
> on a system wide scale:
> 
>  # netlabelctl unlbl allow on|off

Always applying the permission check would allow such control, but the
the issue is that if you use the unlabeled initial SID for the
non-netlabel'd traffic, then the only way to allow a process to receive
the packets would be to give its domain MLS networking overrides, and at
that point, it could receive not only non-netlabel'd traffic but also
netlabel'd traffic with a higher level if you allow it to receive any
netlabel'd traffic at all.  Which limits you to one of (receive all
non-netlabel'd traffic, receive netlabel'd traffic that I dominate, or
receive all traffic even if it dominates my level) as your per-domain
options.  Is that sufficient?

It also seems that you might want the ability to distinguish among
different kinds of non-netlabel'd traffic based on receiving network
interface, so you could map some of that traffic to one level and some
of it to another level (which is actually closer in concept to the
netmsg sids, as they can be configured per netif in policy, although
nothing is using that support currently - legacy of when we were using
it as the default packet label for incoming traffic on a network
interface).

So an alternative would be to use the netmsg SID (or even the per-netif
netmsg SIDs obtained via sel_netif_sids(), specified in netifcon
statements in policy, should be supported by libsemanage/libsepol but
not in the current semanage interface) for the non-netlabel'd traffic
rather than the other way around.  Then you aren't forced to having
SystemHigh on that traffic, and can even support per-NIC levels in the
future.  Although that will yield the amusing situation that your
netlabel'd traffic will still have unlabeled_t and your non-netlabel'd
traffic will have some other type.

> [I'm not ignoring you compatibility comments, I'm just trying to focus the 
> discussion a bit until we resolve the core issue]

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
