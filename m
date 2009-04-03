Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n331KgQr025212
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 21:20:42 -0400
Received: from sca-es-mail-1.sun.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n331Kedf028512
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 01:20:41 GMT
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n331Keux017088
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 18:20:40 -0700 (PDT)
MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_VlybYQSqudTqWn+HJPTg1w)"
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java(tm) System Messaging Server 7.0-5.01 64bit (built Feb 19 2009))
 id <0KHI00F003LZDW00@fe-sfbay-10.sun.com> for selinux@tycho.nsa.gov; Thu,
 02 Apr 2009 18:20:40 -0700 (PDT)
Date: Thu, 02 Apr 2009 18:21:08 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted
 to IETF website
In-reply-to: <200904011246.33436.paul.moore@hp.com>
To: Paul Moore <paul.moore@hp.com>
Cc: labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org
Message-id: <49D56484.50401@sun.com>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
 <200903311047.21216.paul.moore@hp.com> <49D31BF2.2040100@sun.com>
 <200904011246.33436.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Boundary_(ID_VlybYQSqudTqWn+HJPTg1w)
Content-type: text/plain; format=flowed; charset=ISO-8859-15
Content-transfer-encoding: 7BIT

On 04/01/09 09:46, Paul Moore wrote:
> On Wednesday 01 April 2009 03:46:58 am Jarrett Lu wrote:
>   
>
[ ... ]
>
>   
>> The challenge of interpreting and translating labels is that one system
>> needs to know a lot of info about its peer. And there is no good way to
>> describe the (sometimes subtle) difference. I think this problem may be
>> harder on DTE systems than on MLS systems, I believe.
>>     
>
> I'm not sure we will ever be able to arrive at a solution that requires a 
> system to be able to understand the security policy/labels of another; things 
> change to much and I don't think anyone's crystal ball is that good.  
> Personally I think the best we can do is hope for a solution that allows a 
> system to understand a security policy/label system defined by a pre-existing 
> DOI definition.  If we can do that then we can at least allow two different 
> systems to communicate via an agreed upon DOI regardless of their internal 
> security policies/labels.  I'll admit it isn't perfect, but I think the 
> problem space is much smaller and likely to have less churn over time.
>   

This comes back to semantics of DOI. So far, I heard two slightly 
different versions:
(1) DOI is a key to a set of label parsing functions. Knowing the DOI 
value implies the parser on the system knows how to parse the octet 
string in opaque field. It says nothing about whether a peer's label can 
be correctly interpreted. I believe Daivd's draft uses this definition. 
(2) In addition to being able to parse the opaque field, DOI also 
implies communicating systems have consistent label policy and encoding. 
Systems with inconsistent policies are not supposed to use same DOI. 
This definition is closer to the CALIPSO DOI, and is how MLS systems use 
DOI today.

While (1) is easier to specify on the wire, I am not clear on what it 
takes to use it safely even when OOB methods are used. Since this 
definition doesn't say who should use this DOI and who is not supposed 
to, what happens when a node, which has not consented to the agreement 
over the OOB method, uses the same DOI and octet string format but with 
inconsistent label policy? (2) has an easier usage model, IMO. But it's 
harder to define a "pre-existing" DOI., e.g.  define DOI X to mean 
vendor ABC, OS version 1.0, label policy 2.0, label parser version 3.0, 
etc., and store that in some kind of registry. I think Nico's "URL 
during authentication" idea is interesting.

>>> Ultimately I believe that the required label translation information
>>> (wire/DOI label to internal and the other way around) is going to need to
>>> be bundled with the system's security policy and distributed as a single
>>> "package". Granted this does require prior knowledge of the DOIs in use
>>> but I believe this is a much easier requirement than the opposite.  From
>>> a practical point of view this isn't too far removed from the notion of
>>> sending sending label encoding data upon joining the network, the big
>>> difference is that we are sending both security policy and label
>>> encoding/DOI-translation data at the same time (in the TSOL case I
>>> suspect this would just be the label encoding data, which may mean the
>>> original poster had this in mind).
>>>       
>> Depending how different the systems are, the "package" content will be
>> different.
>>     
>
> Yep, that is the point; squares hole need square pegs, round holes need round 
> pegs.
>
>   
>> Assuming we can assemble all the information required to do
>> label translation correctly into a package, passing that around the
>> systems seem inefficient, non-scalable ...
>>     
>
> Honestly I don't see it as being that far removed from many of the current 
> solutions that ship "security policy" to individual systems through the 
> network/enterprise.  Also look at some of the NAC stuff that is being used 
> these days, how is a security policy/translation "package" all that different 
> from an anti-virus update or a set of os/application patches?
>
> It is a solvable problem, or at least one that users have shown a willingness 
> to tolerate.
>   

I was thinking how to do that within a protocol enhancement.

>   
>> ... and probably outside the scope of labeled NFSv4 enhancement.
>>     
>
> Perhaps.  Keep in mind I'm trying to think a bit more generically; if that 
> isn't the goal I'll be happy to go back to my corner and sit quietly :)
>
>   
>> So realistically, I think the DOI + opaque label is useful between very
>> compatible systems.
>>     
>
> Of course.  I agree there are a lot of things you can do with a DOI + opaque 
> label, especially if you are only concerned about end-to-end security issues 
> which I believe is the case for labeled NFS.
>
>   
>> Given that limitation, may be the "package" is small enough and can be
>> passed in RPC layer during authentication so that MLS can share files with
>> like MLS systems, and same is true for DTE, fmac, smack, ....
>>     
>
> Well, I think all that the opaque label buys you is the ability to limit who 
> you share the security policy/translation "package" with, as those systems 
> that participate in the labeled communication (be it NFS, generic IP or some 
> other random service) still need to worry about label translation and security 
> policy differences if they want to enforce policy locally.
>   

