Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0KEW9fC030188
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2009 09:32:09 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n0KETFQd014674
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2009 14:29:16 GMT
Subject: Re: [refpolicy] [PATCH] Add a new permission to db_procedure
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: refpolicy@oss.tresys.com, SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <49758904.2070303@ak.jp.nec.com>
References: <4973468F.1010706@kaigai.gr.jp> <49758904.2070303@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 20 Jan 2009 09:31:11 -0500
Message-Id: <1232461874.10460.1.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-01-20 at 17:19 +0900, KaiGai Kohei wrote:
> This is just an aside, I would like to make a rapid conclusion due to
> the current (v8.4) PostgreSQL development cycle, if possible.
> 
>   http://wiki.postgresql.org/wiki/CommitFestInProgress
> 
> KaiGai Kohei wrote:
> > The attached patch add a new permission named as "install" to db_procedure.
> > 
> > The purpose of this permission is to prevent malicious functions are invoked
> > as a part of server's internal tasks.
> > 
> > PostgreSQL allows user-defined functions to use its internal tasks.
> > For example, it can be used to implement an output/input handler of new data
> > types, an index access method, implementation of operator classes and so on.
> > 
> > When we defines a new type, it requires to specify its output/input handler
> > at least. No need to say, these functions should not be malicious ones,
> > because user implicitly invokes these function when he uses the type.
> > This permission is checked when we defines a new system catalog entry which
> > has a possibility to invoke user defined functions.
> > 
> > In the attached patch, only sepgsql_proc_t is allowed to { install }, because
> > any other user defined functions are not checked by DBA, so it is not safe to
> > use it as a part of internal/common processes.
> > If DBA want to apply user defined functions as a part of internal task, he has
> > to confirm its safeness and relabel to sepgsql_proc_t at first.
> > 
> > Please apply it, if no matter.

Changes to object classes need to be discussed on the SELinux list.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
