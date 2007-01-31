From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>
Subject: Re: provoking fsetfilecon failure in a test case
In-Reply-To: <1170267927.12293.89.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Wed, 31 Jan 2007 13:25:27 -0500")
References: <87y7nk8g3a.fsf@rho.meyering.net>
	<1170261007.12293.64.camel@moss-spartans.epoch.ncsc.mil>
	<87iren6rag.fsf@rho.meyering.net>
	<1170267927.12293.89.camel@moss-spartans.epoch.ncsc.mil>
Date: Wed, 31 Jan 2007 22:32:01 +0100
Message-ID: <873b5q7ui6.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2007-01-31 at 18:26 +0100, Jim Meyering wrote:
...
>> In the interest of reproducing the conditions of the "cp -a" failure
>> for my test script, I'd prefer to run as non-root: far fewer users run
>> coreutils' root-requiring tests.  But so far, even with your list above,
>> unless the test can find a writable NFS partition, it looks like having
>> a non-root test is not feasible.  Can you see a way?
>
> Only by running the test in a confined domain that lacks the necessary
> permissions to the file type.  Which would either require finding a
> suitable domain to which you can transition in the existing policy or
> creating a small test policy module (which would have to be preloaded by
> a root process, of course).

Thanks for the continued (quick!) feedback.

This sounds like it could be less invasive than mounting a temporary
file system.  Especially if I can find an existing confined domain
that works.  What do you think?  If you're running coreutils'
"make check-root" rule, which would you prefer it to use:
  - a temporary loopback file system, or
  - create/load a test policy module, assuming I can unload it,
      leaving no trace, when done, or
  - (maybe best?) use some commonly-available confined domain
    that's suitable.  Then I don't have to worry about
    creating/loading one.

If the test-policy route sounds better, can you give a small demo?
Like how to find a suitable confined domain and, if needed,
how to create and preload a small test policy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
