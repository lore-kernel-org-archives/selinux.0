Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>, "Joshua Brindle" <jbrindle@tresys.com>
Cc: "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "James Morris" <jmorris@namei.org>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>
Subject: RE: SELinux Networking Enhancements
Date: Wed, 1 Nov 2006 13:25:10 -0600
Message-ID: <000d01c6fdeb$732ed9f0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <4548E08B.4020704@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> >>As may have been noticed, I am currently thinking of a 
> >>separate generic filtering module in the filter table that 
> >>would filter packets based on the label (internal as well as 
> >>external) on the packet and the label on the filtering point. 
> > 
> > This is not appropriate, the TE/MLS policy should be in the SELinux
> > policy, not in the SELinux policy and the filter tables(or anywhere
> > else). Policy should be centralized and analyzable to be 
> part of the MAC
> > policy at all.
> 
> Maybe I'm missing something, but I think you could make this 
> part of the SELinux
> policy much like SECMARK rules are part of the policy now, right?

That's correct. The filtering rules as well as the policy that goes
with them would all be part of the policy like with secmark.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
