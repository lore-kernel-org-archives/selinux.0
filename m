Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1DFiPRb028088
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 10:44:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1DFiNOi028044
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 15:44:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1DFiNWW028041 for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 15:44:23 GMT
Subject: Re: 2.4-based SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Miguel Bolanos <mike@linuxlabs.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1076438424.3450.7.camel@pyro>
References: <1076427867.5910.162.camel@moss-spartans.epoch.ncsc.mil>
	 <1076438424.3450.7.camel@pyro>
Content-Type: text/plain
Message-Id: <1076687053.10189.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 13 Feb 2004 10:44:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-02-10 at 13:40, Miguel Bolanos wrote:
> Sure Compatibility is now an issue, but i do believe there is still
> several people out whom will want to keep 2.4 for a while, that includes
> myself.
> If the 2.4-based SELinux is going to be maintained by people outside
> NSA, I would like to contribute with the team doing this work.

Just to clarify, we don't mind updating the 2.4-based SELinux for newer
base kernels for a little bit (e.g. until 2.4.26), but we don't plan on
back porting changes to it from the 2.6-based SELinux any longer.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
