Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>,
        <sds@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Mon, 16 Oct 2006 08:45:10 -0500
Message-ID: <000001c6f129$4cdbe370$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1161001890.5980.173.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > > > 5. can the packet flow into the ipsec association?
> 
> > > Without 5, we can't restrict the association traffic to just
> > > http_client_packet_t, so mozilla_t can't be denied 
> sending/receiving
> > > dns_client_packets_t over the httpd_t association.
> > 
> > You can restrict it, but by way of the policy in the SPD, where you
> > can use selectors such as ipaddr, port, protocol, etc. (see 
> setkey(8)).
> > 
> > The "security points" have nothing to do with ipsec associations.
> 
> This is not sufficient because it encodes the access control 
> policy into
> the SPD,

No it doesn't. You are ONLY labeling the rules in the SPD. Enforcement
is still via SELinux policy where you would have rules like:

allow apache_t  httpd_ipsec_t:association { polmatch };

> instead of putting the policy in the SELinux policy.  Putting
> it in the SPD can't be analyzed when you do a policy analysis.

Agreed and that's not what's happening. IOW, you are only labeling
the rules in the SPD leveraging the SPD syntax, but enforcement is
still via SELinux policy. Hope that clarifies. I think looking at
www.ipsec-howto.org would give you a good idea.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
