Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2J7sm0I001867
	for <selinux@tycho.nsa.gov>; Fri, 19 Mar 2010 03:54:48 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2J7sOIm027896
	for <selinux@tycho.nsa.gov>; Fri, 19 Mar 2010 07:54:24 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o2J7sfFO007295
	for <selinux@tycho.nsa.gov>; Fri, 19 Mar 2010 16:54:41 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o2J7sfj13557 for selinux@tycho.nsa.gov; Fri, 19 Mar 2010 16:54:41 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
	by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id o2J7se1t023574
	for <selinux@tycho.nsa.gov>; Fri, 19 Mar 2010 16:54:40 +0900 (JST)
Message-ID: <4BA32D3B.9010502@ak.jp.nec.com>
Date: Fri, 19 Mar 2010 16:52:27 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: libselinux APIs should take "const" qualifier?
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Right now, security_context_t is an alias of char *, declared in selinux.h.

Various kind of libselinux API takes security_context_t arguments,
however, it is inconvenience in several situations.

For example, the following query is parsed, then delivered to access
control subsystem with the security context as "const char *" cstring.

  ALTER TABLE my_tbl SECURITY LABEL TO 'system_u:object_r:sepgsql_table_t:SystemHigh';
                const char *  <----    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In this case, we want to call selinux_trans_to_raw_context() to translate
the given security context into raw format. But it takes security_context_t
argument for the source context, although this pointer is read-only.
In the result, compiler raises warnings because we gave "const char *" pointer
into functions which take security_context_t (= char *).

Any comments?

It seems to me the following functions' prototype should be qualified by
"const".

extern int setcon(*const* security_context_t con);
extern int setexeccon(*const* security_context_t con);
extern int setfscreatecon(*const* security_context_t context);
extern int setkeycreatecon(*const* security_context_t context);
extern int setsockcreatecon(*const* security_context_t context);

extern int security_compute_av(*const* security_context_t scon,
                               *const* security_context_t tcon,
                               security_class_t tclass,
                               access_vector_t requested,
                               struct av_decision *avd);
extern int security_compute_av_flags(*const* security_context_t scon,
                                     *const* security_context_t tcon,
                                     security_class_t tclass,
                                     access_vector_t requested,
                                     struct av_decision *avd);
extern int security_compute_create(*const* security_context_t scon,
                                   *const* security_context_t tcon,
                                   security_class_t tclass,
                                   security_context_t * newcon);
extern int security_compute_relabel(*const* security_context_t scon,
                                    *const* security_context_t tcon,
                                    security_class_t tclass,
                                    security_context_t * newcon);
extern int security_compute_member(*const* security_context_t scon,
                                   *const* security_context_t tcon,
                                   security_class_t tclass,
                                   security_context_t * newcon);
extern int security_compute_user(*const* security_context_t scon,
                                 const char *username,
                                 security_context_t ** con);
extern int security_check_context(*const* security_context_t con);
extern int security_canonicalize_context(*const* security_context_t con,
                                         security_context_t * canoncon);
 ... and all the _raw version.

extern int selinux_trans_to_raw_context(*const* security_context_t trans,
                                        security_context_t * rawp);
extern int selinux_raw_to_trans_context(*const* security_context_t raw,
                                        security_context_t * transp);

-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
