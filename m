Subject: Re: Selinux checkpolicy parse error
From: Christopher Warner <chris@servertogo.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, cwarner@kernelcode.com
In-Reply-To: <1112115616.4339.103.camel@moss-spartans.epoch.ncsc.mil>
References: <1112098232.21770.70.camel@jasmine>
	 <1112115616.4339.103.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 09:58:49 -0500
Message-Id: <1112108330.21058.82.camel@jasmine>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-29 at 12:00 -0500, Stephen Smalley wrote:
> This sounds familiar, looks like the thread starting at
> http://marc.theaimsgroup.com/?l=selinux&m=109338670806273&w=2
> As far as I could see, it was a bug in the scanner produced by the
> person's version of flex, not a bug in the checkpolicy sources.  And I
> couldn't reproduce it on Fedora.

It seems that flex is the problem. Somewhere in the flex series of
patches for redhat/fedora lies a fix for this problem (this in version
2.5.4). Going through the spec file doesn't necessarily give any direct
info, changelogs are sparse. I'll try to find the the right combo of
patch and update here with whatever works.. Thanks again for the help.

Christopher Warner


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
