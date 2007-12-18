Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBIE7gZe028156
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 09:07:42 -0500
Received: from mailhub.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBIE7fu5023957
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 14:07:41 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v8 05/18] LSM: Add secctx_to_secid() LSM hook
Date: Tue, 18 Dec 2007 08:44:22 -0500
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com
References: <20071214213548.10069.59135.stgit@flek.lan> <20071214215020.10069.51960.stgit@flek.lan> <Xine.LNX.4.64.0712181925210.19727@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0712181925210.19727@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712180844.23260.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 18 December 2007 3:25:54 am James Morris wrote:
> On Fri, 14 Dec 2007, Paul Moore wrote:
> > Add a secctx_to_secid() LSM hook to go along with the existing
> > secid_to_secctx() LSM hook.  This patch also includes the SELinux
> > implementation for this hook.
>
> Please sign off your patches (especially this one asap, so I can push it
> upstream).

The lack of a sign-off line is actually intentional at this point as I wanted 
to make sure they didn't go anywhere before they were ready.  For instance, 
I've got the changes that were pointed out yesterday on-list as well as a 
handful of IPv6 changes from some IPv6 folks here at HP.

Most of the new peer object class code paths haven't even been tested yet.  I 
realize we can still get fixes/corrections in after -rc1 but I'd like to try 
and minimize that if I can.

I've been operating under the assumption that I've most likely got until the 
end of next week before I need to post "final-ish" version of the patches, 
complete with a signed-off line.  If that isn't the case and you need these 
bits sooner (or now) please let me know.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
