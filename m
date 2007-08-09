Date: Thu, 9 Aug 2007 06:59:53 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        kaigai@ak.jp.nec.com, joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
In-Reply-To: <200708090929.16906.paul.moore@hp.com>
Message-ID: <Pine.LNX.4.64.0708090654230.16824@us.intercode.com.au>
References: <20070807141415.525577324@hp.com> <1186663363.6916.393.camel@moss-spartans.epoch.ncsc.mil>
 <200708090929.16906.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Aug 2007, Paul Moore wrote:

> However, I agree that packet labeling is in a "weird" state right now and 
> there is a lot of room for improvement.  Bearing in mind your comments that 
> SECMARK is effectively unused due to lack of demand and that having two types 
> of packet labels is not helpful I wonder if the following would a worthwhile 
> effort:

I think a big factor here is that the OS integration work has not been 
done, and there's a (general) lack of high-level tools for managing 
SELinux.  The functionality, in terms of providing complete coverage of 
the OS, is required.

> 
>  * Do away with internal label concept completely, but leave the SECMARK
>    secid field in the sk_buff struct.  This includes removing the SECMARK
>    related MAC checks on incoming traffic, whether we bring back compat_net
>    or not is not important.

Removing the secmark checks would leave us without a good way to perform 
local network labeling & control.

We should probably schedule compat_net removal per the kernel deprecation 
schedule guidelines.

>  * Convert the external labeling protocols to make use of the SECMARK secid
>    field in the sk_buff struct.  The advantage to NetLabel and explicit
>    labeling protocols is really marginal but this should be a huge win for
>    labeled IPsec.

The way we were discussing this (off-list) was that we'd allow iptables 
secmark labeling to set fallback/default labels, which may be overridden 
by external labeling (Netlabel, IPsec).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
