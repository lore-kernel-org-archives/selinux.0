Message-ID: <4899798A.6070500@ak.jp.nec.com>
Date: Wed, 06 Aug 2008 19:14:34 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: [PATCH 2/3] Thread/Child-Domain Assignment (rev.3)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <4897EB68.5080309@ak.jp.nec.com>
In-Reply-To: <4897EB68.5080309@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> [2/3] thread-context-checkpolicy.2.patch
>   It enables to support TYPEBOUNDS statement and to expand
>   existing hierarchies implicitly.
> 
> Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
> --
>  module_compiler.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++
>  policy_define.c   |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  policy_define.h   |    1
>  policy_parse.y    |    5 ++
>  policy_scan.l     |    2 +
>  5 files changed, 186 insertions(+), 1 deletion(-)

The patch for checkpolicy is unchanged at revision 3.
Please apply the previous version, as is.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
