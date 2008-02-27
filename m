Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RFsWnl013595
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 10:54:32 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1RFsSDp019510
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 15:54:29 GMT
Message-ID: <47C5879A.2060108@redhat.com>
Date: Wed, 27 Feb 2008 10:54:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: Speaking of networking...
References: <Xine.LNX.4.64.0802280057060.14155@us.intercode.com.au> <200802270951.55462.paul.moore@hp.com>
In-Reply-To: <200802270951.55462.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Wednesday 27 February 2008 9:01:31 am James Morris wrote:
>   
>> Any further thoughts on how to push the secmark integration forward?
>>
>> The secmark table patch should allow MAC rules to be administered
>> independently, and I know there has been some demand for the new
>> (well, now not so new) networking controls.
>>     
>
> When I asked this question previously the one thing that came up was 
> semanage integration/compatibility.  However, there didn't appear to be 
> a consensus as to if that was a good idea because semanage has a rather 
> simplistic view of local network controls due to the limitations of the 
> legacy netif/node controls.
>
> I'm with you in that I'd really like to see all of the distributions 
> shift over to using secmark.  Beyond the normal performance improvement 
> of moving to secmark, starting with 2.6.25 having both secmark and the 
> new network_peer_controls capability enabled should result in a nice 
> performance boost* over the legacy network controls.
>
> * No, I don't have any numbers yet, but looking at the code should 
> explain why.
>
>   
I have no problem with switching to this, as long as we do NO harm.  IE 
Everything just works.
Nothing breaks when the user shuts down iptables.

It needs to be exactly compatible with what we have now. 

Permissive mode has got to work.

And it has to be before Beta 1 March 4.

It has to be easy for a user to customize.

Most users will never use it, so it better not be a headache.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
