Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDlrL9015591
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:47:53 -0500 (EST)
Subject: Re: sshd transition points
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050216134457.GL31121@lkcl.net>
References: <20050215155323.GC23765@lkcl.net>
	 <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215191640.GA26294@lkcl.net>
	 <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net>
	 <20050215231707.GC29523@lkcl.net> <20050216000437.GD30341@lkcl.net>
	 <1108559425.19756.54.camel@moss-spartans.epoch.ncsc.mil>
	 <20050216134457.GL31121@lkcl.net>
Content-Type: text/plain
Message-Id: <1108561176.19756.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Feb 2005 08:39:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-16 at 08:44, Luke Kenneth Casson Leighton wrote:
>  out of curiosity: why?
> 
>  if it's specified in the policy, and there are permissions
>  required for it to occur, what is the harm?

Because you have an application that has explicitly requested a context
C1 but you are applying a different context C2 without its awareness. 
Compare with file relabeling; we don't rewrite the context passed to
setfilecon(3).  Or compare with setexeccon(3) - we don't rewrite the
context passed to it.  That is different than applying a default context
defined by policy when the application specified _no_ context for an
execve or a file creation.

>  what rules must be placed in the policy such that
>  security_compute_create will produce the desired results, for example:

It consults the type_transition rules in the policy.  It was named
security_transition_sid in the old pre-2.6 SELinux API (and that is
still the internal kernel function), but was renamed along with the
other APIs to reflect the elimination of SIDs from the kernel interface,
to avoid common misunderstandings (people often thought it caused a
transition rather than computing one, and they often thought that it was
used to relabel an object rather than to compute one for a new one), and
to provide a consistent naming convention - see selinux-doc/PORTING. 
Possibly a mistake to not retain transition in the name since that is
still the name for the rules in the policy.

>  if scon = "sshd_priv_t" and tcon = "user_t"
>  [and tclass = SECCLASS_PROCESS?]
> 
>  and i want newcon to equal "sshd_priv_user_t" as a result of the call,
> 
>  what do i put in the policy to reflect this?

type_transition sshd_priv_t user_t:process sshd_priv_user_t;

But I'm still not clear on your usage, as these processes are not
associated with a user.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
