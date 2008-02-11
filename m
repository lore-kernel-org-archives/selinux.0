Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1BB0QTh006076
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2008 06:00:26 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1BB0Pkt010306
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2008 11:00:25 GMT
Date: Mon, 11 Feb 2008 21:59:07 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Trond.Myklebust@netapp.com, chuck.lever@oracle.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/37] Security: Add a kernel_service object class to
 SELinux
In-Reply-To: <20080208165240.15902.64781.stgit@warthog.procyon.org.uk>
Message-ID: <Xine.LNX.4.64.0802112157590.27028@us.intercode.com.au>
References: <20080208165156.15902.62457.stgit@warthog.procyon.org.uk>
 <20080208165240.15902.64781.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Feb 2008, David Howells wrote:

> +++ b/security/selinux/include/flask.h
> @@ -51,6 +51,7 @@
>  #define SECCLASS_DCCP_SOCKET                             60
>  #define SECCLASS_MEMPROTECT                              61
>  #define SECCLASS_PEER                                    68
> +#define SECCLASS_KERNEL_SERVICE                          69

I just pushed a patch to Linus from Stephen which uses this class number; 
you'll likely need to bump it to 70.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
