Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2EhgXZ005921
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 09:43:42 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2EgL4G010595
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 14:42:22 GMT
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41879A1B.40103@redhat.com>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>
	 <1099078308.12321.96.camel@moss-lions.epoch.ncsc.mil>
	 <418661C8.8000801@redhat.com> <200411030027.28875.russell@coker.com.au>
	 <41879A1B.40103@redhat.com>
Content-Type: text/plain
Message-Id: <1099406385.31739.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 09:39:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 09:30, Daniel J Walsh wrote:
> ypbind.
> 
> I will add
> 
> allow $1_t self:capability net_bind_service; to ypbind.

Will it work without the permission, e.g. if you just dontaudit the
permission?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
