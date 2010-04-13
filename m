Subject: Re: The confusing dot operator
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov, Joe Nall <joe@nall.com>,
        Ted X Toth <txtoth@gmail.com>, Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <20100406134846.GO1518@myhost.felk.cvut.cz>
References: <20100406134846.GO1518@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Tue, 13 Apr 2010 15:12:59 -0400
Message-Id: <1271185979.9577.62.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-04-06 at 15:48 +0200, Michal Svoboda wrote:
> Hi,
> 
> I've been doing some MCS lately and I particularly started disliking the
> dot range operator, as in 'c0.c1023'.
> 
> It seems to be an underdeveloped way of saying 'all categories' or
> perhaps grouping them. I would welcome a 'star' operator that would do
> the former and a more intelligent naming mechanism to express the latter
> (ie. let's have a facility that can group 'dogs,cats,horses' as 'mammals'
> and 'mammals,insects' as 'animals').
> 
> It imposes a range where there isn't. The range is in fact dependent on
> the exact order of delaration. If you declare 'category c1; category c0;
> category c2;' then 'c0.c2' does not include c1. If you use named cats
> rather than c0-cN then even this little sense of range goes away.
> 
> Finally and most importantly sets of such 'consecutive' categories tend
> to get 'range-ized' at numerous places. If a seuser is assigned to have
> 'dogs,cats,rats' then semanage will tell you he's got 'dogs.rats',
> leaving you to figure out what's 'in between'.
> 
> What do the list members think about this?

The c0.cN notation was introduced as a convenient shorthand as part of
the rewrite of the MLS support in SELinux.  It is as you say limited in
its expressiveness and not well suited to general configuration of the
category definitions, but nonetheless quite useful for MLS users, where
most of the semantics for the categories are expressed in the mcstransd
configuration and the user does not see the raw kernel contexts.  It
also serves a practical end - keeping context string sizes sane for
kernel interfaces (/selinux/* and /proc/self/attr/*).

I think we're open to improvements in this area, but naturally we will
need to retain compatibility for the current users of the dot notation.
We have talked in the past about improving direct kernel support for
complex label encodings, but unfortunately no one has really moved
forward in that space.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
