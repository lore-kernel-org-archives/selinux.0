Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7TEcflf008435
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2012 10:38:41 -0400
Received: by vcbfl17 with SMTP id fl17so761483vcb.12
        for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2012 07:38:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120829130233.GA14196@telmora.telvanni>
References: <20120829130233.GA14196@telmora.telvanni>
Date: Wed, 29 Aug 2012 10:38:39 -0400
Message-ID: <CAB9W1A0++6KKqQ+ttHQXQBeVsqpd-F+6Hk-WK+KoyhHQiD0_cQ@mail.gmail.com>
Subject: Re: network packet context
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 29, 2012 at 9:02 AM, Ole Kliemann <ole@plastictree.net> wrote:
> I have another one of those 'Is it normal?' questions.
>
> To begin with my system does not label network packets in any
> way, packets are not unlabeled_t, they just seem to be ignored by
> LSM. There is no rule of the type 'allow X Y:packet { send recv }'
> required, all domains can access the network.
>
> When I introduce just a single iptables rule utilizing SECMARK, say
>
>     iptables -A INPUT -t security -i tun0 -j SECMARK system_u:object_r:sec_tun_t:s0
>
> to label all packets coming in at tun0, then suddenly all traffic
> on all devices gets labeled. Those which lack an iptables rule
> get unlabeled_t. Suddenly all network is locked down and I need
> 'allow X Y:packet { send recv }' rules in the policy.
>
> Ole

Yes, that is expected.  The secmark packet are only applied if you
have defined at least one iptables secmark rule.  The labeled
networking peer checks are similar; they are only applied if you
configure network labeling (NetLabel or labeled IPSEC).  There was
recent discussion on list of whether this was desirable behavior (by
Chris PeBenito), and I think he has posted some patches to make this a
policy option as to whether or not the checks are always applied.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
