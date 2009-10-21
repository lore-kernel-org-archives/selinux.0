Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9LH7E1w031426
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 13:07:14 -0400
Received: from mta1.srv.hcvlny.cv.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9LH90ps009304
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 17:09:00 GMT
Received: from srv.laga.pri (ool-43568f33.dyn.optonline.net [67.86.143.51])
 by mta1.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0KRV0069MJJZTX50@mta1.srv.hcvlny.cv.net> for
 selinux@tycho.nsa.gov; Wed, 21 Oct 2009 13:07:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])	by srv.laga.pri (Postfix)
 with ESMTP id D316C1B42002	for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 13:07:10 -0400 (EDT)
Received: from srv.laga.pri ([127.0.0.1])
 by localhost (srv.laga.pri [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11501-06 for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 13:07:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])	by srv.laga.pri (Postfix)
 with ESMTP id 76C701B42003	for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 13:07:10 -0400 (EDT)
Received: from [164.55.144.109] (unknown [164.55.254.106])
	by srv.laga.pri (Postfix) with ESMTP id 54C8F1B42002	for
 <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 13:07:09 -0400 (EDT)
Date: Wed, 21 Oct 2009 13:07:09 -0400
From: Eric Laganowski <eric@laganowski.net>
Subject: Re: 'make policy' issues
In-reply-to: <1256144567.4061.223.camel@moss-pluto.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Message-id: <4ADF3FBD.3010306@laganowski.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <4ADF2358.4050606@laganowski.net>
 <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
 <4ADF2663.2030105@laganowski.net>
 <1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>
 <87hbtsvhru.fsf@anzu.internal.golden-gryphon.com>
 <4ADF3D2C.2030408@laganowski.net>
 <1256144567.4061.223.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>>>>   
>>>>         
>>>        Debian currently carries 13 (though 3 of them need to be
>>>  squashed together) patches against 2.5.35. I can make them available if
>>>  there is interest.
>>>
>>>         manoj
>>>   
>>>       
>> Yes please. Patches would be welcome.
>>     
>
> Did you try the three patches that I attached to my email for flex?
>
>   
Yes I did: applied patches and rebuilt checkpolicy-2.0.19, which did not 
resolve the issue.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
