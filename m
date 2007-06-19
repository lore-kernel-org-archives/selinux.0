Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JEQTNn008773
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 10:26:29 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5JEQRif009826
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 14:26:27 GMT
Subject: Re: unable to connect PostgreSQL from user_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46737613.3020205@kaigai.gr.jp>
References: <46737613.3020205@kaigai.gr.jp>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 14:24:50 +0000
Message-Id: <1182263090.4077.113.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-06-16 at 14:33 +0900, KaiGai Kohei wrote:
> I found the following definition at 'policy/modules/services/postgresql.te'
> 
> --------------------------------
> ifdef(`TODO',`
> ifdef(`targeted_policy', `', `
> bool allow_user_postgresql_connect false;
> 
> if (allow_user_postgresql_connect) {
> # allow any user domain to connect to the database server
> allow userdomain postgresql_t:unix_stream_socket connectto;
> allow userdomain postgresql_var_run_t:sock_file write;
> allow userdomain postgresql_tmp_t:sock_file write;
> }
> ')
> --------------------------------
> Is there any reason why this block is disabled now, although
> 'mysql_stream_connect($_t)' is enabled at 'system/userdomain.if' ?

No, just a block that missed getting converted from the example policy.

> The attached patch enables the definition and moves them into
> userdomain.(if|te) as mysql did.

Merged, though I moved the userdomain.if change down a few lines.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
