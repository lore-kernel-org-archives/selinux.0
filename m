Subject: Re: libselinux APIs should take "const" qualifier?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4BA32D3B.9010502@ak.jp.nec.com>
References: <4BA32D3B.9010502@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 19 Mar 2010 09:32:29 -0400
Message-Id: <1269005549.25642.5.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-03-19 at 16:52 +0900, KaiGai Kohei wrote:
> Right now, security_context_t is an alias of char *, declared in selinux.h.
> 
> Various kind of libselinux API takes security_context_t arguments,
> however, it is inconvenience in several situations.
> 
> For example, the following query is parsed, then delivered to access
> control subsystem with the security context as "const char *" cstring.
> 
>   ALTER TABLE my_tbl SECURITY LABEL TO 'system_u:object_r:sepgsql_table_t:SystemHigh';
>                 const char *  <----    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> In this case, we want to call selinux_trans_to_raw_context() to translate
> the given security context into raw format. But it takes security_context_t
> argument for the source context, although this pointer is read-only.
> In the result, compiler raises warnings because we gave "const char *" pointer
> into functions which take security_context_t (= char *).
> 
> Any comments?
> 
> It seems to me the following functions' prototype should be qualified by
> "const".

That seems reasonable and should have no impact on library ABI.
On the other hand, others have pointed out that security_context_t is
not a properly encapsulated data type at all, and perhaps should be
deprecated and replaced with direct use of char*/const char* throughout.

There are other library API issues as well that have come up in the
past, such as lack of adequate namespacing (with approaches put forth),
but we don't ever seem to get a round tuit.

> extern int setcon(*const* security_context_t con);
> extern int setexeccon(*const* security_context_t con);
> extern int setfscreatecon(*const* security_context_t context);
> extern int setkeycreatecon(*const* security_context_t context);
> extern int setsockcreatecon(*const* security_context_t context);
> 
> extern int security_compute_av(*const* security_context_t scon,
>                                *const* security_context_t tcon,
>                                security_class_t tclass,
>                                access_vector_t requested,
>                                struct av_decision *avd);
> extern int security_compute_av_flags(*const* security_context_t scon,
>                                      *const* security_context_t tcon,
>                                      security_class_t tclass,
>                                      access_vector_t requested,
>                                      struct av_decision *avd);
> extern int security_compute_create(*const* security_context_t scon,
>                                    *const* security_context_t tcon,
>                                    security_class_t tclass,
>                                    security_context_t * newcon);
> extern int security_compute_relabel(*const* security_context_t scon,
>                                     *const* security_context_t tcon,
>                                     security_class_t tclass,
>                                     security_context_t * newcon);
> extern int security_compute_member(*const* security_context_t scon,
>                                    *const* security_context_t tcon,
>                                    security_class_t tclass,
>                                    security_context_t * newcon);
> extern int security_compute_user(*const* security_context_t scon,
>                                  const char *username,
>                                  security_context_t ** con);
> extern int security_check_context(*const* security_context_t con);
> extern int security_canonicalize_context(*const* security_context_t con,
>                                          security_context_t * canoncon);
>  ... and all the _raw version.
> 
> extern int selinux_trans_to_raw_context(*const* security_context_t trans,
>                                         security_context_t * rawp);
> extern int selinux_raw_to_trans_context(*const* security_context_t raw,
>                                         security_context_t * transp);
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
