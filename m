Subject: Re: Finer grained SELinux controls for CAP_SYS_ADMIN functionality
To: Nick Kralevich <nnk@google.com>
References: <CAFJ0LnF39oRy0emD6JQn6ouQp0uwG_Q6a5NbWVczSfF=2t4yqg@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f640a61d-9e8f-17ee-aff7-610eca121b55@tycho.nsa.gov>
Date: Tue, 22 Nov 2016 09:15:28 -0500
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnF39oRy0emD6JQn6ouQp0uwG_Q6a5NbWVczSfF=2t4yqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/21/2016 05:09 PM, Nick Kralevich wrote:
> On Mon, Nov 21, 2016 at 1:06 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 11/21/2016 03:48 PM, Nick Kralevich wrote:
>>>
>>>
>>> On Mon, Jun 15, 2015 at 5:41 AM, Stephen Smalley <sds@tycho.nsa.gov
>>> <mailto:sds@tycho.nsa.gov>> wrote:
>>>
>>>     On 06/14/2015 01:33 AM, Dominick Grift wrote:
>>>     > On Wed, May 27, 2015 at 11:03:25AM -0400, Stephen Smalley wrote:
>>>     >> Permissions never used in mainline Linux:
>>>     >> file swapon
>>>     >
>>>     > I think that blk_file (fixed disk) swapon is actually used in my policy by fstools (i think swapon command)
>>>
>>>     It isn't checked anywhere in the SELinux kernel code, so it might be
>>>     defined in your policy but it has no meaning.  The LSM hook and SELinux
>>>     hook function implementation that applied the check was never merged
>>>     into mainline.
>>>
>>>
>>> Why was the LSM hook and SELinux hook function implementation for swapon
>>> never mainlined?
>>>
>>> In particular, without some kind of swapon check, a process with
>>> CAP_SYS_ADMIN could take any readable-writeable file, call swapon on the
>>> file, force swapping, and gain read-write access to another process memory.
>>>
>>> Can we try to get these patches mainlined again?
>>
>> I think it just wasn't a high priority, since the operation was already
>> being controlled via CAP_SYS_ADMIN (and thus also SELinux :capability
>> sys_admin check) and there wasn't a clear use case for distinguishing
>> it.  Given that there are over 500 CAP_SYS_ADMIN checks in the kernel,
>> it is unclear how much we would gain by separately restricting just
>> swapon.  A more comprehensive audit of all CAP_SYS_ADMIN checks and
>> adding finer-grained LSM hooks and/or new finer-grained capabilities
>> would likely be useful, but is not a trivial undertaking.  One can
>> disable swap altogether via CONFIG_SWAP=n if you don't need that
>> functionality at all.
> 
> Unfortunately, for my particular problem, CONFIG_SWAP=n isn't going to
> be an option, as many Android devices "swap" to zram for memory
> savings.
> 
> While I can certainly understand not wanting to have 500 LSM hooks for
> the 500 different CAP_SYS_ADMIN calls, I'm concerned about the overly
> broad reach that CAP_SYS_ADMIN has today. Today, we only have one
> course-grained LSM hook which checks the SELinux :capability sys_admin
> check.
> 
> There has to be a middle ground somewhere between one course-grained
> check and 500 individual tiny LSM hooks...
> 
> Has anyone given any thought into technically what we could do to have
> finer grained LSM control here? I have some ideas here, but I'd like
> to read about what has been previously been suggested...

In general, we would audit the current set of CAP_SYS_ADMIN checks,
prioritize the most significant ones, organize them into equivalence
classes, and only define a single LSM hook and SELinux permission check
for each equivalence class.  That's if you want to just add
finer-grained LSM hooks and leave the CAP_SYS_ADMIN checks alone.

If you want to split CAP_SYS_ADMIN into finer-grained capabilities, then
an example of doing that in the past was CAP_SYSLOG; you can see how
they provide backward compatibility there.  However, that is only
sufficient if you only need to perform a check based on the process'
credentials; if you want to take into consideration any object (e.g. in
the case of swapon, the target file) or any other parameters, then
you'll want a LSM hook instead.
