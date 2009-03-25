MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Date: Wed, 25 Mar 2009 01:52:49 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: New MAC label support Internet Draft posted to IETF website
In-reply-to: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org, nfsv4@ietf.org,
        nfs-discuss@opensolaris.org
Message-id: <49C9F0E1.1040202@sun.com>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David P. Quigley wrote:
> Hello,
>    I have just posted a new document for the MAC labeling support work
> to the IETF website. It contains a lot of clarifying text that has been
> asked for by several people in the IETF community. I would like to ask
> that people give it a look over and provide comments if possible. I
> would prefer that discussion takes place on the NFSv4 WG mailing list
> since it shows interest in the technology which is what the WG is
> currently looking for. If you have any questions regarding the text or
> the system outlined in it email me and I'll be more than happy to help
> with any confusion. I am hoping to drum up enough interest in the work
> to request that it be added to the NFSv4 WG charter at the next IETF
> meeting. If you are interested in the work and would like to participate
> or just think that it is a worthwhile technology and would like to see
> it added to the NFSv4 standard feel free to speak up. 
>
> The information for the document which I received in the conformation
> email and a link to it can be found below.
>
> Dave Quigley
>
>
>
> http://www.ietf.org/internet-drafts/draft-quigley-nfsv4-sec-label-00.txt
>   

Sorry about the late reply. I have the following comments on the draft.

1. section 3, a nit. It's probably better to number your requirements as 
R1, R2, ... R4. When you refer to them later in your draft, I don't need 
to count every time.

2. section 3, the semantics of DOI in your draft is different from the 
one in the CALIPSO draft. Traditionally, DOI in MLS context refers to 
(at least in part) administrative control and deployment of the MLS 
systems. For example, DOD may own a block of DOIs. Systems using that 
block of DOIs are permitted to communicate with on another. Label 
translations are possible among the DOIs. Systems are not permitted to 
accept data packets carrying DOI outside a known DOI range. In your 
draft, DOI is used to imply label format in the opaque field of the 
security attribute. This makes it impossible to share the CALIPSO DOI.

3. section 3, on a MAC system, every subject and object has a label as 
you stated. Different objects are labeled in different layers or 
subsystems. For example, data packets, network interface, sockets are 
labeled by IP module. I believe the draft should at least state that 
NFSv4 MAC labeling should be consistent with MAC policy on the entire 
system. Take MLS system as an example, it's considered a MAC violation 
that a file labeled SECRET goes out on a network interface labeled 
UNCLASSIFIED. It's important that NFS implements this correctly so that 
MAC is enforced correctly on the system. It's difficult for IP module to 
inspect whether NFS has put the correct label in IP's payload.

4. section 4, the draft should probably state how a MAC client knows 
whether the server is MAC aware or not, via configuration? Also how a 
MAC aware server knows whether the client is MAC aware, via 
configuration or based on the fact that security attributes are present?

5. section 4, nit. "MAC aware client/server" are probably better names 
than "smart client/server".

6. section 4.1, in full mode, does reply carry a label? It appears to me 
that a client never needs to do a DOI translation. The draft should be 
more explicit on  that, IMO.

7. section 4.2.2, the phrase "this may fail based on the DAC criteria 
even if the MAC policy grants access" applies to all three modes of 
operation. It may mislead reader to believe it only applies to this mode.

8. section 4.3, what actually prevents a MAC aware server to serve a 
mixture of MAC aware and MAC unaware clients? This restriction may not 
be necessary. There are environments where both kinds of clients coexist.

9. section 5.1, while I understand what you intend to explain, your 
example is not completely correct. In B&L MLS model, a request with TOP 
SECRET security attributes can actually read SECRET or UNCLASSIFIED 
directory. It's not a MAC violation, i.e. read down is OK. The reverse 
is not permitted.

10. section 7, as stated above, you seem to use the DOI field 
differently. It appears that you want the DOI to indicate whether an 
NSFv4 server understands the label format AND knows how to interpret the 
opaque field. This implies the server has to know all the label 
definitions for all valid DOIs. For example, a server must be able to 
detect a label is undefined under a DOI although it knows the format of 
the label. This may be better solved via configuration instead of going 
through IANA. For example, if one wants his server to be able to 
translate among three labeling schemes, she/he will configure the system 
with all three label definitions, translation tables, modules containing 
appropriate label functions and utilities, etc..


Jarrett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
