Subject: Re: [gov-eng] Multithreaded applications, SELinux, and RAM
	Protection
From: Stephen Smalley <sds@tycho.nsa.gov>
To: swells@redhat.com
Cc: Ben Woodard <woodard@redhat.com>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <47AA9956.6030002@redhat.com>
References: <47AA8E86.8010501@redhat.com> <47AA91D7.1010504@redhat.com>
	 <47AA9956.6030002@redhat.com>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 09:28:41 -0500
Message-Id: <1202394521.27371.233.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-07 at 00:38 -0500, Shawn Wells wrote:
> Ben Woodard wrote:
> > Shawn Wells wrote:
> >> Hi All,
> >>
> >>    I have a customer who is encountering the following issue, and 
> >> I've been unable to solve it myself.
> >>
> >>    The scenario:
> >>
> >> WebUserX (with TS//SCI//Alpha) sends a query to MACHINE1 which then 
> >> parses the query and executes it on a database. For example:
> >> |-- WebUserX Sends Query to Query Engine
> >> |--------> Query Engine creates new thread, parses, sends to database
> >> |--------|--------> Database executes & returns data
> >> |--------|--------|--------> Data is stored in RAM, say the first 
> >> 512MB of allocatable space
> >> |--------|--------|--------|--------> Data passed back to WebUserX
> >> |--------|--------|--------|--------|--------> Query Engine thread 
> >> dies, marks first 512MB of RAM available.  Doesn't delete the data in 
> >> RAM, but it is now tagged as available.
> >>
> > 1st suggestion, don't use threads for the query. The first line of 
> > defense that I would setup is to make sure that each and every query 
> > operates in its own compartmentalized address space. Threads share 
> > address space. Processes do not.
> 
> Would it be possible, I'm guessing through setcon(), to have threads 
> change their context and label the data in RAM?  Thus revoking 
> different/lesser threads from accessing that data later? I'm guessing 
> not, as I believe setcon would change the label for the process, not the 
> thread -- is this correct? (the man page leads me to this, but I thought 
> I'd ask)

setcon() presently fails with EPERM if a multi-threaded application
tries to invoke it.

You can't prevent a thread within a process (thread group) from
accessing any of the memory - they share the same memory space.  Thus,
you can't safely run one thread in one security context and another
thread in another security context.

As your colleague suggested, use separate processes instead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
