Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5UFtggA023751
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 11:55:42 -0400 (EDT)
Received: from web31602.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j5UFs2Bs005535
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 15:54:02 GMT
Message-ID: <20050630155440.68314.qmail@web31602.mail.mud.yahoo.com>
Date: Thu, 30 Jun 2005 08:54:39 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Groups in the alternative user solution
To: Stephen Smalley <sds@tycho.nsa.gov>, gyurdiev@redhat.com
Cc: kmacmillan@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1120139167.11798.46.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2005-06-30 at 09:27 -0400, Ivan Gyurdiev
> wrote:
> > What about Casey's suggestion in this thread:
> > 
> > > 
> > >     root:*:sysadm
> > >     fred:wheel:wand
> > >     *:wheel:staff
> > >     *:*:normal

Since this small example led to confusion
in great minds, let me expand a touch.

Let's say that Fred is allowed groups:
    wheel,lever,pulley
And Barney is allowed groups:
    hoop,stick,gameboy

    root:*:sysadm
    fred:wheel:wand
    fred:wheel,lever:sword
    fred:wheel,pulley:sword
    fred:wheel,pulley,lever:blunderbus
    fred:pulley,lever:dagger
    fred:pulley:club
    fred:lever:club
    barney:hoop,stick,gameboy:gamer
    barney:stick:player
    barney:*:bored
    *:wheel:staff
    *.*:normal

> > > Fred would be in "wand" if only in group wheel,
> > > in "normal" if in groups wheel and dev. Fun.

> > Not sure I understand... 
> > So if Fred is in more groups other than wheel, 
> > he maps to normal? What's the rationale for that?

If there is an entry that exactly
matches it is used. In the revised
list above all the permutations of
Fred's group lists are explicitly
defined. For Fred, it is not ambiguous.
Barney has two entries that are exact
and one with a wildcard for the group.
If Barney is in all three of his groups
he gets one context, if in exactly the
one specified group he gets another,
and a third in all other cases.

> I didn't understand the reasoning there either,
> particularly as we
> aren't dealing with the effective GID but the entire
> authorized group
> list for the user since we are only doing this once
> at login/su time.

I hope this has clarified the group vs.
group list confusion.
 
> > Controlling information disclosure? Does that * 
> > take precedence to fred? What about conflicts? 
> > This seems complicated..

I don't think there are any conflicts.
If you have an exact match, you
use it. Otherwise if there is a match
on the UID and a wildcard match
for the group, you use that. If there
is no UID match but a group list
match you use that.

The same mindset as POSIX ACLs.




Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
