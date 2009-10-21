Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9LFJCpt013931
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 11:19:12 -0400
Received: from mta4.srv.hcvlny.cv.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9LFKwIe001296
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 15:20:58 GMT
Received: from srv.laga.pri (ool-43568f33.dyn.optonline.net [67.86.143.51])
 by mta4.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0KRV00GYQEJPSX70@mta4.srv.hcvlny.cv.net> for
 selinux@tycho.nsa.gov; Wed, 21 Oct 2009 11:19:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])	by srv.laga.pri (Postfix)
 with ESMTP id 4361A1B42002	for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 11:19:01 -0400 (EDT)
Received: from srv.laga.pri ([127.0.0.1])
 by localhost (srv.laga.pri [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10256-10 for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 11:19:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])	by srv.laga.pri (Postfix)
 with ESMTP id DEA741B42003	for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 11:19:00 -0400 (EDT)
Received: from [164.55.144.109] (unknown [164.55.254.106])
	by srv.laga.pri (Postfix) with ESMTP id B67FC1B42002	for
 <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 11:19:00 -0400 (EDT)
Date: Wed, 21 Oct 2009 11:18:59 -0400
From: Eric Laganowski <eric@laganowski.net>
Subject: Re: 'make policy' issues
In-reply-to: <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Message-id: <4ADF2663.2030105@laganowski.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <4ADF2358.4050606@laganowski.net>
 <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2009-10-21 at 11:06 -0400, Eric Laganowski wrote:
>   
>> Hello,
>>
>>  I was trying to build selinux userspace tools on my custom linux build. 
>> Everything went fine until I attempted to compile reference policy.
>> Could you please help me in understanding what went wrong here.
>>
>> refpolicy-2.20090730
>>
>> $ make policy
>> Compiling refpolicy policy.24
>> /usr/bin/checkpolicy policy.conf -o policy.24
>> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
>> policy/modules/kernel/corenetwork.te":1715:ERROR 'syntax error' at token ':' on line 9122:
>> allow corenet_unconfined_type node_type:node *;
>>
>> checkpolicy:  error(s) encountered while parsing configuration
>> make: *** [policy.24] Error 1
>>
>>
>> Packages:
>>
>> checkpolicy-2.0.19
>> libselinux-2.0.85
>> libsemanage-2.0.33
>> libsepol-2.0.37
>> policycoreutils-2.0.69
>> sepolgen-1.0.17
>>
>> $ yacc -V
>> yacc - 1.9 20090221
>> $ flex -V
>> flex 2.5.35
>>     
>
> Sounds similar to:
> http://marc.info/?l=selinux&m=117076095205821&w=2
>
> which was an upstream flex problem.  However, I also see that you are using yacc rather than bison?
> Default for building checkpolicy is bison -y, which could be relevant.
>   
Re bison/yacc: I tried both, byacc and 'bison -y'
Re flex: What is the requirement for flex from selinux perspective? Is 
it known what build of flex is "known good"?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
