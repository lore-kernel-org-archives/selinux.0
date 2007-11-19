Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAJKICSx011862
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 15:18:12 -0500
Received: from g5t0009.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAJKI4gT010507
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 20:18:05 GMT
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Problems with Labeled IPsec, IKE and ECN
Date: Mon, 19 Nov 2007 15:17:34 -0500
Cc: Joy Latten <latten@us.ibm.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711191517.34487.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All,

Bill Sommerfeld, a Sun engineer looking into implementing Labeled IPsec, ran 
across a problem with Linux's Labeled IPsec implementation[1].  The problem 
is that the IKE/IPsec attribute used to pass the SELinux context is also used 
as part of the Explicit Congestion Notification (ECN) specification[2][3].  

The ipsec-tools package currently defines the SELinux context attribute value 
as "10" in src/racoon/ipsec_doi.h (taken from v0.7):

    #ifdef HAVE_SECCTX
    #define IPSECDOI_ATTR_SECCTX                 10 /* V */
    #endif

However, in RFC 3168 section 9.2.1.1 the ECN attribute value is also defined 
as "10":

    A new IPsec Security Association Attribute is defined to enable the
    support for ECN congestion notifications based on the outer IP header
    to be negotiated for IPsec tunnels (see [RFC2407]).  This attribute
    is OPTIONAL, although implementations that support it SHOULD also
    support the SAD field defined in Section 9.2.1.1.
 
    Attribute Type
 
            class               value           type
      -------------------------------------------------
      ECN Tunnel                 10             Basic
 
    The IPsec SA Attribute value 10 has been allocated by IANA to
    indicate that the ECN Tunnel SA Attribute is being negotiated; the
    type of this attribute is Basic (see Section 4.5 of [RFC2407]).  The
    Class Values are used to conduct the negotiation.  See [RFC2407,
    RFC2408, RFC2409] for further information including encoding formats
    and requirements for negotiating this SA attribute.

Needless to say this is a problem and we need to move away from using the 
IKE/IPsec attribute value of "10" as soon as possible.  Further, simply 
picking a new number is not a good solution, we should really petition IANA 
to get an attribute number assigned for this purpose.  However, doing so will 
most likely require documenting the Linux Labeled IPsec design and submitting 
it to the IETF as a draft specification for approval[4].  If this is not 
possible we will need to start investigating alternatives as "poaching" 
existing standards is not a viable, maintainable solution.

[1] http://blogs.sun.com/sommerfeld/entry/poaching_codepoints
[2] http://www.ietf.org/rfc/rfc3168.txt
[3] http://www.iana.org/assignments/isakmp-registry
[4] http://www.ietf.org/rfc/rfc2860.txt

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
