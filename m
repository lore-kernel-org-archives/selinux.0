Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n95Ii814029541
	for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2009 14:44:08 -0400
Received: from mx.meyering.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n95IjhqZ019524
	for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2009 18:45:43 GMT
From: Jim Meyering <jim@meyering.net>
To: =?utf-8?B?T25kxZllaiBWYcWhw61r?= <ovasik@redhat.com>, yaneti@declera.com
Cc: CoreutilsBugs <bug-coreutils@gnu.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH]: chcon: no longer abort on SELinux disabled kernel
In-Reply-To: <1254727932.3849.8.camel@dhcp-lab-219.englab.brq.redhat.com>
	(=?utf-8?B?Ik9uZMWZZWogVmHFocOtayIncw==?= message of "Mon, 05 Oct 2009
 09:32:12 +0200")
References: <1254727932.3849.8.camel@dhcp-lab-219.englab.brq.redhat.com>
Date: Mon, 05 Oct 2009 20:44:01 +0200
Message-ID: <87zl85bs0e.fsf@meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ondřej Vašík wrote:
> as reported in https://bugzilla.redhat.com/show_bug.cgi?id=527142 by
> Yanko Kaneti, chcon aborts on SELinux disabled kernel due to missing
> check for SELinux enabled kernel. Attached patch is fixing the issue.
>
> Additionally - for consistency - error message of this check in runcon
> was changed to not hardcode "runcon" program name.

[Cc'ing the SELinux list for the question at the end
 Summary: chcon(1) aborts when a successful getfilecon
 result is passed to context_new and makes it return NULL. ]

Thanks, Ondřej.
At first, I planned to use that patch, mostly as-is, but
moving the chcon paragraph in NEWS "up" so that it's alphabetized.

  chcon no longer aborts on SELinux disabled system.
  [the bug dates back to the initial implementation]

However, since I have so far been unable to reproduce the failure,
(neither in mock, nor on bare-metal x86_64 with SELinux disabled)
and know that merely running chcon with SELinux disabled is not
enough to trigger the abort, what's written above is misleading.
What if the only way to trigger the abort is with a strangely-
or improperly-configured system?
In fact, until I understand how/why the offending code is being
reached, I hesitate to call this a bug or say where it originated.

If the getfilecon call succeeds, then why would context_new fail?
Right after I wrote the line above, it clicked.
Some versions of getfilecon can succeed (and return >= 0)
yet set the context string to "unlabeled".  *That* is what
causes trouble if you pass it to context_new.

This makes me want to write a getfilecon wrapper
that would convert that surprising result into a return
value of -1 with errno of ENOTSUP.  A wrapper would also
protect us from the small risk of folks using the older
libselinux versions that can return 0 and a NULL context.

Can the SELinux folks tell us under what circumstances
getfilecon will return 10 and set *context to "unlabeled"?

Thanks,

Jim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
