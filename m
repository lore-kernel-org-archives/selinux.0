Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j65JgAgA025617
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 15:42:10 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j65JeEEn001016
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 19:40:15 GMT
Message-ID: <42CAE220.9060802@redhat.com>
Date: Tue, 05 Jul 2005 15:40:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: selinux@tycho.nsa.gov
Subject: Re: Groups in the alternative user solution
References: <20050630191417.26186.qmail@web31611.mail.mud.yahoo.com>	 <42CADC3F.8000206@redhat.com> <1120592032.16262.5.camel@nexus.verbum.private>
In-Reply-To: <1120592032.16262.5.camel@nexus.verbum.private>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:

>On Tue, 2005-07-05 at 15:15 -0400, Daniel J Walsh wrote:
>
>  
>
>>This would potentially eliminate the 1000's of file contexts files problem,
>>since almost all users would map to the default user_r and user_home_t...
>>for his home dir file context.
>>    
>>
>
>But isn't a large part of the point of this to ensure that e.g. grissom
>can never access medical records stored in welby's home directory, even
>if welby accidentally sets the DAC permissions to allow it?  Or is
>something else in this scheme preventing that?
>
>  
>
I would argue that medical records should never be stored in a users 
home directory.

The idea here is that the application to view medical records would not 
be able to be run
by the ordinary user.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
