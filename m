Date: Mon, 10 Dec 2001 11:02:15 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: New security policy
In-Reply-To: <3C144994.8010308@pcez.com>
Message-ID: <Pine.GSO.4.33.0112101059130.13300-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 9 Dec 2001, Shaun Savage wrote:

> I have compiled some of the selinux utils for RH7.2, I hope to do the
> rest this week.
> this is how I did it
>
> I first did  >rpm -bp XXXX.spec
> the patched the XXXX directory using the patch
> on some XXXX i needed to autoconf  (caution: the autoconf that comes
> with RH7.2 is bad upgrade to 2.52 from GNU.org)
> I then go back to the SPEC directory and rpm -bc --short-circuit XXXX.spec
> then rpm -bi --short-circuit XXXX.spec

In our work in upgrading the utilities, we've encountered a fair number of
rejects from the existing patches that have required manual merging, and
at least some of those manual merges were non-trivial.  We also had to add
stat64 variants of the stat_secure system calls, with transparent
redirection, in order to support the new fileutils package.  Are you
actually dealing with any of these kinds of issues in your patches?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
