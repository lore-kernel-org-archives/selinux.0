Date: Fri, 19 Jun 2009 00:18:29 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, jdennis@redhat.com
Subject: Re: type bounds audit messages
In-Reply-To: <4A39FA25.8050400@ak.jp.nec.com>
Message-ID: <alpine.LRH.2.00.0906190018020.26343@tundra.namei.org>
References: <1244730288.10762.120.camel@localhost.localdomain>  <200906161040.52279.sgrubb@redhat.com>  <1245164133.2848.12.camel@localhost.localdomain>  <200906161123.52932.sgrubb@redhat.com>  <1245166869.2848.21.camel@localhost.localdomain>
 <4A38727F.7090705@ak.jp.nec.com> <1245243187.29288.19.camel@localhost.localdomain> <4A39FA25.8050400@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Jun 2009, KaiGai Kohei wrote:

> [PATCH] Add audit messages on type boundary violations
> 
> The attached patch adds support to generate audit messages on two cases.
> 
> The first one is a case when a multi-thread process tries to switch its
> performing security context using setcon(3), but new security context is
> not bounded by the old one.
> 
>   type=SELINUX_ERR msg=audit(1245311998.599:17):        \
>       op=security_bounded_transition result=denied      \
>       oldcontext=system_u:system_r:httpd_t:s0           \
>       newcontext=system_u:system_r:guest_webapp_t:s0
> 
> The other one is a case when security_compute_av() masked any permissions
> due to the type boundary violation.
> 
>   type=SELINUX_ERR msg=audit(1245312836.035:32):	\
>       op=security_compute_av reason=bounds              \
>       scontext=system_u:object_r:user_webapp_t:s0       \
>       tcontext=system_u:object_r:shadow_t:s0:c0         \
>       tclass=file perms=getattr,open
> 
> 
>  Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
