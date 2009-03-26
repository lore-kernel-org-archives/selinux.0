MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Date: Thu, 26 Mar 2009 02:25:44 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [nfsv4] New MAC label support Internet Draft posted to IETF	website
In-reply-to: <20090325163317.GV9992@Sun.COM>
To: Nicolas Williams <Nicolas.Williams@sun.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org, selinux@tycho.nsa.gov
Message-id: <49CB4A18.3090709@sun.com>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
 <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nicolas Williams wrote:
> On Wed, Mar 25, 2009 at 01:52:49AM -0700, Jarrett Lu wrote:
>   
>> 2. section 3, the semantics of DOI in your draft is different from the 
>> one in the CALIPSO draft. Traditionally, DOI in MLS context refers to 
>> (at least in part) administrative control and deployment of the MLS 
>> systems. For example, DOD may own a block of DOIs. Systems using that 
>> block of DOIs are permitted to communicate with on another. Label 
>> translations are possible among the DOIs. Systems are not permitted to 
>> accept data packets carrying DOI outside a known DOI range. In your 
>> draft, DOI is used to imply label format in the opaque field of the 
>> security attribute. This makes it impossible to share the CALIPSO DOI.
>>     
>
> Before CALIPSO it's always been the case that the form of a label
> depends on the DOI it is from, with a DOI being either implied by
> context or explicit on the wire.
>   

CALIPSO DOI is intended for IP packets. Nodes using same DOI value 
implies that they all agree on how to interpret a MAC label. In that 
sense, it's more about label definition and encodings, less about its 
format. For example, host A and host B use a label encoding where label 
CONFIDENTIAL dominates label INTERNAL. A and B communicate using DOI 1. 
Host C and D both use a compatible label encoding. But in their label 
definition, label INTERNAL dominates label CONFIDENTIAL. C and D can 
communicate using DOI 2 without any problems. But host A is not allowed 
to communicate with host C using DOI 1, despite their label format may 
be compatible. I believe CALIPSO DOI assumes that host A and B are under 
the same administrative control. The administrative authority is 
supposed to register the DOI number with IANA for its use.

CALIPSO spec is very clear that the first thing IP checks is DOI number. 
IP drops packets if the DOI is unexpected. CALIPSO hasn't changed how 
DOI is used in that regard. Sun's trusted OS has similar behavior for a 
long time. That's DOI for IP module. It appear that labeled NFSv4 wants 
a different DOI, or different semantics of DOI. Using the example above, 
it seems to desire the following semantics:

DOI value      Opaque Security Attribute Field
---------      -------------------------------
    1          CALIPSO MLS label using label encodings shared by A, B
    2          CALIPSO MLS label using label encodings shared by C, D
    3          Redhat DTE label using security policy shared by A, B
    4          OpenSolaris FMAC DTE label using sec policy shared by C, D
    5          BSD's Biba label using security policy shared by C, D
   ....
 
In an MLS example, server host C gets a request from client host A with 
DOI = 1, requester label = CONFIDENTIAL. The client wants to write to 
file foo, which is protected by label INTERNAL under DOI 2. Server C 
validates that CONFIDENTIAL is a defined label in label encodings under 
DOI 1. It then translates the label and concludes that CONFIDENTIAL in 
DOI 1 is equivalent to INTERNAL in DOI 2, it then grants the write 
access to object foo (note in MLS, write access requires labels being 
equal).

I am having difficulty with how to manage DOIs with different 
combinations in the opaque field.

> A CALIPSO DOI is, AFAICT, a DOI that imposes an MLS form on the label
> (though with label encoding being protocol specific) and a security
> policy registration/definition requirement.  CALIPSO also requires that
> a DOI always be explicit.  CALIPSO also imposes a namespace of DOIs, and
> I'm not sure that it allows any DOIs that are not CALIPSO DOIs.  CALIPSO 
>
> In other words, any protocol that carries a {DOI ID, opaque label}
> should be compatible with CALIPSO.
>   

Whenever a packet carries a CALIPSO label, explicit DOI is mandatory.
The DOI is for validation purpose, it doesn't say anything about how the 
node should interpret the label. The "how to" part is already agreed 
upon by the virtue of using the same DOI.

