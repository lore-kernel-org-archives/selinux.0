Date: Fri, 20 Sep 2002 22:48:37 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: pppd and net_context
In-Reply-To: <200209150931.CAA07926@lookout.la.tislabs.com>
Message-ID: <Pine.GSO.4.33.0209202246050.2978-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 15 Sep 2002, Carsten Grohmann wrote:

> last week I add the isdn4linux devices to my selinux rules.
> That do you think, is the attached patch correct?
> The type declaration should be ok, also the netifcon entries. Both are
> wrote on "Configure the SELinux Policy".
> I am not sure with the two allow entries, because I don't found anything
> about it in the documentation.
> And why uses the loopback device the special node_lo_t ?

Yes, this is fine, and is now merged.  I don't think that node_lo_t
serves any real purpose in the example policy; it just shows that you can
assign a different node type to particular addresses.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
