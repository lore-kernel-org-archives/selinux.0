From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MLS and network
Date: Fri, 5 Feb 2010 15:31:10 -0500
Cc: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>, selinux@tycho.nsa.gov
References: <20100204174901.GL1750@myhost.felk.cvut.cz> <20100205160720.GN1750@myhost.felk.cvut.cz> <1265388590.18100.73.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1265388590.18100.73.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201002051531.10341.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 05 February 2010 11:49:50 am Stephen Smalley wrote:
> On Fri, 2010-02-05 at 17:07 +0100, Michal Svoboda wrote:
> > Stephen Smalley wrote:
> > > 2) Can you provide more details about your configuration and your test
> > > case (e.g. your exact netlabel configuration, the policy package you
> > > are using, the context in which your process runs)?
> >
> > Fedora 12 with latest updates; mls policy package. Base package
> > description says:
> > Based off of reference policy: Checked out revision  2.20090730
> >
> > Context is user_u:user_r:user_t:s1
> >
> > I did something like
> > netlabelctl unlbl add default address:0.0.0.0/0 \
> > 	label:system_u:object_r:netlabel_peer_t:s0
> >
> > I could see the packets on the outgoing interface.
> 
> Hmm...running that netlabelctl command was sufficient to kill my ssh
> connection to my box ...

Do you type everything you read on the internet into a root shell?  I always 
figured you were smarter than that :)

Kidding aside, the 'netlabelctl unlbl add|del ...' commands only effect the 
peer labeling used when a packet is not labeled via a labeling protocol, 
e.g. CIPSO or labeled IPsec.  It does not affect the labeling of outbound 
traffic in any way.  Here is an example of using it to label unlabeled 
traffic entering the system:

 * http://paulmoore.livejournal.com/1758.html

For outbound packets that originate on the local system, you don't need to 
specify a fallback peer label as we determine the packet's peer label based 
on the socket's label, which we can access at all of the egress control 
points via a back pointer in the packet itself.  It is a little more 
interesting for forwarded packets as we don't have access to the sending 
socket, in this case we derive the packet's peer label just like we do for 
incoming packets: first we look for a CIPSO or labeled IPsec peer label then 
we fall back to a fallback label if one is configured.  I really haven't 
written much about forwarding packets and manipulating the peer labels but 
you can do some really cool stuff with it if you have a little patience to 
get the configuration just right.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
