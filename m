Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91DuLsJ025149
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 09:56:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h91DsXZt001176
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:54:33 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h91DsXM3001173
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:54:33 GMT
Subject: Re: file_labels_t
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1064984367.1511.30.camel@chris.pebenito.net>
References: <1064984367.1511.30.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1065016578.350.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 01 Oct 2003 09:56:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-01 at 00:59, Chris PeBenito wrote:
> I was doing some cleaning (goodbye devfsd.{te.fc}), and I was thinking
> that file_labels_t could be removed in new api policy, since psid is
> gone.  However, when I was going through looking for the rules that had
> it, I realized that it is still an initial sid.  Why is the initial sid
> still around if psid is gone?  Because it requires a bit of a kernel
> modification?

You can remove the type, and just map the initial SID to unlabeled_t
until we get around to cleaning up the initial SIDs.  Cleaning up the
initial SIDs does presently require rebuilding the kernel module with
updated headers so that it reflects the current values of the subsequent
initial SIDs, which will be perturbed by the removal of earlier initial
SIDs, so we would likely increment the policy version number at that
point.  The initial SID support needs to be reworked to support more
dynamic removal and extension; we originally expected the initial SIDs
to be very static, but that doesn't really seem to be the case.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
