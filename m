From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 10:50:43 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        kaigai@ak.jp.nec.com, joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <20070807141415.525577324@hp.com> <200708090929.16906.paul.moore@hp.com> <Pine.LNX.4.64.0708090654230.16824@us.intercode.com.au>
In-Reply-To: <Pine.LNX.4.64.0708090654230.16824@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708091050.43955.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 09 August 2007 9:59:53 am James Morris wrote:
> On Thu, 9 Aug 2007, Paul Moore wrote:
> >  * Convert the external labeling protocols to make use of the SECMARK
> > secid field in the sk_buff struct.  The advantage to NetLabel and
> > explicit labeling protocols is really marginal but this should be a huge
> > win for labeled IPsec.
>
> The way we were discussing this (off-list) was that we'd allow iptables
> secmark labeling to set fallback/default labels, which may be overridden
> by external labeling (Netlabel, IPsec).

If I understand you correctly, SECMARK would continue as SECMARK as we know it 
today, the only real difference is that if getpeercon() would return failure 
because NetLabel or labeled IPsec was not in use we would return the SECMARK 
label?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
