Subject: Re: semodule memory use
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <200809101150.15440.russell@coker.com.au>
References: <200809101150.15440.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 10 Sep 2008 08:05:26 -0400
Message-Id: <1221048326.8658.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-09-10 at 11:50 +1000, Russell Coker wrote:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=495786
> 
> I've received the above bug report against the Debian policy packages.  The 
> operation in question is "semodule -b" followed by "semodule -i".
> 
> I haven't had time to work on this (and won't until well after Lenny is 
> released).  But if anyone has any quick ideas of how to reduce memory use by 
> semodule then I would be interested to hear them.

Set expand-check = 0 in /etc/selinux/semanage.conf.
The downside is you'll lose neverallow and hierarchy checking at module
insertion time (but you can get them back at policy build time for the
modules you provide by doing a make validate in refpolicy).  The upside
is that it doesn't have to expand the attributes in rules nor walk them
for neverallow checking or hierarchy checking.

BTW, hierarchy checking really ought to be conditional on whether there
is any hierarchy at all, the way that neverallow checking immediately
returns if there were no neverallow rules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
