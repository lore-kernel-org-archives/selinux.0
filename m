Message-ID: <4889CC5F.3030500@ak.jp.nec.com>
Date: Fri, 25 Jul 2008 21:51:43 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: [PATCH 0/3] Thread/Child-Domain Assignment
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>
In-Reply-To: <4886AC81.9030202@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The series of patches enable to assign a thread a "weaker" hierarchical
domain, even if the process is multithreaded.

We can use this feature to implement server application which handles
user's request within more restricted domain, to protect harms from
potential application bugs. SELinux awared server application can
voluntarily minimize the permissions set of its backend thread at
the begining of processing request.

No need to say, thread shares local memory, so mixed security context
within a process can make a violation in domain separation.
However, a characteristic relationship between hierarchical domains can
help the situation. It restricts a child domain (like "httpd_t.staff")
cannot over the boundary of its parent ("httpd_t"). It also means
a multi-threaded process cannot over the (parent) domain boundary,
even if a part of threads has different security context.

[1/3] thread-context-kernel.1.patch
  This patch enables to assign a thread a "weaker" hierarchical domain,
  only if the destinated domain is a child of the current domain.
  Hierachy relationships are defined in the policy version 24.
  This patch also enables to read the new version of policy.

[2/3] thread-context-checkpolicy.1.patch
  This patch add a new statement of TYPEDOMINATE for policy language.

    TYPEDOMINATE <parent type>  <chile type> [, <child type> ...] ;

  It defines expilct hierarchical relationship between two types.
  Existing name based hierarchy is dealt as TYPEDOMINATE is described
  implicitly.

[3/3] thread-context-libsepol.1.patch
  This patch add support of new policy version of POLICYDB_VERSION_HIERARCHY.
  It keeps child-parent relationship between two types, and used to make
  a decision whether required dynamic type transition within multithreaded
  process can be allowed, or not, in the kernel space.

---- Examples ------------
[kaigai@saba ~]$ gcc thread-context.c -lselinux -lpthread
[kaigai@saba ~]$ ./a.out
12864: Now leader is running at unconfined_u:unconfined_r:unconfined_t:SystemLow-SystemHigh
12865: setcon(unconfined_u:unconfined_r:unconfined_red_t:s0) = 0 (Success)
12865: Now I'm running in unconfined_u:unconfined_r:unconfined_red_t
12866: setcon(unconfined_u:unconfined_r:unconfined_blue_t:s0) = 0 (Success)
12866: Now I'm running in unconfined_u:unconfined_r:unconfined_blue_t
12867: setcon(unconfined_u:unconfined_r:unconfined_green_t:s0) = -1 (Operation not permitted)
12868: setcon(unconfined_u:unconfined_r:unconfined_t:s0) = 0 (Success)
12868: Now I'm running in unconfined_u:unconfined_r:unconfined_t
[kaigai@saba ~]$

This sample program makes four threads, and they tries to change its domain.
The number in leftside shows its thread id. Three of them succeeded to change,
but rest of them cannot.
The unconfined_red_t and unconfined_blue_t is a hierarchical child domain of
unconfined_t and the forth thread (12868) does not change its domain, so they
are allowed to have its security context different from others.


Please review them, Thanks.
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
