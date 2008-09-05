Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m858rbJV020705
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 04:53:37 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m858rbfb028092
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 08:53:37 GMT
Date: Fri, 5 Sep 2008 18:53:11 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v4 03/14] selinux: Fix a problem in
 security_netlbl_sid_to_secattr()
In-Reply-To: <20080903004901.15669.37418.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0809051852460.2526@tundra.namei.org>
References: <20080903003647.15669.45349.stgit@flek.lan> <20080903004901.15669.37418.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Sep 2008, Paul Moore wrote:

> Currently when SELinux fails to allocate memory in
> security_netlbl_sid_to_secattr() the NetLabel LSM domain field is set to
> NULL which triggers the default NetLabel LSM domain mapping which may not
> always be the desired mapping.  This patch fixes this by returning an error
> when the kernel is unable to allocate memory.  This could result in more
> failures on a system with heavy memory pressure but it is the "correct"
> thing to do.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
