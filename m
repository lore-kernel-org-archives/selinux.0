Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9UIwdOS020337
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 13:58:39 -0500
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9UIvmZZ016563
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 18:57:49 GMT
Date: Mon, 30 Oct 2006 13:58:35 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@redhat.com,
        sds@epoch.ncsc.mil, eparis@redhat.com
Subject: Re: [patch 1/1] NetLabel: protect the CIPSOv4 socket option from
 setsockopt()
In-Reply-To: <20061030180801.641867000@hp.com>
Message-ID: <Pine.LNX.4.64.0610301357590.8348@d.namei>
References: <20061030180331.404950000@hp.com> <20061030180801.641867000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Oct 2006, paul.moore@hp.com wrote:

> From: Paul Moore <paul.moore@hp.com>
> 
> This patch makes two changes to protect applications from either removing or
> tampering with the CIPSOv4 IP option on a socket. 

Thanks.  Applied to:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-net-2.6.git




-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
