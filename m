Subject: RE: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
In-Reply-To: <000201c6f12d$9c979540$cc0a010a@tcssec.com>
References: <000201c6f12d$9c979540$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 13:26:21 -0400
Message-Id: <1161019581.26428.18.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-16 at 09:16 -0500, Venkat Yekkirala wrote:
> > > > > > > > 5. can the packet flow into the ipsec association?
> > > > 
> > > > > > Without 5, we can't restrict the association traffic to just
> > > > > > http_client_packet_t, so mozilla_t can't be denied 
> > > > sending/receiving
> > > > > > dns_client_packets_t over the httpd_t association.
> > > > > 
> > > > > You can restrict it, but by way of the policy in the 
> > SPD, where you
> > > > > can use selectors such as ipaddr, port, protocol, etc. (see 
> > > > setkey(8)).
> > > > > 
> > > > > The "security points" have nothing to do with ipsec 
> > associations.
> > > > 
> > > > This is not sufficient because it encodes the access control 
> > > > policy into
> > > > the SPD,
> > > 
> > > No it doesn't. You are ONLY labeling the rules in the SPD. 
> > Enforcement
> > > is still via SELinux policy where you would have rules like:
> > > 
> > > allow apache_t  httpd_ipsec_t:association { polmatch };
> > > 
> > > > instead of putting the policy in the SELinux policy.  Putting
> > > > it in the SPD can't be analyzed when you do a policy analysis.
> > > 
> > > Agreed and that's not what's happening. IOW, you are only labeling
> > > the rules in the SPD leveraging the SPD syntax, but enforcement is
> > > still via SELinux policy.
> > 
> > No, that is what is happening.  You can't tell from looking at the
> > SELinux policy that only http_server_packet_t can go on the
> > httpd_ipsec_t association, you would have to look at the SPD.
> 
> You CAN, if you labeled your SPD rules properly, just like how you
> have to ensure you labeled your files and secmark rules correctly.
> What's the difference?

The above rule clearly shows a relationship between a domain(socket?)
and a SPD entry.  It does not show a relationship between a packet and
an association.

When analyzing policy, the labeling is ignored until the very end where
you verify that the labeling fits the policy.   If you don't know what
is in the SPD, you can not know which packets can go over the
association by looking at the above rule.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
