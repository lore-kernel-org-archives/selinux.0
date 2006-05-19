Message-ID: <446DCD4C.6000303@gentoo.org>
Date: Fri, 19 May 2006 09:51:08 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
References: <446AFED3.9010800@redhat.com> <446B3B51.1060703@redhat.com> <446B3E11.6040302@gentoo.org> <200605192333.01639.russell@coker.com.au>
In-Reply-To: <200605192333.01639.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Thursday 18 May 2006 01:15, Joshua Brindle <method@gentoo.org> wrote:
>   
>>> Yes, you mean translation change, I think.  Since I do not see where
>>> policy reload would effect this.  We could add some kind of timer to
>>> this, but refreshing the cache is a small problem, but this same
>>> problem existed with shared libraries.
>>>       
>> Because on an MLS system the server will be deciding whether or not you
>> have permission to see a particular translation and a policy reload
>> would affect that. The same problem did exist with the shared libraries
>> but we aren't using them anymore :) the server should be smart enough to
>> handle this. If client side caching is really desired it needs to work
>> like an avc where you can get flush notifications from the server.
>>     
>
> Client side caching is not required to work the same way as server-side.
>
> The idea behind SE Linux is that the kernel enforces access control in almost 
> all situations, and that applications which enforce access control are the 
> exception (this means crond, login programs, the X server for SE-X, and not 
> much else).
>
> If an application such as "ls" gets a copy of the translation data then there 
> is no point in writing the library code such that the data can not be 
> (easily) displayed a second time.  The information once available is presumed 
> to have already been displayed to the user or stored in a way such that it 
> can be obtained in another manner.
>   
If that were true we wouldn't revoke access to file descriptors (or 
files) after a policy reload. And you are still ignoring the case where 
the translation actually changes. My worry isn't ls (which is one-shot, 
and executes quickly most of the time), _anything_ that uses this 
library code now caches the answer and if its a long running process 
then it has no way of knowing when translations have changed or access 
has been revoked.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
