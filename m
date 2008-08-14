Message-ID: <48A3F30A.6000208@ak.jp.nec.com>
Date: Thu, 14 Aug 2008 17:55:38 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: A toy of SQL injection (Re: [PATCH 0/3] Thread/Child-Domain Assignment)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com>
In-Reply-To: <4889CC5F.3030500@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following PHP script is an example to assign individual security
context. A modified version of Apache kicks a child thread for each
requirests and assign its security context based on authenticated
username via HTTP basic authentication.

  http://kaigai.myhome.cx/index.php

Three users are set up (curry, sushi and noodle) with same password
of "selinux", to confirm they have individual security context.

No need to say, this script has a vulnerability of SQL injection.
It can help to image how SELinux aware LAPP stack protect from
web application bugs.

(*) The above URL and environment is temporary one, so I'll close
    it without any notices after a week. :-)

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
