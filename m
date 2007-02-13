Subject: Re: [RFC] security_getprocattr() API idiocy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@ftp.linux.org.uk, selinux@tycho.nsa.gov,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com
In-Reply-To: <20070213134555.GG4095@ftp.linux.org.uk>
References: <20070213134555.GG4095@ftp.linux.org.uk>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 08:52:46 -0500
Message-Id: <1171374766.3242.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-13 at 13:45 +0000, Al Viro wrote:
> 	security_getprocattr() takes a buffer + length, copies data
> to it and return the actual length.  If buffer is NULL, it just returns
> the right length, a-la snprintf().  Observations:
> 	* at least selinux ends up actually allocating the buffer of the
> right size, filling it, then copying its contents to buffer and freeing
> what had been allocating.
> 	* all users allocate buffer, then call security_getprocattr() to
> fill just allocated one.
> 	* one place does even worse - it calls security_getprocattr() passing
> it NULL and uses obtained length to allocate buffer and call
> security_getprocattr() _again_.
> 
> It's bloody bogus.  In all cases we would be just as happy if it returned
> the buffer it'd allocated itself.  In the best case we end up with two
> allocations; in the worst it's _three_, not to mention recalculating the
> contents and size.  We end up doing
> 	* calculate size
> 	* allocate buffer of that size with GFP_ATOMIC
> 	* fill it
> 	* free it
> 	* allocate buffer of that size with GFP_KERNEL
> 	* caluclate the same size
> 	* allocate buffer of that size with GFP_ATOMIC
> 	* fill it with the same string
> 	* copy it to buffer we's allocated with GFP_KERNEL
> 	* free the buffer we'd allocated with GFP_ATOMIC
> I'm sorry, but could we please not mix the kernel with Vogon poetry contest?
> 
> AFAICS, the sane solution is to make security_getprocattr() return the
> allocated buffer instead.  All callers would be only happy with that.
> Alternatively, we can introduce a new LSM hook (security_getprocattr_sane())
> and leave the original as-is.
> 
> So, do we want to keep the original variant and add a saner one in parallel
> to it or should we just switch to saner API?

Just switch to the saner API.

audit_log_task_context) could be using selinux_get_task_sid() +
selinux_sid_to_string() instead of security_getprocattr.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
