Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j31KStDo015141
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2005 15:28:56 -0500 (EST)
Subject: Re: patch: change var_lib_DOMAIN_t to DOMAIN_var_lib_t
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050330161911.GB5791@thorium.jmh.mhn.de>
References: <20050330161911.GB5791@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 15:28:38 -0500
Message-Id: <1112387318.9437.21.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Wed, 2005-03-30 at 18:19 +0200, Thomas Bleher wrote:
> This patch changes var_lib_DOMAIN_t to DOMAIN_var_lib_t. It adds
> appropriate typealiases, so should be safe. It also adds a few comments
> to macros/global_macros.te and removes user_application_domain() since
> noone is using it.
> 
> Please apply.
> Thomas
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
