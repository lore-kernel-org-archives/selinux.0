From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: is any use of runcon by arbitrary users valid when enforcing?
In-Reply-To: <1191935842.24970.35.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Tue, 09 Oct 2007 09:17:22 -0400")
References: <87fy0n9zn3.fsf@rho.meyering.net>
	<1191935842.24970.35.camel@moss-spartans.epoch.ncsc.mil>
Date: Tue, 09 Oct 2007 18:01:15 +0200
Message-ID: <878x6cwa44.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Sun, 2007-10-07 at 09:01 +0200, Jim Meyering wrote:
>> In a simple test of runcon for coreutils test suite, I used the following,
>> but see that it's failing in an enforcing F8t3 environment:
>> [from coreutils/tests/misc/runcon]
>>
>>     ...
>>     cat <<\EOF > exp || framework_failure
>>     runcon: runcon may be used only on a SELinux kernel
>>     EOF
>>
>>     fail=0
>>
>>     # This test works even on systems without SELinux.
>>     # On such a system it fails with the above diagnostic, which is fine.
>>     # Before the no-reorder change, it would have failed with a diagnostic
>>     # about -j being an invalid option.
>>     runcon -t unconfined_t true -j 2> out && : > exp
>>
>>     compare out exp || fail=1
>>
>>     (exit $fail); exit $fail
>>
>> Is there any similar use of runcon that can be expected to succeed?
>
> How does it fail?  The runcon in rawhide (coreutils-6.9-6.fc8) appears

I think it failed with one of these:

    runcon: invalid context: ... Invalid argument
    runcon: unable to set security context ...

> to work fine when invoked as above aside from needing to specify -- to
> stop option processing before it reaches the -j.  This was while
> enforcing with selinux-policy-3.0.8-18.fc8.  Possibly your system was
> left in a strange state after an update (I have seen that in rawhide,
> where a policy update left some processes with invalidated contexts).

Ahh... maybe that's it.  It _was_ after a rawhide update.
Since then, I've updated at least once and rebooted with
the new kernel, and I can no longer reproduce it.

> However, the above test is clearly policy-specific; a policy may or may
> not define unconfined_t, and a policy may or may not allow users to set
> their exec context at all.  Under strict or mls policy, the above should
> fail.
>
> runcon `id -Z` true would be slightly more general (i.e. run in my own
> context),

Good idea.  I've just done that:

  http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=3e53920470cf34

> but it too could fail since some policies may prohibit users
> from writing to /proc/self/attr/exec altogether.
>
> Possibly you could distinguish based on exit code as to whether the
> cause was a permission failure?

Is that sort of set-up common?  Currently, runcon distinguishes these
three types of failure:

     1   if `runcon' itself fails
     126 if COMMAND is found but cannot be invoked
     127 if COMMAND cannot be found
     the exit status of COMMAND otherwise

I'll deal with that if anyone ever reports the problem.
>From the amount of SELinux feedback I get for coreutils, I suspect
I'm the only one who tests coreutils on SELinux-enabled systems.

FWIW, you'll be glad to know I've opted to leave in the controversial
SELinux bits we talked about a few months ago, and coreutils-6.10 isn't
far off.

In case any of you are interested, snapshots are here:
  http://meyering.net/cu/
  http://meyering.net/cu/coreutils-6.9-ss.tar.gz
  http://meyering.net/cu/coreutils-6.9-ss.tar.gz.sig

Or via git:
  http://git.sv.gnu.org/gitweb/?p=coreutils.git
  git clone git://git.sv.gnu.org/coreutils

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
