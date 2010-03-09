Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o290veFt026103
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 19:57:40 -0500
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o290w42m008448
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 00:58:05 GMT
Message-ID: <4B959CB3.9040309@ak.jp.nec.com>
Date: Tue, 09 Mar 2010 09:56:19 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: selinux@tycho.nsa.gov
Subject: Re: db_schema object class (and others)
References: <4B959214.90905@rubix.com>
In-Reply-To: <4B959214.90905@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/03/09 9:11), Andy Warner wrote:
> Back in March of 2009 there was discussion regarding adding new database 
> object classes (e.g., db_schema) to policy. I have been keeping my eye 
> open for them but have not seen them. Can anyone give me a status of 
> this? If it has not be implemented, is there still interest if some 
> picks it up?

Right now, we are waiting for SELinux feature to be gotten upstreamed to
PostgreSQL, because here is a risk that we are forced to change definition
of the object class and permissions. :(

I also think the following object classes are necessary:
 - db_catalog (specific to rubix, it is a layer between database and schema)
 - db_schema
 - db_sequence
 - db_view

Currently, I'm reworking existing access control stuff in PostgreSQL
for the upcoming v9.1 development cycle, because it does not have clear
interface between the core and security server like LSM, so the patch
had been too large to merge at one for two years.

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
