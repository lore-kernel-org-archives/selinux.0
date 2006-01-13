Subject: Re: [SEMANAGE] Fix calloc check in semanage_store:115
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43C59613.4010206@cornell.edu>
References: <43C59613.4010206@cornell.edu>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:52:04 -0500
Message-Id: <1137160324.3445.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-11 at 16:34 -0700, Ivan Gyurdiev wrote:
> This fixes an omem check bug noticed by Steve Grubb.

Merged as of libsemanage 1.5.12.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
