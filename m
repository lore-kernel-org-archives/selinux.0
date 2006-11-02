Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joshua Brindle'" <jbrindle@tresys.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "Paul Moore" <paul.moore@hp.com>
Cc: "James Morris" <jmorris@namei.org>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 11:01:17 -0600
Message-ID: <001501c6fea0$8540d980$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588514A47@exchange.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Let's say you secmark a packet coming from a certain host
> > with webonly_packet_t.
> >
> > You could have a filter point defined as:
> >
> > iptables -t filter -A FORWARD -d webserver -dport 80 -j
> > SECFILTER --selctx "system_u:object_r:webserver_t:s4-s5"
> >
> > Your policy could say:
> >
> > allow webonly_t webserver_t:secfilter { flow_out }
>
> Ok, I don't think I understand. Are you using the filter table to
> relabel a packet?

No. I am using the FILTER table to FILTER a packet.

> What is the subject here?

The subject is the secmark/external label and the target is the filter point
label.

>
> If this is indeed relabeling (which it appears to be from here) then
> there should be a relabel permission, shouldn't it also be in the
> FORWARD mangle table instead of filter? How is it different
> from secmark
> at all?

secmark to mark the packets and secfilter to filter them at the system
level (in addition to socket).

> (eg., why not just have a secmark rule in the mangle
> table that
> relabels its secmark for doing forward access control?)
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
