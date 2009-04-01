MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Date: Tue, 31 Mar 2009 20:33:07 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted
 to IETF	website
In-reply-to: <20090331182851.GG9992@Sun.COM>
To: Nicolas Williams <Nicolas.Williams@sun.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfs-discuss@opensolaris.org, nfsv4@ietf.org
Message-id: <49D2E073.3060003@sun.com>
References: <20090327001102.GU9992@Sun.COM>
 <1238158539.15207.6.camel@localhost.localdomain>
 <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com>
 <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com>
 <1238434634.2484.90.camel@localhost.localdomain> <49D10FC1.3000103@sun.com>
 <1238447664.2484.119.camel@localhost.localdomain> <49D1B133.3010907@sun.com>
 <20090331182851.GG9992@Sun.COM>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nicolas Williams wrote:
> On Mon, Mar 30, 2009 at 10:59:15PM -0700, Jarrett Lu wrote:
>   
>> That's certainly one option. We can say DOI + an opaque field is what we 
>> will add to NFSv4 protocol. Use the information as you see fit. Going 
>>     
>
> That's what David's I-D and what my RPCSEC_GSSv3 I-D both say now.
>   

If we stop here, we don't have much of an interoperability story. I 
thought it is one of the things we are aiming for. We can say "give us 
an opaque field and we (the MAC systems) will decide how and when to use 
it. NFSv4 WG and ADs still want to know how this opaque field may be 
used. They are less willing to hand out "opaque" field just because 
someone asked for one. At least this is the impression I got at IETF74 
in SF.

> It's also what CALIPSO does (except that the label must be MLS and the
> bits on the wire are defined, though the actual sentivity levels and
> compartment naming and mapping to bits is not).
>   

Right. This makes it easier for systems speaking CALIPSO protocol to 
interoperate at IP layer. Compliant hosts and routers know how to deal 
with packets with that option. Label translation between different DOIs 
is out of scope.

>   
>> this route, we basically punt on the label interpretation / translation 
>> problem. I believe this simple DOI + opaque attribute does add value as 
>> it provides an potentially easier way for compatible systems to 
>> communicate label attributes on file objects. I was trying to explore 
>> whether it makes sense to include other information (e.g. OS version, 
>> signature of security policy or label encoding files) to make handling 
>> of label interpretation and translation easier.
>>     
>
> Signature of security policy is certainly an interesting idea!  But it
> does require defining a standard security policy description syntax --
> that's work that I think is well outside what this WG should be working
> on.  (Also, we'll need hash function agility.)
>
> Therefore I think the NFSv4 community should stop at either
>
>  - {DOI #, opaque label, hash function name, hash-of-policy}
>    (which means blocking on a standards-track labeled policy document)
>
> or, more likely,
>
>  - {DOI #, opaque label, [extensibility field for future hash function
>    name / hash-of-policy]}.
>
> The latter seems better to me because {DOI #, opaque label} is the easy
> way forward for this WG, but we'd make room for a future hash-of-policy.
>   

I'm in general agreement with you on this. I am not sure to what extent 
the extensibility stuff makes sense, e.g. how much may be enough? I 
guess we need to study more use scenarios. I suspect TE systems may have 
more challenges in this area, just because security policies on TE 
systems tend to be more flexible. For example, how many things are 
critical in order to translate label correctly, OS version, vendor, 
label parser, security policy file? How likely DTE systems are 
configured with exact same policy files? Does it make sense that a 
(harmless) update to security policy file causes label translation 
failures from that point on?

> I think the security area of the IETF should explore Kerberos V
> authz-data and PKIX certificate extensions to ensure DOI label encoding
> synchronization (whether based on my sketch or some other approach) as
> well as a common labeled security policy syntax covering MLS and DTE.
>
> I know, where each set of documents gets done is a subtle distinction
> when it might well be the same people doing all of them.  But it's an
> important distinction here.
>
> Also, it's possible that some of this work will be done in the form of
> individual submission I-Ds all the way if it doesn't naturally fit any
> WG and we don't have enough work to justify spinning up a new WG.  But
> we'd still seek review in the appropriate WGs (NFSv4 WG for NFS work,
> KRB-WG for Kerberos work, PKIX WG for PKIX work, SAAG for labeled
> security policy description).
>
> (Between CALIPSO and NFSv4 and all the other potential work mentioned
> above we might well have enough work for a new WG.  But I think we
> should proceed as though we don't, for now.)
>   

No disagreement here either. At the end of this scoping exercise, we'll 
hopefully know how big a bite we can chew. I believe the DOI + opaque 
field may be useful to identical or compatible system under same 
administrative control. To push David's draft forward, I believe we 
still need to understand more about how different systems may use the 
opaque field and decide if it makes sense to propose extensibility 
fields for future use.


Jarrett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
