Subject: Re: why I have /selinux??
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <44844b0e.1953fca1.1083.ffffce13@mx.gmail.com>
References: <44844b0e.1953fca1.1083.ffffce13@mx.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 10:57:50 -0400
Message-Id: <1150124270.8086.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-06-05 at 17:17 +0200, Mario Fanelli wrote:
> I don't understand why I have selinuxfs mounted on /selinux, but in
> /etc/fstab I don't find any entry that concern that...
> Why?

It is explicitly mounted by /sbin/init in order to perform the initial
policy load, and thus doesn't require a fstab entry.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
