Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v31CxwYi020385
 for <selinux@tycho.nsa.gov>; Sat, 1 Apr 2017 08:59:58 -0400
Received: from www.coker.com.au (ppp118-209-81-26.bras1.mel11.internode.on.net
 [118.209.81.26])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: russell@coker.com.au)
 by smtp.sws.net.au (Postfix) with ESMTPSA id A2447EC63
 for <selinux@tycho.nsa.gov>; Sat,  1 Apr 2017 23:59:30 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: ssh/cron access checks and my Play Machine
Date: Sat, 1 Apr 2017 23:59:15 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201704012359.15451.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ever since the earliest days of SE Linux (at least 2001 according to my 
recollection) the cron patches for SE Linux have included a check of the 
context of the crontab file to ensure that the policy specifies that it is 
permitted to have crontab entries to run in the context in question.  Such 
checks were comparable to the checks in crond for a UID match for running the 
job with Unix permissions, but a little more complex because we aren't just 
dealing with UIDs.

The sshd checks the Unix permissions of ~/.ssh/authorized_keys to ensure that 
only the owner of the account in question and the primary group of that 
account can write to it, ~/.ssh, and ~.  But we don't have similar checks for 
SE Linux permissions.  I really should have thought of this back when I was 
doing a lot of the maintenance for the SE Linux patches for cron and sshd.

To test this, try "chmod 666 ~/.ssh/authorized_keys" and then observe that you 
can't ssh to that account without a password.  Then use chcon to set the type 
of the authorized_keys file to something inappropriate but readable by sshd_t 
(such as user_tmpfs_t or etc_t) or set the identity to something other than 
system_u or the identity of the account in question and observe that you can 
still login without a password.

During a recent upgrade to my SE Linux Play Machine (or to be more specific the 
Debian/Unstable Play Machine that recently replaced the Debian/Jessie 
instance) the permissions were reset on the home directory of the sysadm_r 
account by a policy upgrade and I didn't notice and set them correctly.  This 
made it theoretically possible for a user_r user to modify the authorized_keys 
file, login to the sysadm_r account, and then totally pwn the system.

Today I noticed that sshd was taking more memory than usual and user_r logins 
were failing with the error "fatal: monitor_apply_keystate: packet_set_state: 
memory allocation failed".  Only user_r logins were failing because only 
user_r has a memory limit set in /etc/security/limits.conf.  This raises the 
possibility that someone replaced sshd or a library it depends on.  I'll make 
the system image available to anyone who wants to do forensics.  I am not 
certain that the system was compromised at this stage.  But given that it 
could have been compromised and that it was operating in a different way to 
what I expected I think it's most reasonable to assume that it was.

Some people may wonder why I am posting this on the first of April.  Someone 
sent an April 1st joke to a mailing list that had obfuscinated shell code and 
my usual practice is to login to my Play Machine as user_r to run suspect 
code.  This is what led me to discover the problem.  That said, there is 
evidence that the system might have been running correctly yesterday.

When running such systems there have been a number of incidents of problems 
discovered.  As long as the end result is improvement of knowledge about 
computer security (both by the person running the system and the community) or 
an improvement in SE Linux to make such attacks more difficult in future (which 
I aim to implement by changes to policy and PAM/sshd code) it can be counted 
as a win for us.  I think that this will end up achieving the aims of 
education and software improvement.  So while it sucks a bit, the end result 
should be positive.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
