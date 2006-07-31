From: Jim Meyering <jim@meyering.net>
To: Valdis.Kletnieks@vt.edu
Cc: SELinux@tycho.nsa.gov
Subject: Re: infelicity in context_user_set; new syscalls: setfileconat, etc.?
In-Reply-To: <200607310458.k6V4wScX009997@turing-police.cc.vt.edu> (Valdis
	Kletnieks's message of "Mon, 31 Jul 2006 00:58:27 -0400")
References: <87zmeslb2v.fsf@rho.meyering.net>
	<200607310458.k6V4wScX009997@turing-police.cc.vt.edu>
Date: Mon, 31 Jul 2006 10:39:24 +0200
Message-ID: <87odv6kw1v.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:

> On Sat, 29 Jul 2006 16:50:16 +0200, Jim Meyering said:
>
>> FYI, as part of merging the coreutils SE Linux changes "upstream",
>> I've just rewritten chcon to use fts (and new openat-style functions,
>> getfileconat, lgetfileconat, setfileconat, lsetfileconat[*]).
>
> OK...
>
>> [*] With linux and /proc, I can emulate functions like openat and
>> setfileconat, but not everyone has linux, and some linux environments
>> lack access to /proc, so...
>
> Everybody who cares about SELinux changes for coreutils presumably has Linux. ;)

Of course :)

> And I suspect that nobody's running an SELinux system with no /proc mounted
> (except on some *really* Martian-logic design for a Really Secure embedded
> system or something...)

Let's assume that all properly-configured environments do mount /proc.
Are the required features[*] of /proc usable even in the most restrictive
environments?  If so, then the only remaining argument for adding syscalls
is one of efficiency -- not very compelling.

[*] The ability to access any FILE via /proc/self/fd/N/FILE,
where the directory containing FILE is open on file descriptor N.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
