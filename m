Message-ID: <3F744120.6090509@tresys.com>
Date: Fri, 26 Sep 2003 09:37:36 -0400
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: Dale Amon <amon@vnl.com>
Cc: "NSA's SELinux" <SELinux@tycho.nsa.gov>
Subject: Re: policy language extensions
References: <3F7361F8.1080603@tresys.com> <20030926130232.GF10225@vnl.com>
In-Reply-To: <20030926130232.GF10225@vnl.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Dale Amon wrote:
> 
> Some things could be difficult though: policy statements
> do not appear to me to have a 1:1 relation to the binary 
> representation.
> 

You are right, they do not.  The policy statement:

allow  domain  init_t : process  { sigchld signull };

expands into a hash table entry (in the binary policy) for every type 
associated with the domain attribute.  In a very stripped down policy I 
was looking at this was 49 types.

You also need to keep in mind that "subtraction" or disabling of rules, 
via a conditional policy, is not equivalent to removing permissions.  If 
the above rule were in a condition block that was disabled, there might 
still be an allow rule in the base policy, or even in another 
conditional block, that allowed those permissions.


-- 
__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
