Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0KMwKSk027352
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2009 17:58:20 -0500
Received: from g5t0007.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0KMtPbo008925
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2009 22:55:25 GMT
From: Paul Moore <paul.moore@hp.com>
To: ipsec@ietf.org
Subject: Re: [IPsec] IPsec Security Context drafts
Date: Tue, 20 Jan 2009 17:58:08 -0500
Cc: Joy Latten <latten@austin.ibm.com>, serue@us.ibm.com, gcwilson@us.ibm.com,
        tjaeger@cse.psu.edu, selinux@tycho.nsa.gov
References: <1231790397.5251.40.camel@faith.austin.ibm.com>
In-Reply-To: <1231790397.5251.40.camel@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901201758.08137.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 12 January 2009 2:59:57 pm Joy Latten wrote:
> The following IPsec Security Context drafts were announced last week.
>
> We would appreciate any comments, suggestions or reviews.

[NOTE: I've CC'd the SELinux mailing list since this draft was also 
announced there]

> http://www.ietf.org/internet-drafts/draft-jml-ipsec-ikev2-security-co
>ntext-00.txt
>
> Filename:        draft-jml-ipsec-ikev2-security-context
> Revision:        00
> Title:           Security Context Addendum to IPsec
> Creation_date:   2009-01-08
> WG ID:           Independent Submission
> Number_of_pages: 12

Hello,

I've only had a chance to read the IKEv2 version of the drafts but I 
believe that most of my comments apply to the IKEv1 version of the 
draft as well.  My comments are below, ordered by section:

 * Section 1 (Introduction)

- In paragraph two, second sentence it might be nice to mention that 
sensitivity levels are hierarchical and categories are not.

- In paragraph three you mention that domain type enforcement is not 
hierarchical but fail to explain how it differs from the MLS concept of 
categories which is also a non-hierarchical security attribute.

- In paragraph three you mention "exempt tasks" but it is not clear to 
me what you are referring to.

- In paragraph five you mention how RFC1108 when used in conjunction 
with FIPS-188 would enable additional security attributes (assumed to 
be DTE attributes), why is RFC1108 needed?  Why not just FIPS-188?

 * Section 3 (Labeled Networking)

- In paragraph two you only mention data export, text on data import is 
missing.

- In paragraph four and five you talk about using IPsec to protect both 
implicitly and explicitly labeled network traffic, it would be helpful 
if you could explain why implicit labeling is needed since the 
combination of IPsec and explicit labeling seems to address the issues 
you listed in section 1.

 * Section 3.1 (Relationship Between a Security Association ...)

- It would be nice to mention in this section how to deal the potential 
for packets employing both AH and ESP with differing security contexts.

 * Section 3.2 (Security Context Selector)

- In general I feel this section is not specific enough for 
implementation, e.g. in paragraph two how are traffic streams 
controlled via SPD security labels?

- In paragraph three you don't mention how the security label assigned 
to a newly SA is determined.

- In paragraph four you don't mention how the correct SA pair is 
determined.

 * Section 3.3 (Security Context Selector and PFP)

- In this section you never mention how a SA created via PFP would 
arrive at the correct security label.  In addition, while you describe 
SPD entries as "objects" from a security perspective it isn't clear if 
an SA's security label represents a "subject" or an "object".

 * Section 3.5 (Additional Outbound Processing)

- What happens when an SA doesn't exist?  Compare labeled versus 
unlabeled SPD entries and how a SA's security label is determined.

- How are errors (unknown DOI, invalid label, etc.) and denials (access 
not allowed per security policy) handled?  Is the sender notified, if 
so, how?  

 * Section 3.6 (MAC Processing for Security Gateways)

- In paragraph two you discuss the potential for forwarding packets with 
security attributes derived from either explicit labeling protocols, in 
this particular case how do you handle the traffic?  Specifically, what 
happens to the explicit labeling information?  What about security 
label translations?

- In paragraph three you mention how outgoing forwarded traffic should 
be labeled using explicit labeling or security attributes of the 
destination, how is this determined and managed?

- How are errors (unknown DOI, invalid label, etc.) and denials (access 
not allowed per security policy) handled?  Is the sender notified, if 
so, how?

 * Section 4 (Security Context Transform)

- I believe it should be a "MUST" that each SA in a bundle use the same 
security label.

- The term "doi" should be capitalized since it is an acronym.

- Is any part of the DOI space reserved for private use?

 * Section 4.1 (Attribute Negotiation)

- On systems that support multiple DOIs, how is a DOI selected for 
outbound traffic?

- More detail is needed on how the SA security label negotiation process 
works.

 * Section 4.3

- If a system's security policy for a given SPD entry only allows for a 
single SA with a specific security label, "MUST" is be willing to 
accept another SA?  Why and how?

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
