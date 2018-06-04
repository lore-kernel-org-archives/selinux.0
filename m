Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w543xqHD027676
 for <selinux@tycho.nsa.gov>; Sun, 3 Jun 2018 23:59:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 40zh5y0gYCz2NhLY
 for <selinux@tycho.nsa.gov>; Mon,  4 Jun 2018 03:59:50 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 40zh5x31J6z2NhLV
 for <selinux@tycho.nsa.gov>; Mon,  4 Jun 2018 03:59:49 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id t134-v6so22912406lff.6
 for <selinux@tycho.nsa.gov>; Sun, 03 Jun 2018 20:59:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Alexey Lyashkov <alexey.lyashkov@gmail.com>
In-Reply-To: <87h8mjp5o0.fsf@notabene.neil.brown.name>
Date: Mon, 4 Jun 2018 06:59:45 +0300
Cc: "Dilger, Andreas" <andreas.dilger@intel.com>,
 Andreas Dilger <adilger@dilger.ca>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "Drokin, Oleg" <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 fsdevel <linux-fsdevel@vger.kernel.org>,
 lustre-devel <lustre-devel@lists.lustre.org>
Message-Id: <FE290581-D17D-4CEC-9AE2-B79DCBBD0823@gmail.com>
References: <20180601091133.GA27521@kroah.com>
 <20180601114151.GA25225@infradead.org>
 <E5BF8501-35EB-4DDF-ADBE-6016CF31A502@dilger.ca>
 <29ACF5A8-7608-46BB-8191-E3FEB77D0F24@cray.com>
 <87h8mmrt6b.fsf@notabene.neil.brown.name>
 <58123CDD-8424-4E1D-A11F-0F899970A49B@intel.com>
 <87h8mjp5o0.fsf@notabene.neil.brown.name>
To: NeilBrown <neilb@suse.com>
Subject: Re: [lustre-devel] [PATCH] staging: lustre: delete the
 filesystem from the tree.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


> 4 июня 2018 г., в 6:54, NeilBrown <neilb@suse.com> написал(а):
> 
> On Sun, Jun 03 2018, Dilger, Andreas wrote:
> 
>> On Jun 1, 2018, at 17:19, NeilBrown <neilb@suse.com> wrote:
>>> 
>>> On Fri, Jun 01 2018, Doug Oucharek wrote:
>>> 
>>>> Would it makes sense to land LNet and LNDs on their own first?  Get
>>>> the networking house in order first before layering on the file
>>>> system?
>>> 
>>> I'd like to turn that question on it's head:
>>> Do we need LNet and LNDs?  What value do they provide?
>>> (this is a genuine question, not being sarcastic).
>>> 
>>> It is a while since I tried to understand LNet, and then it was a
>>> fairly superficial look, but I think it is an abstraction layer
>>> that provides packet-based send/receive with some numa-awareness
>>> and routing functionality.  It sits over sockets (TCP) and IB and
>>> provides a uniform interface.
>> 
>> LNet is originally based on a high-performance networking stack called
>> Portals (v3, http://www.cs.sandia.gov/Portals/), with additions for LNet
>> routing to allow cross-network bridging.
>> 
>> A critical part of LNet is that it is for RDMA and not packet-based
>> messages.  Everything in Lustre is structured around RDMA.  Of course,
>> RDMA is not possible with TCP

To be clear. Soft IB (aka Soft RoCE) driver is part of OFED stack from 4.8(or 4.9).
So RDMA API now is possible with TCP networks.


Alex
