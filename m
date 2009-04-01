Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n317l07g026363
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 03:47:00 -0400
Received: from sca-es-mail-2.sun.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n317ksXa020650
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 07:46:54 GMT
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n317kr80027894
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 00:46:54 -0700 (PDT)
MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_QxkJVpTV9B9arjUiogB7UQ)"
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java(tm) System Messaging Server 7.0-5.01 64bit (built Feb 19 2009))
 id <0KHE00300W6IY600@fe-sfbay-09.sun.com> for selinux@tycho.nsa.gov; Wed,
 01 Apr 2009 00:46:53 -0700 (PDT)
Date: Wed, 01 Apr 2009 00:46:58 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted
 to IETF website
In-reply-to: <200903311047.21216.paul.moore@hp.com>
To: Paul Moore <paul.moore@hp.com>
Cc: labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org
Message-id: <49D31BF2.2040100@sun.com>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
 <49D10FC1.3000103@sun.com> <49D188D6.6020107@schaufler-ca.com>
 <200903311047.21216.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Boundary_(ID_QxkJVpTV9B9arjUiogB7UQ)
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

On 3/31/2009 7:47 AM, Paul Moore wrote:
> On Monday 30 March 2009 11:07:02 pm Casey Schaufler wrote:
>    
>> Jarrett Lu wrote:
>>      
>>> Maybe we can do something better 15 years later. The first step is to
>>> figure out how much information is needed and then look into how to
>>> get this info across securely. GSS_SEC may be able to help us. To make
>>> NFSv4 work, only TCP is needed. So peer information is needed per
>>> session vs. per packet, I believe. Evidently, there is more work to do
>>> in figuring this all out.
>>>        
>> Not to throw a puppy in the gears, but sophisticated handshaking and
>> negotiation protocols are not the answer. We had TSIG session management
>> for doing that and it is just not enough. How would you negotiate the
>> differences between two SELinux policies?
>>      
>
> I'm with Casey, I don't think it is worth spending a whole lot of time right
> now finding out how to pass information across the network in a secure manner.
> There are plenty of ways of to do that which are well established,
> interoperable and generally regarded as "secure".
>    

I'm not reinventing another secure way to pass information. I thought 
kerberos gss api may be a good candidate. I also agree that 
sophisticated handshaking negotiation protocol or complicated security 
attribute mapping between various systems is not the way to go.

>  From my point of view the real issue is how do we translate/resolve security
> labels defined by DOI X to an internal, security model/policy specific label?
> Some have mentioned a mechanism which would serve up label encoding data
> whenever a new system joined the network; unfortunately, I believe this only
> works when you know the security policy of the system before hand (or can
> restrict the security policy, after all a TSOL label encodings file will do
> nothing for SELinux and/or Smack).  While I think it is reasonable to assume a
> limited number of on-the-wire label encodings and DOIs I think it would be a
> mistake to assume a limited number of security models and or policies.
>    

True. The first question is whether we should try to solve, or at least 
ease, the label interpretation / translation problem in the context of 
NFSv4 protocol. I don't know if we can solve it, but it seems worthwhile 
to explore further, to gain more understanding if nothing else. The 
challenge of interpreting and translating labels is that one system 
needs to know a lot of info about its peer. And there is no good way to 
describe the (sometimes subtle) difference. I think this problem may be 
harder on DTE systems than on MLS systems, I believe.

> Ultimately I believe that the required label translation information (wire/DOI
> label to internal and the other way around) is going to need to be bundled
> with the system's security policy and distributed as a single "package".
> Granted this does require prior knowledge of the DOIs in use but I believe
> this is a much easier requirement than the opposite.  From a practical point
> of view this isn't too far removed from the notion of sending sending label
> encoding data upon joining the network, the big difference is that we are
> sending both security policy and label encoding/DOI-translation data at the
> same time (in the TSOL case I suspect this would just be the label encoding
> data, which may mean the original poster had this in mind).
>
>    

Depending how different the systems are, the "package" content will be 
different. Assuming we can assemble all the information required to do 
label translation correctly into a package, passing that around the 
systems seem inefficient, non-scalable, and probably outside the scope 
of labeled NFSv4 enhancement. So realistically, I think the DOI + opaque 
label is useful between very compatible systems. Given that limitation, 
may be the "package" is small enough and can be passed in RPC layer 
during authentication so that MLS can share files with like MLS systems, 
and same is true for DTE, fmac, smack, ....


