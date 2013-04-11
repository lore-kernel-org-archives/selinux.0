Message-ID: <51671A2A.9010905@tycho.nsa.gov>
Date: Thu, 11 Apr 2013 16:16:42 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Ondrej Oprala <ooprala@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: ipc security context
References: <5166AD29.60901@redhat.com>
In-Reply-To: <5166AD29.60901@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/11/2013 08:31 AM, Ondrej Oprala wrote:
> Hi,
> is it possible to get/set a security context per separate IPC objects?
> As far as my googling got me, it seems IPCs are the same context
> as process creation, so I'm guessing I should probably be able
> to get some info about a shared memory segment for example, by passing
> lpid to getpidcon. Are my assumptions correct or am I completely off the
> chart?
> I'd be very thankful for any clarification.

If you truly need to programmatically get the security context of an IPC 
object, I'd suggest defining new command values for the *ctl() functions 
that copy out the security context of the IPC object.  That's a kernel 
change of course.

If you just want to see the security contexts of some IPC objects, then 
you can likely just turn on syscall audit and define some audit filters 
to trigger collection and auditing of the ipc object information, 
including its security context.  Or you might try defining auditallow 
rules for the relevant domain(s) with the ipc object security classes in 
your policy.

Looking up the security context from the pid may work in some cases, but 
won't be reliable.  In the case of shm, I think you'd want cpid rather 
than lpid, but even that won't guarantee it is still the same.
It would be better to have real APIs for getting the security context.









--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
