Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5CCDx45014258
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 08:13:59 -0400
Received: by oihd6 with SMTP id d6so20618908oih.2
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 05:13:57 -0700 (PDT)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <CA+SaE3t=02nZnoM=K2cd+1MyPo74QZHvYwv+5Shr0+LpLFUGBA@mail.gmail.com>
References: <008e01d0a431$3c777980$b5666c80$@gmail.com>
 <557983AD.1040706@tycho.nsa.gov>
 <00b901d0a449$0988c2f0$1c9a48d0$@gmail.com>
 <CA+SaE3uawE6VSKiDTeh-dayVnjWzK=DzqQ9Ju5YtN1m_uyuAiQ@mail.gmail.com>
 <CAHC9VhR1NbLkaXRY8Up0DT_onxFe05Xr87ddRMBXTUkA4QvyLQ@mail.gmail.com>
 <CA+SaE3t=02nZnoM=K2cd+1MyPo74QZHvYwv+5Shr0+LpLFUGBA@mail.gmail.com>
Date: Fri, 12 Jun 2015 14:13:57 +0200
Message-ID: <CAPzO=Nxredpu5q-w4x_3UkbP=HU5a4VzjRd8_bTXXo=UHSUVwQ@mail.gmail.com>
Subject: Re: SELinux: Interface Labeling Problem
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Maurizio Pagani <pag.maurizio@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 11, 2015 at 10:47 PM, Maurizio Pagani
<pag.maurizio@gmail.com> wrote:
> ok, imattached also the community on this thread.
>> >> -----Messaggio originale-----
>> >> Da: Stephen Smalley [mailto:sds@tycho.nsa.gov]
[...]
>> >> In any event, SELinux network permission checks have changed over time.
>> >> The netif { tcp_recv tcp_send udp_recv udp_send } checks were legacy
>> >> network checks that were removed in Linux 2.6.30.  netif { ingress
>> >> egress }
>> >> are newer checks that are only enabled if you have configured peer
>> >> labeling
>> >> via NetLabel or labeled IPSEC/xfrm.

As Stephen already mentioned, recent Linux kernels only listen to the
egress/ingress permissions in the netif class. The other permissions
might still be marked as "existing" for backwards compatibility, but
they are not enforced anymore. See
http://lists.openwall.net/netdev/2009/03/27/144

To enable the egress/ingress support however, you need to use either
Labeled IPSec or NetLabel/CIPSO support.

If you want to use SECMARK, then the controls are not on the netif
class, but on the packet classes.

Wkr,
  Sven Vermeulen
