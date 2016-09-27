Subject: Re: [PATCH 1/1] genhomedircon: support policies using RBACSEP
To: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <pebenito@ieee.org>,
 Gary Tierney <gary.tierney@gmx.com>
References: <cover.1474639773.git.gary.tierney@gmx.com>
 <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
 <7be4daef-ca03-da40-0fb0-79bf39e3ce18@tycho.nsa.gov>
 <52a12ae5-ccbf-2545-1525-011d2c768c54@gmail.com>
 <ea1d8e6a-1bdf-8c54-aacc-41c068a7182f@tycho.nsa.gov>
 <20160927074412.GA15284@x250.enp8s0.d30>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c6f41bcd-a5ca-0760-4e97-c9e99d0bee88@tycho.nsa.gov>
Date: Tue, 27 Sep 2016 09:39:49 -0400
MIME-Version: 1.0
In-Reply-To: <20160927074412.GA15284@x250.enp8s0.d30>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/27/2016 03:44 AM, Dominick Grift wrote:
> On Mon, Sep 26, 2016 at 10:20:12AM -0400, Stephen Smalley wrote:
>> On 09/24/2016 04:26 AM, Dominick Grift wrote:
>>> On 09/23/2016 09:36 PM, Stephen Smalley wrote:
>>>> On 09/23/2016 10:28 AM, Gary Tierney wrote:
>>>>> Introduces support for generating homedir/user contexts
>>>>> for policies that implement RBACSEP.  The support works by
>>>>> taking the prefix of a logins seuser and replacing the role
>>>>> field in their context specifications with the prefix.  A
>>>>> new option "genhomedircon-rbacsep" was added to
>>>>> /etc/selinux/semanage.conf to allow toggling this
>>>>> behavior.
>>>> 
>>>> The user prefix was previously used as a prefix for types,
>>>> e.g. you could have: HOME_DIR/\.gnupg(/.+)? 
>>>> system_u:object_r:ROLE_gpg_secret_t and get it replaced with:
>>>>  /home/[^/]+/\.gnupg(/.+)? 
>>>> system_u:object_r:user_gpg_secret_t /root/\.gnupg(/.+)? 
>>>> system_u:object_r:sysadm_gpg_secret_t
>>>> 
>>>> So I guess you could use it for the role field too, but for 
>>>> consistency you would want it to be: HOME_DIR/\.gnupg(/.+)? 
>>>> system_u:ROLE_r:ROLE_gpg_secret_t
>>>> 
>>>> and the prefix would still just be "user".
>>> 
>>> No one is actually using that privsep functionality anymore. 
>>> Reference policy removed support for it.
>>> 
>>> Can we not instead just re-use that code for rbacsep?
>>> 
>>> The alternative would be to add code similar to the privsep
>>> code but then for rbacsep.
>>> 
>>> Then we will have the issue that we can't reasonably rely on
>>> the userprefix and prefix statements for rbacsep, because they
>>> might be used for privsep (in theory at least)
>>> 
>>> I other words if we were to implement rbacsep code similar to
>>> the privsep code, then we would need a new policy statement
>>> similar to userprefix and prefix.
>>> 
>>> It seems much easier to me to just re-use the privsep code.
>>> 
>>> rbacsep is the successor to privsep after all.
>> 
>> First, I'm not sure what you mean by privsep; usually that term
>> refers to privilege separation as in openssh.
>> 
>> There are at least three ways of implementing "role" separation
>> for objects in SELinux: (1) via TE and the use of derived types
>> on objects e.g. ROLE_home_t, ROLE_devpts_t, etc, (2) via RBAC and
>> the use of roles on objects (originally problematic because it
>> required a set of changes to the kernel to support roles on 
>> objects, but that's all history now), (3) via UBAC and the use of
>> SELinux user identities on objects to represent roles.
>> 
>> refpolicy started with (1), experimented with (2) and seems to
>> have settled on (3), likely because (2) wasn't fully supported in
>> the kernel or userspace for a long time.  I guess libsemanage / 
>> genhomedircon already support (3) adequately.
>> 
>> CIL apparently doesn't support (1), so that's broken regardless.
>> 
>> So I guess reusing the prefix for RBACSEP won't break any
>> existing users.  That said, it is clearly confusing to use
>> something identified in the policy language and documentation as
>> a "prefix" for the purpose of a "default role".  So maybe we
>> should look to rename it in the language and code, with backward
>> compatibility.  That can be done as a separate set of changes.
>> That might also help us with a different problem - obsoleting
>> security_compute_user() aka /sys/fs/selinux/user and taking the
>> get_default_context() logic to userspace.
>> 
>> Has anyone compared UBAC vs RBAC now that the kernel and policy 
>> support roles on objects?  Is there a strong reason for refpolicy
>> to stay with (3) other than compatibility with older
>> distributions and this genhomedircon issue?
>> 
> 
> Another likely issue is also with sudo.
> 
> An unprivileged user (staff_u) runs sudo to change to root/sysadm_r
> in order to create a file that should be accessible system wide.
> 
> The file he created will end up with staff_u identity and IBACSEP
> constrained processes might not be able to access it.
> 
> This wouldnt be an issue with RBACSEP because the role is changed
> to sysadm_r, which is not RBACSEP constrained. (no "privileged"
> roles are constrained)
> 
> This IBACSEP sudo issue can be avoided by using: `machinectl shell
> .host` instead. which will change the context fully to
> sysadm_u:sysadm_r:sysadm_t
> 
> However that is more difficult to configure and depends on systemd

Ok, so let's drop the unrelated change from the patch, resolve whether
we want this to be enabled through semanage.conf or some other means,
and get a final patch for it.  And then look in the future toward
renaming things in a backward-compatible manner.
