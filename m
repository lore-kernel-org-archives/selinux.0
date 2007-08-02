Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7205Kvo009119
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 20:05:20 -0400
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7205Jxj022093
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 00:05:19 GMT
Date: Wed, 1 Aug 2007 17:05:16 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] NET: fix memory leaks from security_secid_to_secctx()
In-Reply-To: <20070801151557.264877461@hp.com>
Message-ID: <Pine.LNX.4.64.0708011705020.29184@us.intercode.com.au>
References: <20070801151257.475951538@hp.com> <20070801151557.264877461@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Both patches applied to:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
