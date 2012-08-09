Message-ID: <1344534512.1175.17.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Possible bug in finding default context?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov
Date: Thu, 09 Aug 2012 13:48:32 -0400
In-Reply-To: <20120809174519.GE1643@telvanni>
References: <20120809174519.GE1643@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-09 at 19:45 +0200, Ole Kliemann wrote:
> Sometime ago I posted about a problem I had when building a 
> monolithic policy. Login programs were unable to determine the 
> default context of users when logging in, although i was pretty 
> sure I did everything right. I never resolved that but didn't 
> bother either since I started writing a new modular policy from 
> scratch.
> 
> Everything worked flawlessly, including logins, until suddenly 
> now logins started to fail again with the login programs unable 
> to determine the context of the user.
>  
> Oh, what fresh hell is this?! So I started rolling back changes, 
> and it turns out if there are too many types associated with one 
> role and that role and one of its types is set as default context 
> for a user, /bin/login gives 'Unable to get valid context'.
> 
> BTW, the exact number seems 194. 194 types associated with one 
> role works. 195 and it's broken.
> 
> I'm doing this on Ubuntu 12.04, so it could be the crappily 
> maintained selinux userland here.

We'd like to rip out all usage of security_compute_user()
aka /sys/fs/selinux/user and everything that calls it.  Previously
discussed on the list, although not your specific problem (presumably
we're hitting the selinuxfs limit on size of response for /selinux/user
transactions).  Take all of that logic to userspace and greatly simplify
it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
