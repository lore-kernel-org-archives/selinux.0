Subject: Re: dpkg bug related to SE Linux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>,
        Manoj Srivastava <manoj.srivastava@stdc.com>, 474339@bugs.debian.org
In-Reply-To: <200804080930.13447.russell@coker.com.au>
References: <200804051347.55320.russell@coker.com.au>
	 <1207586935.21223.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1207587315.21223.50.camel@moss-spartans.epoch.ncsc.mil>
	 <200804080930.13447.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 08 Apr 2008 08:23:23 -0400
Message-Id: <1207657403.21223.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-04-08 at 10:30 +1100, Russell Coker wrote:
> On Tuesday 08 April 2008 02:55, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Mon, 2008-04-07 at 12:48 -0400, Stephen Smalley wrote:
> > > On Sat, 2008-04-05 at 13:47 +1100, Russell Coker wrote:
> > > > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474339
> > > >
> > > > When the file_contexts file has an invalid context then dpkg will
> > > > crash, see the above bug report.
> > > >
> > > > dpkg is statically linked against libselinux.
> > >
> > > Can you reproduce with a simpler caller, e.g. compile matchpathcon from
> > > libselinux/utils statically and run it on your corrupted file_contexts
> > > file, passing in a pathname that will match the invalid line?
> 
> Restorecon doesn't have this problem, neither when dynamically nor statically 
> linked.

In that case, I'd recommend looking more closely at the dpkg selinux
code itself rather than libselinux.  For example, does dpkg try to free
the context from matchpathcon() upon an error return?  That would be a
bug in it rather than libselinux.  Or is dpkg double free'ing a returned
context?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
