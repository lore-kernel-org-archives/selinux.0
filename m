Subject: Re: How can modular policy ever have worked? [patch]
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1142691657.4017.23.camel@wintermute.xmldesign.de>
References: <1142691657.4017.23.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 09:39:13 -0500
Message-Id: <1142865553.16487.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-03-18 at 15:20 +0100, Erich Schubert wrote:
> This also seems to turn up a problem in the linux kernel (2.6.15, not
> the latest patches yet, sorry):
> Even the _working_ (well, except for the missing rules) policy generated
> without this patch, will link, but not load any more:
> [...]
> Committing changes:
> /usr/sbin/load_policy:  Can't load policy:  Invalid argument
> 
> So it seems the kernel is now rejecting any policy loads, albeit it
> still in permissive mode.

Any "security:" messages from the kernel in /var/log/messages upon the
attempted policy load?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
