MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: overriding home directory file contexts
Date: Thu, 22 May 2008 14:19:21 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70FB9DD3C@blums0042.bluelnk.net>
References: <0794F277152EF94AA637E3AECF5CB70FB9DD15@blums0042.bluelnk.net> <1211487975.7486.543.camel@moss-spartans.epoch.ncsc.mil>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, May 22, 2008 1:26 PM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: overriding home directory file contexts
> 
> 
> On Thu, 2008-05-22 at 13:16 -0700, Clarkson, Mike R (US SSA) wrote:
> > There seems to be a very strong preference by the policy to label
files
> > and directories under a home directory to user_home_t. I would like
to
> > override that for a particular directory structure.
> >
> > I have the following directory with many other files and directories
> > below it:
> > /opt/home/oracle/product/10.2.0
> >
> > Many of files are libraries, which I would like to label lib_t and
> > shlib_t. As a specific example I have the following two files:
> >
> > # ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
> > -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> > /opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
> > -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> > /opt/home/oracle/product/10.2.0/lib32/libsqlplus.so
> >
> > If I add the following file context line to my policy without any
regex
> > wildcard chars, it works. The libsqlplus.so file is properly labeled
as
> > shlib_t.
> >
> > /opt/home/oracle/product/10\.2\.0/lib32/libsqlplus\.so --
> > gen_context(system_u:object_r:shlib_t,__SYSTEMLOW__)
> >
> > # ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
> > -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> > /opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
> > -r-xr-xr-x  oracle oinstall system_u:object_r:shlib_t:SystemLow
> > /opt/home/oracle/product/10.2.0/lib32/libsqlplus.so
> >
> > However, if I add any regex wildcard chars, the label reverts back
to
> > the default user_home_t context. For example, with the following
> > modification to the above file context line:
> >
> > /opt/home/oracle/product/10\.2\.0/lib32/libsqlplus.*\.so --
> > gen_context(system_u:object_r:shlib_t,__SYSTEMLOW__)
> >
> > # ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
> > -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> > /opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
> > -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> > /opt/home/oracle/product/10.2.0/lib32/libsqlplus.so
> >
> > Being that this is a large directory structure with lots of files, I
do
> > not want to have to label each one explicitly, without the use of
regex
> > wildcards.
> >
> > My understanding is that the policy should apply the most specific
file
> > context line. But that does not appear to be what is happening in
this
> > case. Is there some way to override this strong preference to label
> > files under a home directory as user_home_t?
> >
> > I'm using the rhel5.1 mls policy
> >
> > Any help would be greatly appreciated.
> 
> Use semanage fcontext -a to add the entries to your
file_contexts.local
> file.  That will take precedence.
> 

Thanks. That helps.

There are some disadvantages to doing it this way though. 

Mainly, I can't use M4 macros to make the file context definition more
portable. For instance I usually do something like this to make it
easier to port the policy from one machine to another, where something
like the ORACLE_HOME path may change:

__DB_ORACLE_HOME__/lib/lib.+\.so.* --
gen_context(system_u:object_r:shlib_t,__SYSTEMLOW__)

Also, the semanage interface it harder to use than editing a file
directly, and it is less obvious to look in the file_contexts.local file
for oracle file context definitions than in the oracle_db.fc file

Is there any way to make the policy source *.fc files override the
file_contexts.homedirs file?

> --
> Stephen Smalley
> National Security Agency




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
