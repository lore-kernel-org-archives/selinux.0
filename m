Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16FAVRb023099
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 10:10:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i16F8iQk025956
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 15:08:44 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i16F8hYo025950
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 15:08:43 GMT
Message-ID: <4023AE3A.1050109@redhat.com>
Date: Fri, 06 Feb 2004 10:09:46 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Eric Estabrooks <eric@urbanrage.com>, selinux@tycho.nsa.gov
Subject: Re: selinux-policy-default
References: <40232CBB.7020607@urbanrage.com> <200402062339.14289.russell@coker.com.au>
In-Reply-To: <200402062339.14289.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Fri, 6 Feb 2004 16:57, Eric Estabrooks <eric@urbanrage.com> wrote:
>  
>
>>/usr/bin/checkpolicy:  loading policy configuration from
>>/etc/security/selinux/src/policy.conf
>>domains/admin.te:32:ERROR 'unknown type sysadm_locate_t' at token ';' on
>>line 5974:
>>allow sysadm_locate_t { sysadm_mozilla_ro_t sysadm_mozilla_rw_t }:dir {
>>getattr
>>search };
>>    
>>
>
>I'll upload a new policy package to fix that tomorrow.
>
>Anyway using the locate policy for Debian is not a good idea.  Debian does not 
>have a SE Linux patched locate and is not likely to have one in the 
>forseeable future.  I think that locate is simply a bad idea and have no 
>plans to support it in Debian.
>
>  
>
>>I searched for type lines for sysadm_locate_t but couldn't find any in
>>    
>>
>
>Look at macros/program/locate_macros.te .
>
>  
>

Easiest thing to do is remove slocate.te from domain/program and  then 
do a make reload.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
