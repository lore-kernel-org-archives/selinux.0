Date: Thu, 9 Aug 2007 08:49:25 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        kaigai@ak.jp.nec.com, joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
In-Reply-To: <200708091048.41932.paul.moore@hp.com>
Message-ID: <Pine.LNX.4.64.0708090846500.7142@us.intercode.com.au>
References: <20070807141415.525577324@hp.com> <200708090929.16906.paul.moore@hp.com>
 <1186667663.6916.464.camel@moss-spartans.epoch.ncsc.mil>
 <200708091048.41932.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Aug 2007, Paul Moore wrote:


> See my comments above about the difference in getpeercon() behavior.  There 
> are also implementation issues regarding the use of iptables, the "flush all" 
> case being a good example.

You need cap_net_admin, so it is technically controllable in terms of 
MAC.

It may also be possible to create a new table which has finer-grained MAC 
controls.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
