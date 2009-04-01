Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3189NSH029905
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 04:09:24 -0400
Received: from sca-es-mail-2.sun.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3189Buv023982
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 08:09:11 GMT
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n3189AZb028950
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 01:09:10 -0700 (PDT)
MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_KIDibbqR6u8WxmC6InWvFA)"
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java(tm) System Messaging Server 7.0-5.01 64bit (built Feb 19 2009))
 id <0KHE00E00X8XQO00@fe-sfbay-09.sun.com> for selinux@tycho.nsa.gov; Wed,
 01 Apr 2009 01:09:10 -0700 (PDT)
Date: Wed, 01 Apr 2009 01:09:16 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft posted
 to IETF website
In-reply-to: <alpine.LRH.2.00.0904011751320.21948@tundra.namei.org>
To: James Morris <jmorris@namei.org>
Cc: Nicolas Williams <Nicolas.Williams@sun.com>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org
Message-id: <49D3212C.9070002@sun.com>
References: <20090327001102.GU9992@Sun.COM>
 <1238158539.15207.6.camel@localhost.localdomain>
 <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com>
 <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com>
 <1238434634.2484.90.camel@localhost.localdomain> <49D10FC1.3000103@sun.com>
 <1238447664.2484.119.camel@localhost.localdomain> <49D1B133.3010907@sun.com>
 <20090331182851.GG9992@Sun.COM> <49D2E073.3060003@sun.com>
 <alpine.LRH.2.00.0904011751320.21948@tundra.namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Boundary_(ID_KIDibbqR6u8WxmC6InWvFA)
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

On 3/31/2009 11:58 PM, James Morris wrote:
> On Tue, 31 Mar 2009, Jarrett Lu wrote:
>
>    
>> I'm in general agreement with you on this. I am not sure to what extent
>> the extensibility stuff makes sense, e.g. how much may be enough? I
>> guess we need to study more use scenarios. I suspect TE systems may have
>> more challenges in this area, just because security policies on TE
>> systems tend to be more flexible. For example, how many things are
>> critical in order to translate label correctly, OS version, vendor,
>> label parser, security policy file? How likely DTE systems are
>> configured with exact same policy files? Does it make sense that a
>> (harmless) update to security policy file causes label translation
>> failures from that point on?
>>      
>
> With SELinux systems, policies do not need to be identical to be
> considered part of the same DOI.  Generally, labels need to remain
> semantically equivalent (i.e. mean the same thing on each system), and the
> policies need to be managed within the same administrative boundary.
> Systems may restrict which labels they'll interpret from remote systems
> (similar to root_squash).
>
>    

Understood. My point is that a signature on a policy file may not always 
be the right tool to determine whether label translation should be done. 
When policies are different on two systems, how does one system know 
labels or types are semantically equivalent or not? Are you also saying 
that DOI is tied to administrative boundary, and the fact that systems 
using the same DOI implies the label and type definitions in each policy 
are always semantically equivalent?


Jarrett

> - James
>    


--Boundary_(ID_KIDibbqR6u8WxmC6InWvFA)
Content-type: text/html; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
On 3/31/2009 11:58 PM, James Morris wrote:
<blockquote
 cite="mid:alpine.LRH.2.00.0904011751320.21948@tundra.namei.org"
 type="cite">
  <pre wrap="">On Tue, 31 Mar 2009, Jarrett Lu wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">I'm in general agreement with you on this. I am not sure to what extent 
the extensibility stuff makes sense, e.g. how much may be enough? I 
guess we need to study more use scenarios. I suspect TE systems may have 
more challenges in this area, just because security policies on TE 
systems tend to be more flexible. For example, how many things are 
critical in order to translate label correctly, OS version, vendor, 
label parser, security policy file? How likely DTE systems are 
configured with exact same policy files? Does it make sense that a 
(harmless) update to security policy file causes label translation 
failures from that point on?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
With SELinux systems, policies do not need to be identical to be 
considered part of the same DOI.  Generally, labels need to remain 
semantically equivalent (i.e. mean the same thing on each system), and the 
policies need to be managed within the same administrative boundary. 
Systems may restrict which labels they'll interpret from remote systems 
(similar to root_squash).

  </pre>
</blockquote>
<br>
Understood. My point is that a signature on a policy file may not
always be the right tool to determine whether label translation should
be done. When policies are different on two systems, how does one
system know labels or types are semantically equivalent or not? Are you
also saying that DOI is tied to administrative boundary, and the fact
that systems using the same DOI implies the label and type definitions
in each policy are always semantically equivalent?<br>
<br>
<br>
Jarrett<br>
<br>
<blockquote
 cite="mid:alpine.LRH.2.00.0904011751320.21948@tundra.namei.org"
 type="cite">
  <pre wrap="">
- James
  </pre>
</blockquote>
<br>
</body>
</html>

--Boundary_(ID_KIDibbqR6u8WxmC6InWvFA)--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
