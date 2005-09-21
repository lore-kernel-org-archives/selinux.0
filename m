Subject: Re: [ SEPOL ] Fix memory leaks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <433074D8.3030507@cornell.edu>
References: <432FBD08.2050903@cornell.edu>  <433074D8.3030507@cornell.edu>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 10:44:04 -0400
Message-Id: <1127313844.2550.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 16:45 -0400, Ivan Gyurdiev wrote:
> The attached patch applies on top of the sepol patch (or at least..I 
> hope it does - might complain about whitespace). It fixes memory leaks 
> noticed by Steven Smalley, and removes the prototypes of two functions 
> that are only used internally (there's a lot more, but this gets rid of 
> two of them).

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
