Subject: Re: Method to assign MCS Category without login.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Josh <josh@globalherald.net>
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <Pine.LNX.4.64.0708211009490.15934@home-av-server.home-av>
References: <Pine.LNX.4.64.0708191603500.15934@home-av-server.home-av>
	 <1187611079.24940.27.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0708201313150.21628@home-av-server.home-av>
	 <1187698887.1451.52.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0708211009490.15934@home-av-server.home-av>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 08:44:49 -0400
Message-Id: <1187786689.1451.279.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-21 at 10:33 -0400, Josh wrote:
> > I'd guess that you would want the root httpd process to perform the set
> > up of the child's context, including switching it into the desired
> > category set and into a different domain than the root httpd process.
> 
> So the question then becomes, does the root httpd process then need to be 
> trusted, and does this trust break the domain/type enforcement that is 
> applied to the httpd domain?  (For example: when I first set up a 
> Python-based website, my connection to Postgres was denied because I 
> hadn't yet defined a rule to allow it.  If I alow the root httpd instance 
> to be trusted - in order to set the context - will that weaken the domain 
> and type enforcement for httpd?

No, you'd allow it to set MCS categories and to transition to a domain
for the child processes, but it wouldn't be able to transition to any
arbitrary domain.  TE is a pairwise access matrix.  You'd need a
distinct domain for the root httpd process from the one you use for the
children, so that might require refactoring httpd_t into two domains, a
httpd_master_t and a httpd_child_t or likewise.

> Being a newbie I am most likely missing something here.
> 
> > What is your real goal?
> 
> My goal is to protect Python-based sites from each other.  The OS is 
> protected against rogue scripts by the domain and type enforcement of 
> HTTPD; but I would like to use Category Access to protect the scripts 
> against other rogue scripts.

Well, you should be able to run different scripts in different domains
to achieve the same end.

The tricky part is getting them into the right domain; normally that
happens via an exec, but here you are just doing a fork and running an
interpreter in-process.  You could have it do a setcon(3), but you'll
get stronger protection if you have the child exec it instead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
