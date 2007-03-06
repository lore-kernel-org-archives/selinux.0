Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
In-Reply-To: <45EDBB95.50703@kaigai.gr.jp>
References: <45EC0D21.2070706@kaigai.gr.jp>
	 <200703062034.24993.russell@coker.com.au>  <45EDBB95.50703@kaigai.gr.jp>
Content-Type: text/plain
Date: Tue, 06 Mar 2007 14:17:05 -0500
Message-Id: <1173208625.1230.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-07 at 04:05 +0900, KaiGai Kohei wrote:
> >> * There is no compatibility between SE-PostgreSQL and PostgreSQL.
> >>   You have to pay attention not to destroy your database files
> >>   for native PostgreSQL.
> > 
> > Have you considered enabling "permissive mode" for the database server such 
> > that it can run with unlabeled databases?
> >
> > Why can't "native PostgreSQL" just ignore the labelling?
> 
> We have to store a security context of tuple in anywhere, so modifying the file
> format was not avoidable. The storage manager of PostgreSQL cannot handle different
> file formats, so SE-PostgreSQL cannot run over the unlabeled databased generated
> by native PostgreSQL.
> 
> It might be possible, but I expect more hooks to the PostgreSQL is necessary.
> It will prevent to follow the version-up of native one.

Do they provide any kind of attribute / metadata support at that
granularity?  Along the lines of filesystem xattrs?

Could you store the labels in a separate table?  Along the lines of the
old persistent label mapping in SELinux (issues for consistency and
performance, of course).

Could you split the storage from the presentation such that you only
store data of one context in a given underlying table and then compose a
set of single context tables to present a multi-context virtual table?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
