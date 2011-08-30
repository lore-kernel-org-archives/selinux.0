Message-ID: <4E5D2DBA.9060201@manicmethod.com>
Date: Tue, 30 Aug 2011 14:36:42 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>, KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: sepgsql and process transition
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kaigai, I'm taking a look at the latest Postgresql master and I see that you are 
using process:transition permission to check access to transition from one type 
to another for trusted procedures.

Why didn't you add a transition permission to db_procedure? We are trying not to 
reuse kernel object classes for userspace object managers these days (I know we 
haven't been great about that in the past). I know this situation is a little 
tricky because the beginning type is a process type (domain) and the ending type 
is a procedure type, which closely maps to a domain type.

The beginning type may not always be a domain type though, if a procedure calls 
another procedure, or if postgres user session types become derived types 
(user_t -> sepgsql_user_t) we could completely divorce process types from 
postgres types.

Stephen, do you have an opinion on this?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
