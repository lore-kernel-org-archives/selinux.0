Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA07211
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 11:42:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA02495
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 16:40:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id QAA02491 for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 16:40:59 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA13213
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 11:41:31 -0500 (EST)
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA06227
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 09:20:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA24769
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 14:19:39 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA24765 for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 14:19:38 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 978F092443
	for <selinux@tycho.nsa.gov>; Sat, 23 Mar 2002 01:20:37 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 0AD99108F
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 15:20:27 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: sub-domains and chroot
Date: Fri, 22 Mar 2002 15:20:26 +0100
MIME-Version: 1.0
Message-Id: <20020322142028.0AD99108F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has any thought been given to the idea of allowing users to create their own 
sub domains?

SE Linux well satisfies the needs of the sys-admin who wants to lock down 
their system.  But what about the non-administrative user who is running 
buggy or potentially malicious code and wants to use different restrictions 
for it?

The first possibility that comes to mind is that I could create user_a_t 
through user_z_t and then the user can do what they like with them, then we 
have SE domains to segregate trusted and untrusted programs in one account 
(with the user deciding which ones are trusted) and the Unix permissions to 
protect accounts from each other.

Another thing I have been thinking of is chroot() environments.  I am 
planning on writing a sample policy to have a sshd inside the chroot which 
gets an automatic transition to chroot_login_t (which has access to setuid, 
setgid, and most things other than killing processes in other domains and 
chroot).  Then from that type executing any program in the chroot causes an 
automatic domain transition to a domain which can't do any network operations 
either.  Then certain programs inside the chroot (such as apache) could 
trigger domain transitions to allow network access.  The problem with this is 
that I would like to limit an apache instance in a chroot to binding to only 
a particular IP address.  Is this possible?  It seems that there are only 
domains defined for eth0, eth1, etc.  I want to limit it to eth0:1...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
