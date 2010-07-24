MIME-Version: 1.0
In-Reply-To: <1279915503.32473.18.camel@moss-pluto.epoch.ncsc.mil>
References: <4C4837F2.1070806@redhat.com> <AANLkTinBsvbjKR4RnRc7NkWUsHRFqVSw7haMnYyR=-mL@mail.gmail.com>
	<1279915503.32473.18.camel@moss-pluto.epoch.ncsc.mil>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Sat, 24 Jul 2010 01:13:38 -0400
Message-ID: <AANLkTimuQfYSm7oTROwLJEhb9sPMTJCZvEbHqTJodTav@mail.gmail.com>
Subject: Re: This is my first patch for systemd
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 23, 2010 at 16:05, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2010-07-22 at 22:33 -0400, Kyle Moffett wrote:
>> Hmm, one thing that I've been thinking about for a while now is a
>> policy extension to type transitions allowing a match against the
>> object name.
>>
>> So for example, assuming /var/run gets correctly labelled as var_run_t:
>>
>> typename_transition systemd_t var_run_t:file "mysqld" mysql_var_run_t;
>>
>> If some form of globbing or patterns was added, this could in theory
>> even replace the current file_contexts file with a big list of
>> named_type_transitions in the policy.  Admittedly it could potentially
>> make the policy larger, but I believe with careful encoding and
>> compression it would be a net reduction in the size of
>> /etc/selinux/$POLICYNAME/ (since the plain-text highly-repetitive
>> file_contexts would go away).
>
> I don't think so.  The file_contexts configuration is for the initial
> assignment of filesystem labeling state by userspace, not for
> determining how files are labeled at runtime.  The file_contexts
> configuration would still be needed for applications like rpm and
> install in order to determine the right security context, even with an
> extended type_transition construct.  So this would not eliminate the
> need for file_contexts.

I understand the problem of initial labeling, but it would still be
possible to generate the entire set of initial labels from type
transition rules if name-pattern-matching were introduced.

Say you define 2 initial SID types in policy, an "fsroot_t" type and a
"labelinit_t" type.

Then to label the top-level directories, you have something along the lines of:

typename_transition labelinit_t fsroot_t:dir "lib" lib_t;
typename_transition labelinit_t fsroot_t:dir "usr" usr_t;
typename_transition labelinit_t fsroot_t:dir "etc" etc_t;
[...]
typename_transition labelinit_t usr_t:dir "lib" lib_t;

To label the /etc/passwd file, you would have:

typename_transition labelinit_t etc_t:file "passwd" etc_passwd_t;

Presumably you could do something similar with role-transitions
(although would anything other than object_r be appropriate?) and with
range-transitions in the MLS/MCS case.

The downside is a whole lot of new transition rules, but I believe
that we can improve the speed and performance of the policy compiler
and libsepol/libsemanage enough that it won't be an issue.

When you run "restorecon", "dpkg", "rpm", etc... all they would need
to do while unpacking is maintain the current label for each directory
in the path, and then check the transition from labelinit_t into the
destination directory for the file.

In practice I suspect that this would also rather dramatically cut
down on the number of rules needed to secure certain filetypes, and
furthermore it would make it much easier to customize the system.

For example, let's say I'm developing on some GIT checkouts of X and
installing them in /opt/xorgdev so they don't mess with my working
distribution-provided X install.  All I would need to do is ensure
that the immediate subdirectories of /opt/xorgdev/ are labelled
properly with lib_t, bin_t, etc.  Then when I drop the suid X binaries
into /opt/xorgdev/bin by hand and restorecon them, the pre-existing
transition rule for "X" in a bin_t directory would trigger and set the
context correctly.

IE: When you put a suid program called "X" in some directory that's in
the default path, it should get special SELinux privileges.

> We did previously discuss enabling type_transition rules to match on
> last component name, but the initial forays on linux-fsdevel on the
> necessary changes to pass down the name to the right function were shot
> down by the vfs folks IIRC.

Hmm, that's depressing... Do you have a link to the patches that were
posted?  From what I understand some of the hooks for path-based
security eventually got merged, so it's possible the information is
now more readily available than it was before.  The audit logs seem to
contain the file or directory name *most* of the time, so it seems
that it is frequently available somehow.

Cheers,
Kyle Moffett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
