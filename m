Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <36282A1733C57546BE392885C061859201573525@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859201573525@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 16:57:28 -0400
Message-Id: <1158958648.19877.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 13:23 -0400, Venkat Yekkirala wrote:
> OK, here's what we will do:
> 
> 1. We will have getpeercon() fail if there's no labeled-SA.
> 
> 2. We will do a getdatacon() or something similar to retrieve the
>    secmark (as reconciled in the proposed reconciliation logic, of course).
> 
> Comments?

I think that just moves the problem.  The question is still whether we
can have a coherent policy using that reconciliation logic for both
users of secmark.  At present, we have refpolicy (trying to) use secmark
to mark packets based on their direction and destination (e.g.
http_client_packet_t for all traffic on an outbound connection to port
80, http_server_packet_t for all traffic on an inbound connection to
port 80) and then using packet send/recv to control flow between
applications (e.g. httpd_t can send/recv http_server_packet_t, and
xxx_mozilla_t can send/recv http_client_packet_t).  If labeled
networking is enabled for a given communication and secid reconciliation
happens, the packet labels are now reconciled to the sender's label, so
httpd_t now sends httpd_t packets and receives xxx_mozilla_t packets,
and vice versa.  So we now have multiple rules on packet class to
achieve the same goal via different mechanisms, and getdatacon() can
potentially return any of these types.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
