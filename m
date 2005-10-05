Subject: Re: I've written a shell script which turns log deny to allow.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shintarou_fujiwara <shin216@xf7.so-net.ne.jp>
Cc: John Ramsdell <ramsdell@mitre.org>,
   "Brian T. Sniffen" <bsniffen@mitre.org>,
   selinux mailing list <selinux@tycho.nsa.gov>
In-Reply-To: <002601c5c9b5$b7748ee0$0300a8c0@admin0>
References: <002601c5c9b5$b7748ee0$0300a8c0@admin0>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 10:30:49 -0400
Message-Id: <1128522649.24059.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-05 at 23:04 +0900, shintarou_fujiwara wrote:
> Hello, again from Japan .
> 
> The other day I've written a policy, noip but
> today I've written a script , easy to use 
> especially begginers, like me ...
> 
> Denied log is so annoying , so I've written down this 
> small script named sepolf (selinux policy finder).
> 
> I really want it to display macro, but all I can do now
> is to display allow... like audit2allow (I have never used,though).
> 
> Experts advice I really want to get ,to make it better.

How does it differ from audit2allow?  If you think audit2allow lacks
something, feel free to propose a patch to it.

If you are interested in more sophisticated policy generation, I'd
suggest that you take a look at polgen.  There should be an updated
release of it soon, but you can look at the polgen 1.1 release from 
http://www.mitre.org/tech/selinux/.  Unlike audit2allow, polgen can
generate new domains and types, recognize patterns and suggest
appropriate policy, and emit macro-based rules rather than just raw TE
rules.  Note that polgen uses filtered strace output (extended to
include security contexts) from running the program rather than audit
messages as its input.  This has advantages (e.g. program-specific data,
more detailed data than one can currently obtain from audit messages)
and disadvantages (e.g. weak linkage with actual SELinux permission
checks, lack of data on other processes interacting with the program,
dependency on patched strace program - which is included in the polgen
tarball).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
