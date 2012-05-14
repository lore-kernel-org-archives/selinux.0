Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4EFZASB013851
	for <selinux@tycho.nsa.gov>; Mon, 14 May 2012 11:35:10 -0400
Received: by qady23 with SMTP id y23so3898775qad.14
        for <selinux@tycho.nsa.gov>; Mon, 14 May 2012 08:35:11 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
Date: Mon, 14 May 2012 11:35:06 -0400
Message-ID: <2254819.3TiCjlmuru@sifl>
In-Reply-To: <4FB1000D.4040403@tresys.com>
References: <4FA95098.1050201@tresys.com> <1540303.QUZeuyPSRI@sifl> <4FB1000D.4040403@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, May 14, 2012 08:52:29 AM Christopher J. PeBenito wrote:
> On 05/10/12 16:02, Paul Moore wrote:
> > Ever since secmark was introduced it has required users/admins to ensure,
> > via a secondary mechanism not contained within the SELinux policy, that
> > the netfilter/iptables configuration was both correctly matched to the
> > policy and that is was not tampered with, either maliciously or
> > accidentally.  Failure to do this verification and correctly configure
> > netfilter/iptables could result in the mis-labeling of network traffic
> > via the secmark label.
> > 
> > This applies to both the current behavior and the "old" behavior.
> > 
> > Simply going back to always applying the per-packet secmark access
> > controls does nothing to solve the problem of ensuring correctness.  This
> > is my main problem with your argument.
> 
> I don't understand what correctness you're referring to.  Labeling
> correctness?  You always need that; thats the crux of having a proper
> running system.  But we don't stop enforcing policy if its not correct.

That last sentence is particularly interesting, but I'll avoid commentary on 
it for right now ...

My concern is that for every aspect of the system that I can think of, and 
feel free to correct me if I'm missing something (as I know you will), the 
system's policy can enforce the (re)labeling of the subjects and objects on 
the system so it has _some_ control over the assigned labels.  There are also 
tools, e.g. restorecon, which can be used to verify/reset/correct the labels 
on persistent filesystem objects.  With those two things you should be able to 
verify the correctness of a filesystem's labels and then ensure it stays 
correct.

With secmark labels we still have the ability to enforce the (re)labeling via 
the system's policy, but we are missing the ability to verify/reset/correct 
the label assignment.

> >> * during boot and shutdown you can guarantee no network access
> > 
> > You can do this through a variety of other mechanisms that have nothing to
> > do with secmark labels.
> 
> No, you can't.

Yes, you can. See "netif:{ ingress egress }".

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
