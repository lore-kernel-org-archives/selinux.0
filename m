Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5BG6gQI023094
	for <selinux@tycho.nsa.gov>; Thu, 11 Jun 2009 12:06:42 -0400
Received: from yw-out-1718.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5BG6WII019659
	for <selinux@tycho.nsa.gov>; Thu, 11 Jun 2009 16:06:32 GMT
Received: by yw-out-1718.google.com with SMTP id 5so718825ywr.84
        for <selinux@tycho.nsa.gov>; Thu, 11 Jun 2009 09:06:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1244732999.21565.750.camel@gorn.columbia.tresys.com>
References: <dd18b0c30906101326l7f017005p7b581c74da4e83a3@mail.gmail.com>
	 <1244732999.21565.750.camel@gorn.columbia.tresys.com>
Date: Thu, 11 Jun 2009 09:06:41 -0700
Message-ID: <dd18b0c30906110906j1667e794qc1b0aed3c95a676e@mail.gmail.com>
Subject: Re: [refpolicy] problem when compiling svn policy
From: Justin Mattock <justinmattock@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 11, 2009 at 8:09 AM, Christopher J.
PeBenito<cpebenito@tresys.com> wrote:
> On Wed, 2009-06-10 at 20:26 +0000, Justin Mattock wrote:
>> I seem to be running into an issue while compiling
>> the latest svn(just pulled, Ill test it out for you guys)
>> I see this:
>
> Can you provide more detail as to the build.conf settings?  I am not
> able to reproduce this.
>
>> make: *** No rule to make target
>> `/etc/selinux/refpolicy/contexts/users/appconfig-standard', needed by
>> `install'.  Stop.
>>
>> if I copy config/appconfig-standard to /etc/selinux/refpolicy/*
>> then the policy will compile all together.
>> should I just  wait and pull the policy  later?
>>
>> Also when doing make relabel I see this:
>>
>> Relabeling filesystem types: ext2 ext3 xfs jfs
>> /sbin/setfiles /etc/selinux/refpolicy/contexts/files/file_contexts /
>> filespec_add:  conflicting specifications for
>> /usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG and /usr/bin/getconf, using
>> system_u:object_r:bin_t.
>> filespec_add:  conflicting specifications for
>> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFF32 and
>> /usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG, using
>> system_u:object_r:bin_t.
>> filespec_add:  conflicting specifications for
>> /usr/lib/glibc/getconf/POSIX_V6_ILP32_OFFBIG and
>> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFF32, using
>> system_u:object_r:bin_t.
>> filespec_add:  conflicting specifications for
>> /usr/lib/glibc/getconf/XBS5_ILP32_OFF32 and
>> /usr/lib/glibc/getconf/POSIX_V6_ILP32_OFFBIG, using
>> system_u:object_r:bin_t.
>> filespec_add:  conflicting specifications for
>> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFFBIG and
>> /usr/lib/glibc/getconf/XBS5_ILP32_OFF32, using
>> system_u:object_r:bin_t.
>> filespec_add:  conflicting specifications for
>> /usr/lib/glibc/getconf/POSIX_V6_ILP32_OFF32 and
>> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFFBIG, using
>> system_u:object_r:bin_t.
>> filespec_eval:  hash table stats: 163158 elements, 29863/65536 buckets
>> used, longest chain length 11
>>
>> should I bee concerned, or is this something still being worked out?
>
> It would seem that /usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG
> and /usr/bin/getconf are hardlinked, which is why there is a conflict
> since they are lib_t and bin_t, respectively.  Which distribution?
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

sure,
Below is build.conf
I'm not sure but I think
choosing
DISTRO = redhat
might be causing these build errors.
(The system right now is an LFS system, I chose
redhat due to having /etc/rc.d/init.d/*)

As for reproducing these build errors:
If I load a fresh policy in my home directory
(choose mcs) then compile then once installing
I get errors(mainly file not found errors).
maybe I have something wrong with the "install"
command.
But If I compile the policy as a standard policy
seems to go through(except yesterday with some
appconfig-standard confusion)

seems this issue is a bit on and off, almost as if
the system needs to be in a correct state to properly
compile, or maybe because choosing redhat as the distro causes
confusion.(but still am not certain why I'm hitting this).

build.conf:

########################################
#
# Policy build options
#

# Policy version
# By default, checkpolicy will create the highest
# version policy it supports.  Setting this will
# override the version.  This only has an
# effect for monolithic policies.
OUTPUT_POLICY = 22

# Policy Type
# standard, mls, mcs
TYPE = standard

# Policy Name
# If set, this will be used as the policy
# name.  Otherwise the policy type will be
# used for the name.
NAME = refpolicy

# Distribution
# Some distributions have portions of policy
# for programs or configurations specific to the
# distribution.  Setting this will enable options
# for the distribution.
# redhat, gentoo, debian, suse, and rhel4 are current options.
# Fedora users should enable redhat.
DISTRO = redhat

# Unknown Permissions Handling
# The behavior for handling permissions defined in the
# kernel but missing from the policy.  The permissions
# can either be allowed, denied, or the policy loading
# can be rejected.
# allow, deny, and reject are current options.
UNK_PERMS = deny

# Direct admin init
# Setting this will allow sysadm to directly
# run init scripts, instead of requring run_init.
# This is a build option, as role transitions do
# not work in conditional policy.
DIRECT_INITRC = n

# Build monolithic policy.  Putting n here
# will build a loadable module policy.
MONOLITHIC = y

# User-based access control (UBAC)
# Enable UBAC for role separations.
UBAC = y

# Number of MLS Sensitivities
# The sensitivities will be s0 to s(MLS_SENS-1).
# Dominance will be in increasing numerical order
# with s0 being lowest.
MLS_SENS = 16

# Number of MLS Categories
# The categories will be c0 to c(MLS_CATS-1).
MLS_CATS = 256

# Number of MCS Categories
# The categories will be c0 to c(MLS_CATS-1).
MCS_CATS = 256

# Set this to y to only display status messages
# during build.
QUIET = n

As for any other adjustments, only
policy/users(for adding the user)
and default_contexts local_login
for the starting role.
then adding allow rules, and that's it
(I mainly am running the policy as set by you
guys, without any tweaks to it as much as possible).

I'll go ahead and try and recreate these errors
so you can get an idea of what I'm seeing.

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
