Received: from jazzdrum.ncsc.mil ([144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j03E88Ii017017
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 09:08:08 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j03E8A6C027326
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 14:08:10 GMT
Subject: Re: modules needed to be compiled in for selinux to work
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050102104530.GG6142@lkcl.net>
References: <20050102104530.GG6142@lkcl.net>
Content-Type: text/plain
Message-Id: <1104760954.16598.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 Jan 2005 09:02:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-01-02 at 05:45, Luke Kenneth Casson Leighton wrote:
> hi,
> 
> debian's 2.6.9 kernel has selinux - and capabilities - as modules.

SELinux cannot be built as a module.  

> in other words, is CONFIG_CAPABILITY=m stopping selinux from
> working in debian's 2.6.9 kernel?

No, it shouldn't be an issue.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
