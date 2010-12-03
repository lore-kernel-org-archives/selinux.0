Message-ID: <4CF8418E.8030609@tycho.nsa.gov>
Date: Thu, 02 Dec 2010 20:02:06 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Blake <eblake@redhat.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: libselinux memory leak in multi-threaded processes due to abuse
 of __thread
References: <4CF58D24.1020609@redhat.com> <4CF8089B.7020301@redhat.com>
In-Reply-To: <4CF8089B.7020301@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/02/2010 03:59 PM, Eric Blake wrote:
> On 11/30/2010 04:47 PM, Eric Blake wrote:
>> Here's a simple program that demonstrates that libselinux's attempts to
>> cache data ends up being a memory leak instead.  The problem is that
>> __thread variables have no destructor, so when a long-running program
>> that uses multiple pthreads, where each thread uses selinux functions
>> which stash malloc'd memory into a __thread cache, then the cache memory
>> is leaked when the threads exit.
> Eamon's patch[1] looks good to me; and a quick test with my sample
> program proves that it avoids the leak.
>
> [1] https://bugzilla.redhat.com/attachment.cgi?id=464338, found at
> https://bugzilla.redhat.com/show_bug.cgi?id=658571
>

Pushed to libselinux 2.0.97.


-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
