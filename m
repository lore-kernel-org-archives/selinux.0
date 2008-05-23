Subject: RE: overriding home directory file contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <0794F277152EF94AA637E3AECF5CB70FB9DD3C@blums0042.bluelnk.net>
References: <0794F277152EF94AA637E3AECF5CB70FB9DD15@blums0042.bluelnk.net>
	 <1211487975.7486.543.camel@moss-spartans.epoch.ncsc.mil>
	 <0794F277152EF94AA637E3AECF5CB70FB9DD3C@blums0042.bluelnk.net>
Content-Type: text/plain
Date: Fri, 23 May 2008 08:21:52 -0400
Message-Id: <1211545312.7486.569.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-05-22 at 14:19 -0700, Clarkson, Mike R (US SSA) wrote:
> 
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > Sent: Thursday, May 22, 2008 1:26 PM
> > To: Clarkson, Mike R (US SSA)
> > Cc: selinux@tycho.nsa.gov
> > Subject: Re: overriding home directory file contexts
> > 
> > 
> > On Thu, 2008-05-22 at 13:16 -0700, Clarkson, Mike R (US SSA) wrote:
> > > There seems to be a very strong preference by the policy to label
> files
> > > and directories under a home directory to user_home_t. I would like
> to
> > > override that for a particular directory structure.
> > >
> > > I have the following directory with many other files and directories
> > > below it:
> > > /opt/home/oracle/product/10.2.0
> > >
> > > Many of files are libraries, which I would like to label lib_t and
> > > shlib_t. As a specific example I have the following two files:
> > >
> > > # ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
> > > -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> > > /opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
> > > -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> > > /opt/home/oracle/product/10.2.0/lib32/libsqlplus.so
> > >
> > > If I add the following file context line to my policy without any
> regex
> > > wildcard chars, it works. The libsqlplus.so file is properly labeled
> as
> > > shlib_t.
> > >
> > > /opt/home/oracle/product/10\.2\.0/lib32/libsqlplus\.so --
> > > gen_context(system_u:object_r:shlib_t,__SYSTEMLOW__)
> > >
> > > # ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
> > > -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> > > /opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
> > > -r-xr-xr-x  oracle oinstall system_u:object_r:shlib_t:SystemLow
> > > /opt/home/oracle/product/10.2.0/lib32/libsqlplus.so
> > >
> > > However, if I add any regex wildcard chars, the label reverts back
> to
> > > the default user_home_t context. For example, with the following
> > > modification to the above file context line:
> > >
> > > /opt/home/oracle/product/10\.2\.0/lib32/libsqlplus.*\.so --
> > > gen_context(system_u:object_r:shlib_t,__SYSTEMLOW__)
> > >
> > > # ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
> > > -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> > > /opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
> > > -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> > > /opt/home/oracle/product/10.2.0/lib32/libsqlplus.so
> > >
> > > Being that this is a large directory structure with lots of files, I
> do
> > > not want to have to label each one explicitly, without the use of
> regex
> > > wildcards.
> > >
> > > My understanding is that the policy should apply the most specific
> file
> > > context line. But that does not appear to be what is happening in
> this
> > > case. Is there some way to override this strong preference to label
> > > files under a home directory as user_home_t?
> > >
> > > I'm using the rhel5.1 mls policy
> > >
> > > Any help would be greatly appreciated.
> > 
> > Use semanage fcontext -a to add the entries to your
> file_contexts.local
> > file.  That will take precedence.
> > 
> 
> Thanks. That helps.
> 
> There are some disadvantages to doing it this way though. 
> 
> Mainly, I can't use M4 macros to make the file context definition more
> portable. For instance I usually do something like this to make it
> easier to port the policy from one machine to another, where something
> like the ORACLE_HOME path may change:
> 
> __DB_ORACLE_HOME__/lib/lib.+\.so.* --
> gen_context(system_u:object_r:shlib_t,__SYSTEMLOW__)
> 
> Also, the semanage interface it harder to use than editing a file
> directly, and it is less obvious to look in the file_contexts.local file
> for oracle file context definitions than in the oracle_db.fc file
> 
> Is there any way to make the policy source *.fc files override the
> file_contexts.homedirs file?

Not at present, although we're open to suggestions.

The current situation is that the file contexts configuration consists
of three generated files (all managed by libsemanage and all read by
libselinux):  file_contexts, file_contexts.homedirs, and
file_contexts.local.

file_contexts is generated from the .fc files in the individual policy
modules in the policy store.  It used to be unordered aside from the
relative ordering between the base module and non-base modules but
libsemanage was later changed to apply the sorting heuristics introduced
in the reference policy when creating it.

file_contexts.homedirs is generated from template entries extracted from
the .fc files in the individual policy modules and from user data
extracted from system databases like passwd.  It used to be created by
the separate genhomedircon script, but that logic has now moved into
libsemanage.

file_contexts.local is populated via semanage fcontext (RHEL5) or by
manual editing (RHEL4).  I don't believe it is presently sorted at
generation time.

libselinux reads the three files in such a way as to give first
precedence to file_contexts.local, then second to
file_contexts.homedirs, then last to file_contexts.  The only sorting
libselinux applies to the final result is to move entries that are fully
specified (i.e. no regex) to highest precedence.  The libselinux logic
predates the libsemanage or reference policy sorting heuristics by a
long time, and has to continue to work even in the absence of any
sorting of the file_contexts file at creation time for use on old
systems (e.g. RHEL4).

Simply flipping the precedence of file_contexts.homedirs and
file_contexts would be unsafe as file_contexts generally has the
catch-all /.* regex.  Applying the full sorting heuristics in libselinux
was viewed as too expensive IIRC.  Merging the three files together in
libsemanage and sorting them all together at generation time would solve
some problems but break the ability to ensure that local modifications
via semanage always take precedence over base policy.

Given that genhomedircon has been merged into libsemanage though, we
might be able to eliminate the separation between file_contexts and
file_contexts.homedirs, and sort them together?  While leaving
file_contexts.local separate.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
