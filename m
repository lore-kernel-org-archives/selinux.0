Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FHoNHa018873
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 13:50:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6FHoGH5028211
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:50:16 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6FHoGRX028208 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:50:16 GMT
Subject: Re: another patch for the new release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200307150256.11377.russell@coker.com.au>
References: <200307122201.06936.russell@coker.com.au>
	 <1058200198.13738.652.camel@moss-huskers.epoch.ncsc.mil>
	 <200307150256.11377.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058291404.13738.733.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Jul 2003 13:50:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-07-14 at 12:56, Russell Coker wrote:
> So does this mean that we don't support the idea of changing to a less 
> priviledged role to run untrusted programs?

You can limit the initial login domain (user_t, staff_t, sysadm_t) to a
minimal set of permissions, push many permissions into specific program
domains, and transition to an even less privileged domain for untrusted
programs.  Not clear that staff_t should include any special permissions
other than the ability to transition to sysadm_t, although it presently
has a few privileges.  You wouldn't have staff_t transition to user_t
for running untrusted programs; have it transition to its own derived
domain for that purpose.

> I'm using glibc 2.3.1, is it required to use 2.3.2 to get this to compile 
> correctly?

Yes, I think so.   Reverse the libsecure patch that was posted to the
list a while back if using glibc 2.3.1.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
