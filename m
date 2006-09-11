Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8BCG4bo014701
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 08:16:04 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8BCFF0o006183
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 12:15:15 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] SELinux and PostgreSQL (draft v2)
Date: Mon, 11 Sep 2006 08:16:02 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015883C173C@exchange.columbia.tresys.com>
In-Reply-To: <45055236.5010500@kaigai.gr.jp>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "KaiGai Kohei" <kaigai@kaigai.gr.jp>, <russell@coker.com.au>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Kohei KaiGai [mailto:kaigai.kohei@gmail.com] On Behalf 
> Of KaiGai Kohei
> 
> Russell Coker wrote:
> > On Sunday 10 September 2006 14:55, KaiGai Kohei 
> <kaigai@kaigai.gr.jp> wrote:
> >> In recent days, I'm making a plan to enhance PostgreSQL 
> with SELinux.
> >> I posted the first draft of this plan a few days ago, and 
> I got many 
> >> response. Thanks for your comments so much.
> >> (Especially, Joshua and Russell)
> >
> > Firstly, I didn't notice any getattr permission...
> 
> I also agreed your opinion.
> But we have to pay attention on what select and getattr are 
> always used together on regular tables, because PostgreSQL 
> packed metadata of each column into result set.
> (It's a purely implementation matter.)
> 

Which includes all data and schema labels..

> In the special case, how should we consider the system 
> catalog which is the non-regular table contains only metadata?
> I think a query for it should be purely handled as a metadata 
> reference operation, so only getattr is required for 'select 
> * from pg_attribute;'
> for example.
> 
> In addition, setattr is neccesary to control ALTER XXXX 
> operations, isn't it?
> 

Sounds good.

> >> - delete a row
> >> Becaues the delete opetation involves the whole of one row, 
> >> column:delete is not evaluated when we try to delete a row.
> >> (Thus, it's not defined.)
> >> This behavior may be a bit controvertible.
> >
> > Maybe the column object class could have an entry deletefrom which 
> > allows deleting a row that has an entry in that column.
> 
> It will solve the matter from TE viewpoint, but how dose it 
> handle the MLS/MCS constraint?
> If the client must dominate any columns when a row is 
> deleted, it seems to me that the client must have the highest 
> or upper clearance originally.
> 

Only if the policy says that. Delete would be a write which means anyone
below it can do so. A worse problem is when someone is a high clearance
and can't delete a row because one of the fields is below him. I think
this makes the deletefrom permission unnecessarilly restrictive. It
might be sufficient to need delete on the table and row.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
