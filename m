Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97DElWt011145
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 09:14:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97DEk7d025675
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 13:14:46 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h97DEkRn025672 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 13:14:46 GMT
Subject: Re: Problems applying SELinux patch to util-linux-2.11y
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Erlend Aasland <erlend-a@ux.his.no>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>
In-Reply-To: <20031007102943.GA12671@badne3.ux.his.no>
References: <20031007102943.GA12671@badne3.ux.his.no>
Content-Type: text/plain
Message-Id: <1065532472.3919.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 07 Oct 2003 09:14:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 06:29, Erlend Aasland wrote:
> Is this a known problem? Should I apply the patch against a different
> version of util-linux? (I got the util-linux-2.11y source from
> www.kernel.org). 

The patch is applied after the other patches in the RH util-linux
SRPM.   You can get the full SRPM (including the selinux patch) from
http://www.nsa.gov/selinux/SRPMS.  The patch does apply cleanly relative
to the preceding patches in that SRPM.  In particular, it applies
cleanly _after_ applying the util-linux-2.11r-ctty3.patch from that
SRPM. 

> I tried to manually apply the rejected code, and I
> placed the it ca. around line 1250:
> 
> if (childPid) {
> 	...
> 	signal();
> 	signal();
> 	signal();
> 	wait();
> ->	<the rejected code>
> 	PAM_EXIT;
> 	exit();
> }
> 
> Is that correct?

Yes, this looks correct (but PAM_EXIT == PAM_END, right?).

Note that Dan Walsh of RH has developed a pam_selinux session module as
an alternative to patching login at all.  I think that it is included in
his pam SRPM available from
ftp://people.redhat.com/dwalsh/SELinux/srpms.  With that module, you
just add pam_selinux as a session module to login's pam configuration.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
