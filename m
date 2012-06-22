Message-ID: <1340368816.14703.36.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] SE Android local manifest patch dalvik and lobcore
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, seandroid@tycho.nsa.gov
Date: Fri, 22 Jun 2012 08:40:16 -0400
In-Reply-To: <CAFftDdognt2TCbSjuc2PNmjzhYH4wGYWO+DjaWCcSOCc3Ast8g@mail.gmail.com>
References: 
	<CAFftDdognt2TCbSjuc2PNmjzhYH4wGYWO+DjaWCcSOCc3Ast8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-06-21 at 14:19 -0700, William Roberts wrote:
> If your getting errors on sync that are about dalvik and libcore not
> being found, this patch may help.
> 
> 
> AOSP updated their references for dalvik and libcore to snapshots and
> named them dalvik2 and libcore2.
> 
> 
> remove project was failing in local_manifest for master. Not sure
> about other branches.
> 
> 
> This patch resolves this, not sure if this is the best approach, but
> this patch will help in the interim. 
> 
> 
> make sure you get your local_manifest's from git:
> git clone git://git.selinuxproject.org/~seandroid/manifests

I changed the local manifest files for master to drop dalvik and libcore
altogether, as our changes are now present in AOSP master.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