Jarrett



--Boundary_(ID_QxkJVpTV9B9arjUiogB7UQ)
Content-type: text/html; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
On 3/31/2009 7:47 AM, Paul Moore wrote:
<blockquote cite="mid:200903311047.21216.paul.moore@hp.com" type="cite">
  <pre wrap="">On Monday 30 March 2009 11:07:02 pm Casey Schaufler wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Jarrett Lu wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Maybe we can do something better 15 years later. The first step is to
figure out how much information is needed and then look into how to
get this info across securely. GSS_SEC may be able to help us. To make
NFSv4 work, only TCP is needed. So peer information is needed per
session vs. per packet, I believe. Evidently, there is more work to do
in figuring this all out.
      </pre>
    </blockquote>
    <pre wrap="">Not to throw a puppy in the gears, but sophisticated handshaking and
negotiation protocols are not the answer. We had TSIG session management
for doing that and it is just not enough. How would you negotiate the
differences between two SELinux policies?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'm with Casey, I don't think it is worth spending a whole lot of time right 
now finding out how to pass information across the network in a secure manner.  
There are plenty of ways of to do that which are well established, 
interoperable and generally regarded as "secure".
  </pre>
</blockquote>
<br>
I'm not reinventing another secure way to pass information. I thought
kerberos gss api may be a good candidate. I also agree that
sophisticated handshaking negotiation protocol or complicated security
attribute mapping between various systems is not the way to go.<br>
<br>
<blockquote cite="mid:200903311047.21216.paul.moore@hp.com" type="cite">
  <pre wrap="">
>From my point of view the real issue is how do we translate/resolve security 
labels defined by DOI X to an internal, security model/policy specific label?  
Some have mentioned a mechanism which would serve up label encoding data 
whenever a new system joined the network; unfortunately, I believe this only 
works when you know the security policy of the system before hand (or can 
restrict the security policy, after all a TSOL label encodings file will do 
nothing for SELinux and/or Smack).  While I think it is reasonable to assume a 
limited number of on-the-wire label encodings and DOIs I think it would be a 
mistake to assume a limited number of security models and or policies.
  </pre>
</blockquote>
<br>
True. The first question is whether we should try to solve, or at least
ease, the label interpretation / translation problem in the context of
NFSv4 protocol. I don't know if we can solve it, but it seems
worthwhile to explore further, to gain more understanding if nothing
else. The challenge of interpreting and translating labels is that one
system needs to know a lot of info about its peer. And there is no good
way to describe the (sometimes subtle) difference. I think this problem
may be harder on DTE systems than on MLS systems, I believe. <br>
<br>
<blockquote cite="mid:200903311047.21216.paul.moore@hp.com" type="cite">
  <pre wrap="">
Ultimately I believe that the required label translation information (wire/DOI 
label to internal and the other way around) is going to need to be bundled 
with the system's security policy and distributed as a single "package".  
Granted this does require prior knowledge of the DOIs in use but I believe 
this is a much easier requirement than the opposite.  From a practical point 
of view this isn't too far removed from the notion of sending sending label 
encoding data upon joining the network, the big difference is that we are 
sending both security policy and label encoding/DOI-translation data at the 
same time (in the TSOL case I suspect this would just be the label encoding 
data, which may mean the original poster had this in mind).

  </pre>
</blockquote>
<br>
Depending how different the systems are, the "package" content will be
different. Assuming we can assemble all the information required to do
label translation correctly into a package, passing that around the
systems seem inefficient, non-scalable, and probably outside the scope
of labeled NFSv4 enhancement. So realistically, I think the DOI +
opaque label is useful between very compatible systems. Given that
limitation, may be the "package" is small enough and can be passed in
RPC layer during authentication so that MLS can share files with like
MLS systems, and same is true for DTE, fmac, smack, ....<br>
<br>
<br>
Jarrett<br>
<br>
<br>
</body>
</html>

--Boundary_(ID_QxkJVpTV9B9arjUiogB7UQ)--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
