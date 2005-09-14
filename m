Subject: Re: New ideas on implementation on libsetrans.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050914130323.29097.qmail@web51502.mail.yahoo.com>
References: <20050914130323.29097.qmail@web51502.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 09:33:10 -0400
Message-Id: <1126704790.12299.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 06:03 -0700, Steve G wrote:
> >Am I missing other disadvantages?
> 
> How often would this library be called? Is it a performance hit for programs to
> parse the flat file everytime they run? I'm thinking mostly of coreutils style
> programs that would be in shell scripts. What program would be the heaviest user
> of the translation library? Is anything other than translation being considered? 

The issue being discussed was if we changed the existing libsetrans in
Fedora to obtain context translations from a separate daemon (as
proposed by Dan, and also the way in which TCS handles it) rather than
directly performing translation itself, should we fold the libsetrans
code (which would then consist of just the client-side communication and
caching code) into libselinux or keep it as a separate optional library
that is dlopen'd by libselinux during library initialization.  I favored
keeping it separate so that one still has the options of no libsetrans
at all or a libsetrans that performs direct translation as alternatives.

The context translation functions are called all the time by libselinux
functions if context translation is enabled (which is determined by
libselinux during initialization based on whether the dlopen and dlsym
lookups succeed), so any program that gets or sets a context would
exercise them.  A simple ls -Z would exercise them.  But the mapping
file itself is typically only loaded once, during library initialization
for the direct libsetrans or upon daemon start or SIGHUP for the
daemon-based one, and the actual context translation functions are just
performing lookups on in-memory data structures.  When using the daemon,
you have the overhead of the communication with the daemon, so you would
likely want libsetrans to cache the results in memory (but you then have
the issue of flushing the cache on the client side when there is a
change on the server side).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
