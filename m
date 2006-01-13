Subject: Re: [SEMANAGE(lib/tool)] Remove add_local/set_local
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43C2C414.9070503@cornell.edu>
References: <43C2C414.9070503@cornell.edu>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:50:20 -0500
Message-Id: <1137160220.3445.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-01-09 at 13:14 -0700, Ivan Gyurdiev wrote:
> Hi, this patch removes add_local and set_local functions from the dbase 
> API, since they duplicate other functionality.

Merged as of libsemanage 1.5.12 and policycoreutils 1.29.6.
I then later had to move the semanage tool diffs over to the new
seobject.py introduced by Dan in a later policycoreutils.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
