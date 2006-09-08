Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8815FWZ032143
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 21:05:15 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8814p7M006206
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 01:04:51 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] SELinux and PostgreSQL
Date: Thu, 7 Sep 2006 21:06:18 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015883C1638@exchange.columbia.tresys.com>
In-Reply-To: <200609081048.39569.russell@coker.com.au>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <russell@coker.com.au>, "KaiGai Kohei" <kaigai@kaigai.gr.jp>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Russell Coker [mailto:russell@coker.com.au] 
> 
> On Friday 08 September 2006 00:28, KaiGai Kohei 
> <kaigai@kaigai.gr.jp> wrote:
> > The reason of this decision is that we cannot enforce 
> SELinux's access 
> > controls to any tables, columns and rows, even if the proxy server 
> > rewrite SQL statement.
> 
> You want to label columns AND rows?
> 
> How is that going to work?  I can understand the desire for 
> this (EG have a password column in the user table), but the 
> mechanism of enforcing this will be tricky to say the least.  
> Will you perform two access checks on each cell, one for 
> column and one for row?

Columns are part of the schema, rows are data, they are different
objects.

You label columns because an entire column might contain important data
(eg., a password). The rows are labeled because some domain X is putting
data in them and you still want to be able to use policy to enforce
information flow goals with the policy whether you are using kernel
objects or userspace objects. In other words, if user X is topsecret and
writes a row to a table you don't want user Y who is just secret to read
it. 

The latter can be accomplished in many ways including virtual databases
(eg., views) or by modifying queries (like KaiGai mentioned in his first
email) or filtering results or course grained labeling on tables so that
each table is only 1 context. Some are better approaches than others, I
won't go into that at this point..

The answer is yes, there may be multiple security queries per database
query, due to the data model of relational databases this is optimal and
necessary IMO. This isn't abnormal either. Creating a file, for example,
requires dir { add_name search}, file { create } and filesystem {
associate } (for the object). The policy server has similar multiple
checks in its current state. I don't think there is a problem if they
overlap some as long as one isn't necessarilly a superset of another
(which would just be redundant) which is not the case here since we are
talking about different objects that can be labeled differently for any
given query.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
