From: "Minear, Spencer" <Spencer_Minear@mcafee.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "SELinux (selinux@tycho.nsa.gov)"
 <selinux@tycho.nsa.gov>
Subject: RE: What did I do wrong?
Date: Wed, 21 Jan 2015 17:38:26 +0000
Message-ID: <a41cad6969e34da494a847cf09d581fe@MIVEXUSR1N02.corpzone.internalzone.com>
References: <2cd599239cf54fb0956fa8de9f849c6b@MIVEXUSR1N02.corpzone.internalzone.com>
 <54BFAC96.1010302@tycho.nsa.gov> <54BFBB14.3070004@tycho.nsa.gov>
 <d557fd4e0ee04b4e882a8430ec5637a7@MIVEXUSR1N02.corpzone.internalzone.com>
 <54BFC284.5070602@tycho.nsa.gov>
In-Reply-To: <54BFC284.5070602@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Problem has been resolved.  Since I'm building/installing a monolithic policy one has to  pay more attention to which modules provide the key pieces of information that I need.  Once I came to the conclusion that the role_allow output from sesearch pointed to the missing pieces I could see I was not including the unconfined module in my policy.  This meant that the allow rules for transitions between system_r and unconfined_r was missing.   This  explains why I was seeing the 0 response from the sys/fs/selinux/user interaction.  Once this was added I get the transition as one would expect for the default policy.

Thank you for your assistance and pointers.

Spence

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Wednesday, January 21, 2015 9:15 AM
To: Minear, Spencer; SELinux (selinux@tycho.nsa.gov)
Subject: Re: What did I do wrong?

On 01/21/2015 10:08 AM, Minear, Spencer wrote:
> A bit more insight and by reading further into the strace I see more clues.
> 
> The interaction on /sys/fs/selinux/user, appears to work, but returns nothing.  Not sure what that may mean.
> 
> 26281 open("/sys/fs/selinux/user", O_RDWR) = 4
> 26281 write(4, "system_u:system_r:sshd_t:s0-s0:c0.c1023 unconfined_u", 52) = 52
> 26281 read(4, "0\0", 4095)              = 2

As I said, the response starts with a NUL-terminated count of the number of reachable contexts found from the calling context (sshd's context) to a valid context for the specified user (unconfined_u).  Since it contains "0", this means that there were no reachable contexts at all according to the policy, either due to a mismatch between the user's MLS information (default level and range) and the range in which sshd is running or due to a lack of transition permission from sshd's context to any of the authorized roles and types for the unconfined_u user.

> 
> A bit later I now see that the interaction on the /sys/fs/selinux/context is failing.
> 
> 26281 open("/sys/fs/selinux/context", O_RDWR) = 4
> 26281 write(4, "unconfined_u:sysadm_r:sysadm_t:s0\0", 34) = -1 EINVAL 
> (Invalid argument)

This is just an error path trying to fallback to a "failsafe" context defined in /etc/selinux/targeted/contexts/failsafe_context when we obtained no reachable contexts from the kernel.  But it is not the root of the problem you are having; that is the lack of any reachable contexts from sshd's context for the user.

> 
> The subsequent error message, WHICH I have to admit I did not look for, my bad.  It provides the obvious fact:
> 
> sendto(4, "<35>Jan 21 08:35:52 sshd[26281]: error: 
> ssh_selinux_getctxbyname: Failed to get default SELinux security 
> context for root", 121, MSG_NOSIGNAL, NULL, 0) = 121
> 
> Now I just have to go back to the policy and figure out what I did wrong or left out of the policy construction.  Because the installation image is going to use a read only file system, the policy development has to be done on a system different than where it will run, which seems to be the more typical environment assumed by most of the information one finds.
> 
> Spence
> 
> 
> 
> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Wednesday, January 21, 2015 8:44 AM
> To: Minear, Spencer; SELinux (selinux@tycho.nsa.gov)
> Subject: Re: What did I do wrong?
> 
> On 01/21/2015 08:41 AM, Stephen Smalley wrote:
>> On 01/20/2015 11:28 PM, Minear, Spencer wrote:
>>> Wonder if someone could give me a pointer to what my policy file is missing that would result in the /sys/fs/selinux/user API not providing a context when the sshd process context is written to that API?  I can see the behavior in a strace capture.  I believe that the action is  a call from sshd to the security_compute_user entry in libselinux.
>>>
>>> On a clean working system with the available default policy sshd writes in the sshd process's context and reads back the context that is ultimately applied to the shell process started by sshd.
>>>
>>> Obviously I'm missing something or not including some critical information into the policy but I haven't been able to find any documentation that describes what goes on behind the scenes of this API.
>>
>> Did the write() to /sys/fs/selinux/user return an error code (if so, 
>> what errno), or a string specifying that there are 0 contexts?
>>
>> The underlying function first computes the maximal set of possible 
>> contexts based on the user's role authorizations and the role's type 
>> authorizations in the policy.  Then it filters that set to only 
>> include contexts for which process transition permission is allowed 
>> in policy from the caller's context (i.e. sshd in this case).
>>
>> There is some further complication for the MLS field; it prefers the 
>> user's default level from the policy if that falls within the range 
>> of the caller's MLS range.  But if the user's default level is not 
>> within that range, it tries to find a level that is both consistent 
>> with the caller's MLS range limitations and the user's authorized 
>> range.  If it cannot do so, it will ultimately fail with an error.
> 
> Actually, looking at it again, a failure here will cause all of the contexts to be dropped, yielding a 0-context response like the one you are getting. So that could explain your issue.  What's the range of the sshd process and what is the user's default level and range?
> 
>> This has long been on our todo as something to take to userspace and 
>> simplify.
> 
> 
> 
> 
