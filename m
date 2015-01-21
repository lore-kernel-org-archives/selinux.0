Message-ID: <54BFAC96.1010302@tycho.nsa.gov>
Date: Wed, 21 Jan 2015 08:41:42 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Minear, Spencer" <Spencer_Minear@mcafee.com>,
 "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>
Subject: Re: What did I do wrong?
References: <2cd599239cf54fb0956fa8de9f849c6b@MIVEXUSR1N02.corpzone.internalzone.com>
In-Reply-To: <2cd599239cf54fb0956fa8de9f849c6b@MIVEXUSR1N02.corpzone.internalzone.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/20/2015 11:28 PM, Minear, Spencer wrote:
> Wonder if someone could give me a pointer to what my policy file is missing that would result in the /sys/fs/selinux/user API not providing a context when the sshd process context is written to that API?  I can see the behavior in a strace capture.  I believe that the action is  a call from sshd to the security_compute_user entry in libselinux.
> 
> On a clean working system with the available default policy sshd writes in the sshd process's context and reads back the context that is ultimately applied to the shell process started by sshd.
> 
> Obviously I'm missing something or not including some critical information into the policy but I haven't been able to find any documentation that describes what goes on behind the scenes of this API.

Did the write() to /sys/fs/selinux/user return an error code (if so,
what errno), or a string specifying that there are 0 contexts?

The underlying function first computes the maximal set of possible
contexts based on the user's role authorizations and the role's type
authorizations in the policy.  Then it filters that set to only include
contexts for which process transition permission is allowed in policy
from the caller's context (i.e. sshd in this case).

There is some further complication for the MLS field; it prefers the
user's default level from the policy if that falls within the range of
the caller's MLS range.  But if the user's default level is not within
that range, it tries to find a level that is both consistent with the
caller's MLS range limitations and the user's authorized range.  If it
cannot do so, it will ultimately fail with an error.

This has long been on our todo as something to take to userspace and
simplify.
