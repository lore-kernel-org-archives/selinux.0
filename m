Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1JdPRb009518
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:39:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1JdOqY023831
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:39:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB1JdN0o023828 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:39:23 GMT
Subject: Re: libselinux-3 (reviewed)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031128091911.GA27465@wavehammer.waldi.eu.org>
References: <20031128091911.GA27465@wavehammer.waldi.eu.org>
Content-Type: text/plain
Message-Id: <1070307562.12270.223.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 14:39:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-11-28 at 04:19, Bastian Blank wrote:
> hi folks
> 
> this patch fixes following problems:
> - size_t vs. int, ssize_t
> - unsigned int vs. int
> files: src/*

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
