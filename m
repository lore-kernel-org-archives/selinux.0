Subject: Re: get_default_context() hit the SIMPLE_TRANSACTION_LIMIT
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
References: <5640A2F2.3080703@redhat.com> <5640ABE9.2060208@tycho.nsa.gov>
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <5645B969.9030905@redhat.com>
Date: Fri, 13 Nov 2015 11:20:25 +0100
MIME-Version: 1.0
In-Reply-To: <5640ABE9.2060208@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/09/2015 03:21 PM, Stephen Smalley wrote:
> On 11/09/2015 08:43 AM, Miroslav Grepl wrote:
>> We are trying to get pam_selinux + systemd-user working on Fedora
>> Rawhide to avoid systemd-user running with init_t. The problem is with
>> init_t domain which is unconfined domain by default on Fedora.
>>
>>
>> echo -n system_u:system_r:init_t:s0 unconfined_u > /sys/fs/selinux/user
>> sh: echo: write error: Numerical result out of range
>>
>>
>> causes failsafe_context is used for SELinux user context as a result of
>> pam_selinux. With disabled unconfined.pp module it works as expected.
>>
>> The problem is also described here
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1274345
> 
> In the past, I have suggested not using security_compute_user() anymore
> and taking a simplified version of this logic entirely to userspace,
> http://marc.info/?t=133054875600001&r=1&w=2
> 
> Obviously we could increase the kernel limit, but think about what the
> get_ordered_context_list() code is doing:  it is asking the kernel to
> compute the complete set of reachable contexts (which is this case is
> huge because you are going from an unconfined domain to a user
> authorized for the unconfined role) and then throwing away the vast
> majority of the returned contexts because they don't match anything in
> /etc/selinux/targeted/contexts/default_contexts or
> /etc/selinux/targeted/contexts/users/<seuser> and then ultimately only
> using the first (highest priority) context from the ordered list.  So
> the kernel computation is mostly wasted.  Better to just cut it out
> entirely.

You are correct. So we could skip security_compute_user() context at
all, pick it up from context files and check if a final user context is
valid.

-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
