Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FF3wx9019309
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 11:03:58 -0400
Received: from ccerelrim01.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FF3vX0021599
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 15:03:57 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
Date: Sat, 15 Jul 2006 11:03:48 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
References: <20060714185739.780700000@flek.zko.hp.com> <20060714185915.270209000@flek.zko.hp.com> <Pine.LNX.4.64.0607142209180.19821@d.namei>
In-Reply-To: <Pine.LNX.4.64.0607142209180.19821@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607151103.49142.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 14 July 2006 10:18 pm, James Morris wrote:
>
> If you're in a permanent cleanup phase, why bother clearing all of these
> global variables and using temporary pointers?
>
> Why not just simply free each entry?  The way this is coded makes it seem
> like you're unsure about the safety of the code.
>
> e.g. what could it possibly matter at this stage whether cipso_v4_cache is
> NULL or not?
>
> I think I asked this some time ago: what are the lifetime rules for this
> code as a loadable module?  What if you arbitrarily rmmod it?
>

The answer to all of your comments in this email is that these appear to be 
fragments from earlier thoughts about trying to make this code a loadable 
module.  Upon further reflection I realized that it probably doesn't make 
much sense to have this code as a module for much of the same reason that 
SELinux isn't setup as a loadable module.

As you have progressed through the patchset I'm sure you've realized by now 
this code is not intended to function as a module.  I'll clean these 
leftovers up for the next version of the patchset.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
