Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5DCSfae015927
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 08:28:41 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5DCSUhG020636
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 12:28:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "max bianco" <maximilianbianco@gmail.com>
Subject: Re: SELinux References/Books
Date: Fri, 13 Jun 2008 22:28:19 +1000
Cc: selinux@tycho.nsa.gov
References: <48502D42.4030905@gmail.com> <1213273867.17842.179.camel@moss-spartans.epoch.ncsc.mil> <a040ffdc0806121100v7732f155h881379386ad546da@mail.gmail.com>
In-Reply-To: <a040ffdc0806121100v7732f155h881379386ad546da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806132228.21083.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 13 June 2008 04:00, "max bianco" <maximilianbianco@gmail.com> wrote:
> here that I am unaware of or that simply aren't occurring to me right
> now. I can't be the first person to have such an idea and it will of
> course be pointed out that live journals work much the same but here
> my point is the scope of the audience that you are reaching on a
> mailing list vs. an individual blog of which there are hundred's of
> thousands if not millions. Also it would help by adding more

That's why you have blog syndication.  I expect that the number of people who 
read my blog via the various Planets exceeds the number of subscribers that 
most mailing lists have.  Of course blog syndication does not work well for 
content that is being modified.

> other thing I noticed, while at the bookstore, is that various/most of
> the Linux magazines on the shelf right now have articles on security
> in them and one, i forget which, has a piece on SELinux. It seems its
> a hot topic everywhere I look. Cspan aired a rerun, from yesterday I

My observation is that SE Linux is not as much of a hot topic as it used to 
be.  Now there are many people using it (some of whom don't even realise that 
they do), and it's part of the infrastructure.  When SE Linux was a new thing 
that few people understood there was a lot more excitement.

> what I saw nobody mentioned the real problem. As far as I am concerned
> the "real" problem is having the widespread use of an operating system
> that makes things like drive by downloads so easy in the first place,

Until we get the X access controls in common use, SE Linux won't be doing that 
much to prevent desktop attacks.

> where most of the security rests with a program(anti virus) that
> relies almost exclusively on updates but that is another debate and

I don't think that you will get a debate on the merits of anti-virus software 
on this list.  I think that there is general agreement that any attacker 
worth worrying about will launch an attack that doesn't match a known 
signature.  Past discussions on this list have covered issues such as the 
utility of shells and interpreters such as Perl for launching attacks.

Note that this doesn't mean that virus scanners for email and browser warnings 
for bogus sites are a bad idea.  Mitigating factors that reduce the scope of 
the threat make it easier to recognise real threats.

> probably not one worth having anyway. Unfortunately it will probably
> take a major virus outbreak, on a scale we have yet to see, or a
> massive, widespread, and very public breach of security to wake people
> up. I will go ahead and shutdown here,  my real point is that it seems
> people are starting to pay a lot more attention :^). Thanks for the
> feedback.

http://conference.auscert.org.au/conf2006/presentation.php

There are significant amounts of money involved in computer crime nowadays.  
At the AusCERT 2006 conference Jake Jacobson of the U.S. Secret Service gave 
a very interesting talk about the organised computer crime groups.  The 
amounts of money involved give a lot of nasty people significant incentives 
to not have public breaches of security.

I've been involved in the SE Linux project for almost seven years.  Over that 
time I have always felt that the problem scope is increasing faster than our 
progress on fixing things.


PS  If you get a chance I recommend that you attend a lecture by Jake or one 
of his colleagues.  It's an experience you'll remember for the rest of your 
life.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
