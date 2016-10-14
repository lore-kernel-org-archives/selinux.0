Subject: Re: ANN: SELinux userspace release
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>
 <23249b84-09fa-1e38-a391-9b37ad6a5457@gmail.com>
 <3c05e0f9-eef9-0290-97f0-fb2a1730d02c@tycho.nsa.gov>
 <629e4cb0-52ae-fdf0-6415-1cfdbd253b12@gmail.com>
 <213db96b-7274-bdbf-78dc-9418c1ed2566@tycho.nsa.gov>
 <b0247b13-fc06-e22a-4788-8831a283fb54@gmail.com>
 <bd7f3d99-cb86-183e-afb2-aef188d85adb@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0381fa21-bf6b-911b-937d-a9ad11a374ea@tycho.nsa.gov>
Date: Fri, 14 Oct 2016 13:32:10 -0400
MIME-Version: 1.0
In-Reply-To: <bd7f3d99-cb86-183e-afb2-aef188d85adb@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/14/2016 01:28 PM, Stephen Smalley wrote:
> On 10/14/2016 01:18 PM, Dominick Grift wrote:
>> On 10/14/2016 07:17 PM, Stephen Smalley wrote:
>>> On 10/14/2016 12:20 PM, Dominick Grift wrote:
>>>> On 10/14/2016 06:15 PM, Stephen Smalley wrote:
>>>>> On 10/14/2016 12:02 PM, Dominick Grift wrote:
>>>>>> On 10/14/2016 05:55 PM, Stephen Smalley wrote:
>>>>>>> The 2016-10-14 / 2.6 release for the SELinux userspace is
>>>>>>> now available at: 
>>>>>>> https://github.com/SELinuxProject/selinux/wiki/Releases
>>>>>>>
>>>>>>> This has been tagged as 20161014 in the git repository.
>>>>>>>
>>>>>>> Below are some notes on this release for packagers of
>>>>>>> the SELinux userspace.  Please see the individual
>>>>>>> ChangeLog files for a detailed list of changes.
>>>>>>>
>>>>>>> 1) sepolicy converted to setools4: - sepolicy and its 
>>>>>>> users now depend on setools4 instead of setools3.
>>>>>>>
>>>>>>> - Please convert any remaining users of setools3 to 
>>>>>>> setools4 since setools3 is no longer being developed.
>>>>>>>
>>>>>>> 2) genhomedircon enhancements and behavior changes: - 
>>>>>>> genhomedircon supports the %{USERID} template for 
>>>>>>> substituting the user's uid. %{USERNAME} has also been 
>>>>>>> added as a new template for substituting the user's 
>>>>>>> username.  The USER template is still supported for 
>>>>>>> backward compatibility but is deprecated.
>>>>>>>
>>>>>>> - genhomedircon supports generating home directory 
>>>>>>> contexts for login mappings using the %group syntax. This
>>>>>>> may produce an error if the user belongs to multiple 
>>>>>>> groups specified in the login mapping, which can be 
>>>>>>> resolved by adding an explicit mapping for the user to 
>>>>>>> override the group-based mapping.
>>>>>>>
>>>>>>> - genhomedircon will fully replace the SELinux user and 
>>>>>>> range fields in each templated security context rather 
>>>>>>> than only substituting for the hardcoded strings 
>>>>>>> "system_u" and "s0".  As a side effect, genhomedircon no 
>>>>>>> longer has special handling of "system_u" and will 
>>>>>>> therefore trigger a warning if there is a "system_u" 
>>>>>>> entry in seusers: libsemanage.add_user: user system_u
>>>>>>> not in password file This warning is not fatal, but it
>>>>>>> would be preferable to remove system_u from the seusers
>>>>>>> file. See
>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1378204
>>>>>>>
>>>>>>> - genhomedircon will replace the role field in each 
>>>>>>> templated security context with the user prefix for the 
>>>>>>> user if the user prefix is the identifier of a role
>>>>>>> valid for the given user, or if it is "object_r". This
>>>>>>> enables configuring RBACSEP (i.e. role-based separation
>>>>>>> of user home directories) in policy.  If the user prefix
>>>>>>> is not a valid role, then genhomedircon will leave the
>>>>>>> role field unmodified as before.
>>>>>>>
>>>>>>
>>>>>> An issue was reported about genhomedircon with standard 
>>>>>> policy model (non-mls), where no contexts were generated.
>>>>>>
>>>>>> I was able to reproduce this issue, and Gary produced a 
>>>>>> patch to fix this. However the patch does not fully
>>>>>> address the issue, as it requires that one runs an
>>>>>> additional semodule -B to rerun genhomedircon.
>>>>>> genhomedircon does not generate the contexts the first time
>>>>>> around.
>>>>>
>>>>> Hmm..reported to whom, and where did this discussion take 
>>>>> place? I have seen nothing on the list.  Would have been 
>>>>> helpful to have reported it on the -rc releases.
>>>>
>>>> Someone using gentoo-hardened encountered the issue, and
>>>> gentoo maintainer told Gary about it on IRC. Two day's ago,
>>>> with a delay, I set out to reproduce the issue to confirm the
>>>> bug. I was planning to report this on the list but: I was not 
>>>> expecting a release this soon, and I was hoping for a
>>>> revisited patch soon but it obviously delayed.
>>>>
>>>> So only two day's ago the bug was confirmed. We should have 
>>>> reported then but we didn't
>>>
>>> Since I haven't seen the patch, I can't comment on it.  I would 
>>> think one could simply test sepol_policydb_mls_enabled(policydb) 
>>> in semanage_genhomedircon() to determine whether MLS is enabled, 
>>> and then pass that result down as appropriate so that the 
>>> underlying code could handle the MLS-disabled case correctly.
>>>
>>>
>>
>> This is the patch that does not fully address the issue
>>
>> https://github.com/garyttierney/selinux/commit/600f20e5ea50eaac919ad8fee8987c6bdfa081e6.patch
>>
>>
>>
> I requires one additional "semodule -B" to make genhomedircon
>> generate the contexts. So it is only part of the fix. Also I 
>> haven't tested the above patch in all scenarios (switching back
>> and forth between the various models)
> 
> That's because it is testing the wrong policy.  As I said above, it
> needs to test sepol_policydb_mls_enabled(policydb) using the policydb
> passed to semanage_genhomedircon(), which is not yet the active
> policy.  Doing so is also more efficient since it avoids re-loading
> the policy from a file into memory.

And that's already passed down via genhomedircon_settings_t, so you
could just do a sepol_policydb_mls_enabled(s->policydb) there instead.
