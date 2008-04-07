Subject: Re: dpkg bug related to SE Linux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>,
        Manoj Srivastava <manoj.srivastava@stdc.com>
In-Reply-To: <1207586935.21223.40.camel@moss-spartans.epoch.ncsc.mil>
References: <200804051347.55320.russell@coker.com.au>
	 <1207586935.21223.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 07 Apr 2008 12:55:15 -0400
Message-Id: <1207587315.21223.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-04-07 at 12:48 -0400, Stephen Smalley wrote:
> On Sat, 2008-04-05 at 13:47 +1100, Russell Coker wrote:
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474339
> > 
> > When the file_contexts file has an invalid context then dpkg will crash, see 
> > the above bug report.
> > 
> > dpkg is statically linked against libselinux.
> 
> Can you reproduce with a simpler caller, e.g. compile matchpathcon from
> libselinux/utils statically and run it on your corrupted file_contexts
> file, passing in a pathname that will match the invalid line?
> 
> I wasn't able to reproduce the bug myself.
> 
> libselinux does rely on its constructors having run before any functions
> are called.  dpkg isn't built in such a way as to suppress constructor
> execution, is it?  What options are passed to gcc when compiling dpkg?

Oh, and what version of libselinux and libsepol was dpkg built against?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
