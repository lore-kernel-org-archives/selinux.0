Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        kaigai@ak.jp.nec.com, joe@nall.com, Eric Paris <eparis@parisplace.org>
In-Reply-To: <200708091050.43955.paul.moore@hp.com>
References: <20070807141415.525577324@hp.com>
	 <200708090929.16906.paul.moore@hp.com>
	 <Pine.LNX.4.64.0708090654230.16824@us.intercode.com.au>
	 <200708091050.43955.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 11:13:06 -0400
Message-Id: <1186672386.6916.513.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-09 at 10:50 -0400, Paul Moore wrote:
> On Thursday 09 August 2007 9:59:53 am James Morris wrote:
> > On Thu, 9 Aug 2007, Paul Moore wrote:
> > >  * Convert the external labeling protocols to make use of the SECMARK
> > > secid field in the sk_buff struct.  The advantage to NetLabel and
> > > explicit labeling protocols is really marginal but this should be a huge
> > > win for labeled IPsec.
> >
> > The way we were discussing this (off-list) was that we'd allow iptables
> > secmark labeling to set fallback/default labels, which may be overridden
> > by external labeling (Netlabel, IPsec).
> 
> If I understand you correctly, SECMARK would continue as SECMARK as we know it 
> today, the only real difference is that if getpeercon() would return failure 
> because NetLabel or labeled IPsec was not in use we would return the SECMARK 
> label?

Except that secmark would also be used as the means of propagating the
label with the skb throughout the stack, thereby enabling loopback
labeling and flow control.  So secmark gets initialized via iptables to
a fallback (or left unlabeled if no iptables match exists), then
replaced (after a consistency check) if labeled networking is in use
with the explicit or implicit label.  Then the secmark gets used
everywhere for permission checking - it represents the most accurate
label we know for the packet at any given time.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
