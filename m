Subject: Re: [ SEMANAGE ] Fix record handlers, add status codes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <432FD4D1.5000604@cornell.edu>
References: <432FCF8F.8070909@cornell.edu>  <432FD4D1.5000604@cornell.edu>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 10:42:48 -0400
Message-Id: <1127313768.2550.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 05:22 -0400, Ivan Gyurdiev wrote:
> The attached patch applies on top of the previous one, and fixes
> several bugs. It also adds a header with status codes which I need...
> the debug system should go into this header IMHO, once we decide
> what the debug system should be.

Thanks, merged.

What do you view as still undecided for the debug system?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
