From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] SELinux: use SECINITSID_NETMSG instead of SECINITSID_UNLABELED for NetLabel
Date: Tue, 20 Mar 2007 17:34:18 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Joshua Brindle <method@manicmethod.com>, dwalsh@redhat.com
References: <20070314025023.115872483@hp.com> <200703201358.05890.paul.moore@hp.com> <1174416211.22565.286.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1174416211.22565.286.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703201734.18351.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 20 March 2007 2:43:31 pm Stephen Smalley wrote:
> On Tue, 2007-03-20 at 13:58 -0400, Paul Moore wrote:
> > Yes, while it is both simple and tempting I don't see that solution as
> > viable since it requires encoding meaning into the MLS sensitivity
> > labels.  I understand that in certain other MLS implementations specific
> > sensitivity labels have been given "special" meaning but I think doing so
> > in an implementation as flexible as SELinux is a mistake.
>
> I wasn't actually suggesting any special or fixed meaning for a
> particular label value in the code, just assigning the unlabeled SID a
> level that dominates all of the levels that are legitimate for the
> system in policy (which is actually what current policy does - unlabeled
> sid is mapped to mls_systemhigh definition in refpolicy), and then using
> the ordinary MLS logic to ensure that packets with such a level cannot
> be received without network MLS overrides.  Then any non-MLS-privileged
> application would be denied access to such "unlabeled" packets, vs. the
> netlabel'd packets that would have a MLS value < systemhigh.

I think by creating a sensitivity label that dominates every other label on 
the system, i.e. SystemHigh, and then restricting that label from being used 
by the network does in fact grant some special meaning to that label.  
Perhaps I'm using the wrong terminology but the point I am trying to make is 
that I would prefer to see NetLabel have the ability to support every 
sensitivity label on the system (granted some protocols may impose their own 
restrictions but others do not).

> So what is your goal?  Do you want to allow
> non-netlabel'd packets under MLS (problematic then to use unlabeled SID
> as the basis) or deny it?

My goal is to have the ability to specify, in SELinux policy on a per-domain 
basis, access controls for both NetLabel'd and non-NetLabel'd traffic.  Right 
now you can only specify access for NetLabel'd traffic using SELinux policy, 
restricting non-NetLabel'd traffic must be done outside of the SELinux policy 
on a system wide scale:

 # netlabelctl unlbl allow on|off

[I'm not ignoring you compatibility comments, I'm just trying to focus the 
discussion a bit until we resolve the core issue]

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
