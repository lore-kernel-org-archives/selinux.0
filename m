Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77E9sYL026941
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 10:09:55 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l77E9sVa027481
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 14:09:54 GMT
Subject: Re: Fedora/SE-PostgreSQL
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, dwalsh@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <46B878D9.6090004@ak.jp.nec.com>
References: <46B079EF.9050909@kaigai.gr.jp> <1186489529.18881.9.camel@gorn>
	 <46B878D9.6090004@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 10:09:24 -0400
Message-Id: <1186495764.18881.17.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-07 at 22:51 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
> > On Wed, 2007-08-01 at 08:17 -0400, KaiGai Kohei wrote:

> > Interface naming:
> > 
> >> +interface(`mls_database_read_up',`
> > 
> > mls_db_read_all_levels
> > 
> >> +interface(`mls_database_write_down',`
> > 
> > mls_db_write_all_levels
> > 
> >> +interface(`mls_database_upgrade',`
> > 
> > mls_db_upgrade
> > 
> >> +interface(`mls_database_downgrade',`
> > 
> > mls_db_downgrade
> 
> OK, I'll rename these interfaces more simple.
> Is it necessary to make the attribute names shorter?

Not strictly, but it probably would be a good idea.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
