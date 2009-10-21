Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9LGuIw7029640
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 12:56:18 -0400
Received: from mta5.srv.hcvlny.cv.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9LGtOih019107
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 16:55:24 GMT
Received: from srv.laga.pri (ool-43568f33.dyn.optonline.net [67.86.143.51])
 by mta5.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0KRV00DW5J1QT1E0@mta5.srv.hcvlny.cv.net> for
 selinux@tycho.nsa.gov; Wed, 21 Oct 2009 12:56:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])	by srv.laga.pri (Postfix)
 with ESMTP id 71B7E1B42002	for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 12:56:14 -0400 (EDT)
Received: from srv.laga.pri ([127.0.0.1])
 by localhost (srv.laga.pri [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11501-04 for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 12:56:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])	by srv.laga.pri (Postfix)
 with ESMTP id F22891B42003	for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 12:56:13 -0400 (EDT)
Received: from [164.55.144.109] (unknown [164.55.254.106])
	by srv.laga.pri (Postfix) with ESMTP id C1C6E1B42002	for
 <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 12:56:13 -0400 (EDT)
Date: Wed, 21 Oct 2009 12:56:12 -0400
From: Eric Laganowski <eric@laganowski.net>
Subject: Re: 'make policy' issues
In-reply-to: <87hbtsvhru.fsf@anzu.internal.golden-gryphon.com>
To: selinux@tycho.nsa.gov
Message-id: <4ADF3D2C.2030408@laganowski.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <4ADF2358.4050606@laganowski.net>
 <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
 <4ADF2663.2030105@laganowski.net>
 <1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>
 <87hbtsvhru.fsf@anzu.internal.golden-gryphon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Manoj Srivastava wrote:
> On Wed, Oct 21 2009, Stephen Smalley wrote:
>   
>>> Re flex: What is the requirement for flex from selinux perspective? Is 
>>> it known what build of flex is "known good"?
>>>       
>> My impression is that one of the patches carried by the distributions
>> for flex is needed for checkpolicy to work, but no one has ever fully
>> investigated the precise dependency - people just grab the Fedora srpm
>> and apply those patches to flex, and then rebuild checkpolicy and it
>> works.  I haven't seen any complaints from Debian or Gentoo so I presume
>> that they also carry the same patches for flex.
>>
>> flex -V here also shows 2.5.35.  But there are three patches in the
>> Fedora package.  Attached.
>>     
>
>         Debian currently carries 13 (though 3 of them need to be
>  squashed together) patches against 2.5.35. I can make them available if
>  there is interest.
>
>         manoj
>   
Yes please. Patches would be welcome.

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
