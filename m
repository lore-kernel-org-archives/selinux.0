Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PIcZOx010663
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 14:38:45 -0400
Received: from e1.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PIcYLe003288
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 18:38:34 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6PIcTPZ025929
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 14:38:29 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m6PIcTxI126236
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 14:38:29 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m6PIcTx9023374
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 14:38:29 -0400
Date: Fri, 25 Jul 2008 12:51:19 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200807251751.m6PHpJk4012058@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [RFC 1/2] labeled ipsec internet drafts
Cc: gcwilson@us.ibm.com, serue@us.ibm.com, tjaeger@cse.psu.edu
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My apologies if you have already received copies of this. 
I sent this email out earlier this week, but it appears to 
have never arrived to selinux mailing list, so trying again 
without attachments.

regards,

Joy 

----------------------------------------------------------------------------

I have attached two internet drafts for labeled ipsec for the community's 
review if interested.

I have not yet submitted to IETF. I'd need comments by next
Thursday (July 31) so I can incorporate any comments before submitting. 

There are two drafts because IKEv1 was obsoleted by IKEv2, but most 
are still using IKEv1. I also noticed some recent IPsec rfcs, particularly 
those proposing algorithm suites sometimes referred to IKEv1 also, 
although it has been obsoleted. So just in case, there is a draft for 
IKEv1 too. It didn't seem the drafts could be merged since ikev1 and ikev2 
are different.

Lastly, IPsec architecture rfc 2401 was obsoleted by rfc 4301. 
2401, section 8 supported "MLS networking" within IPsec. All this was 
removed from rfc 4301. Thus the labeled ipsec draft for ikev2, 
reintroduces mls networking as MAC Networking and is longer. 

Please let me know if anything is missing or could be improved.
Thanks!

regards,
Joy

---------------------------------------------------------------





Network Working Group                                   J. Latten
Internet-Draft                                          G. Wilson
Intended Status: Standards Track                        S. Hallyn
Expires: ?                                                    IBM
                                                        T. Jaeger
                                                       Penn State
                                                        June 2008

                        Security Label Addendum to 
                    IPsec Domain of Interpretation (DOI)
                      for Internet Security Association 
                    and Key Management Protocol (ISAKMP)

                  draft-jml-ipsec-ikev1-security-label-00

Status of This Memo

   By submitting this Internet-Draft, each author represents that any
   applicable patent or other IPR claims of which he or she is aware
   have been or will be disclosed, and any of which he or she becomes
   aware will be disclosed, in accordance with Section 6 of BCP 79.

   Internet-Drafts are working documents of the Internet Engineering
   Task Force (IETF), its areas, and its working groups. Note that
   other groups may also distribute working documents as Internet-
   Drafts.

   Internet-Drafts are draft documents valid for a maximum of six months
   and may be updated, replaced, or obsoleted by other documents at any
   time. It is inappropriate to use Internet-Drafts as reference
   material or to cite them other than as "work in progress".

   The list of current Internet-Drafts can be accessed at
   http://www.ietf.org/ietf/1id-abstracts.txt.

   The list of Internet-Draft Shadow Directories can be accessed at
   http://www.ietf.org/shadow.html.

   This Internet-Draft will expire on December, 2008.

Copyright Notice

   Copyright (C) The IETF Trust (2008)

Abstract

   This document describes the need for and the use of a security label
   within IPsec. It describes the extension to the Internet IP Security



Latten, et al.               Expires ?                          [Page 1]

Internet-Draft               IKEv1SecurityLabel                June 2008


   Domain of Interpretation (IPsec DOI) [RFC2407] for the Internet
   Security Association and Key Management Protocol (ISAKMP) [RFC2408]. 
   This extension supports the negotiation of the security label for a 
   particular IP Authentication Header (AH) [RFC4302] or IP 
   Encapsulating Security Payload (ESP) [RFC4303] security association.

