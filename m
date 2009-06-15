Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5F4nau0026465
	for <selinux@tycho.nsa.gov>; Mon, 15 Jun 2009 00:49:37 -0400
Received: from yw-out-1718.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5F4o2jr027030
	for <selinux@tycho.nsa.gov>; Mon, 15 Jun 2009 04:50:02 GMT
Received: by yw-out-1718.google.com with SMTP id 5so1569159ywr.84
        for <selinux@tycho.nsa.gov>; Sun, 14 Jun 2009 21:49:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dd18b0c30906121101y6e1aeb55icbffa79ef495e741@mail.gmail.com>
References: <dd18b0c30906101326l7f017005p7b581c74da4e83a3@mail.gmail.com>
	 <1244732999.21565.750.camel@gorn.columbia.tresys.com>
	 <dd18b0c30906110906j1667e794qc1b0aed3c95a676e@mail.gmail.com>
	 <dd18b0c30906111029q50526f8eo620768e9647d4ec9@mail.gmail.com>
	 <dd18b0c30906111503n31651346p47f87e647aba6f56@mail.gmail.com>
	 <dd18b0c30906121101y6e1aeb55icbffa79ef495e741@mail.gmail.com>
Date: Sun, 14 Jun 2009 21:49:35 -0700
Message-ID: <dd18b0c30906142149j485741bbj774ab3ca778d1268@mail.gmail.com>
Subject: Re: [refpolicy] problem when compiling svn policy
From: Justin Mattock <justinmattock@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 12, 2009 at 11:01 AM, Justin Mattock<justinmattock@gmail.com> wrote:
> On Thu, Jun 11, 2009 at 3:03 PM, Justin Mattock<justinmattock@gmail.com> wrote:
>> On Thu, Jun 11, 2009 at 10:29 AM, Justin Mattock<justinmattock@gmail.com> wrote:
>>> On Thu, Jun 11, 2009 at 9:06 AM, Justin Mattock<justinmattock@gmail.com> wrote:
>>>> On Thu, Jun 11, 2009 at 8:09 AM, Christopher J.
>>>> PeBenito<cpebenito@tresys.com> wrote:
>>>>> On Wed, 2009-06-10 at 20:26 +0000, Justin Mattock wrote:
>>>>>> I seem to be running into an issue while compiling
>>>>>> the latest svn(just pulled, Ill test it out for you guys)
>>>>>> I see this:
>>>>>
>>>>> Can you provide more detail as to the build.conf settings?  I am not
>>>>> able to reproduce this.
>>>>>
>>>>>> make: *** No rule to make target
>>>>>> `/etc/selinux/refpolicy/contexts/users/appconfig-standard', needed by
>>>>>> `install'.  Stop.
>>>>>>
>>>>>> if I copy config/appconfig-standard to /etc/selinux/refpolicy/*
>>>>>> then the policy will compile all together.
>>>>>> should I just  wait and pull the policy  later?
>>>>>>
>>>>>> Also when doing make relabel I see this:
>>>>>>
>>>>>> Relabeling filesystem types: ext2 ext3 xfs jfs
>>>>>> /sbin/setfiles /etc/selinux/refpolicy/contexts/files/file_contexts /
>>>>>> filespec_add:  conflicting specifications for
>>>>>> /usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG and /usr/bin/getconf, using
>>>>>> system_u:object_r:bin_t.
>>>>>> filespec_add:  conflicting specifications for
>>>>>> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFF32 and
>>>>>> /usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG, using
>>>>>> system_u:object_r:bin_t.
>>>>>> filespec_add:  conflicting specifications for
>>>>>> /usr/lib/glibc/getconf/POSIX_V6_ILP32_OFFBIG and
>>>>>> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFF32, using
>>>>>> system_u:object_r:bin_t.
>>>>>> filespec_add:  conflicting specifications for
>>>>>> /usr/lib/glibc/getconf/XBS5_ILP32_OFF32 and
>>>>>> /usr/lib/glibc/getconf/POSIX_V6_ILP32_OFFBIG, using
>>>>>> system_u:object_r:bin_t.
>>>>>> filespec_add:  conflicting specifications for
>>>>>> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFFBIG and
>>>>>> /usr/lib/glibc/getconf/XBS5_ILP32_OFF32, using
>>>>>> system_u:object_r:bin_t.
>>>>>> filespec_add:  conflicting specifications for
>>>>>> /usr/lib/glibc/getconf/POSIX_V6_ILP32_OFF32 and
>>>>>> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFFBIG, using
>>>>>> system_u:object_r:bin_t.
>>>>>> filespec_eval:  hash table stats: 163158 elements, 29863/65536 buckets
>>>>>> used, longest chain length 11
>>>>>>
>>>>>> should I bee concerned, or is this something still being worked out?
>>>>>
>>>>> It would seem that /usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG
>>>>> and /usr/bin/getconf are hardlinked, which is why there is a conflict
>>>>> since they are lib_t and bin_t, respectively.  Which distribution?
>>>>>
>>>>> --
>>>>> Chris PeBenito
>>>>> Tresys Technology, LLC
>>>>> (410) 290-1411 x150
>>>>>
>>>>>
>>>>
>>>> sure,
>>>> Below is build.conf
>>>> I'm not sure but I think
>>>> choosing
>>>> DISTRO = redhat
>>>> might be causing these build errors.
>>>> (The system right now is an LFS system, I chose
>>>> redhat due to having /etc/rc.d/init.d/*)
>>>>
>>>> As for reproducing these build errors:
>>>> If I load a fresh policy in my home directory
>>>> (choose mcs) then compile then once installing
>>>> I get errors(mainly file not found errors).
>>>> maybe I have something wrong with the "install"
>>>> command.
>>>> But If I compile the policy as a standard policy
>>>> seems to go through(except yesterday with some
>>>> appconfig-standard confusion)
>>>>
>>>> seems this issue is a bit on and off, almost as if
>>>> the system needs to be in a correct state to properly
>>>> compile, or maybe because choosing redhat as the distro causes
>>>> confusion.(but still am not certain why I'm hitting this).
>>>>
>>>> build.conf:
>>>>
>>>> ########################################
>>>> #
>>>> # Policy build options
>>>> #
>>>>
>>>> # Policy version
>>>> # By default, checkpolicy will create the highest
>>>> # version policy it supports.  Setting this will
>>>> # override the version.  This only has an
>>>> # effect for monolithic policies.
>>>> OUTPUT_POLICY = 22
>>>>
>>>> # Policy Type
>>>> # standard, mls, mcs
>>>> TYPE = standard
>>>>
>>>> # Policy Name
>>>> # If set, this will be used as the policy
>>>> # name.  Otherwise the policy type will be
>>>> # used for the name.
>>>> NAME = refpolicy
>>>>
>>>> # Distribution
>>>> # Some distributions have portions of policy
>>>> # for programs or configurations specific to the
>>>> # distribution.  Setting this will enable options
>>>> # for the distribution.
>>>> # redhat, gentoo, debian, suse, and rhel4 are current options.
>>>> # Fedora users should enable redhat.
>>>> DISTRO = redhat
>>>>
>>>> # Unknown Permissions Handling
>>>> # The behavior for handling permissions defined in the
>>>> # kernel but missing from the policy.  The permissions
>>>> # can either be allowed, denied, or the policy loading
>>>> # can be rejected.
>>>> # allow, deny, and reject are current options.
>>>> UNK_PERMS = deny
>>>>
>>>> # Direct admin init
>>>> # Setting this will allow sysadm to directly
>>>> # run init scripts, instead of requring run_init.
>>>> # This is a build option, as role transitions do
>>>> # not work in conditional policy.
>>>> DIRECT_INITRC = n
>>>>
>>>> # Build monolithic policy.  Putting n here
>>>> # will build a loadable module policy.
>>>> MONOLITHIC = y
>>>>
>>>> # User-based access control (UBAC)
>>>> # Enable UBAC for role separations.
>>>> UBAC = y
>>>>
>>>> # Number of MLS Sensitivities
>>>> # The sensitivities will be s0 to s(MLS_SENS-1).
>>>> # Dominance will be in increasing numerical order
>>>> # with s0 being lowest.
>>>> MLS_SENS = 16
>>>>
>>>> # Number of MLS Categories
>>>> # The categories will be c0 to c(MLS_CATS-1).
>>>> MLS_CATS = 256
>>>>
>>>> # Number of MCS Categories
>>>> # The categories will be c0 to c(MLS_CATS-1).
>>>> MCS_CATS = 256
>>>>
>>>> # Set this to y to only display status messages
>>>> # during build.
>>>> QUIET = n
>>>>
>>>> As for any other adjustments, only
>>>> policy/users(for adding the user)
>>>> and default_contexts local_login
>>>> for the starting role.
>>>> then adding allow rules, and that's it
>>>> (I mainly am running the policy as set by you
>>>> guys, without any tweaks to it as much as possible).
>>>>
>>>> I'll go ahead and try and recreate these errors
>>>> so you can get an idea of what I'm seeing.
>>>>
>>>> --
>>>> Justin P. Mattock
>>>>
>>>
>>> This is what I see when using the same build.conf
>>> above, except just changing:
>>> TYPE = mcs
>>> NAME = mcs
>>> (then issue the following commands: make clean,
>>> make conf, make policy, sudo make install)
>>> results:
>>>
>>> Installing file_contexts.
>>> install -m 644 file_contexts /etc/selinux/mcs/contexts/files/file_contexts
>>> install -m 644 homedir_template /etc/selinux/mcs/contexts/files/homedir_template
>>> python -E support/genhomedircon -d /etc/selinux -t mcs
>>> grep: /etc/libuser.conf: No such file or directory
>>> You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=
>>> The user "staff_u" is not present in the passwd file, skipping...
>>> The user "sysadm_u" is not present in the passwd file, skipping...
>>> The user "unconfined_u" is not present in the passwd file, skipping...
>>> make: *** No rule to make target
>>> `/etc/selinux/mcs/contexts/default_contexts', needed by `install'.
>>> Stop.
>>>
>>> if I do the same above
>>> except
>>> sudo make install-src
>>> make conf
>>> make policy
>>> sudo make install
>>>
>>> I see:
>>>
>>> Installing file_contexts.
>>> install -m 644 file_contexts /etc/selinux/mcs/contexts/files/file_contexts
>>> install -m 644 homedir_template /etc/selinux/mcs/contexts/files/homedir_template
>>> python -E support/genhomedircon -d /etc/selinux -t mcs
>>> grep: /etc/libuser.conf: No such file or directory
>>> You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=
>>> The user "staff_u" is not present in the passwd file, skipping...
>>> The user "sysadm_u" is not present in the passwd file, skipping...
>>> The user "unconfined_u" is not present in the passwd file, skipping...
>>> make: *** No rule to make target
>>> `/etc/selinux/mcs/contexts/default_contexts', needed by `install'.
>>> Stop.
>>>
>>>
>>> Now leaving the build.conf the same except for
>>> changing DISTRO = redhat to
>>> #DISTRO = redhat
>>> (make clean, make conf, make policy,
>>> sudo make install)
>>>
>>> Installing file_contexts.
>>> install -m 644 file_contexts /etc/selinux/mcs/contexts/files/file_contexts
>>> install -m 644 homedir_template /etc/selinux/mcs/contexts/files/homedir_template
>>> python -E support/genhomedircon -d /etc/selinux -t mcs
>>> grep: /etc/libuser.conf: No such file or directory
>>> You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=
>>> The user "staff_u" is not present in the passwd file, skipping...
>>> The user "sysadm_u" is not present in the passwd file, skipping...
>>> The user "unconfined_u" is not present in the passwd file, skipping...
>>> make: *** No rule to make target
>>> `/etc/selinux/mcs/contexts/default_contexts', needed by `install'.
>>> Stop.
>>>
>>> Now same as above just adding
>>> sudo make install-src before build.conf
>>>
>>> Installing file_contexts.
>>> install -m 644 file_contexts /etc/selinux/mcs/contexts/files/file_contexts
>>> install -m 644 homedir_template /etc/selinux/mcs/contexts/files/homedir_template
>>> python -E support/genhomedircon -d /etc/selinux -t mcs
>>> grep: /etc/libuser.conf: No such file or directory
>>> You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=
>>> The user "staff_u" is not present in the passwd file, skipping...
>>> The user "sysadm_u" is not present in the passwd file, skipping...
>>> The user "unconfined_u" is not present in the passwd file, skipping...
>>> make: *** No rule to make target
>>> `/etc/selinux/mcs/contexts/default_contexts', needed by `install'.
>>> Stop.
>>>
>>> Now if I change the build.conf to:
>>> TYPE = standard
>>> NAME = refpolicy
>>> #DISTRO = redhat
>>> I see:
>>> Installing file_contexts.
>>> install -m 644 file_contexts /etc/selinux/refpolicy/contexts/files/file_contexts
>>> install -m 644 homedir_template
>>> /etc/selinux/refpolicy/contexts/files/homedir_template
>>> python -E support/genhomedircon -d /etc/selinux -t refpolicy
>>> grep: /etc/libuser.conf: No such file or directory
>>> You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=
>>> The user "staff_u" is not present in the passwd file, skipping...
>>> The user "sysadm_u" is not present in the passwd file, skipping...
>>> The user "unconfined_u" is not present in the passwd file, skipping...
>>> make: *** No rule to make target
>>> `/etc/selinux/refpolicy/contexts/default_contexts', needed by
>>> `install'.  Stop.
>>>
>>> then changing:
>>> TYPE = standard
>>> NAME = refpolicy
>>> DISTRO = redhat
>>> I see:
>>>
>>> Installing file_contexts.
>>> install -m 644 file_contexts /etc/selinux/refpolicy/contexts/files/file_contexts
>>> install -m 644 homedir_template
>>> /etc/selinux/refpolicy/contexts/files/homedir_template
>>> python -E support/genhomedircon -d /etc/selinux -t refpolicy
>>> grep: /etc/libuser.conf: No such file or directory
>>> You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=
>>> The user "staff_u" is not present in the passwd file, skipping...
>>> The user "sysadm_u" is not present in the passwd file, skipping...
>>> The user "unconfined_u" is not present in the passwd file, skipping...
>>> make: *** No rule to make target
>>> `/etc/selinux/refpolicy/contexts/default_contexts', needed by
>>> `install'.  Stop.
>>>
>>>
>>> To get mcs to properly go through the whole install process
>>> I have to issue these commands:
>>> (inside refpolicy tree)
>>> sudo cp -Rv appconfig-mcs/* /etc/selinux/mcs/contexts
>>> sudo cp -Rv config/appconfig-mcs /etc/selinux/mcs/contexts/users
>>> sudo touch -v /etc/selinux/mcs/contexts/files/media
>>> (then make clean,make conf,make policy,
>>> sudo make install)
>>>
>>> For some reason the proper files are not being created,
>>> and not going to the right location.
>>> (seems when I loaded svn only mcs would produce this,
>>> standard would follow through and install properly).
>>>
>>> As for libuser.conf, probably not pertaining to this.
>>> (but could be wrong).
>>>
>>> --
>>> Justin P. Mattock
>>>
>>
>> Well I don't get it
>> I have two machines here
>> same system(created one, then just made
>> a copy for the other) same kernel.
>>
>> downloaded two copies of refpolicy svn(today)
>> and on one machine refpolicy compiles perfectly,
>> and on the other I'm hitting this error.
>> I must have something missing, or did something
>> to the machine that doesn't want to compile the policy.
>> (I guess out of desperation I'll just copy the good compiled policy
>> over to the other machine).
>>
>>
>> --
>> Justin P. Mattock
>>
>
> Not sure how to handle this, with the machine
> that passes with the latest svn, is also failing
> with the latest refpolicy tar ball.
> below is what sudo make -d install
> produces:
>
> Installing file_contexts.
> Live child 0x08134cb0 (/etc/selinux/mcs/contexts/files/file_contexts) PID 13421
> Reaping winning child 0x08134cb0 PID 13421
> Live child 0x08134cb0 (/etc/selinux/mcs/contexts/files/file_contexts) PID 13422
> Reaping winning child 0x08134cb0 PID 13422
> install -m 644 file_contexts /etc/selinux/mcs/contexts/files/file_contexts
> Live child 0x08134cb0 (/etc/selinux/mcs/contexts/files/file_contexts) PID 13423
> Reaping winning child 0x08134cb0 PID 13423
> install -m 644 homedir_template /etc/selinux/mcs/contexts/files/homedir_template
> Live child 0x08134cb0 (/etc/selinux/mcs/contexts/files/file_contexts) PID 13424
> Reaping winning child 0x08134cb0 PID 13424
> python -E support/genhomedircon -d /etc/selinux -t mcs
> Live child 0x08134cb0 (/etc/selinux/mcs/contexts/files/file_contexts) PID 13425
> grep: /etc/libuser.conf: No such file or directory
> You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=
> The user "staff_u" is not present in the passwd file, skipping...
> The user "sysadm_u" is not present in the passwd file, skipping...
> The user "unconfined_u" is not present in the passwd file, skipping...
> Reaping winning child 0x08134cb0 PID 13425
> Removing child 0x08134cb0 PID 13425 from chain.
>  Successfully remade target file
> `/etc/selinux/mcs/contexts/files/file_contexts'.
>  Considering target file `/etc/selinux/mcs/contexts/default_contexts'.
>  File `/etc/selinux/mcs/contexts/default_contexts' does not exist.
>  Looking for an implicit rule for
> `/etc/selinux/mcs/contexts/default_contexts'.
>  Trying pattern rule with stem `default_contexts'.
>  Trying rule prerequisite `config/appconfig-mcs'.
>  Trying implicit prerequisite `/default_contexts'.
>  Trying pattern rule with stem `default_contexts'.
>  Trying implicit prerequisite `/etc/selinux/mcs/contexts/default_contexts,v'.
>  Trying pattern rule with stem `default_contexts'.
>  Trying implicit prerequisite
> `/etc/selinux/mcs/contexts/RCS/default_contexts,v'.
>  Trying pattern rule with stem `default_contexts'.
>  Trying implicit prerequisite
> `/etc/selinux/mcs/contexts/RCS/default_contexts'.
>  Trying pattern rule with stem `default_contexts'.
>  Trying implicit prerequisite `/etc/selinux/mcs/contexts/s.default_contexts'.
>  Trying pattern rule with stem `default_contexts'.
>  Trying implicit prerequisite
> `/etc/selinux/mcs/contexts/SCCS/s.default_contexts'.
>  Trying pattern rule with stem `default_contexts'.
>  Trying rule prerequisite `config/appconfig-mcs'.
>  Trying implicit prerequisite `/default_contexts'.
>  Looking for a rule with intermediate file `/default_contexts'.
>   Avoiding implicit rule recursion.
>   Trying pattern rule with stem `default_contexts'.
>   Trying implicit prerequisite `/default_contexts,v'.
>   Trying pattern rule with stem `default_contexts'.
>   Trying implicit prerequisite `/RCS/default_contexts,v'.
>   Trying pattern rule with stem `default_contexts'.
>   Trying implicit prerequisite `/RCS/default_contexts'.
>   Trying pattern rule with stem `default_contexts'.
>   Trying implicit prerequisite `/s.default_contexts'.
>   Trying pattern rule with stem `default_contexts'.
>   Trying implicit prerequisite `/SCCS/s.default_contexts'.
>  No implicit rule found for `/etc/selinux/mcs/contexts/default_contexts'.
>  Finished prerequisites of target file
> `/etc/selinux/mcs/contexts/default_contexts'.
>  Must remake target `/etc/selinux/mcs/contexts/default_contexts'.
> make: *** No rule to make target
> `/etc/selinux/mcs/contexts/default_contexts', needed by `install'.
> Stop.
>
>
> No implicit rule found for `/etc/selinux/mcs/contexts/default_contexts'.
>
> What rule might this be looking for?
> (BTW I accidentally just sent a post that had an attachment
> of the debug messages, that ended up being to big,
> sorry)
>
> --
> Justin P. Mattock
>

Well I finally got mcs to compile cleanly
without any errors.
one thing that I remembered is I added "y" to:
CC_STACKPROTECTOR=y
(then experienced these errors)
after
CC_STACKPROTECTOR=n
then loading a fresh copy seemed
to compile like there was nothing wrong.

I don't know I give up!!

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