I am still trying to understand what is needed to make safe sharing 
possible. BTW, are you implying that it's always necessary to do one 
label translation, e.g. from on-the-wire format to a native label format?


Jarrett



--Boundary_(ID_VlybYQSqudTqWn+HJPTg1w)
Content-type: text/html; charset=ISO-8859-15
Content-transfer-encoding: 8BIT

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-15"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
On 04/01/09 09:46, Paul Moore wrote:
<blockquote cite="mid:200904011246.33436.paul.moore@hp.com" type="cite">
  <pre wrap="">On Wednesday 01 April 2009 03:46:58 am Jarrett Lu wrote:
  </pre>
  <br>
</blockquote>
[ ... ]<br>
<blockquote cite="mid:200904011246.33436.paul.moore@hp.com" type="cite">
  <pre wrap="">

  </pre>
  <blockquote type="cite">
    <pre wrap="">The challenge of interpreting and translating labels is that one system
needs to know a lot of info about its peer. And there is no good way to
describe the (sometimes subtle) difference. I think this problem may be
harder on DTE systems than on MLS systems, I believe.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'm not sure we will ever be able to arrive at a solution that requires a 
system to be able to understand the security policy/labels of another; things 
change to much and I don't think anyone's crystal ball is that good.  
Personally I think the best we can do is hope for a solution that allows a 
system to understand a security policy/label system defined by a pre-existing 
DOI definition.  If we can do that then we can at least allow two different 
systems to communicate via an agreed upon DOI regardless of their internal 
security policies/labels.  I'll admit it isn't perfect, but I think the 
problem space is much smaller and likely to have less churn over time.
  </pre>
</blockquote>
<br>
This comes back to semantics of DOI. So far, I heard two slightly
different versions:<br>
(1) DOI is a key to a set of label parsing functions. Knowing the DOI
value implies the parser on the system knows how to parse the octet
string in opaque field. It says nothing about whether a peer's label
can be correctly interpreted. I believe Daivd's draft uses this
definition. (2) In addition to being able to parse the opaque field,
DOI also implies communicating systems have consistent label policy and
encoding. Systems with inconsistent policies are not supposed to use
same DOI. This definition is closer to the CALIPSO DOI, and is how MLS
systems use DOI today. <br>
<br>
While (1) is easier to specify on the wire, I am not clear on what it
takes to use it safely even when OOB methods are used. Since this
definition doesn't say who should use this DOI and who is not supposed
to, what happens when a node, which has not consented to the agreement
over the OOB method, uses the same DOI and octet string format but with
inconsistent label policy? (2) has an easier usage model, IMO. But it's
harder to define a "pre-existing" DOI., e.g.  define DOI X to mean
vendor ABC, OS version 1.0, label policy 2.0, label parser version 3.0,
etc., and store that in some kind of registry. I think Nico's "URL
during authentication" idea is interesting.<br>
<br>
<blockquote cite="mid:200904011246.33436.paul.moore@hp.com" type="cite">
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">Ultimately I believe that the required label translation information
(wire/DOI label to internal and the other way around) is going to need to
be bundled with the system's security policy and distributed as a single
"package". Granted this does require prior knowledge of the DOIs in use
but I believe this is a much easier requirement than the opposite.  From
a practical point of view this isn't too far removed from the notion of
sending sending label encoding data upon joining the network, the big
difference is that we are sending both security policy and label
encoding/DOI-translation data at the same time (in the TSOL case I
suspect this would just be the label encoding data, which may mean the
original poster had this in mind).
      </pre>
    </blockquote>
    <pre wrap="">Depending how different the systems are, the "package" content will be
different.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yep, that is the point; squares hole need square pegs, round holes need round 
pegs.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Assuming we can assemble all the information required to do
label translation correctly into a package, passing that around the
systems seem inefficient, non-scalable ...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Honestly I don't see it as being that far removed from many of the current 
solutions that ship "security policy" to individual systems through the 
network/enterprise.  Also look at some of the NAC stuff that is being used 
these days, how is a security policy/translation "package" all that different 
from an anti-virus update or a set of os/application patches?

It is a solvable problem, or at least one that users have shown a willingness 
to tolerate.
  </pre>
</blockquote>
<br>
I was thinking how to do that within a protocol enhancement.<br>
<br>
<blockquote cite="mid:200904011246.33436.paul.moore@hp.com" type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">... and probably outside the scope of labeled NFSv4 enhancement.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Perhaps.  Keep in mind I'm trying to think a bit more generically; if that 
isn't the goal I'll be happy to go back to my corner and sit quietly :)

  </pre>
  <blockquote type="cite">
    <pre wrap="">So realistically, I think the DOI + opaque label is useful between very
compatible systems.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Of course.  I agree there are a lot of things you can do with a DOI + opaque 
label, especially if you are only concerned about end-to-end security issues 
which I believe is the case for labeled NFS.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Given that limitation, may be the "package" is small enough and can be
passed in RPC layer during authentication so that MLS can share files with
like MLS systems, and same is true for DTE, fmac, smack, ....
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well, I think all that the opaque label buys you is the ability to limit who 
you share the security policy/translation "package" with, as those systems 
that participate in the labeled communication (be it NFS, generic IP or some 
other random service) still need to worry about label translation and security 
policy differences if they want to enforce policy locally.
  </pre>
</blockquote>
<br>
I am still trying to understand what is needed to make safe sharing
possible. BTW, are you implying that it's always necessary to do one
label translation, e.g. from on-the-wire format to a native label
format?<br>
<br>
<br>
Jarrett<br>
<br>
<br>
</body>
</html>

--Boundary_(ID_VlybYQSqudTqWn+HJPTg1w)--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
