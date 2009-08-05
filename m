Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n75Lwk99013203
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 17:58:46 -0400
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n75LwIbL026511
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 21:58:18 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>, eparis@redhat.com
Subject: Re: [RFC PATCH v1 1/2] lsm: Add hooks to the TUN driver
Date: Wed, 5 Aug 2009 17:58:38 -0400
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
References: <20090804211304.10798.65601.stgit@flek.lan> <20090804212158.10798.34592.stgit@flek.lan> <20090805141350.GA353@us.ibm.com>
In-Reply-To: <20090805141350.GA353@us.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200908051758.39051.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 05 August 2009 10:13:50 am Serge E. Hallyn wrote:
> Quoting Paul Moore (paul.moore@hp.com):

[NOTE: my email has been out all day due to some mysterious FS issue so my 
apologies for not replying sooner]

...

> The checks before and after this patch are not equivalent.  Post-patch,
> one must always have CAP_NET_ADMIN to do the attach, whereas pre-patch
> you only needed those if current_cred() did not own the tun device.  Is
> that intentional?

Nope, just a goof on my part; I misread the booleans and haven't fully tested 
the patch yet so it slipped out, thanks for catching it.  This brings up a 
good point, would we rather move the TUN owner/group checks into the cap_tun_* 
functions or move the capable() call back into the TUN driver?  The answer 
wasn't clear to me when I was looking at the code before and the uniqueness of 
the TUN driver doesn't help much in this regard.

> Also as Eric said this patch needs to set the cap_ hooks.  This patch
> isn't yet introducing the selinux hooks, so iiuc actually this patch should
> always oops if CONFIG_SECURITY=y.

Yep, another symptom of not enough testing as I mentioned out in the original 
posting, thanks to both of you for pointing this out ... now somebody just 
needs to fix Rawhide so I can actually get a KVM instance running :)

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
