Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBABkXRb027261
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 06:46:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBABjmlU023141
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 11:45:48 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hBABjVSX023114
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 11:45:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: nagray@austin.rr.com
Subject: Re: Questions: (was Updated Release)
Date: Wed, 10 Dec 2003 22:44:46 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <1070656123.844.16.camel@moss-huskies> <1071023275.4060.685.camel@hawaii.efficax.net>
In-Reply-To: <1071023275.4060.685.camel@hawaii.efficax.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312102244.46741.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 10 Dec 2003 13:27, Nick <nagray@austin.rr.com> wrote:
> 	I have finally caught up with the current version. I downloaded the
> ISOs from a mirror site. And created CDs. The first thing I noticed is

This is apparently a question about a Linux distribution, not about SE Linux.  
As you don't mention which distribution it's not possible to answer the 
question.  In any case this isn't the best list.

> #2
> 	The next thing I noticed was that when I boot up the system tries to
> mount /selinux IAW the entry I put in the fstab (as per the README). But
> the system is giving me an error about it being mounted or in use.

In my Debian package I have /selinux mounted but not umounted, so for Debian 
the thing to do is to use "noauto" in /etc/fstab.  For Fedora the last 
package of Dan's that I tested would umount /selinux so the /etc/fstab needed 
to have "defaults".  It sounds like you were using a Debian package (or 
similar code) and had the /etc/fstab entry that would work for Fedora.

> 	When I log in initially as root I have the staff_r role and staff_t
> domain. I immediately get the context error of trying to access my home
> dir which is  system_u:object_r:sysadm_home_dir_t.

I suggest putting sysadm_r:sysadm_t as the first entry in the local_login_t 
line.  I think that a console login to an administrative account should 
default to the administrative role.

> It seems to me that this dir should be set to
> system_u:object_r:staff_home_dir_t. or system_u:object_r:root_home_dir_t
> so that this isn't a context failure. Another way to do this is set the
> root account to sysadm_r:sysadm_t initially.

I don't think that this is a good idea.  I created staff_r based on user_r to 
be a user role with extra privs.  The idea being that staff_r could be for 
professors and user_r for students, or managers and employees.  So staff_t 
can do all the same things as user_t but be protected from attack by user_t, 
also staff_t can be given privs to kill user_t processes or have other 
controll.  But staff_r does not grant system administration privs.

If staff_t is given write access to /root, and if /root is the home directory 
for the main administrative account then anyone who has staff_r can get 
sysadm_r by creative replacement of .login type files (it's been done on play 
machines).

In the example of an academic environment you don't expect a professor to try 
to hack the university server (although it probably has happened), but you do 
expect professors to choose bad passwords and to type them in while students 
can watch.  Having a professor's account get taken over by students has 
happened at least once to my knowledge (the students told me, I told the 
sys-admin, the sys-admin refused to believe and the students in question kept 
the professor's account).

So in the case of a staff_r non-root account being taken over, if staff_t can 
write to /root without restriction then all that's needed to get full access 
is to transition to UID 0.  SE Linux makes this much more difficult than a 
regular Unix system, but it's still much easier to go from UID > 0 to
UID == 0 than to go from staff_r to sysadm_r.

Speaking of this, it would be useful to have a tool that could check for:
transitions from a domain to another domain with setuid capability or other 
important privs.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
