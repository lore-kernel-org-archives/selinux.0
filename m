Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1EJaRb006652
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 09:19:36 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1EJZqY005855
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:19:35 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB1EJZ0o005851 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:19:35 GMT
Subject: Re:
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick <nagray@austin.rr.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1070143772.4562.253.camel@hawaii>
References: <1070143772.4562.253.camel@hawaii>
Content-Type: text/plain
Message-Id: <1070288104.12270.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 09:15:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-11-29 at 17:09, Nick wrote:
> I seem to have lost usage of Kudzu (Actually it still runs but cannot
> see the printer on the parallel port) after installing SELinux. Is this
> a known issue? 
> 
> I am running in permissive mode. Any suggestions?

Likely just a kernel configuration issue, i.e. you didn't enable the
driver.  Try using Arjan's 2.6 kernel RPMs from under
http://people.redhat.com/arjanv/2.5.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
