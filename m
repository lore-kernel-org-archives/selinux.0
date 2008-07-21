Date: Mon, 21 Jul 2008 13:42:19 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Eric Paris <eparis@parisplace.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
Subject: Re: About unifying the coding style
In-Reply-To: <Pine.LNX.4.64L.0807211208370.17053@ruuvi.it.helsinki.fi>
Message-ID: <Pine.LNX.4.64L.0807211321270.19239@ruuvi.it.helsinki.fi>
References: <Pine.LNX.4.64L.0807211208370.17053@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

On Mon, 21 Jul 2008, Vesa-Matti J Kari wrote:

> 1) Is there a general agreement that only one style should be used?

Some time ago I came across a very interesting text called "An
Interview with Brian Kernighan" by Mihai Budiu. You can find it
at:

  http://www-2.cs.cmu.edu/~mihaib/kernighan-interview/index.html

Below is an excerpt from the interview. It is related to the style issues:

===== excerpt begins ==================================

M: Speaking of sanity checks, I am working on a project which involves a
large code base; some functions which are edited by several people: they
constantly change the style of the indentation and identifiers. You have
published some books on coding style: does your style always match your
co-author's style, or do you have problems in reconciling?

K: [laughing] That's also a nice question. Occasionally I've had,
``trouble'' is not the word, but with co-authors, there have been
discussions about where to put the braces, where to put the spaces and how
to spell identifier names. Most of those things have been pretty trivial,
partly because my co-authors have been right around here and we have grown
up in the same kind of cultural background. But for instance when Rob Pike
and I were working on ``The Practice of Programming'' a couple of years
ago, we had pretty intense discussions about trivial keywords like ``where
do you put the spaces''. How many spaces do you put? I like to put spaces
after things like if and while and for and Rob does not. I won that part
of the battle, but there was some other part of the battle I lost, I don't
even remember now what it was. We definitely didn't agree 100%, but we
came to a friendly settlement of the whole thing.

The more people you have working on something and the bigger the program,
the harder it's going to be, and at some point you have to have
agreed-upon standards that everybody sticks to and mechanized tools like
pretty-printers that just enforce doing it by the rules, because otherwise
you lose too much time and there's real chance for making mistakes.

===== excerpt ends =====================================

I think the important lessons are:

1) Style matters. The great masters such as Kernighan & Pike spend
   time making their code look unified and beautiful.

2) Kernighan & Pike "came to a friendly settlement of the whole thing"
   despite not agreeing 100%. I interpret that to mean that both
   had to make some compromises, but ultimately a common coding standard
   agreement was reached.


Linux (the kernel) is critical code, and SELinux, handling crucial
security issues, is a very critical part of Linux.

Therefore the coding standards should be very high, and preferably made
explicit by a written standard. That is my opinion.

Yes, there is Linus' "Linux kernel coding style"
(Documentation/CodingStyle), which serves as a good base document, but I
think SELinux could have even more explicit rules.

Having a written coding standard document would render style debates
unnecessary, which would save time in the future and would also lead to a
cleaner code base.

I also think the coding standard should apply to the SELinux userspace
too.

Best regards,
vmk
--
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