1. Introduction

   Traditionally, security context referred to the security level and
   category used by Multilevel Security (MLS). This document will refer
   to the security level and category as the security classification.

   Current security mechanisms, such as SELinux, use the security
   classification and additional security attributes to form their 
   security context. For example, a type for type enforcement. 
  
   Techniques such as IP Security Options (IPSO) allow IP datagrams to
   be labeled with an MLS security classification [RFC1108]. This 
   ensured the same security applied to local objects and resources was 
   utilized when communicating over the network with homogenous systems.
   However, these techniques cannot pass along the additional security
   attributes used in current security mechanisms.

   The ISAKMP specification defines a Situation field in the Security 
   Association payload [RFC2408]. The IPsec DOI describes the use of 
   this field to communicate sensitivity and integrity classification 
   information between initiator and responder when negotiating a 
   security association [RFC2407]. However, it does not provide for 
   additional security attributes that may be required by the security 
   mechanism being deployed in the environment.

   This document describes the additions to the IPsec DOI for ISAKMP
   that are needed to support communication of additional security 
   attributes between two hosts, in particular a security label.

2. Terminology
 
   The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
   "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
   document are to be interpreted as described in [RFC2119].











Latten, et al.               Expires ?                          [Page 2]

Internet-Draft               IKEv1SecurityLabel                June 2008


3. IPsec Security Association Attribute

    The following SA attribute definition is used in Phase II of an
    Internet Key Exchange Protocol (IKE) negotiation that includes a 
    security label. The attribute type is Variable-Length (V).  
    Encoding of attributes is defined in the base ISAKMP specification 
    [RFC2408].

    Attribute Type

                class                   value           type
          ------------------------------------------------------
               Security Label             ?              V
    
    Class Values

      Security Label

        Specifies that the security association is being negotiated 
        in an environment that requires labeled security. This field 
        will contain the security label.

        The security label has the following format.

        0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |     doi       |  algorithm    |            length             |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                 security label (variable)                     |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

                     Figure 1: Security Label format

       - doi (1 octet) - The first octet contains the security label's
         domain of interpretation.

         The domain of interpretation can be viewed as a group of
         systems that agree on the meaning of particular values within
         the security label of a security mechanism.

         The value of 1 is reserved as the default.

         Reserved       0
         Default        1

       - algorithm (1 octet) - The second octet contains the security 
         label's algorithm.




Latten, et al.               Expires ?                          [Page 3]

Internet-Draft               IKEv1SecurityLabel                June 2008


         The security label's algorithm specifies the security
         mechanism or context in which the label is applicable. For
         example, the security label is interpreted within the SELinux
         context.

         Requests for assignment of additional algorithms should be 
         addressed to the Internet Assigned Numbers Authority (IANA).

         Reserved       0
         SELinux        1
         Smack          2
         Private Use    120-128

       - length (2 octets) - The third and fourth octets contain the 
         string length of the security context.

       - security label (1 or more octets) - The security label. The
         actual content will be dependent on the security algorithm
         that is specified. Within IKE context, this is regarded as
         an opaque bit string.

3. Attribute Negotiation

   If an implementation receives an IPsec DOI attribute or attribute
   value that it does not support, it SHOULD send an 
   ATTRIBUTES-NOT-SUPPORT and the security association negotiation 
   and setup MUST be aborted.

4. Security Considerations

   This document describes an extension to IKE [RFC2409] and ISAKMP 
   [RFC2408] protocols. The use of the described security label should 
   not change the basic security features of the two. 

   The IPsec DOI describes a Situation field whose values can be 
   SIT_SECRECY and/or SIT_INTEGRITY. When SIT_SECRECY is used, it 
   indicates an environment requiring labeled secrecy and is
   followed with sensitivity label. When SIT_INTEGITY is used,
   it indicates an environment requiring labeled integrity and 
   is followed with integrity information. 

   SIT_SECRECY and SIT_INTEGRITY themselves indicate the use of
   a security label and therefore the security attribute described
   in this document MUST NOT be used in conjunction with either.
   The new security attribute extends the existing security
   mechanism to allow for additional interpretations of a security
   label and not just those defined by SIT_SECRECY and SIT INTEGRITY.
   It is possible that the sensitivity level and/or integrity level are



