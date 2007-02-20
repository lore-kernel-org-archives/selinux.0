Subject: Re: restorecond matchpathcon patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov, James Athey <jathey@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <691709.57722.qm@web51508.mail.yahoo.com>
References: <691709.57722.qm@web51508.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 11:02:08 -0500
Message-Id: <1171987328.14363.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 07:33 -0800, Steve G wrote:
> Hi,
> 
> I was investigating why restorecond consumes so much memory and noticed that
> valgrind is reporting about 18mb of reachable memory at exit. It seems that
> matchpathcon sits on a lot of memory that may or may not help restorcond. This
> patch causes matchpathcon to free its memory after we get its results. 
> 
> This helps cleanup valgrind output so that leaks are confined to utmpter and
> another list. But I have to wonder if the strategy of allocating memory for each
> file in a directory is a good thing or if we can just depend on partial path
> matching to decide if we should care about the file. 
> 
> IOW, this patch cleans up one problem, but I wonder if the underlying algorithm
> should be changed to be les of a memory hog.

Possibly the FCGlob work will help address that problem.
http://selinux-symposium.org/2007/abstracts.php#fcglob
James Athey (cc'd) - what is the implementation status and prospects for
code submission?

Calling matchpathcon_fini each time will require re-creation of the
entire in-memory table from the file contexts configuration on each
matchpathcon call, so you are trading off runtime performance for memory
here.  Normally, upon the first matchpathcon call or an explicit
matchpathcon_init call, libselinux loads the file contexts configuration
from the relevant files and builds the in-memory table, including
compiling the pathname regexes to internal form, so that subsequent
matchpathcon calls can just walk the in-memory table and call regexec on
the precompiled expressions.  That memory should be stable though after
initialization - it shouldn't grow over time.  The only memory that
would grow over time might be the translated context that is cached on
first use by matchpathcon, although matchpathcon then frees the raw
context so you'd only grow by the difference between the two (if the
translated context was longer).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
