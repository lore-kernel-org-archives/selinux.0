Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAEJxlRb026881
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 14:59:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAEJxfqY016579
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 19:59:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAEJxe0o016576 for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 19:59:40 GMT
Subject: Re: insmod
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>, Howard Holm <hdholm@epoch.ncsc.mil>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200311050757.54690.russell@coker.com.au>
References: <200311050757.54690.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1068839961.18402.178.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 14 Nov 2003 14:59:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-11-04 at 15:57, Russell Coker wrote:
> So it seems that we need have insmod run in kernel_t and have modprobe run in 
> it's own domain modprobe_t.

There should be no userland entrypoints into kernel_t.  Grant insmod_t
additional permissions if necessary, but keep it separate from kernel_t.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
