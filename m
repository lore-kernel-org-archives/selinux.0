From: "Minear, Spencer" <Spencer_Minear@mcafee.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "SELinux (selinux@tycho.nsa.gov)"
 <selinux@tycho.nsa.gov>
Subject: RE: What did I do wrong?
Date: Wed, 21 Jan 2015 15:08:54 +0000
Message-ID: <d557fd4e0ee04b4e882a8430ec5637a7@MIVEXUSR1N02.corpzone.internalzone.com>
References: <2cd599239cf54fb0956fa8de9f849c6b@MIVEXUSR1N02.corpzone.internalzone.com>
 <54BFAC96.1010302@tycho.nsa.gov> <54BFBB14.3070004@tycho.nsa.gov>
In-Reply-To: <54BFBB14.3070004@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A bit more insight and by reading further into the strace I see more clues.

The interaction on /sys/fs/selinux/user, appears to work, but returns nothing.  Not sure what that may mean.

26281 open("/sys/fs/selinux/user", O_RDWR) = 4
26281 write(4, "system_u:system_r:sshd_t:s0-s0:c0.c1023 unconfined_u", 52) = 52
26281 read(4, "0\0", 4095)              = 2

A bit later I now see that the interaction on the /sys/fs/selinux/context is failing.

26281 open("/sys/fs/selinux/context", O_RDWR) = 4
26281 write(4, "unconfined_u:sysadm_r:sysadm_t:s0\0", 34) = -1 EINVAL (Invalid argument)

The subsequent error message, WHICH I have to admit I did not look for, my bad.  It provides the obvious fact:

sendto(4, "<35>Jan 21 08:35:52 sshd[26281]: error: ssh_selinux_getctxbyname: Failed to get default SELinux security context for root", 121, MSG_NOSIGNAL, NULL, 0) = 121

Now I just have to go back to the policy and figure out what I did wrong or left out of the policy construction.  Because the installation image is going to use a read only file system, the policy development has to be done on a system different than where it will run, which seems to be the more typical environment assumed by most of the information one finds.

Spence



-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Wednesday, January 21, 2015 8:44 AM
To: Minear, Spencer; SELinux (selinux@tycho.nsa.gov)
Subject: Re: What did I do wrong?

On 01/21/2015 08:41 AM, Stephen Smalley wrote:
> On 01/20/2015 11:28 PM, Minear, Spencer wrote:
>> Wonder if someone could give me a pointer to what my policy file is missing that would result in the /sys/fs/selinux/user API not providing a context when the sshd process context is written to that API?  I can see the behavior in a strace capture.  I believe that the action is  a call from sshd to the security_compute_user entry in libselinux.
>>
>> On a clean working system with the available default policy sshd writes in the sshd process's context and reads back the context that is ultimately applied to the shell process started by sshd.
>>
>> Obviously I'm missing something or not including some critical information into the policy but I haven't been able to find any documentation that describes what goes on behind the scenes of this API.
> 
> Did the write() to /sys/fs/selinux/user return an error code (if so, 
> what errno), or a string specifying that there are 0 contexts?
> 
> The underlying function first computes the maximal set of possible 
> contexts based on the user's role authorizations and the role's type 
> authorizations in the policy.  Then it filters that set to only 
> include contexts for which process transition permission is allowed in 
> policy from the caller's context (i.e. sshd in this case).
> 
> There is some further complication for the MLS field; it prefers the 
> user's default level from the policy if that falls within the range of 
> the caller's MLS range.  But if the user's default level is not within 
> that range, it tries to find a level that is both consistent with the 
> caller's MLS range limitations and the user's authorized range.  If it 
> cannot do so, it will ultimately fail with an error.

Actually, looking at it again, a failure here will cause all of the contexts to be dropped, yielding a 0-context response like the one you are getting. So that could explain your issue.  What's the range of the sshd process and what is the user's default level and range?

> This has long been on our todo as something to take to userspace and 
> simplify.
