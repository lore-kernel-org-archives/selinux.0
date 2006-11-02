MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 12:19:54 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588514A55@exchange.columbia.tresys.com>
In-Reply-To: <001501c6fea0$8540d980$cc0a010a@tcssec.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <vyekkirala@TrustedCS.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "Paul Moore" <paul.moore@hp.com>
Cc: "James Morris" <jmorris@namei.org>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Venkat Yekkirala [mailto:vyekkirala@trustedcs.com] 
> 
> > > Let's say you secmark a packet coming from a certain host with 
> > > webonly_packet_t.
> > >
> > > You could have a filter point defined as:
> > >
> > > iptables -t filter -A FORWARD -d webserver -dport 80 -j SECFILTER 
> > > --selctx "system_u:object_r:webserver_t:s4-s5"
> > >
> > > Your policy could say:
> > >
> > > allow webonly_t webserver_t:secfilter { flow_out }
> >
> > Ok, I don't think I understand. Are you using the filter table to 
> > relabel a packet?
> 
> No. I am using the FILTER table to FILTER a packet.
> 

Ok, I think I'm beginning to get it (I'm a bit slow lately :\).. You are
defining a condition where iptables will call into the security server
using the packet label (either secmark or external, how do you decide?)
and some abstract object to see if it should drop (or is it reject? Can
you choose?). 

It is interesting, I'm a little dubious, iptables basically becomes an
object manager and uses iptables rules to determine whether or not to
call into the security server, which isn't inappropriate, per se. The
iptables filter rules must be included as part of the policy or the
expected filtering would occur, the same is true for secmark though. The
difference is that secmark is labeling packets and if the labels aren't
in place a restrictive policy will drop them. With these filter rules if
they aren't in place the policy becomes less restrictive (right?)..

> > What is the subject here?
> 
> The subject is the secmark/external label and the target is 
> the filter point label.
> 
> >
> > If this is indeed relabeling (which it appears to be from 
> here) then 
> > there should be a relabel permission, shouldn't it also be in the 
> > FORWARD mangle table instead of filter? How is it different from 
> > secmark at all?
> 
> secmark to mark the packets and secfilter to filter them at 
> the system level (in addition to socket).
> 

gotcha


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
