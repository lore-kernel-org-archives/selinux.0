Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <36282A1733C57546BE392885C061859201573762@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859201573762@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 16:47:15 -0400
Message-Id: <1159217235.16991.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 16:02 -0400, Chad Hanson wrote:
> In the absence of any other labeling, I would the secmark label would be
> equivalent to the old selinux network labels. If I have guard that sits
> between two unlabeled networks, I still want to be able to get the label of
> a packet. Since these networks are unlabeled and thus don't speak IPSEC or
> CIPSO, why wouldn't I use the MLS label that is in the secmark, as it is the
> best information I have for the label of the data.

But the secmark often tells you nothing about the data origin, or even
the way it entered the system, at least as currently employed by
refpolicy / netfilter_contexts.  That's my point.

You can certainly create custom iptables secmark rules that label
packets based on the receiving NIC, and then they would be useful in the
manner you describe.  But in general, they aren't guaranteed to tell you
anything about the origin at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