Latten, et al.               Expires ?                          [Page 4]

Internet-Draft               IKEv1SecurityLabel                June 2008


   included in the security label defined by the security algorithm 
   using the new security attribute.

5. IANA Considerations

   This document contains two new "magic numbers" which are allocated
   and maintained by IANA registry.

        - The class value for the security label attribute.

                  class            value     type
              -----------------------------------------
                Security Label       ?        V

          Only one value assigned by IANA is required.

          - The value for the security algorithm.

                SELinux         1(?)
                Smack           2(?)

          Additional values may be assigned by IANA for the
          security mechanisms requiring IKE to communicate its
          security label.

Acknowledgements

   The authors would like to thank Stephen Smalley, James Morris and
   the SELinux community for their work on labeled ipsec.

Normative References

   [RFC2119]    Bradner, S., "Key words for use in RFCs to Indicate
                Requirement Level", BCP 14, RFC 2119, March 1997.

   [RFC2407]    Piper, D., "The Internet IP Security Domain of
                Interpretation for ISAKMP", RFC 2407, November 1998.

   [RFC2408]    Maughan, D., Schertler, M., Schneider, M., and
                J. Turner, "Internet Security Association and Key
                Management Protocol", RFC 2408, November 1998.

   [RFC2409]    Harkins, D. and D. Carrel, "The Internet Key Exchange",
                RFC 2409, November 1998.

   [RFC4302]   Kent, S., "IP Authentication Header", RFC 4302, 
               December 2005.




Latten, et al.               Expires ?                          [Page 5]

Internet-Draft               IKEv1SecurityLabel                June 2008


   [RFC4303]   Kent, S., "IP Encapsulating Security Payload (ESP)", 
               RFC 4303, December 2005. 

Informative references

   [RFC1108]   Kent, S., "U.S. DoD Security Options for the Internet
               Protocol, RFC 1108, November 1991.

Authors' Addresses

Joy Latten
IBM 
email: latten@austin.ibm.com

George Wilson
IBM 
email: gcwilson@us.ibm.com

Serge Hallyn
IBM
email: serue@us.ibm.com

Trent Jaeger
Penn State
email: tjaeger@cse.psu.edu


























Latten, et al.               Expires ?                          [Page 6]

Internet-Draft               IKEv1SecurityLabel                June 2008


Full Copyright Statement

   Copyright (C) The IETF Trust (2008).

   This document is subject to the rights, licenses and restrictions 
   contained in BCP 78, and except as set forth therein, the authors
   retain all their rights.

   This document and the information contained herein are provided on an
   "AS IS" basis and THE CONTRIBUTOR, THE ORGANIZATION HE/SHE REPRESENTS
   OR IS SPONSORED BY (IF ANY), THE INTERNET SOCIETY, THE IETF TRUST AND 
   THE INTERNET ENGINEERING TASK FORCE DISCLAIM ALL WARRANTIES, EXPRESS 
   OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTY THAT THE USE OF 
   THE INFORMATION HEREIN WILL NOT INFRINGE ANY RIGHTS OR ANY IMPLIED 
   WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.

Intellectual Property

   The IETF takes no position regarding the validity or scope of any
   Intellectual Property Rights or other rights that might be claimed
   to pertain to the implementation or use of the technology
   described in this document or the extent to which any license
   under such rights might or might not be available; nor does it
   represent that it has made any independent effort to identify any
   such rights.  Information on the procedures with respect to rights
   in RFC documents can be found in BCP 78 and BCP 79.

   Copies of IPR disclosures made to the IETF Secretariat and any
   assurances of licenses to be made available, or the result of an
   attempt made to obtain a general license or permission for the use
   of such proprietary rights by implementers or users of this
   specification can be obtained from the IETF on-line IPR repository
   at http://www.ietf.org/ipr.

   The IETF invites any interested party to bring to its attention
   any copyrights, patents or patent applications, or other
   proprietary rights that may cover technology that may be required
   to implement this standard.  Please address the information to the
   IETF at ietf-ipr@ietf.org.












Latten, et al.               Expires ?                          [Page 7]


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
