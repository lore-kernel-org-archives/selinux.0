Message-ID: <488EC3A0.5010000@ak.jp.nec.com>
Date: Tue, 29 Jul 2008 16:15:44 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/3] Thread/Child-Domain Assignment
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4889CF38.6010301@ak.jp.nec.com>
In-Reply-To: <4889CF38.6010301@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> [2/3] thread-context-checkpolicy.1.patch
>   This patch add a new statement of TYPEDOMINATE for policy language.
> 
>     TYPEDOMINATE <parent type>  <chile type> [, <child type> ...] ;
> 
>   It defines expilct hierarchical relationship between two types.
>   Existing name based hierarchy is dealt as TYPEDOMINATE is described
>   implicitly.

I reconsidered that the statement should be replaced as follows,
because "DOMINATE" is an associated term with MLS and roles/users
also have name based hierarchy ideas now.

  HIERARCHY <parent type> TYPES <child type> [, <child type> ...];
  HIERARCHY <parent role> ROLES <child role> [, <child role> ...];
  HIERARCHY <parent user> USERS <child user> [, <child user> ...];

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
