From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: dpkg bug related to SE Linux
Date: Tue, 8 Apr 2008 10:30:06 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>,
        Manoj Srivastava <manoj.srivastava@stdc.com>, 474339@bugs.debian.org
References: <200804051347.55320.russell@coker.com.au> <1207586935.21223.40.camel@moss-spartans.epoch.ncsc.mil> <1207587315.21223.50.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1207587315.21223.50.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200804080930.13447.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 08 April 2008 02:55, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2008-04-07 at 12:48 -0400, Stephen Smalley wrote:
> > On Sat, 2008-04-05 at 13:47 +1100, Russell Coker wrote:
> > > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474339
> > >
> > > When the file_contexts file has an invalid context then dpkg will
> > > crash, see the above bug report.
> > >
> > > dpkg is statically linked against libselinux.
> >
> > Can you reproduce with a simpler caller, e.g. compile matchpathcon from
> > libselinux/utils statically and run it on your corrupted file_contexts
> > file, passing in a pathname that will match the invalid line?

Restorecon doesn't have this problem, neither when dynamically nor statically 
linked.

# semanage fcontext -l|grep squid_conf
/etc/squid(/.*)?                                   all files          
system_u:object_r:squid_conf_t:s0
/usr/share/squid(/.*)?                             all files          
system_u:object_r:squid_conf_t:s0
# restorecon -R -v /etc/squid
restorecon reset /etc/squid context 
root:object_r:etc_t:s0->system_u:object_r:squid_conf_t:s0
restorecon set context /etc/squid->system_u:object_r:squid_conf_t:s0 
failed:'Invalid argument'
# ldd ./restorecon
        not a dynamic executable
# ./restorecon -R -v /etc/squid
./restorecon reset /etc/squid context 
root:object_r:etc_t:s0->system_u:object_r:squid_conf_t:s0
./restorecon set context /etc/squid->system_u:object_r:squid_conf_t:s0 
failed:'Invalid argument'


> > I wasn't able to reproduce the bug myself.
> >
> > libselinux does rely on its constructors having run before any functions
> > are called.  dpkg isn't built in such a way as to suppress constructor
> > execution, is it?  What options are passed to gcc when compiling dpkg?

I don't believe that there is anything strange about the way dpkg is built.  
The fact that it works in the normal case suggests that constructors are not 
the problem.

> Oh, and what version of libselinux and libsepol was dpkg built against?

ii  libselinux1    2.0.59-1       SELinux shared libraries
ii  libsepol1      2.0.25-1       Security Enhanced Linux policy library for c

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
