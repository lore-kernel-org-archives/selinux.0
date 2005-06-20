Subject: Re: dumb newbie questions
From: "R. Steven Rainwater" <srainwater@ncc.com>
To: SELinux@tycho.nsa.gov
In-Reply-To: <1119213695.17213.29.camel@localhost.localdomain>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
	 <1119213695.17213.29.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 19 Jun 2005 22:34:47 -0500
Message-Id: <1119238487.5253.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the replies so far. I understand that using audit2allow is
the wrong way to fix my problem but that still doesn't get me any closer
to making my perl scripts work.

On Sun, 2005-06-19 at 16:41 -0400, Ivan Gyurdiev wrote:
> To actually write policy you need to understand the
> SELinux policy language. There are several books
> on this...

Ouch. I normally don't have to read several books to get a one line
"hello world" perl script to run reliably on a new box. :-(

On Sun, 2005-06-19 at 23:13 +0100, Luke Kenneth Casson Leighton wrote: 
>  heck - it took me (and i pride myself on being a knowledge
>  sponge) TWO MONTHS to go from being an ill-educated
>  pain-in-the-ass to being an over-confident pain-in-the-ass.

Ouch again. I simply don't have two months to get this system up and
running. I've never had that many security problems on our servers and
we've been running normal Linux for years, so I don't think the extra
security of selinux will really be that helpful, especially if I can't
easily admin my boxes or install and run new programs when I need to.
I'm begining to think the best route would be to completely disable
selinux and go back to normal linux mode. What's the best way to do
that?

I've found two ways of getting rid of selinux:

1. adding SELINUX=disabled to /etc/sysconfig/selinux

2. or, add SELINUX=permissive

>From what the FAQs say, I'm guessing #1 is the way to go? It sounds like
option 2 will fill up my message log with more warnings. One of the FAQs
also says having selinux turned on slows the system down by 7%, so I'm
guess I'll get my 7% back with option 1 but not option 2?

When I've got a few months of free time available (ha!), I can set up a
test box and play around with selinux again.

-Steve



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
