From: Paul Moore <paul.moore@hp.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Wed, 6 Jun 2007 07:45:31 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        Joe Nall <joe@nall.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com> <1180966620.14220.57.camel@moss-spartans.epoch.ncsc.mil> <4666260D.9060409@ak.jp.nec.com>
In-Reply-To: <4666260D.9060409@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200706060745.31980.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 05 June 2007 11:12:13 pm KaiGai Kohei wrote:
> >> How do you think necessity for generic fall back behavior in the case
> >> when getpeercon() failed?
> >
> > I think it would be useful.  There was some discussion of it during the
> > labeled networking discussions, but directly returning the secmark label
> > or the netif/netmsg labels was viewed as problematic because they aren't
> > peer/process contexts.
>
> I agree the conclusion. Those labels don't represent domain's one.
> But I think that using them an entrypoint of domain transition is
> a considerable idea, like this:
>   type_transition postgresql_t untrusted_network_t : packet
>     sepgsql_client_t;
>   type_transition ftpd_t untrusted_network_t : packet 
>     ftpd_client_t;

There was a discussion about using packet type transitions before, although it 
was slightly different than what you are proposing here.  The basic idea was 
to reconcile both the "internal" and "external" packet labels into a single 
label using type transitions.  In the end it became to complex to write sane 
policy so the idea was dropped.

Your proposal is slightly different in that I view it more as a per-domain 
renaming scheme where you rename/relabel packets based on the receiving 
domain.  Can you help me understand the advantage of 
renaming "untrusted_network_t" to "sepgsql_client_t" from a policy point of 
view?  For example, how would these two policy rules be different or have any 
advantage over one another:

 allow sepgsql_t untrusted_network_t:<class> <perms>;
 allow sepgsql_t sepgsql_client_t:<class> <perms>:

Also, if it is decided that this idea does have merit and is worth 
implementing I see it as being complimentary, and not mutually exclusive, to 
static labeling of unlabeled hosts/networks.

> Is it different from Paul's idea, isn't it?
> In my understanding, he intends to associate a domain's context directly
> with network interfaces and/or network addresses.

Yes, that is correct.  It is similar to how existing trusted OSs provide 
connection/packet labels for unlabeled hosts/networks.

> If corrent, I have a question.
> Is it possible to distinguish the fallback context for each server domain?

Anything is possible, but that is not how I am currently intending to 
implement the functionality.  Once again, since these are static labels, what 
advantage is there to doing this individually for each receiving domain?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
