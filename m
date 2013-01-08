Message-ID: <50EC31AE.5040807@tycho.nsa.gov>
Date: Tue, 08 Jan 2013 09:48:14 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Ondrej Oprala <ooprala@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: setfscreatecon optimizations
References: <50EC1D32.3090607@redhat.com>
In-Reply-To: <50EC1D32.3090607@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/08/2013 08:20 AM, Ondrej Oprala wrote:
> Hi, there have been some attempts on the coreutils mailing list at
> optimizing cp copying by caching the selinux security context ( please
> see: http://lists.gnu.org/archive/html/coreutils/2013-01/msg00012.html ).
> Would it be possible to perform some kind of caching inside
> setfscreatecon? For example not going through the whole process of
> setfscreatecon if the context to be set equals the current one?

I think that should be possible.  The relevant code that would need to 
be modified is in libselinux/src/procattr.c.  You would likely want to 
modify the common helper for all of the set*con functions, 
setprocattrcon_raw().  A conceptually similar cache exists in 
libselinux/src/setrans_client.c; note the methods used to make it 
thread-safe and to ensure that it is properly freed.  You would need a 
separate cache for each kind of attribute that can be set, i.e. current, 
exec, fscreate, keycreate, sockcreate.  You could likely also cache the tid.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
