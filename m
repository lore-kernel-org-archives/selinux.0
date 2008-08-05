Message-ID: <4897E974.2040003@ak.jp.nec.com>
Date: Tue, 05 Aug 2008 14:47:32 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: [PATCH 0/3] Thread/Child-Domain Assignment (rev.2)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com>
In-Reply-To: <4889CC5F.3030500@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The series of patches enables to assign a thread an indivisual
"more bounded" domain, even if the process is multithreaded.

We can apply this feature to set up a server application which
handles user's request withing more restricted domain, to protect
potential harms come from application bugs.

It also adds a new binary policy format (version 24).
This version allows each definitions of user/role/type to have
its bounds. The bounds restrict capabilities of bounded one
with similar rules compared to existing name based hierarchy
support.
The following rules are enhanced from existing hierarchy stuff.
- A bounded type cannot have any attribute which does not assigned
  to the upper type.
- CONSTRAIN/MLSCONSTRAIN rules are enhanced to pay attention
  the boundary relationships.

I adds a new statement of TYPEBOUNDS as follows:

  TYPEBOUNDS <parent type>  <child type 1> [, <child type 2> ...] ;

It defines boundary relationships between two types, and these
are loaded to the kernelspace via policy version 24.
(*) The existing hierarchy is implicitly expanded to bounds.

I don't provide a statement to define boundary relationships
between roles/users, although existing hierarchy supports them,
because its purpose/worth is unclear now.
The policy format version 24 has a field to represent boundary
relationship between users/roles, but it is only used to ship
existing hierarhies.

[1/3] thread-context-kernel.1.patch
  It allows a multithreaded process to assign an individual
  "more bounded" security context, and it also enables to
  handle binary policy format version 24 in kernel space.

[2/3] thread-context-checkpolicy.2.patch
  It enables to support TYPEBOUNDS statement and to expand
  existing hierarchies implicitly.

[3/3] thread-context-libsepol.2.patch
  It enables to support binary policy format version 24.

The series of patches does not contains facilities to support
lazy NEVERALLOW support, due to enlarged policy size, as I noted
before.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
