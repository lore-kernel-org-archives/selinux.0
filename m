Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2RBiaYt021185
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 07:44:36 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2RBiVDQ011433
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 11:44:33 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 51230620ED
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 21:44:27 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp.sws.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQDHkBWLgJdA for <selinux@tycho.nsa.gov>;
	Tue, 27 Mar 2007 21:44:27 +1000 (EST)
Received: from nospam.sws.net.au (nospam.sws.net.au [61.95.69.195])
	by smtp.sws.net.au (Postfix) with ESMTP id 21858620E8
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 21:44:27 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id D7F1B182EC
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 21:44:26 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (nospam.sws.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YGiktUjOqMPQ for <selinux@tycho.nsa.gov>;
	Tue, 27 Mar 2007 21:44:26 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 96675182D9
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 21:44:26 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 6B13E2090F
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 21:44:32 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov
Subject: Re: Developer summit minutes
Date: Tue, 27 Mar 2007 10:01:36 +1100
References: <1174931743.3864.204.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1174931743.3864.204.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200703270901.40540.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 27 March 2007 03:55, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On the package management front, the plan in Fedora is still to
> install policy packages from %post and restorecon afterward.  The view
> is that restorecon is needed after install regardless due to files
> created from %post scriptlets.

Of course the %post script would also have to explicitly set the contexts of 
files it creates as no-one else would know what the names might be.  But that 
should work well if the package maintainers keep their lists up to date.

In Debian we currently have PPs selected when the policy is installed based on 
the list of packages that are installed and no automatic changes are made 
afterwards.  Probably the best change we can make is to have tools such as 
apt load PPs before installing packages.  After installing packages apt could 
have a system-wide list of files to relabel that are created by package 
postinst scripts, as well as unconditionally relabelling /etc (which takes 
1.8s on my laptop and probably a lot less time on most machines that are in 
service nowadays).

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
