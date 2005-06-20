Message-Id: <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: dumb newbie questions 
In-Reply-To: Your message of "Sun, 19 Jun 2005 22:34:47 CDT."
             <1119238487.5253.23.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com> <1119210718.17213.6.camel@localhost.localdomain> <1119213695.17213.29.camel@localhost.localdomain>
            <1119238487.5253.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119242736_3970P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 20 Jun 2005 00:45:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1119242736_3970P
Content-Type: text/plain; charset=us-ascii

On Sun, 19 Jun 2005 22:34:47 CDT, "R. Steven Rainwater" said:
> Ouch. I normally don't have to read several books to get a one line
> "hello world" perl script to run reliably on a new box. :-(

Oh? You learned C without a book, or Perl, or any of the other languages? :)

perl -e 'print "Hello World!\n"'

doesn't generate any AVCs on my system when run as a normal user.  So that's a
straw man.

Or are you saying that you let people write more complex Perl CGIs for your
system (complex enough that they're running external commands or using Mysql or
the other usual suspects for SELinux issues) and these people *don't* have Perl
knowledge equivalent to reading several books on it? ;)

> Ouch again. I simply don't have two months to get this system up and
> running. I've never had that many security problems on our servers and
> we've been running normal Linux for years, so I don't think the extra
> security of selinux will really be that helpful, especially if I can't
> easily admin my boxes or install and run new programs when I need to.

It's a matter of trade-offs - if you do a 'chown -R root:root /' and change the
root password to "", it's *really* easy to admin the boxes. ;)

Also, "We haven't had many security problems in the past" doesn't prove
anything. I've heard that from sites that leaked like a sieve security-wise and
simply didn't *know* they'd been 0wnz0red for months.  Also, just because the
defenses you had 3 and 5 years ago stopped most of the hackers 3 and 5 years
ago doesn't mean that they're sufficient to stop next year's hackers....

If you have 2 minutes rather than 2 months, kick the system to 'permissive'
mode.

> I'm begining to think the best route would be to completely disable
> selinux and go back to normal linux mode. What's the best way to do
> that?
> 
> I've found two ways of getting rid of selinux:
> 
> 1. adding SELINUX=disabled to /etc/sysconfig/selinux
> 
> 2. or, add SELINUX=permissive
> 
> >From what the FAQs say, I'm guessing #1 is the way to go? It sounds like
> option 2 will fill up my message log with more warnings. One of the FAQs
> also says having selinux turned on slows the system down by 7%, so I'm
> guess I'll get my 7% back with option 1 but not option 2?

Note that in "permissive" mode, each AVC message will only fire the first time
it gets hit - which means that most likely, in the first hour or so of uptime
you'll accumulate the majority of warnings you'll get.

If nothing else, "permissive" mode is better than "disabled" security-wise -
even if it doesn't stop an attack, at least you get the audit trail that
something odd happened.

Also, your system may be the exception, but the vast majority of people who
see "7% performance hit" and immediately label it as "intolerable" are people
who are running poorly tuned systems that could get back a lot more than 7%
with just a little bit of work.

> When I've got a few months of free time available (ha!), I can set up a
> test box and play around with selinux again.

You probably want to run in permissive mode *before* that, so that when you
start playing around, you have the AVC messages in hand to start thinking
about. As has been pointed out in other recent postings, 'audit2allow' is a
poor substitute for looking at the AVC's your current policy generates and
*thinking* about what is needed...  And although you'll get *most* of the
avc messages fairly quickly, a lot of them will only trip on rare corner-case
occasions (for instance, if you have a monthly summary/whatever process, and
base your policy on the 3 weeks of the month that said process doesn't run,
your policy will likely kill that monthly process....)


--==_Exmh_1119242736_3970P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCtknwcC3lWbTT17ARAh7gAKDQeUQuxM7y41LySW4z+BrPi9IK6ACgj0L5
PGl4tknZy42XYj9Y7Nup3/s=
=togs
-----END PGP SIGNATURE-----

--==_Exmh_1119242736_3970P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
