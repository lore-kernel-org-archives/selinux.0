MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux Networking Enhancements
Date: Wed, 1 Nov 2006 12:54:43 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588514973@exchange.columbia.tresys.com>
In-Reply-To: <000c01c6fdce$8b49fcd0$cc0a010a@tcssec.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <vyekkirala@TrustedCS.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "James Morris" <jmorris@namei.org>
Cc: "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>, "Paul Moore" <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Venkat Yekkirala [mailto:vyekkirala@trustedcs.com] 
> 
<snip>
> 
> As may have been noticed, I am currently thinking of a 
> separate generic filtering module in the filter table that 
> would filter packets based on the label (internal as well as 
> external) on the packet and the label on the filtering point. 

This is not appropriate, the TE/MLS policy should be in the SELinux
policy, not in the SELinux policy and the filter tables(or anywhere
else). Policy should be centralized and analyzable to be part of the MAC
policy at all.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
