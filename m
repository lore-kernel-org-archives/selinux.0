Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KDmSrT003970
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 09:48:28 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KDmRQ4026517
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 13:48:27 GMT
Subject: RE: policy for scponly - need help
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Richard Simpson <richard.simpson@wgint.com>
Cc: Stefan SF <stefan@sf-net.com>, selinux@tycho.nsa.gov
In-Reply-To: <BJENLMGHDPAAAGKKPOFOGEMHCEAA.richard.simpson@wgint.com>
References: <BJENLMGHDPAAAGKKPOFOGEMHCEAA.richard.simpson@wgint.com>
Content-Type: text/plain
Message-Id: <1093009633.16585.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 20 Aug 2004 09:47:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-20 at 09:16, Richard Simpson wrote:
> Hello-
> 
> I'm just a newbie at this, but it looks like a term is missing from your
> last 'allow' statement. Perhaps it should be:
> 
> allow user_t self:capability { dac_override dac_read_search };

You don't want to give user_t those capabilities.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
