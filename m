Subject: Re: is any use of runcon by arbitrary users valid when enforcing?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <87fy0n9zn3.fsf@rho.meyering.net>
References: <87fy0n9zn3.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Tue, 09 Oct 2007 09:17:22 -0400
Message-Id: <1191935842.24970.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-10-07 at 09:01 +0200, Jim Meyering wrote:
> In a simple test of runcon for coreutils test suite, I used the following,
> but see that it's failing in an enforcing F8t3 environment:
> [from coreutils/tests/misc/runcon]
> 
>     ...
>     cat <<\EOF > exp || framework_failure
>     runcon: runcon may be used only on a SELinux kernel
>     EOF
> 
>     fail=0
> 
>     # This test works even on systems without SELinux.
>     # On such a system it fails with the above diagnostic, which is fine.
>     # Before the no-reorder change, it would have failed with a diagnostic
>     # about -j being an invalid option.
>     runcon -t unconfined_t true -j 2> out && : > exp
> 
>     compare out exp || fail=1
> 
>     (exit $fail); exit $fail
> 
> Is there any similar use of runcon that can be expected to succeed?

How does it fail?  The runcon in rawhide (coreutils-6.9-6.fc8) appears
to work fine when invoked as above aside from needing to specify -- to
stop option processing before it reaches the -j.  This was while
enforcing with selinux-policy-3.0.8-18.fc8.  Possibly your system was
left in a strange state after an update (I have seen that in rawhide,
where a policy update left some processes with invalidated contexts).

However, the above test is clearly policy-specific; a policy may or may
not define unconfined_t, and a policy may or may not allow users to set
their exec context at all.  Under strict or mls policy, the above should
fail.

runcon `id -Z` true would be slightly more general (i.e. run in my own
context), but it too could fail since some policies may prohibit users
from writing to /proc/self/attr/exec altogether.

Possibly you could distinguish based on exit code as to whether the
cause was a permission failure?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
