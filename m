Message-ID: <46BB43F9.7010905@trustedcs.com>
From: Darrel Goeddel <DGoeddel@TrustedCS.com>
To: James Morris <jmorris@namei.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com,
        Eric Paris
	 <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 12:42:33 -0400 
MIME-Version: 1.0
in-reply-to: <Pine.LNX.4.64.0708090717580.16824@us.intercode.com.au>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Thu, 9 Aug 2007, Darrel Goeddel wrote:
> 
>> Because of the position I am in (needing to find something workable for
>> actual
>> users), I have been trying to get my head aounrd the state of SELinux
>> networking,
>> the ideas that have been talked about in the past, and how we can prevent
>> the
>> SELinux networking infrastructure from resembling a Rube-Goldberg
machine.
>> I'll
>> be presenting some of the problems I perceive along with some very high
>> level
>> ideas early next week.
> 
> I think the problem we have faced in this area here is not enough focus on

> general usability, and how to make this stuff useful beyond "lspp" 
> customers.  It is essential for SELinux to succeed that it is generally 
> useful, and capable of addressing general security requirements, otherwise

> we _effectively_ end up with a Trusted Solaris style fork, where you have 
> this odd code in the corner that most people don't and won't use.

I am in full agreement.  In fact I fear we may have started down that road
and
need to look at the big picture to avoid going further (and possibly back up
a bit...)  Part of the problem set that I am looking at include the
complexity
of the network controls in general.  It seems that what people really want
is
to think of the peer when deciding on whether or not we can do a little
networking.  I'll get into this more when I think I have a good enough
understanding of some of the issues (why couldn't this have all waited a
bit...).  I would be interested in hearing if people think that this does
not
make sense because I don't want to waste a bunch of time getting focused on
that (confirmation of the desire is also welcome).

OK, I'll give a quick thought right now:

It seems like "can system_u:system_r:ntpd_t:secret (ntp daemon) talk
to system_u:system_r:ntp_t:secret (peer ntp client)" is a much more sensible
question to address than "can system_u:system_r:ntpd_t:secret receive a
system_u:system_r:ntp_client_pkt_t packet, through a
system_u:system_r:unlabeled_t:systemhigh association (which may not really
exist), through a system_u:system_r:unlabeled_t:systemhigh socket"?

The socket vs secmark check seems to become intuitive and the others are no
longer necessary when everything is seen as the context of the peer (whether
it be from our iptables definition or explicit info from the peer itself).

Yes, I was all in favor of treating the packet as data in the past - that is
still very intuitive to me as there is no process inside of it.  However, I
realize the nicety of treating the packet as an extension of the peer
process.
If we pick one and stick with it, things are much easier to understand and
therefore configure properly.  I am now choosing the peer domain instead of
the packet data idea for my further thoughts...

> The proposal outlined in my last email is:
> 
> - Retain existing secmark facilities, allowing them to be used as a way to

> provide default/fallback labeling
> 
> - Allow external labeling (IPsec, CIPSO) to override the secmark labels
> 
> This gives us loopback labeling, the ability to retain the general 
> usability of only local iptables-based labeling, and a very simple 
> mechanism for integrating external labeling.
> 
> Does this address all of your requirements ?

Yes.  That is the foundation of the labeling process.  There are details
such as making sure that multiple sources of peer-provided label information
are in agreement, but the foundation is solid and simple.

> If not, please explain what's missing.

As far as labeling goes, we are good.  We'll need to do something
constructive
with those labels as well.  I think the above example that gives meaning to
the socket vs. secmark check shows how we could look at things in a simpler,
more intuitive way.  We'll also need to address the checks on outbound
(locally
generated and forwarded) traffic.  Good news is that getpeercon work for
free,
just return secmark, and it will actually give you *the* label that was used
for the access check :)

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
