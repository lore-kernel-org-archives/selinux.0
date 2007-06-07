From: Paul Moore <paul.moore@hp.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Thu, 7 Jun 2007 07:51:19 -0400
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joe Nall <joe@nall.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com> <4667ABFD.2070703@ak.jp.nec.com> <4667B6E3.1010000@ak.jp.nec.com>
In-Reply-To: <4667B6E3.1010000@ak.jp.nec.com>
MIME-Version: 1.0
Message-Id: <200706070751.19644.paul.moore@hp.com>
Content-Type: text/plain;
  charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 07 June 2007 3:42:27 am KaiGai Kohei wrote:
> KaiGai Kohei wrote:
> | As I envision it right now this new static external label would be
> | managed via NetLabel (it is a framework after all, not just CIPSO) so we
> | wouldn't need to introduce any more per-packet access checks, similar to
> | how
> | iptables/netfilter manages the SECMARK labels.  The impact to the SELinux
> | kernel code should be quite minimal using this approach.
>
> In my understanding, the next NetLabel-tools enables to store fallbacked
> client's context associated with network addresses/interfaces into the
> kernel space, and those definitions are evaluated to attach a valid
> peer_sid when a connection come from unlabaled network. Is it correct?

Yes, that is correct.

> One more point is here.
> How should be handled a connection come from unlabeled network, without any
> fallbacked context? Two ways are considerable for me. One is that
> getpeercon() really returns -ENOPROTOOPT, the other is returning an initial
> context newly defined for this purpose.

My personal opinion is that the current getpeercon() behavior of 
returning -ENOPROTOOPT when a peer label is not present is probably the best 
solution as it allows per-application handling of this particular case.  
Earlier in the thread Stephen mentioned that Eamon had developed a way to 
handle this for X using a domain specific fallback label and that approach 
seems to make the most sense to me.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
