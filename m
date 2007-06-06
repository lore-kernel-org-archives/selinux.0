From: Paul Moore <paul.moore@hp.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Wed, 6 Jun 2007 13:42:15 -0400
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joe Nall <joe@nall.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com> <200706060745.31980.paul.moore@hp.com> <4666ED96.8080508@kaigai.gr.jp>
In-Reply-To: <4666ED96.8080508@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706061342.15348.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, June 6 2007 1:23:34 pm KaiGai Kohei wrote:
> Paul Moore wrote:
> > On Tuesday 05 June 2007 11:12:13 pm KaiGai Kohei wrote:
> >> I agree the conclusion. Those labels don't represent domain's one.
> >> But I think that using them an entrypoint of domain transition is
> >> a considerable idea, like this:
> >>   type_transition postgresql_t untrusted_network_t : packet
> >>     sepgsql_client_t;
> >>   type_transition ftpd_t untrusted_network_t : packet
> >>     ftpd_client_t;
> >
> > There was a discussion about using packet type transitions before,
> > although it was slightly different than what you are proposing here.  The
> > basic idea was to reconcile both the "internal" and "external" packet
> > labels into a single label using type transitions.  In the end it became
> > to complex to write sane policy so the idea was dropped.
> >
> > Your proposal is slightly different in that I view it more as a
> > per-domain renaming scheme where you rename/relabel packets based on the
> > receiving domain.  Can you help me understand the advantage of
> > renaming "untrusted_network_t" to "sepgsql_client_t" from a policy point
> > of view?  For example, how would these two policy rules be different or
> > have any advantage over one another:
> >
> >  allow sepgsql_t untrusted_network_t:<class> <perms>;
> >  allow sepgsql_t sepgsql_client_t:<class> <perms>:
>
> I didn't intend to rename/relabel contexts of packets. The idea uses the
> context of received packet as an entrypoint of domain transition. In other
> word, the server process's context is renamed/relabeled based on packet's
> one.
>
> The key issues in the discussion is how to determine the context of client
> process connected via unlabeled network. My idea is generating an
> alternative client context based on server process's one and packet's one,
> using domain transition.
>
>  > Also, if it is decided that this idea does have merit and is worth
>  > implementing I see it as being complimentary, and not mutually
>  > exclusive, to static labeling of unlabeled hosts/networks.
>
> The reason why I wanted to separate fallbacked client contexts per server
> domain is not to give more permissions than necessary.
> For example, fallbacked context for SE-PostgreSQL need to access database
> with limited permission. It does not require permissions for any other
> services.

Thank you for the explanation.  I think I'm starting to get a better idea of 
what you are trying to do - see below.

>  >> Is it different from Paul's idea, isn't it?
>  >>
>  >> > In my understanding, he intends to associate a domain's context
>  >> > directly with network interfaces and/or network addresses.
>  >
>  > Yes, that is correct.  It is similar to how existing trusted OSs provide
>  > connection/packet labels for unlabeled hosts/networks.
>
> Is it possible to apply onto TE label, not only MLS label?
>
> Domain transition via packet class is a bit hard to understand.
> It's preferable, if we can configure the fallbacked client context
> directly, as follows:
>     192.168.1.0/24 --> system_u:system_r:sepgsql_client_t
>     192.168.2.0/24 -->
> system_u:system_r:sepgsql_trusted_client_t:SystemLow-SystemHigh

That is exactly what I am intending to implement; the system administrator 
would specify a interface/address/netmask that would match to a _full_ 
SELinux context as you have described above.  Now, using a type which is 
obviously specific to sepostgres (sepgsql_client_t) may not be the best 
choice for a system-wide value, but you could set it to a more generic type 
and the individual label-aware applications could transition to a more 
specific type as appropriate (much like you described in your other email).

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
