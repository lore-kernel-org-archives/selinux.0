Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
	interface)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: vyekkirala@TrustedCS.com, "'Paul Moore'" <paul.moore@hp.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
In-Reply-To: <4666F455.9080007@kaigai.gr.jp>
References: <000301c7a83f$ecf25920$cc0a010a@tcssec.com>
	 <4666EE27.9040803@kaigai.gr.jp>
	 <1181151255.3699.185.camel@moss-spartans.epoch.ncsc.mil>
	 <4666F455.9080007@kaigai.gr.jp>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 14:01:30 -0400
Message-Id: <1181152890.3699.189.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-07 at 02:52 +0900, KaiGai Kohei wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-06-07 at 02:25 +0900, KaiGai Kohei wrote:
> >> Venkat Yekkirala wrote:
> >>>> Your proposal is slightly different in that I view it more as 
> >>>> a per-domain 
> >>>> renaming scheme where you rename/relabel packets based on the 
> >>>> receiving 
> >>>> domain.  Can you help me understand the advantage of 
> >>>> renaming "untrusted_network_t" to "sepgsql_client_t" from a 
> >>>> policy point of 
> >>>> view?  For example, how would these two policy rules be 
> >>>> different or have any 
> >>>> advantage over one another:
> >>>>
> >>>>  allow sepgsql_t untrusted_network_t:<class> <perms>;
> >>>>  allow sepgsql_t sepgsql_client_t:<class> <perms>:
> >>> I doubt that the intent here is to change the permission checks
> >>> to use the transition label. Rather the idea seems to be to
> >>> have getpeercon() return the transition label (sepgsql_client_t).
> >>>
> >>> Coincidentally we (Darrel, Chad and myself) were talking about this
> >>> and it seems like a good idea.
> >> As Paul and Stephen said, what getpeercon() returns fallbacked context
> >> is confusable. I think that application should call a function to compute
> >> fallbacked context explicitly when getpeercon() failed, like follows:
> >>
> >> security_context_t peer_con;
> >>
> >> if (getpeercon(sockfd, &peer_con)) {
> >>      security_context_t serv_con, secmark_con;
> >>      if (getsecmarkcon(sockfd, &secmark_con))
> >>          return NULL;
> >>      if (getcon(&serv_con))
> >>          return NULL;
> >>      if (security_compute_create(serv_con, secmark_con,
> >>                                  SECCLASS_PACKET, &peer_con))
> > 
> > Have you looked at the xinetd logic?
> 
> Sorry, I'm not clear what you intend to say.
> 
> Just before, I confirmed xinetd-2.3.14-label.patch
> in xinetd-2.3.14-11.src.rpm (Fedora 7).

Look at xinetd-2.3.14-contextconf.patch.

> When getpeercon() returns an error, it does not have any
> fallback implementation.

Yes, I'm not referring to fallback behavior there but instead to how
they are using security_compute_create() to compute the domain
transition on the child.  While preserving the MLS range from the peer.

BTW, that kind of logic has got to be encapsulated, as discussed at the
selinux developers summit; we can't have MLS specifics leaking into the
applications.

> ----------------------------------------------------
> +#ifdef LABELED_NET
> +static int set_context_from_socket( int fd )
> +{
> +   const char *func = "set_context_from_socket" ;
> +   security_context_t peer_context;
> +
> +   if (getpeercon(fd, &peer_context) < 0)
> +      return -1;             <-- caller exit soon with an error message.
> +
> +   int retval = setexeccon(peer_context);
> +   freecon( peer_context );
> +
> +   if (debug.on)
> +   {
> +      security_context_t current_exec_context;
> +      if ( getexeccon( &current_exec_context ) == 0 ) {
> +
> +         msg( LOG_DEBUG, func,
> +          "current security exec context now: %s",
> +          current_exec_context ? current_exec_context : "unknown" );
> +
> +         freecon( current_exec_context );
> +      }
> +      else
> +         msg( LOG_DEBUG, func, "Error calling getexeccon: %m" );
> +   }
> +
> +   return retval;
> +}
> +#endif
> ----------------------------------------------------
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
