Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20508
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 09:43:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA23027
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 14:42:26 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id OAA23023
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 14:42:25 GMT
Date: Fri, 14 Dec 2001 09:42:26 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: James Morris <jmorris@intercode.com.au>
cc: <selinux@tycho.nsa.gov>, <linux-security-module@wirex.com>
Subject: Re: ANN: Labeled IPv4 Networking for SELinux (selopt) v0.06 
In-Reply-To: <Pine.LNX.4.31.0112122224280.9996-100000@blackbird.intercode.com.au>
Message-ID: <Pine.GSO.4.33.0112140933000.24054-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Thanks very much for making this contribution to SELinux, and for
providing this concrete example of the need for the LSM skb hooks and the
LSM networking hooks.  This fills an important gap in SELinux.  I'd like
to see this work merged into the base SELinux release as it matures.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com

On Wed, 12 Dec 2001, James Morris wrote:

> I would like to announce the initial public release of Selopt,
> a package which implements labeled IPv4 networking for SELinux.
>
> In a nutshell, Selopt provides mechanisms to extend the Flask
> security model across the network to trusted peers within a
> common security perimeter.
>
> This is an early development release. It is available at:
>
> http://www.intercode.com.au/jmorris/selopt/
>
> The README file (attached below) provides a brief overview of the
> Selopt labeling model and mechanisms.
>
> LSM developers may be interested in this package as it provides
> an example of how to use the skb security hooks.
>
> There is still much work to do on this, but the code is at a
> runnable stage and I feel that it would be good to start getting
> feedback and review from others on the model and implementation.
>
> Any comments are most welcome.
>
>
> - James
> --
> James Morris
> <jmorris@intercode.com.au>
>
>
> $Id: README,v 1.18 2001/12/12 09:32:41 jmorris Exp $
>
> SELinux Labeled Networking Support via CIPSO/FIPS188 IP Options (selopt)
>
> Version 0.06
>
> INTRODUCTION
>
> The selopt package consists of a kernel patch and userspace
> components which implement labeled IPv4 networking for SELinux.
>
> This document provides a brief overview of the selopt labeling model
> and associated components.  More detailed documentation is expected
> to be provided with future releases.
>
> A working knowledge of the Flask security model and SELinux implementation
> are assumed.  Refer to the documentation at http://www.nsa.gov/selinux/
> for more information on these topics.
>
> For installation instructions, see the INSTALL file.
>
>
> MECHANISMS
>
> Selopt provides mechanisms for:
>
>   o Labeling IPv4 packets with local Security IDs (SIDs);
>   o Specifying which packets require labeling;
>   o Decoding labels from peers;
>   o Mapping remote network SIDs to local SIDs.
>
> These mechanisms allow the Flask security model of SELinux to be
> extended to IPv4 networking.
>
>
> SECURITY PERIMETERS
>
> A security perimeter is defined as a group of trusted peers which are managed
> under equivalent security policies.  Security policies are equivalent if users,
> roles, types and MLS attributes are the same, and mean the same thing on each
> system.
>
> Security perimeters are managed using the 'pt' utility.
>
> Selopt does not currently support labeled communication between different
> security perimeters.
>
>
> LABELING
>
> For peers within a security perimeter, IPv4 traffic is labeled via IP
> options.  All traffic between peers within the perimeter must be labeled,
> while unlabeled traffic may pass across the security perimeter, depending on
> policy configuration.
>
> Each packet is labeled with a policy serial number and a source SID.  Once
> the extended socket API is implemented, packets may also be labeled with a
> destination SID, indicating that the specified destination of the packet
> must be enforced.  For non-stream protocols, the extended socket API will
> also allow packets to be labeled with per-message SIDs.
>
> The IP options used to label packets are based on the FIPS188 standard
> and the CIPSO draft.  The FIPS188 "free form" tag is used to encode
> the policy serial and SID values.  Certain packets must bypass the labeling
> mechanisms (e.g. SCMP or ISAKMP) for implicit labeling, and a bypass label
> is available for this purpose.
>
>
> NETWORK SID MAPPING
>
> As SIDs only have local significance, remote SIDs specified in packet
> labels are mapped using a simple UDP protocol called the Security Context
> Mapping Protocol (SCMP).  This protocol allows a peer to request a security
> context for a given SID and security policy serial number.  The remote
> security context is then translated to a local SID and stored in a
> network SID (NSID) mapping cache.
>
> This mapping works because of security policy equivalence.  A security
> context on one peer has the same meaning as a security context on another
> peer within the same security perimeter.
>
> SCMP mapping is performed by a userspace daemon called scmpd, which
> communicates with the kernel via Netlink.
>
>
> DEFERRED PROCESSING
>
> When a labeled packet is received for which there is no current NSID mapping,
> it is queued while an SCMP map request message is sent the originator.  Once
> an SCMP map response is received and processed, the queued packet is marked
> with equivalent local SID(s) and dequeued.
>
> Information about the state of the packet queue may be found
> via /proc/net/selopt_queue
>
> This deferred processing appears to work well, although it has only been tested
> on a LAN so far.
>
>
> PROTECTION
>
> Selopt does not provide any traffic protection, and is itself useless without
> it.  However, the decision was made to separate labeling from protection to
> allow more flexibility in system composition.
>
> A protection layer must minimally provide the following services for all
> labeled traffic: confidentiality, data origin authentication, connectionless
> integrity and anti-replay measures.
>
> It is expected that labeled traffic will be protected by IPsec in most cases.
>
>
> SECURITY POLICY
>
> The Selopt labeling mechanisms are independent of Flask policy.
>
> Once a security perimeter is defined, any traffic within the perimeter
> is labeled.  Selopt decodes the labels but does not interpret them in
> terms of security policy.
>
> New access vectors and Flask security policies need to be implemented
> to integrate labeling with policy.
>
> A more general networking policy system may also be required, which
> encapsulates labeling and protection policies, and allows them to be
> integrated with flask policy.
>
>
> NSID API
>
> The NSID API is a set of hooks in the SELinux code which allow IP options
> based labeling systems to be implemented.  Selopt is one implementation
> if such a system.
>
> It is not known if this API would also be useful for a markedly different
> kind of labeling system, such as the custom IPsec-based implementation
> of an earlier Flask prototype.
>
>
> USERSPACE COMPONENTS
>
> In addition to the userspace applications already mentioned (scmpd and pt),
> an NSID cache management tool (ct), and a Netlink monitoring utility (flmon)
> are provided.
>
> A packet queue management tool is expected to be provided in a future release.
>
>
> STATUS
>
> This software is an early development release.  It is not stable and does
> not yet provide any security.
>
> See the TODO file for a list of things left to do.
>
>
> COPYRIGHT
>
> Copyright (c) 2001 James Morris
> Distributed under the GNU General Public License.
>
>
> WARRANTY
>
> If this product breaks, you get to keep both pieces.
>
>
> CONTACT
>
> James Morris <jmorris@intercode.com.au>
>
>
> URL
>
> http://www.intercode.com.au/jmorris/selopt/
>
>
>
>
>
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