> But an implementation that adheres to CALIPSO will not be able to use
> non-CALIPSO DOIs.  Is that correct?  If so we need to ensure that a
> mapping between MLS and DTE is possible, since David, IIRC, wants
> support for DTE.  But as far as I can tell such a mapping is possible.
>   

If labeled NFSv4 DOI is used to indicate how the opaque field should be 
interpreted, it needs its own DOI, as CALIPSO DOI isn't intended for 
that use. I don't believe this DOI should be in IANA registry. A system 
may support translation of a few MAC labels. Those systems should be 
configured to do so.

> One thing I think is wrong with section 3.1 is that it talks about
> translation of a label "into a form that is usable by the endpoint."
> That's superfluous -- it should suffice to say that the DOI field allows
> the server to know how to interpret the label if it understands the
> given DOI.
>   
>   
>> 4. section 4, the draft should probably state how a MAC client knows 
>> whether the server is MAC aware or not, via configuration? Also how a 
>> MAC aware server knows whether the client is MAC aware, via 
>> configuration or based on the fact that security attributes are present?
>>     
>
> A client has to know a priori somehow whether to trust a server for a
> specific range of labels in some DOI.  The MAC awareness or non-
> awareness of a server relates only to how the label of an object is to
> be determined (MAC server: the server tells you the object's label;
> non-MAC server: the object's location determines the object's label) and
> how authorization is to be done (MAC server: the server does MAC and DAC
> authorization; non-MAC server: the server does DAC and the clients to
> MAC authorization, with the clients having to all have a consistent
> configuration).
>   

I spoke to David about this. He is of the opinion that a MAC aware 
client should not care whether the server is MAC aware. I guess that 
means client always provides label attributes to server, and MAC unaware 
server just ignores it. But I agree with you that MAC aware clients 
should somehow know whether the server is MAC aware so that the client 
is clear on whose responsibility it is to set label of an object. It's 
also more robust to be able to detect the error case where a MAC aware 
server should set label attributes but fails to do so.

>> 6. section 4.1, in full mode, does reply carry a label? It appears to me 
>> that a client never needs to do a DOI translation. The draft should be 
>> more explicit on  that, IMO.
>>     
>
> A client may have to do a DOI translation for reasons unknown to us, but
> we should probably not even mention that.   Is that what you mean?
>   

If a client also needs to do DOI translation, the document should 
explicit about  that and say that replies from server should also carry 
DOI. That way, implementors know what kind of client they need to build 
to be compliant. Requiring client to do translation adds quite a bit of 
complexity. It's probably better not requiring that, until we know for 
sure that is needed.

>   
>> 10. section 7, as stated above, you seem to use the DOI field 
>> differently. It appears that you want the DOI to indicate whether an 
>> NSFv4 server understands the label format AND knows how to interpret the 
>> opaque field. This implies the server has to know all the label 
>> definitions for all valid DOIs.
>>     
>
> Well, for all the DOIs it knows about, for what else is a "valid DOI"?
>   

I still haven't figured out how to use the DOI and the opaque field to 
make different MAC systems to interoperate. We still have some work to 
do to standardize that. If any combination of label format, policy, 
encondings, definition, etc. requires a different DOI, it becomes 
unmanageable quickly.

>   
>>                                 For example, a server must be able to 
>> detect a label is undefined under a DOI although it knows the format of 
>> the label.
>>     
>
> But if the server understands a given DOI then can do that.
>
>   
>>            This may be better solved via configuration instead of going 
>> through IANA. For example, if one wants his server to be able to 
>> translate among three labeling schemes, she/he will configure the system 
>> with all three label definitions, translation tables, modules containing 
>> appropriate label functions and utilities, etc..
>>     
>
> It should be possible for a server to support multiple DOIs without
> necessarily having to know how to translate between them.  Then you get:
> processes with labels in one DOI cannot access objects with labels in
> another.
>   

Yes, that's possible, and this is simpler than having to translate. I 
don't know enough use cases to know whether users keep multiple file 
systems on same server but protect them with two sets of labels.

Thanks.

Jarrett

> Nico
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
