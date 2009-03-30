MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_QP+z+zWbk75jViLyMyQEwQ)"
Date: Mon, 30 Mar 2009 11:30:25 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted
 to IETF	website
In-reply-to: <1238434634.2484.90.camel@localhost.localdomain>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org
Message-id: <49D10FC1.3000103@sun.com>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
 <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM>
 <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM>
 <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM>
 <1238158539.15207.6.camel@localhost.localdomain>
 <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com>
 <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com>
 <1238434634.2484.90.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Boundary_(ID_QP+z+zWbk75jViLyMyQEwQ)
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

On 03/30/09 10:37, Stephen Smalley wrote:
> On Fri, 2009-03-27 at 11:56 -0700, Jarrett Lu wrote:
>   
>> Nicolas Williams wrote:
>>     
>>> On Fri, Mar 27, 2009 at 10:03:35AM -0700, Jarrett Lu wrote:
>>>   
>>>       
>>>> I agree with your statements on TE vs. MLS/BLP. The problem we try to 
>>>> solve is whether a DOI field + an opaque string is sufficient to solve 
>>>> the interoperability problem. My opinion is that it's insufficient as it 
>>>> doesn't take the "how to interpret MAC attribute agreement among all 
>>>> communicating peers" into account. The current proposal seems to assume 
>>>> when a node sees a DOI value of 5, it knows how to interpret the opaque 
>>>> field. This may not be true. In MLS, one also needs to know which agreed 
>>>> upon label encoding file to use in order to interpret label in the 
>>>> opaque filed. I believe the same is true for TE -- one needs to know the 
>>>> security policy being used in order to correctly interpret security 
>>>> context string in the opaque field. DOI + opaque field doesn't say which 
>>>> label encoding scheme or which security policy.
>>>>     
>>>>         
>>> What would you add or remove on the wire to solve this problem?  My
>>> guess: a registry of per-DOI rules, like CALIPSO does.  I don't think a
>>> registry of DOI rules is strictly necessary for NFS (though I can see
>>> how it helps in the case of IP), but I certainly don't object.
>>>   
>>>       
>> I don't yet see a good way to solve this problem using bits on the wire. 
>> The agreement on what label encodings or security policy to use seems 
>> better solved in an out of band manner. For example, on a (secure) 
>> website, you can say "download this label encoding file or configure 
>> your MAC system with this policy and use DOI number 5. Then we can talk".
>>
>> BTW, CALIPSO with IP module has the same issue. While the spec talks a 
>> lot about how a CALIPSO  system should behave, CALIPSO can't tell its 
>> peers to use a particular label encoding. That's done outside CALIPSO.
>>
>> I believe it's still worthwhile to request adding a DOI + an opaque 
>> field in NFSv4 protocol. The spec should be clear that other 
>> arrangements need to be made before interoperability can take place.
>>
>> Once we decouple DOI from how the opaque field should be interpreted, 
>> it's possible for NFSv4 to use CALIPSO DOI. For example, DOD can reserve 
>> DOI 1000 through 1005. It can then decide that 1000 is only used by MLS 
>> systems with a particular label encoding; and 1004 is for TE systems 
>> configured with a particular secular security policy. As long as all 
>> systems using these DOIs agreeing to that, they can communicate with 
>> each other. But the agreement happens outside NFSv4 protocol itself. I 
>> understand this is different from the public internet where all you need 
>> is an IP address to communicate. But this is how MAC systems are used, I 
>> believe.
>>     
>
> I'm not sure if this conflicts with what you are saying, but the DOI
> should merely identify the (externally) agreed-upon network label space
> for the data to be shared between the communicating systems.  That label
> space shouldn't need to be identical to the native/host label spaces of
> any of the individual systems; they just need to have a way of mapping
> between their host label spaces and the network label space identified
> by the DOI in a manner that preserves their security goals.  The two
> systems shouldn't necessarily have to share a label encodings file or
> security policy configuration in order to communicate using a given DOI.
>
>   

As Casey and others pointed out, a lot more information about a 
communicating peer is needed in order to be able to translate a label 
and other security attributes. People have tried this in 90's. 
Apparently the solution is no longer in use today. Maybe we can do 
something better 15 years later. The first step is to figure out how 
much information is needed and then look into how to get this info 
across securely. GSS_SEC may be able to help us. To make NFSv4 work, 
only TCP is needed. So peer information is needed per session vs. per 
packet, I believe. Evidently, there is more work to do in figuring this 
all out.

