From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: Networking Patch (outline)
Date: Tue, 11 Sep 2007 15:31:37 -0400
References: <001301c7f492$00f83ea0$cc0a010a@tcssec.com>
In-Reply-To: <001301c7f492$00f83ea0$cc0a010a@tcssec.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200709111531.37143.paul.moore@hp.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, September 11 2007 12:37:10 pm Venkatesh Yekkirala wrote:
> > > If we want to flow-control just once, another option to
> >
> > consider would be
> >
> > > using rcv_skb for locally destined traffic and a new hook
> >
> > into ip_forward()
> >
> > > for flow-control of forwarded traffic coming-in.
> >
> > Yeah, that's an option, I'm just a little adverse to having
> > to add hooks in
> > the different *_rcv_skb() functions; I'd much prefer them to
> > be at a lower
> > level where we would need less hooks.  Although, we could
> > just piggyback on
> > the existing sk_filter/security_sock_recv_skb() hook since it
> > appears in most
> > of the *_rcv_skb() functions I've looked at (I suspect it's
> > in all, but
> > haven't bothered to check yet).
>
> Piggybacking is what I meant ("using" rcv_skb and a "new" hook
> into ip_forward() :).

One of these days we'll figure out what each other means the first time 
around ;)

> > Time to go for a walk and think about this some more ...
>
> Actually, postroute_last would be hit for each xfrm as well.
> So, perhaps a separate LSM hook into say ip_output() ...

Yep, I'd say we even need to move the check farther down into the call stack 
to ip_finish_output2() or at least after the XFRM check in ip_finish_output() 
so we avoid problems with source NAT (see the check at the top of 
ip_finish_output()).  Sadly, using netfilter hooks doesn't look like it will 
work.

I think this is the current summary of what we think we need in terms of new 
hooks to do flow control, take a look and see if you agree.  The one thing I 
still want to check is how the ipv6 portion of the stack handles options; 
it's a bit different than ipv4 for obvious reasons and I want to make sure 
our hook placement for ipv6 doesn't cause us any problems in the future.

 * Inbound packets (flow in check)
   - add to existing security_sock_rcv_skb() hook for locally consumed
     packets
   - new hook in ip[6]_forward_finish(), before the call to  
     ip_forward_options() for ipv4, to catch packets not destined for the
     local machine

 * Outbound packets (flow out check)
   - new hook in ip_finish_output()/ip6_output_finish() to catch all outbound
     packets, including forwarded packets on their way out

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
