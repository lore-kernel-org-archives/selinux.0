MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Date: Thu, 26 Mar 2009 15:03:00 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [nfsv4] New MAC label support Internet Draft posted to IETF	website
In-reply-to: <20090326150934.GR9992@Sun.COM>
To: Nicolas Williams <Nicolas.Williams@sun.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org, selinux@tycho.nsa.gov
Message-id: <49CBFB94.6030408@sun.com>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
 <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM>
 <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nicolas Williams wrote:
> Jarret,
>
> I agree with your point about interoperability: we must impose a label
> encoding.  We can leave parts of the DOI number space reserved for
> as-yet-unspecified label forms and encodings -- that would satisfy my
> desire for extensibility.  That's a comment I should make on CALIPSO,
> that it should not impose its label structure and encoding on all DOIs,
> just all DOIs in parts of the DOI number space open for registration.
>   

CALIPSO spec doesn't tie a DOI with a particular label encoding. For 
example, it DOI 1000 doesn't have to mean it's CALIPSO label with this 
label encoding file. DOI 1000 could very well be used by SELinux systems 
using a particular MAC policy. CALIPSO DOI does imply that when a node 
can communicate with a DOI, it knows how to interpret the labels 
associated with the DOI. All nodes using the same DOI have agreed on 
what format and encodings to use. The agreement takes place else where, 
most likely an administrative decision. Does labeled NFSv4 aim to 
establish this agreement within the protocol itself?
> Also, this does not mean that the label shouldn't be opaque in the XDR
> sense.  Using opaque in the XDR sense but actually imposing a label
> encoding might still be desirable (mostly for compression, but also if
> we should reserve some of the DOI number space for as-yet-unspecified
> label structures and encodings).
>   


CALIPSO spec reserves DOI value 1 - 255 for private use. If an 
organization doesn't want to do labeled communication outside its 
control, it can use a number in that range, without need to register 
with IANA.

> On Thu, Mar 26, 2009 at 02:25:44AM -0700, Jarrett Lu wrote:
>   
>> Nicolas Williams wrote:
>>     
>>> On Wed, Mar 25, 2009 at 01:52:49AM -0700, Jarrett Lu wrote:
>>>       
>>>> 2. section 3, the semantics of DOI in your draft is different from the 
>>>> one in the CALIPSO draft. Traditionally, DOI in MLS context refers to 
>>>> [...]
>>>>         
>>> Before CALIPSO it's always been the case that the form of a label
>>> depends on the DOI it is from, with a DOI being either implied by
>>> context or explicit on the wire.
>>>  
>>>       
>> CALIPSO DOI is intended for IP packets. Nodes using same DOI value 
>>     
>
> Yes, and there's a relationship to the application data.  Thus, for
> example, the label used for packets carrying NFS traffic has to dominate
> the labels of the files being accessed via NFS.
>   

Typically, SECRET data/file traffic doesn't leave SECRET network. So 
labels in different layers/subsystems should match. What must not happen 
is SECRET data flowing through UNCLASSIFIED network. In other words, we 
don't want to see a request coming in from UNCLASIFFIED  interface 
asking for SECRET files.

> That means that CALIPSO has an impact beyond IP.  Specifically,
> CALIPSO's imposition of structure on labels of any DOIs with DOI ID <
> 2^32 applies to applications as well.
>
>   
>> implies that they all agree on how to interpret a MAC label. In that 
>> sense, it's more about label definition and encodings, less about its 
>> format. For example, host A and host B use a label encoding where label 
>> CONFIDENTIAL dominates label INTERNAL. A and B communicate using DOI 1. 
>>     
>
> CALIPSO imposes structure on labels, not encoding (it does define an
> encoding for use in IPsec though).  The structure is: DOI, sensitivity
> level, compartments, releasability.  We'll need to pick an encoding.
>   

By label encoding, I mean how a CALIPSO label represented in a more 
basic form (e.g. hex or binary). It's usually done in a file, e.g. 
0x000300a0000 translates to SECRET and it dominates 0x0001007000. 
Security administrators control the encoding. They get to say what 
labels are valid and how valid label relate to each other on their 
systems. Given this kind of local control, I don't know how we, who 
defined protocol attributes, could pick one. The way it works is that 
they (administrators) picked one, and agreed among themselves what label 
encoding and DOI to use.

