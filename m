Subject: RE: Useradd patchset - seeking comments..
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, sds@tycho.nsa.gov,
   selinux@tycho.nsa.gov
In-Reply-To: <200507071645.j67GjKQ4010377@gotham.columbia.tresys.com>
References: <200507071645.j67GjKQ4010377@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 14:23:20 -0400
Message-Id: <1120760600.2997.6.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I'll try to look at these - are they against the latest CVS with the module
> infrastructure?

No... I need to resync against that.

They're against the patched (rpm -bp):

libsepol-1.6-1
policycoreutils-1.24-1
checkpolicy-1.23.4-1
libselinux-1.24-1
shadow-utils-4.0.7-9

In other words you can't really test them out - just look at code.
There's also some evil bugs which I just fixed today
(I got usermod working, and fixed userdel), but I haven't 
updated patches - most of it should stay the same though.

>  Quick comment is that I don't think that the extern patch is
> useful and worth the trouble. Things in headers are, by definition, exported.
> Extern has no effect and does not add clarity IMHO.
> http://www.eskimo.com/~scs/C-faq/q1.11.html

Noted, but I don't see why you're complaining, since
your patch is already merged, isn't it? - shouldn't create
problems for you.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
