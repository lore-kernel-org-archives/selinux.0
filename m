Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7ENcbFr027134
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 19:38:37 -0400
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7ENcZYW015651
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 23:38:36 GMT
Date: Tue, 14 Aug 2007 16:38:33 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Steve G <linux_4ever@yahoo.com>
cc: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] correct return code in selinux_audit_rule_init
In-Reply-To: <979167.28392.qm@web51509.mail.re2.yahoo.com>
Message-ID: <Pine.LNX.4.64.0708141638070.23663@us.intercode.com.au>
References: <979167.28392.qm@web51509.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 14 Aug 2007, Steve G wrote:

> This patch corrects an error return code to be something user space recognizes.
> 
> Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm


I'll likely push it to Linus in a day or so.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
