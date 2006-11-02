MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 11:49:40 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588514A47@exchange.columbia.tresys.com>
In-Reply-To: <000f01c6fe91$bb0926d0$cc0a010a@tcssec.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <vyekkirala@TrustedCS.com>, "Paul Moore" <paul.moore@hp.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>
Cc: "James Morris" <jmorris@namei.org>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Venkat Yekkirala [mailto:vyekkirala@trustedcs.com] 
> 

> > Can you help me understand the forwarding case as you envision it 
> > (using external labeling)?  The things I am interested in are:
> > 
> > 1. What would the policy look like?
> 
> Let's say you secmark a packet coming from a certain host 
> with webonly_packet_t.
> 
> You could have a filter point defined as:
> 
> iptables -t filter -A FORWARD -d webserver -dport 80 -j 
> SECFILTER --selctx "system_u:object_r:webserver_t:s4-s5"
> 
> Your policy could say:
> 
> allow webonly_t webserver_t:secfilter { flow_out }

Ok, I don't think I understand. Are you using the filter table to
relabel a packet? What is the subject here? 

If this is indeed relabeling (which it appears to be from here) then
there should be a relabel permission, shouldn't it also be in the
FORWARD mangle table instead of filter? How is it different from secmark
at all? (eg., why not just have a secmark rule in the mangle table that
relabels its secmark for doing forward access control?)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
