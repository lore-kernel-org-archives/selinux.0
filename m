Subject: Re: [SEMANAGE] Validation of local file contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43BD99A1.3070700@cornell.edu>
References: <43BD99A1.3070700@cornell.edu>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 09:57:45 -0500
Message-Id: <1136559465.16811.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-05 at 17:11 -0500, Ivan Gyurdiev wrote:
> This patch adds context validation of local changes to file contexts.
> 
> Should I also check if the regexp is valid?

I'm not sure, as libsemanage presently doesn't do any other
interpretation of the regex.  Might want to defer this to the clients.

> Should I check if the Unix user exists for seusers?

As with the above, I'm inclined to defer this to the clients, as Unix
users aren't something managed by libsemanage itself.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
