From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Wed, 6 Jun 2007 16:48:37 -0400
Cc: vyekkirala@TrustedCS.com, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
References: <000701c7a868$fbdc6a60$cc0a010a@tcssec.com> <200706061537.49417.paul.moore@hp.com> <466719B7.6090003@manicmethod.com>
In-Reply-To: <466719B7.6090003@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706061648.37402.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, June 6 2007 4:31:51 pm Joshua Brindle wrote:
> > The proposal here is to introduce a static external label for single
> > label networks where the remote domain is not explicitly labeling it's
> > network traffic.  This is a common request from people with existing
> > trusted OS installations and would be a nice compliment to the existing
> > labeling mechanisms, both internal and external.
>
> Is this info going to be stored in the policy ala ocontexts? How are you
> planning to manage it? Adding it to libsemanage and semanage seems like
> the best route to take here.

As I envision it right now this new static external label would be managed via 
NetLabel (it is a framework after all, not just CIPSO) so we wouldn't need to 
introduce any more per-packet access checks, similar to how 
iptables/netfilter manages the SECMARK labels.  The impact to the SELinux 
kernel code should be quite minimal using this approach.

Policy integration is still open in my mind, although considering the lessons 
learned from integrating the SECMARK iptables commands into policy I wonder 
if we are best off leaving the labeling details out of the policy itself and 
leaving it in the hands of the NetLabel tools and perhaps libsemanage.

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
