Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2GUwRb015960
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 11:30:58 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB2GUvqY003366
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 16:30:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB2GUu0o003363 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 16:30:56 GMT
Subject: Re: What causes this??
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: nagray@austin.rr.com
Cc: Russell Coker <russell@coker.com.au>, nagray@bruzenak.com,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1070376464.13070.127.camel@hawaii>
References: <1070340338.12612.2.camel@hawaii>
	 <200312021549.34383.russell@coker.com.au>
	 <1070376464.13070.127.camel@hawaii>
Content-Type: text/plain
Message-Id: <1070382538.14253.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Dec 2003 11:28:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-12-02 at 09:47, Nick wrote:
> id -c 
> system_u:system_r:sysadm_t

This implies that you aren't running the patched login program (or,
alternatively, using the pam_selinux module).  Note that the user
identity portion of the context wasn't set, which is why newrole is
confused.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
