Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7AFs5R5007983
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 11:54:05 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7AFrluR006128
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 15:53:47 GMT
Message-ID: <44DB5696.5000102@redhat.com>
Date: Thu, 10 Aug 2006 11:53:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: selinux@tycho.nsa.gov
Subject: Re: does mv need a --context=CTX (-Z) option, too?
References: <20060810154720.5951.qmail@web36608.mail.mud.yahoo.com>
In-Reply-To: <20060810154720.5951.qmail@web36608.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> --- Daniel J Walsh <dwalsh@redhat.com> wrote:
>
>
>   
>> I agree cp should not need this qualifier.  It
>> should either be preserve 
>> or get the new default context.
>>     
>
> Classic Unix philosophy is that mv maintains
> attributes (moves an object) while cp does
> not (creates a new object) except as explicitly
> requested. Hence, it's OK for cp to have this
> option but not mv. If anything, mv might have
> an option that only allows the move if all
> attributes can be maintained.
>   
I am saying cp should not have a qualified where you specify the 
context.  It should either default to the ordinary system behaviour or 
if preserve is set try to maintain the file context.

Since cp does not have a -mode= or -owner= it probably should not have a 
-context=
>
>
> Casey Schaufler
> casey@schaufler-ca.com
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
