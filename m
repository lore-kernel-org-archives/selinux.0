Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j35KLpDo012145
	for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2005 16:21:51 -0400 (EDT)
Subject: Re: New Policy Patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <42518C8A.7040200@redhat.com>
References: <41E57081.4090500@redhat.com>
	 <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
	 <42518C8A.7040200@redhat.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 16:20:50 -0400
Message-Id: <1112732450.2367.11.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

I did change the java_macros.te execmem usage to use the allow_execmem
boolean.

On Mon, 2005-04-04 at 14:50 -0400, Daniel J Walsh wrote:
> Major regrouping of apache_policy
> 
> Now use apache_domain and apache_user_domain
> Added boolean httpd_builtin_scripting.   Which when turned off only allows
> running of external apache scripts, not built in modules like PHP.
> Users can now create their own scripts using apache_domain(myscript)
> 
> More fixes of can_network and named_connect
> 
> Added NetworkManager policy.
> 
> A few fixes submitted from Ivan  for hal, kudzu

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
