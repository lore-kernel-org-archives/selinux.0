Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8QDYHR9008869
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 09:34:17 -0400
Received: from mail.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8QDYF7Q001767
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 13:34:16 GMT
Message-ID: <48DCE45B.3040900@kaigai.gr.jp>
Date: Fri, 26 Sep 2008 22:32:11 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Dominick Grift <domg472@gmail.com>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        selinux@tycho.nsa.gov
Subject: Re: How to find SELinux policy type?
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>	 <48D98748.6090408@ak.jp.nec.com> <9546.1222400049@turing-police.cc.vt.edu>	 <48DC5C16.9040607@ak.jp.nec.com>	 <1222421896.24783.7.camel@sulphur.notebook.internal>	 <48DCB88E.3080503@kaigai.gr.jp> <1222425714.24783.13.camel@sulphur.notebook.internal>
In-Reply-To: <1222425714.24783.13.camel@sulphur.notebook.internal>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick Grift wrote:
> On Fri, 2008-09-26 at 19:25 +0900, KaiGai Kohei wrote:
> 
>> Was the sepostgresql related policy backported to F9 selinux-policy?
> 
> Not sure about that. I know that i have selinux-policy installed plus
> sepostgresql for f9.
> 
> sepostgresql-8.3.3-2.869.fc9.x86_64
> sepostgresql 2.869
> selinux-policy-3.3.1-94.fc9.noarch.rpm
> 
> Thanks

Dan,

Could you add the following policy into F9 updates?
It is already merged into upstream policy, but I cannot find it
at selinux-policy-3.3.1-91.

--- at modules/system/libraries.te ---
optional_policy(`
        postgresql_loadable_module(lib_t)
        postgresql_loadable_module(textrel_shlib_t)
')
--------------------------------------

Lack of this policy prevents database initialization.

$ cat /var/lib/sepgsql/pgstartup.log
              :
creating template1 database in /var/lib/sepgsql/data/base/1 ... ok
initializing pg_authid ... ok
initializing dependencies ... ok
creating system views ... ok
loading system objects' descriptions ... ok
creating conversions ... FATAL:  SELinux: denied { install_module } scontext=unconfined_u:system_r:postgresql_t:s0 tcontext=system_u:object_r:lib_t:s0 tclass=db_database name=/usr/lib/pgsql/ascii_and_mic.so
STATEMENT:  CREATE OR REPLACE FUNCTION ascii_to_mic (INTEGER, INTEGER, CSTRING, INTERNAL, INTEGER) RETURNS VOID AS '$libdir/ascii_and_mic', 'ascii_to_mic' LANGUAGE C STRICT;

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
