Subject: Re: Obtaining Default Context for SELinux Users
To: Mike Palmiotto <mike.palmiotto@crunchydata.com>, selinux@tycho.nsa.gov
References: <CAMN686Hqhqa7D5Thxo5aUGNt+Mt3x+iyB7nCaWn9DFHkfct2ow@mail.gmail.com>
 <CAMN686ETg0+y=fae4q=W3azjDoOAoxvrLjGXGM_NQwTb0_5hBA@mail.gmail.com>
Cc: Joe Conway <joe.conway@crunchydata.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <564F7640.7090405@tycho.nsa.gov>
Date: Fri, 20 Nov 2015 14:36:32 -0500
MIME-Version: 1.0
In-Reply-To: <CAMN686ETg0+y=fae4q=W3azjDoOAoxvrLjGXGM_NQwTb0_5hBA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/18/2015 07:26 PM, Mike Palmiotto wrote:
> On Wed, Nov 18, 2015 at 5:09 PM, Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
>> We're currently running into issues attempting to get a default
>> context for a newly added SELinux user.
>>
>> The user has been added with semanage, and associated with a few
>> roles. There are role declarations and allows (to and from the "scon"
>> role) in place in the policy. We've also added entries to
>> /etc/selinux/mls/contexts/{default_contexts,users/foo_u} to facilitate
>> getting a default context for the SELinux user.
>>
>> The desire is to switch security labels based on the specified user's
>> default context, like so:
>> root:staff_r:staff_t:s0 -> foo_u:foo_r:foo_t:s0
>>
>> We're using a call to `get_default_context("foo_u",
>> "root:staff_r:staff_t:s0", &new_context)` to get the default, but that
>> doesn't seem to be finding working.
>>
>> In testing with a more verbose version of security_compute_user_raw,
>> we noticed that the list of available contexts for foo_u are empty.
>> This behavior has been noted for staff_u as well.
>>
>> Curious to know if there's something glaringly obvious that we're missing.
>
> Other than this discussion (and previous discussions on using
> security_compute_user), of course:
> http://marc.info/?l=selinux&m=144707899910491&w=2
>
> I'm still curious as to why the get_default_context mechanism is not
> finding any reachable contexts.

The underlying logic is computing the set of possible contexts and then 
filtering them based on whether the source/from context has process 
transition permission to each of them (if not, then they aren't 
reachable).  As we don't normally allow a regular user domain to 
directly transition to a different user identity or role (that being 
reserved to programs like login/gdm/sshd and su/sudo/newrole), 
root:staff_r:staff_r:s0 would not normally be able to directly 
transition to foo_u at all.  Those restrictions are defined through 
constraints in the policy, and typically only domains assigned specific 
attributes (e.g. can_change_process_identity, can_change_process_role) 
are exempted.  Those attributes are assigned through refpolicy 
interfaces.  But you don't want to directly assign them to staff_t, or 
that staff_t process can arbitrarily change to another identity/role 
without going through any kind of gatekeeper program to ensure proper 
authentication, sanitization, protection of the new user/role from undue 
influence/control by the caller, etc.
