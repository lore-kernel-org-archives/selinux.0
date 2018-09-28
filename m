Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8S920sx020562
 for <selinux@tycho.nsa.gov>; Fri, 28 Sep 2018 05:02:00 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
 by mail.us.es (Postfix) with ESMTP id 37DFE47C43
 for <selinux@tycho.nsa.gov>; Fri, 28 Sep 2018 11:01:23 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
 by antivirus1-rhel7.int (Postfix) with ESMTP id 28366DA87C
 for <selinux@tycho.nsa.gov>; Fri, 28 Sep 2018 11:01:23 +0200 (CEST)
Date: Fri, 28 Sep 2018 11:01:19 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
 jmorris@namei.org, serge@hallyn.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Message-ID: <20180928090119.mc5rys63kto5jmic@salvia>
References: <20180923182616.11398-1-cgzones@googlemail.com>
 <20180923182616.11398-2-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180923182616.11398-2-cgzones@googlemail.com>
Subject: Re: [PATCH v3 2/2] netfilter: nf_tables: add requirements
 for connsecmark support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Sep 23, 2018 at 08:26:16PM +0200, Christian Göttsche wrote:
> Add ability to set the connection tracking secmark value.
> 
> Add ability to set the meta secmark value.

Also applied, thanks.
