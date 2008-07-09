Subject: Re: newrole assertion
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Joe Nall <joe@nall.com>
In-Reply-To: <cadfc0e40807081202l7badbcb8h84ee373161fd6fd2@mail.gmail.com>
References: <cadfc0e40807081202l7badbcb8h84ee373161fd6fd2@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 11:23:44 -0400
Message-Id: <1215617024.24864.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-07-08 at 14:02 -0500, Xavier Toth wrote:
> Using MLS enforcing in a gnome-terminal with context
> user_u:user_r:user_t:s0-s15:c0.c1023 I run newrole and get these
> results
> 
> newrole -l s1-s1 -- -c "gnome-terminal --disable-factory"
> Password:
> **
> ** ERROR:(terminal.c:1016):new_terminal_with_options: assertion
> failed: (profile)
> 
> 
> I think Joe straced this and has a little more info if he'd like to chime in.

So, I assume that this does not happen if in permissive mode?
What AVC denials occur?  Run semodule -DB and retry if there are no AVCs
by default.

What is the application trying to do at that point (look at the source
code and/or ask on the gnome lists)?  What are the possible failure
conditions there?  What external dependencies does it have?  

strace output might help if you have it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