A process related question: Should we move the "design" related 
discussion to a smaller alias? I assume most people don't care about the 
details and prefer not see this in their email inbox. I set up a mail 
alias, doi-discuss@opensolaris.org, a few months ago for a similar 
discussion. If people think that's a good way to go, I can provide more 
info.

Jarrett

--Boundary_(ID_QP+z+zWbk75jViLyMyQEwQ)
Content-type: text/html; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
On 03/30/09 10:37, Stephen Smalley wrote:
<blockquote cite="mid:1238434634.2484.90.camel@localhost.localdomain"
 type="cite">
  <pre wrap="">On Fri, 2009-03-27 at 11:56 -0700, Jarrett Lu wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Nicolas Williams wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">On Fri, Mar 27, 2009 at 10:03:35AM -0700, Jarrett Lu wrote:
  
      </pre>
      <blockquote type="cite">
        <pre wrap="">I agree with your statements on TE vs. MLS/BLP. The problem we try to 
solve is whether a DOI field + an opaque string is sufficient to solve 
the interoperability problem. My opinion is that it's insufficient as it 
doesn't take the "how to interpret MAC attribute agreement among all 
communicating peers" into account. The current proposal seems to assume 
when a node sees a DOI value of 5, it knows how to interpret the opaque 
field. This may not be true. In MLS, one also needs to know which agreed 
upon label encoding file to use in order to interpret label in the 
opaque filed. I believe the same is true for TE -- one needs to know the 
security policy being used in order to correctly interpret security 
context string in the opaque field. DOI + opaque field doesn't say which 
label encoding scheme or which security policy.
    
        </pre>
      </blockquote>
      <pre wrap="">What would you add or remove on the wire to solve this problem?  My
guess: a registry of per-DOI rules, like CALIPSO does.  I don't think a
registry of DOI rules is strictly necessary for NFS (though I can see
how it helps in the case of IP), but I certainly don't object.
  
      </pre>
    </blockquote>
    <pre wrap="">I don't yet see a good way to solve this problem using bits on the wire. 
The agreement on what label encodings or security policy to use seems 
better solved in an out of band manner. For example, on a (secure) 
website, you can say "download this label encoding file or configure 
your MAC system with this policy and use DOI number 5. Then we can talk".

BTW, CALIPSO with IP module has the same issue. While the spec talks a 
lot about how a CALIPSO  system should behave, CALIPSO can't tell its 
peers to use a particular label encoding. That's done outside CALIPSO.

I believe it's still worthwhile to request adding a DOI + an opaque 
field in NFSv4 protocol. The spec should be clear that other 
arrangements need to be made before interoperability can take place.

Once we decouple DOI from how the opaque field should be interpreted, 
it's possible for NFSv4 to use CALIPSO DOI. For example, DOD can reserve 
DOI 1000 through 1005. It can then decide that 1000 is only used by MLS 
systems with a particular label encoding; and 1004 is for TE systems 
configured with a particular secular security policy. As long as all 
systems using these DOIs agreeing to that, they can communicate with 
each other. But the agreement happens outside NFSv4 protocol itself. I 
understand this is different from the public internet where all you need 
is an IP address to communicate. But this is how MAC systems are used, I 
believe.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'm not sure if this conflicts with what you are saying, but the DOI
should merely identify the (externally) agreed-upon network label space
for the data to be shared between the communicating systems.  That label
space shouldn't need to be identical to the native/host label spaces of
any of the individual systems; they just need to have a way of mapping
between their host label spaces and the network label space identified
by the DOI in a manner that preserves their security goals.  The two
systems shouldn't necessarily have to share a label encodings file or
security policy configuration in order to communicate using a given DOI.

  </pre>
</blockquote>
<br>
As Casey and others pointed out, a lot more information about a
communicating peer is needed in order to be able to translate a label
and other security attributes. People have tried this in 90's.
Apparently the solution is no longer in use today. Maybe we can do
something better 15 years later. The first step is to figure out how
much information is needed and then look into how to get this info
across securely. GSS_SEC may be able to help us. To make NFSv4 work,
only TCP is needed. So peer information is needed per session vs. per
packet, I believe. Evidently, there is more work to do in figuring this
all out.<br>
<br>
A process related question: Should we move the "design" related
discussion to a smaller alias? I assume most people don't care about
the details and prefer not see this in their email inbox. I set up a
mail alias, <a class="moz-txt-link-abbreviated" href="mailto:doi-discuss@opensolaris.org">doi-discuss@opensolaris.org</a>, a few months ago for a similar
discussion. If people think that's a good way to go, I can provide more
info.<br>
<br>
Jarrett<br>
</body>
</html>

--Boundary_(ID_QP+z+zWbk75jViLyMyQEwQ)--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
