Message-ID: <43C29D09.5080601@tresys.com>
Date: Mon, 09 Jan 2006 12:27:37 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
   SELinux-dev@tresys.com, Steve G <linux_4ever@yahoo.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Auditallow execmem
References: <43C28A9F.2070600@redhat.com> <1136824668.19934.61.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1136824668.19934.61.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-01-09 at 11:09 -0500, Daniel J Walsh wrote:
> 
>>Currently there are too many applications that need execmem, to turn off 
>>allow_execmem by default.  So I changed the policy
>>to auditallow execmem if there allow_execmem is set.  This allows us to 
>>at least discover applications in targeted policy that need
>>this priv, and then submit bugzillas for those apps, or fix policy to 
>>allow them if it really is needed.   The problem is that these messages 
>>are not rate limited so you can end up with hundreds or thousands of 
>>these messages in the log file.  What do you think about limiting 
>>auditallow message to once similar to the way we do in permissive mode?  
>>Since this is by it's nature permissive.  IE One pessage per PID.
> 
> 
> That would prevent use of 'auditallow' to audit every occurrence of a
> security-sensitive event, which was its intended purpose.  Some uses of
> auditallow (e.g. for logging all policy loads, setenforce operations,
> etc) will be obsoleted by Steve G's patches adding explicit auditing of
> such events outside of the AVC audit mechanism, but I'm hesitant to turn
> auditallow entirely into a debugging-only tool in this manner.
> 
> Permissive mode avoids floods of denied messages on the same (source
> context, target context, target class, permission) tuple by adding the
> permission to the cache entry on the first denial, so subsequent checks
> on the same tuple pass (until the cache entry is evicted by normal cache
> activity or policy reload or switching to enforcing mode).
> 
> To do what you want and still support operational use of auditallow, I
> think we'd need a way to mark specific auditallow rules as use-once,
> with corresponding changes to the policy language, checkpolicy/libsepol,
> and the kernel.  Not trivial, and it would take time to upstream.
> 
> Not sure whether it might be simpler to instead implement a solution in
> the kernel audit framework for such selective filtering or in auditd
> itself.
> 

why not put an auditallow for execmem in a conditional so that you can 
instruct users to turn it on to get logs for the bug? That way 
additional language/kernel features wouldn't be required.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
