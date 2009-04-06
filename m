MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Date: Mon, 06 Apr 2009 14:07:04 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: my thoughts on how Labeled NFSv4 draft should move forward
To: dpquigl@tycho.nsa.gov
Cc: labeled-nfs@linux-nfs.org, selinux@tycho.nsa.gov,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org
Message-id: <49DA6EF8.1080704@sun.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David,

There were a lot of discussion on labeled NFSv4 recently. I like to make 
a suggestion in how your draft should go forward.  I believe you should 
continue proposing adding a DOI + an opaque label field. There are two 
slightly different usage models of DOI:
(1) the current proposal -- DOI is used to indicate the format of label 
in the opaque field. A new predefined DOI / label format pairing needs 
to exist in a registry. Being able to parse a label doesn't necessarily 
imply one can correctly interpret or translate a label. Label policy 
consistency is administered outside of the Labeled NFSv4 protocol 
extension. (2) Using same DOI implies that communicating peers can 
correctly parse the opaque label field AND label policy between 
communicating parties are consistent, i.e. they can correctly interpret 
labels using same DOI.  This DOI usage is consistent with CALIPSO DOI; 
hence the same DOI registry can be used by NFSv4. I like (2) better for 
following reasons:

- It removes the need for another DOI registry. I believe a new DOI 
registry will be under scrutiny and may cause uneasiness in IETF later on.

- It is consistent with how MAC systems use DOI today. Granted that the 
CALIPSO spec is MLS centric. But DOI need not favor MLS systems in any 
way. It could be effectively used on DTE systems as well. For example, 
DOI number 5 means a pair of DTE system sharing consistent label 
security policies.

- I believe it's easier to implement MAC policy consistency on a system 
where DOI conveys the same meaning in different layer of a system stack.

In any case, the "DOI  + opaque label" proposal relies on an OOB method 
to be useful. This is weak in terms of interoperability. But I believe 
that allowing systems to share file label attribute still adds value, 
even when an OOB method is required. I can help writing some usage 
scenarios about how such extensions may be used on MLS systems.

Now there is a separate discussion on saag list in how to do policy 
exchange among MAC systems. If this can be done, labeled NFS can 
definitely benefit from that effort and improve its interoperability 
story. It's probably wise to separate the two efforts so that each can 
proceed independently. I haven't studied the "labeled policy exchange 
framework" enough to know if it changes the current NFSv4 proposal.


Jarrett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
