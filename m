Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBHEuhIi002251
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 09:56:52 -0500 (EST)
Received: from hawaii.grays-systems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBHEujiS020706
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 14:56:46 GMT
Received: (from nick@localhost)
	by hawaii.grays-systems.com (8.13.1/8.13.1/Submit) id iBHEuk5r015655
	for selinux@tycho.nsa.gov; Fri, 17 Dec 2004 08:56:46 -0600
Subject: Re: Tomcat policy
From: Nick Gray <nick-lists@austin.rr.com>
To: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1103229973.1463.145.camel@moss-spartans.epoch.ncsc.mil>
References: <1103224127.32688.49.camel@hawaii.grays-systems.com>
	 <1103229973.1463.145.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 17 Dec 2004 08:56:45 -0600
Message-Id: <1103295405.32688.80.camel@hawaii.grays-systems.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-16 at 15:46 -0500, Stephen Smalley wrote:
> On Thu, 2004-12-16 at 14:08, Nick Gray wrote:
> > So why can't I use tomcat_t to label directories?
> 
> Because you have defined it as a domain, not a file type.  Domains are
> for processes, and are also applied to the /proc/pid entries of that
> process.  You aren't supposed to use them for other files, and the
> filesystem associate permission check enforces the restriction.
> 
> You do need to label the entrypoint program for the daemon with
> tomcat_exec_t.

This was done, I just didn't spell it out.

tomcat_exec_t would be for the actual executable binaries right. I am
talking about a default label for the entire directory structure
starting with /usr/local/tomcat/. That in the strict policy would keep
all other users out of this subdirectory.

> 
> > I think I understand how to protect the daemon from the system, how do I
> > protect the system from the daemon.
> 
> Under targeted policy, the "system" (i.e. unconfined processes) can do
> whatever it wants to the daemon. 

So basically, your saying I haven't even done what I thought I did. That
if I create a user, by default he will be unconfined and can get into
the labeled tomcat directories depending on the unix permissions?

>  By defining a domain for tomcat, you
> are merely controlling what it can do to the system, 

Sounds like you are telling me that the tomcat daemon can't access types
outside its domain such as unconfined_t.

> and isolating it
> from other confined domains.

This makes sense since tomcat_t shouldn't be able to access httpd_t

>   The daemon (if you have set it up properly
> to run in the tomcat_t domain) can only do what you allow tomcat_t to do
> in the policy, nothing else.

the tomcat (jsvc) application is running as user_u:system_r:tomcat_t. 


> Simply don't allow tomcat_t access to passwd_t.

This isn't a very robust solution since this is one case in point. It
seems to (I'm sure you'll correct me on this point) that the optimum
solution is to add the tomcat user to the user.te file with a role like
user_r and or creating a tomcat_r and giving it access only to the
tomcat domain.

By doing the above, would'nt we have accomplished (in the most efficient
manner) the securing of the tomcat daemon. If a buffer overflow happens
which gives the tomcat user (by virtue of the user that the daemon is
running as) root access, the tomcat user is restricted to the tomcat
domain and prevent from doing much more than creating logs
in /usr/local/tomcat/.../logs, as per the policy!




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
