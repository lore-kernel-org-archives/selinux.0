Message-ID: <54BFB5DA.7030909@tycho.nsa.gov>
Date: Wed, 21 Jan 2015 09:21:14 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Minear, Spencer" <Spencer_Minear@mcafee.com>,
 "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>
Subject: Re: What did I do wrong?
References: <2cd599239cf54fb0956fa8de9f849c6b@MIVEXUSR1N02.corpzone.internalzone.com>
 <54BFAC96.1010302@tycho.nsa.gov>
 <5aec99eaaddd45bca281b84a39acd786@MIVEXUSR1N02.corpzone.internalzone.com>
In-Reply-To: <5aec99eaaddd45bca281b84a39acd786@MIVEXUSR1N02.corpzone.internalzone.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/21/2015 09:18 AM, Minear, Spencer wrote:
> The write to /sys/fs/selinux/user was successful.  The read was successful too, but returned only "0\0".  The read return value was 2, which matches what I see coming back.  This makes me think that I am missing some information in the policy that leads to what appears to be an unexpected result rather than one or more new context's that I believe that the interface is supposed to return.

The response buffer (i.e. what you read from /sys/fs/selinux/user)
begins with a count of the number of contexts, followed by a NUL,
followed by the list of contexts, NUL-separated.  So in this case, the
response is saying that it couldn't find any reachable contexts for that
user from the calling context (whatever sshd is running in) under the
loaded policy.  So, yes, check your user-role authorizations, your
role-type authorizations, and transition permission from sshd's context.

> 
> Spence
> 
> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Sent: Wednesday, January 21, 2015 7:42 AM
> To: Minear, Spencer; SELinux (selinux@tycho.nsa.gov)
> Subject: Re: What did I do wrong?
> 
> On 01/20/2015 11:28 PM, Minear, Spencer wrote:
>> Wonder if someone could give me a pointer to what my policy file is missing that would result in the /sys/fs/selinux/user API not providing a context when the sshd process context is written to that API?  I can see the behavior in a strace capture.  I believe that the action is  a call from sshd to the security_compute_user entry in libselinux.
>>
>> On a clean working system with the available default policy sshd writes in the sshd process's context and reads back the context that is ultimately applied to the shell process started by sshd.
>>
>> Obviously I'm missing something or not including some critical information into the policy but I haven't been able to find any documentation that describes what goes on behind the scenes of this API.
> 
> Did the write() to /sys/fs/selinux/user return an error code (if so, what errno), or a string specifying that there are 0 contexts?
> 
> The underlying function first computes the maximal set of possible contexts based on the user's role authorizations and the role's type authorizations in the policy.  Then it filters that set to only include contexts for which process transition permission is allowed in policy from the caller's context (i.e. sshd in this case).
> 
> There is some further complication for the MLS field; it prefers the user's default level from the policy if that falls within the range of the caller's MLS range.  But if the user's default level is not within that range, it tries to find a level that is both consistent with the caller's MLS range limitations and the user's authorized range.  If it cannot do so, it will ultimately fail with an error.
> 
> This has long been on our todo as something to take to userspace and simplify.
> 
> 
> 
