Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3AJlGro003577
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 15:47:16 -0400
Subject: Re: my thoughts on how Labeled NFSv4 draft should move forward
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: labeled-nfs@linux-nfs.org, selinux@tycho.nsa.gov,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org
In-Reply-To: <49DA6EF8.1080704@sun.com>
References: <49DA6EF8.1080704@sun.com>
Content-Type: text/plain
Date: Fri, 10 Apr 2009 15:43:43 -0400
Message-Id: <1239392623.9761.106.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
   Pete, Steve, and I have taken in the results of the last week and a
half of discussion and have discussed the way we see things working. We
believe that the DOI usage model that you have marked as number 1 is the
one we would like to see agreed on eventually. There are several reasons
we it the first being that it allows for a much smaller DOI space than
would normally be required. By only specifying the format of the label
in the DOI it allows for implementers to easily develop systems to parse
these labels. This method also allows for a more dynamic policy at the
end points allowing for customizations to be made on a site specific
basis without having to use an external entity such as IANA. This
doesn't mean that there will be no authority to provide semantic
information on policies but rather that authority is not specified in
the DOI field. The cool part of using this method is that we can have
DOI 5 be CALIPSO formatted labels and in the opaque field we can use the
complete CALIPSO label specification DOI and all. In this case the
CALIPSO DOI would be an authority identifier to allow the system to
obtain the necessary information. 

To address your first point below we believe that if the DOI space is
sufficiently small and we can define a reasonable way to specify the
label format for parsing purposes that the IETF won't mind that we have
this registry. The question here is how finely do we define the label
specification for a DOI. For example, the SELinux context can be
described as, 1) a string, 2) a colon separated string, 3) a colon
separated string where the first component is a user, the second
component is a role, the third component is a type, and there is an
optional 4th component of an MLS range. We can even go further and say
do we want to specify in some form of regex the valid forms of each
component. I think if the registry contains information like that it
will be very valuable to implementers and will be accepted.

To address your second point, most MAC systems in deployment today are
in fact MLS centric and as Casey has pointed out the problem space has
grown to be larger than just MLS. Because the methods and documents that
people have been discussing over the last couple of weeks are so
engrained with MLS we don't believe that they will generalize well to
other MAC systems such as Type Enforcement. The reason these older
methods were able to work is because the policy was statically defined.
Modern systems require the ability to provide additional policy
configuration on the end points and this dynamic nature makes it seem
unlikely that the older methods will generalize to be able to
accommodate this.

Finally to address your third point we think that it is wrong to assume
that there should be the same DOI across all levels in a system. This
assumption is very limiting to the system design because it assumes that
all levels will be concerned with all information. For example a system
may be using CALIPSO to label its network traffic but once that traffic
comes into the endpoint or is received by the other endpoint it may
translate it into a preferred internal label representation that is
completely different.

Dave

On Mon, 2009-04-06 at 14:07 -0700, Jarrett Lu wrote: 
> David,
> 
> There were a lot of discussion on labeled NFSv4 recently. I like to make 
> a suggestion in how your draft should go forward.  I believe you should 
> continue proposing adding a DOI + an opaque label field. There are two 
> slightly different usage models of DOI:
> (1) the current proposal -- DOI is used to indicate the format of label 
> in the opaque field. A new predefined DOI / label format pairing needs 
> to exist in a registry. Being able to parse a label doesn't necessarily 
> imply one can correctly interpret or translate a label. Label policy 
> consistency is administered outside of the Labeled NFSv4 protocol 
> extension. (2) Using same DOI implies that communicating peers can 
> correctly parse the opaque label field AND label policy between 
> communicating parties are consistent, i.e. they can correctly interpret 
> labels using same DOI.  This DOI usage is consistent with CALIPSO DOI; 
> hence the same DOI registry can be used by NFSv4. I like (2) better for 
> following reasons:
> 
> - It removes the need for another DOI registry. I believe a new DOI 
> registry will be under scrutiny and may cause uneasiness in IETF later on.
> 
> - It is consistent with how MAC systems use DOI today. Granted that the 
> CALIPSO spec is MLS centric. But DOI need not favor MLS systems in any 
> way. It could be effectively used on DTE systems as well. For example, 
> DOI number 5 means a pair of DTE system sharing consistent label 
> security policies.
> 
> - I believe it's easier to implement MAC policy consistency on a system 
> where DOI conveys the same meaning in different layer of a system stack.
> 
> In any case, the "DOI  + opaque label" proposal relies on an OOB method 
> to be useful. This is weak in terms of interoperability. But I believe 
> that allowing systems to share file label attribute still adds value, 
> even when an OOB method is required. I can help writing some usage 
> scenarios about how such extensions may be used on MLS systems.
> 
> Now there is a separate discussion on saag list in how to do policy 
> exchange among MAC systems. If this can be done, labeled NFS can 
> definitely benefit from that effort and improve its interoperability 
> story. It's probably wise to separate the two efforts so that each can 
> proceed independently. I haven't studied the "labeled policy exchange 
> framework" enough to know if it changes the current NFSv4 proposal.
> 
> 
> Jarrett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
