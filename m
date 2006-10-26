Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9QJ7a7T009505
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 15:07:37 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9QJ65W7014027
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 19:06:05 GMT
Message-ID: <45410778.5040302@hp.com>
Date: Thu, 26 Oct 2006 15:07:36 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: socket options ... again
References: <4540E083.2030304@hp.com> <1161881175.16681.239.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161881175.16681.239.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-10-26 at 12:21 -0400, Paul Moore wrote:
> 
>>I was looking at some policy and just realized that it's pretty liberal in
>>handing out the socket setopt permission to domains; for some reason I was
>>thought this was a rather rare thing.  This concerns me slightly because this is
>>how NetLabel attaches security attributes to outgoing packets.
>>
>>As a result I'm starting to look at how to best protect the NetLabel security
>>attributes in the socket's IP options.  It is pretty straight forward to hook
>>into the selinux_socket_setsockopt() function and watch for the
>>IPPROTO_IP/IP_OPTIONS combination but my question to all of you is what is the
>>"right" thing to do in such a case?  I can think of the following options (all
>>of which are fairly easy to implement):
>>
>>1. If NetLabel is compiled into the kernel deny the application the right to set
>>the socket's IP options.  This is pretty heavy handed but it would preserve the
>>security attributes; although I have no idea the problems it might cause in the
>>application space.
>>
>>2. If the socket has a NetLabel attached to it simply deny the access, otherwise
>>allow it to proceed.  This has the problem in that it could allow a "bad"
>>application to write it's own "evil" security attributes to the socket's IP
>>option, although if there is no NetLabel attached to the socket (i.e. NetLabel
>>was told to ignore this domain) this may be okay.
>>
>>3. If the application sets it's own security attributes, clear the socket's
>>option field and replace it with the correct NetLabel option even if the
>>NetLabel configuration for that domain is to leave the packets unlabeled.  The
>>problem here is that we would be allowing the setsockopt() syscall to proceed
>>without error then we would end up resetting the options on the socket (this
>>would happen on the first write to the socket).
>>
>>While option #1 is the easiest I don't really like the idea of simply denying
>>applications the ability to set IP options (although I question how common this
>>really is).  Option #3 is perhaps the most compatible, although it could lead to
>>strange behavior with socket options changing underneath the application.  Which
>>leads me to option #2, it does have the drawback I mentioned above, but then
>>again there is nothing stopping applications from doing this currently.
>>
>>Thoughts on these options?  Can anyone else think of a better solution?
> 
> ip_options_compile() checks CAP_NET_RAW for IPOPT_SEC, IPOPT_SID, and
> any unknown options.  Is there a reason to not do likewise for setting
> IPOPT_CIPSO from userspace (which you need to distinguish in some manner
> from your internal setting)?

Ungh.  I really wanted to believe it was that simple, but upon further
inspection it looks like simply adding CAP_NET_RAW only prevents applications
from setting their own CIPSO option it does not prevent users from replacing a
CIPSO option with another option like source routing.  With this in mind I think
adding the CAP_NET_RAW check and going with option #2 (see above) is the best
choice ... thoughts?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
