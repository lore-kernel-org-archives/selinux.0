Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA28611
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 06:59:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA25209
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 11:57:49 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id LAA25204
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 11:57:48 GMT
Date: Thu, 21 Mar 2002 12:11:21 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Getdate error
Message-ID: <20020321121121.GJ10482@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is probably one for the upstream guy, but here are
some build errors showing on the latest selinux utils:

	getdate.y: In function `yyparse':
	getdate.y:381: parse error before `}'
	getdate.y:387: parse error before `}'
	getdate.y:393: parse error before `}'

They appear to be missing semicolons:

	relunit:
	    tUNUMBER tYEAR_UNIT
	      { PC.rel_year += $1.value * $2; }
	  | tSNUMBER tYEAR_UNIT
	      { PC.rel_year += $1.value * $2; }
	  | tYEAR_UNIT
	      { PC.rel_year += $1; }
	  | tUNUMBER tMONTH_UNIT
	      { PC.rel_month += $1.value * $2; }
	  | tSNUMBER tMONTH_UNIT
	      { PC.rel_month += $1.value * $2; }
	  | tMONTH_UNIT
	      { PC.rel_month += $1; }
	  | tUNUMBER tDAY_UNIT
	      { PC.rel_day += $1.value * $2; }
	  | tSNUMBER tDAY_UNIT
	      { PC.rel_day += $1.value * $2; }
	  | tDAY_UNIT
	      { PC.rel_day += $1 }			<--
	  | tUNUMBER tHOUR_UNIT
	      { PC.rel_hour += $1.value * $2; }
	  | tSNUMBER tHOUR_UNIT
	      { PC.rel_hour += $1.value * $2; }
	  | tHOUR_UNIT
	      { PC.rel_hour += $1 }			<--
	  | tUNUMBER tMINUTE_UNIT
	      { PC.rel_minutes += $1.value * $2; }
	  | tSNUMBER tMINUTE_UNIT
	      { PC.rel_minutes += $1.value * $2; }
	  | tMINUTE_UNIT
	      { PC.rel_minutes += $1 }			<--
	  | tUNUMBER tSEC_UNIT
	      { PC.rel_seconds += $1.value * $2; }
	  | tSNUMBER tSEC_UNIT
	      { PC.rel_seconds += $1.value * $2; }
	  | tSEC_UNIT
	      { PC.rel_seconds += $1; }
	  ;

If someone else already had this problem, excuse me
for the repeat. I'm several days behind on the selinux
mail.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
