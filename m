Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA21513
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 09:09:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA16628
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 13:07:46 GMT
Received: from mail.ispko.com ([210.16.10.89])
        by jazzband.ncsc.mil  with ESMTP id NAA16624 for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 13:07:45 GMT
Message-ID: <3D132564.1060307@evoworks.evoserve.com>
Date: Fri, 21 Jun 2002 21:08:52 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Russell Coker <russell@coker.com.au>
CC: selinux@tycho.nsa.gov
Subject: Re: selinux cramfs
References: <Pine.GSO.4.33.0206210844000.12888-100000@raven> <20020621125427.228C41EE0@lyta.coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Fri, 21 Jun 2002 14:45, Stephen Smalley wrote:
>
>>On Fri, 21 Jun 2002, Stephen Smalley wrote:
>>
>>>You might be able to handle cramfs to some degree using the new
>>>genfs_contexts configuration, which is a generalization of
>>>devfs_contexts. That isn't in the current release, but will be in the
>>>next one.
>>>
>>I just tried using genfs_contexts to specify a context for cramfs and
>>then mounting a cramfs image, and it appears to work correctly.  So this
>>will hopefully be addressed by the next public release.
>>
>
>Excellent!
>
>Howard, when is the next release scheduled?
>
>
>Stephen,  I'm just about to test those patches you sent me.
>
>
>
>Russell Coker
>
Cool! My system is waiting. Lots of possibilities here.



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
