Message-ID: <452AB155.8070409@hp.com>
Date: Mon, 09 Oct 2006 16:30:13 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 00/11] The _entire_ secid reconciliation patchset (tada!)
References: <20061009194223.402695000@hp.com> <Pine.LNX.4.64.0610091612140.31187@d.namei>
In-Reply-To: <Pine.LNX.4.64.0610091612140.31187@d.namei>
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Mon, 9 Oct 2006, paul.moore@hp.com wrote:
> 
>>Please consider this for inclusion into 2.6.20.  If it's too soon to be
>>thinking of 2.6.20 let me know and I'll rebase/resend this patchset once I see
>>notice of David's net-2.6.20 git tree.
> 
> From an initial review of this patchset, it doesn't look quite ready to 
> queue for 2.6.20 (which I plan to to via git once it is).
> 
> Outstanding items include resolving the igmp skb hook issue generally, 
> testing to verify both the design and implementation, and ensuring that 
> all the related policy changes are merged upstream first.

I'll keep the patchset up to date and keep tracking the secid patches (I know
there has been discussion around the IGMP hook this morning).  Once everything
looks okay I'll resend the patchset (with any updates/corrections/etc.) again.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
