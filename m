Date: Tue, 23 Sep 2008 23:21:58 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul.moore@hp.com>
Subject: Re: [RFC][PATCH] selinux:  use default proc sid on symlinks
In-Reply-To: <1222112479.18735.85.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <alpine.LRH.1.10.0809232321390.28321@tundra.namei.org>
References: <1222112479.18735.85.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 Sep 2008, Stephen Smalley wrote:

> Patch below for the recent /proc/net bug related to selinux thread on linux-kernel.
> If this looks sane, then possibly it should be re-sent on that thread.
> 
> As we are not concerned with fine-grained control over reading of
> symlinks in proc, always use the default proc SID for all proc symlinks.
> This should help avoid permission issues upon changes to the proc tree
> as in the /proc/net -> /proc/self/net example.
> This does not alter labeling of symlinks within /proc/pid directories.
> ls -Zd /proc/net output before and after the patch should show the difference.

I'm not seeing any difference.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