>   
>> CALIPSO spec is very clear that the first thing IP checks is DOI number. 
>> IP drops packets if the DOI is unexpected. CALIPSO hasn't changed how 
>> DOI is used in that regard. Sun's trusted OS has similar behavior for a 
>> long time. That's DOI for IP module. It appear that labeled NFSv4 wants 
>> a different DOI, or different semantics of DOI. Using the example above, 
>> it seems to desire the following semantics:
>>     
>
> David seems to want explicit support for DTE.  If we can get away with a
> combination of MLS (and, maybe, privileges) to represent DTE then we can
> stick exclusively to MLS and remain compliant with CALIPSO.  Given the
> impact that CALIPSO has on application protocols I think we have no
> choice (see above).
>   

I used MLS as examples, but I'd expect all MAC systems will have similar 
issues, i.e. MAC aware applications should not do things which are in 
conflicts with MAC policies in other parts of the system. I think the 
"interference" of CALIPSO DOI on application protocols comes from the 
fact that labeled NFSv4 wants to reuse CALIPSO DOI for something different.

>   
>> DOI value      Opaque Security Attribute Field
>> ---------      -------------------------------
>>    1          CALIPSO MLS label using label encodings shared by A, B
>>    2          CALIPSO MLS label using label encodings shared by C, D
>>    3          Redhat DTE label using security policy shared by A, B
>>    4          OpenSolaris FMAC DTE label using sec policy shared by C, D
>>    5          BSD's Biba label using security policy shared by C, D
>>   ....
>>
>> In an MLS example, server host C gets a request from client host A with 
>> DOI = 1, requester label = CONFIDENTIAL. The client wants to write to 
>> file foo, which is protected by label INTERNAL under DOI 2. Server C 
>> validates that CONFIDENTIAL is a defined label in label encodings under 
>> DOI 1. It then translates the label and concludes that CONFIDENTIAL in 
>> DOI 1 is equivalent to INTERNAL in DOI 2, it then grants the write 
>> access to object foo (note in MLS, write access requires labels being 
>> equal).
>>     
>
> I think that's the sort of thing that David was aiming for, yes.
>
>   
>> I am having difficulty with how to manage DOIs with different 
>> combinations in the opaque field.
>>     
>
> I agree that it's best to have an encoding for the label than to leave
> it opaque.  I want a range of unknown DOIs with opque labels for
> extensibility though (see above).
>   

The difficulty is that label interpretation is directly tied to a label 
encoding file. Different organizations have control over content of this 
file. I don't know how you structure this with a protocol attribute.

>   
>>> A CALIPSO DOI is, AFAICT, a DOI that imposes an MLS form on the label
>>> (though with label encoding being protocol specific) and a security
>>> policy registration/definition requirement.  CALIPSO also requires that
>>> a DOI always be explicit.  CALIPSO also imposes a namespace of DOIs, and
>>> I'm not sure that it allows any DOIs that are not CALIPSO DOIs.  CALIPSO 
>>>
>>> In other words, any protocol that carries a {DOI ID, opaque label}
>>> should be compatible with CALIPSO.
>>>       
>
> I should have qualified that last statement: "any protocol that carries
> a {DOI ID, opaque label} _and can use MLS exclusively_ should be
> compatible with CALIPSO."
>
>   
>> Whenever a packet carries a CALIPSO label, explicit DOI is mandatory.
>>     
>
> David's I-D has that.
>
>   
>>> But an implementation that adheres to CALIPSO will not be able to use
>>> non-CALIPSO DOIs.  Is that correct?  If so we need to ensure that a
>>> mapping between MLS and DTE is possible, since David, IIRC, wants
>>> support for DTE.  But as far as I can tell such a mapping is possible.
>>>       
>> If labeled NFSv4 DOI is used to indicate how the opaque field should be 
>>     
>
> In David's I-D the encoding of the label is left to each DOI.  That's
> not unreasonable.  But in the face of CALIPSO we might as well specify
> an actual label encoding given that CALIPSO imposes label structure.
>   

This implies there is only one way to interpret a CALIPSO label. In fact 
every organization gets to say how a CALIPSO label should be 
interpreted. I don't see how a single DOI will make it work without some 
OOB agreement among communicating entities.


Jarrett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
