Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h88CE0La015714
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2003 08:14:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h88CCNLY020647
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2003 12:12:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h88CCNsG020644
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2003 12:12:23 GMT
Subject: Re: SE Linux packages for SuSE 8.2
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Paul Dwerryhouse <paul@dwerryhouse.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030907125906.GA26580@localhost>
References: <20030907125906.GA26580@localhost>
Content-Type: text/plain
Message-Id: <1063023229.8041.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 08 Sep 2003 08:13:49 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-09-07 at 08:59, Paul Dwerryhouse wrote:
> Hi all,
> 
> I don't know if anyone is interested, but I've built a bunch of RPMs
> of the new 2.4-based SE Linux for SuSE 8.2:
> 
> http://leapster.org/linux/selinux/suse/
> 
> In some cases (checkpolicy, libselinux, policy, policycoreutils and
> selinux-doc), the packages are straight RPM builds of the supplied
> files on the SE Linux download page.
> 
> In others, I've backported the supplied patches so that they cleanly
> compile against the SRPM packages made by SuSE, and in a couple of cases
> have used patches that Colin has posted to the list, too.
> 
> SRPM files are provided also. 
> 
> I haven't yet adjusted the policy files for any differences between
> Redhat & SuSE.

Thanks for working on this.  Carsten Grohmann has previously ported the
older SELinux to SuSE; he maintains a web site at
http://www.securityenhancedlinux.de, so you might want to look at what
he did with respect to policy changes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
