Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
	interface)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: vyekkirala@TrustedCS.com, "'Paul Moore'" <paul.moore@hp.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
In-Reply-To: <4666EE27.9040803@kaigai.gr.jp>
References: <000301c7a83f$ecf25920$cc0a010a@tcssec.com>
	 <4666EE27.9040803@kaigai.gr.jp>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 13:34:15 -0400
Message-Id: <1181151255.3699.185.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-07 at 02:25 +0900, KaiGai Kohei wrote:
> Venkat Yekkirala wrote:
> >> Your proposal is slightly different in that I view it more as 
> >> a per-domain 
> >> renaming scheme where you rename/relabel packets based on the 
> >> receiving 
> >> domain.  Can you help me understand the advantage of 
> >> renaming "untrusted_network_t" to "sepgsql_client_t" from a 
> >> policy point of 
> >> view?  For example, how would these two policy rules be 
> >> different or have any 
> >> advantage over one another:
> >>
> >>  allow sepgsql_t untrusted_network_t:<class> <perms>;
> >>  allow sepgsql_t sepgsql_client_t:<class> <perms>:
> > 
> > I doubt that the intent here is to change the permission checks
> > to use the transition label. Rather the idea seems to be to
> > have getpeercon() return the transition label (sepgsql_client_t).
> > 
> > Coincidentally we (Darrel, Chad and myself) were talking about this
> > and it seems like a good idea.
> 
> As Paul and Stephen said, what getpeercon() returns fallbacked context
> is confusable. I think that application should call a function to compute
> fallbacked context explicitly when getpeercon() failed, like follows:
> 
> security_context_t peer_con;
> 
> if (getpeercon(sockfd, &peer_con)) {
>      security_context_t serv_con, secmark_con;
>      if (getsecmarkcon(sockfd, &secmark_con))
>          return NULL;
>      if (getcon(&serv_con))
>          return NULL;
>      if (security_compute_create(serv_con, secmark_con,
>                                  SECCLASS_PACKET, &peer_con))

Have you looked at the xinetd logic?

>          return NULL;
> }
> return peer_con;
> 
> Or, getpeercon_fallback() may be able to wrap the above code.
> 
> Thanks,
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
