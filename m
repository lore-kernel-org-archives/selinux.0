Date: Mon, 20 Jun 2005 19:49:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: dumb newbie questions
Message-ID: <20050620184909.GA8451@lkcl.net>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com> <1119210718.17213.6.camel@localhost.localdomain> <1119213695.17213.29.camel@localhost.localdomain> <1119238487.5253.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1119238487.5253.23.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

allo steven, i didn't notice it was you doin the asking :)
long time no talk!

On Sun, Jun 19, 2005 at 10:34:47PM -0500, R. Steven Rainwater wrote:

> Ouch again. I simply don't have two months to get this system up and
> running. I've never had that many security problems on our servers and
> we've been running normal Linux for years, so I don't think the extra
> security of selinux will really be that helpful, especially if I can't
> easily admin my boxes or install and run new programs when I need to.
> I'm begining to think the best route would be to completely disable
> selinux and go back to normal linux mode. What's the best way to do
> that?
> 
> I've found two ways of getting rid of selinux:
> 
> 1. adding SELINUX=disabled to /etc/sysconfig/selinux
> 
> 2. or, add SELINUX=permissive

 i wouldn't recommend either of these.
 
 what i _would_ recommend is that you install the "targetted"
 policy rather than the "strict" one.

 ... but if you absolutely absolutely must "get rid" of selinux, then
 use 1. not 2.

 remember that you will need to relabel your filesystem if you wish to
 reintroduce selinux, because 1) will create files without an selinux
 permission (equivalent to chmod 000 on files) and 2) will allow files
 to be created that would otherwise be banned, such that they are likely
 to have the _wrong_ [unpredictable] selinux file contexts.


 the targetted policy allows anything that isn't constrained by selinux
 to happily do what it likes - as long as it doesn't stomp on the toes
 of anything that _is_ constrained.

 e.g. if you haven't got a web server installed then you can write your
 own program, run as root, to bind to port 80.

 [on a "strict" system, if you haven't added the apache.te policy in then
  NOTHING can bind to port 80, even if you're running as root.]

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
