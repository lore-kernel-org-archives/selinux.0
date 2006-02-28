Message-ID: <4403E64B.6010804@cornell.edu>
Date: Tue, 28 Feb 2006 00:57:31 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Desktop integration
References: <43DE6244.5010100@cornell.edu> <43DE6578.9050302@redhat.com>
In-Reply-To: <43DE6578.9050302@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
>
> 1. That a user can relabel to all of the customizable types.  In most 
> policies he will not be allowed to .
That's fair enough, but it can be checked...
>
> 2. That the only types he can relabel to are customizable.
> For  example user_home_t is not necessarily customizable but a user 
> could change a context to it.
>
I don't understand this one. Why is the user allowed to relabel to a 
non-customizable type.

Something's wrong with this - it appears to carry a risk that the file 
will be automatically relabeled later, even after the user has made an 
explicit request that it must be labeled user_home_t - that certainly 
seems like a bad thing.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
