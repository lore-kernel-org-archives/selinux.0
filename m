Message-ID: <1491248789.24020.8.camel@tycho.nsa.gov>
Subject: Re: ssh/cron access checks and my Play Machine
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Date: Mon, 03 Apr 2017 15:46:29 -0400
In-Reply-To: <201704012359.15451.russell@coker.com.au>
References: <201704012359.15451.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-04-01 at 23:59 +1100, Russell Coker wrote:
> Ever since the earliest days of SE Linux (at least 2001 according to
> my 
> recollection) the cron patches for SE Linux have included a check of
> the 
> context of the crontab file to ensure that the policy specifies that
> it is 
> permitted to have crontab entries to run in the context in
> question.  Such 
> checks were comparable to the checks in crond for a UID match for
> running the 
> job with Unix permissions, but a little more complex because we
> aren't just 
> dealing with UIDs.
> 
> The sshd checks the Unix permissions of ~/.ssh/authorized_keys to
> ensure that 
> only the owner of the account in question and the primary group of
> that 
> account can write to it, ~/.ssh, and ~.  But we don't have similar
> checks for 
> SE Linux permissions.  I really should have thought of this back when
> I was 
> doing a lot of the maintenance for the SE Linux patches for cron and
> sshd.
> 
> To test this, try "chmod 666 ~/.ssh/authorized_keys" and then observe
> that you 
> can't ssh to that account without a password.  Then use chcon to set
> the type 
> of the authorized_keys file to something inappropriate but readable
> by sshd_t 
> (such as user_tmpfs_t or etc_t) or set the identity to something
> other than 
> system_u or the identity of the account in question and observe that
> you can 
> still login without a password.
> 
> During a recent upgrade to my SE Linux Play Machine (or to be more
> specific the 
> Debian/Unstable Play Machine that recently replaced the
> Debian/Jessie 
> instance) the permissions were reset on the home directory of the
> sysadm_r 
> account by a policy upgrade and I didn't notice and set them
> correctly.  This 
> made it theoretically possible for a user_r user to modify the
> authorized_keys 
> file, login to the sysadm_r account, and then totally pwn the system.
> 
> Today I noticed that sshd was taking more memory than usual and
> user_r logins 
> were failing with the error "fatal: monitor_apply_keystate:
> packet_set_state: 
> memory allocation failed".  Only user_r logins were failing because
> only 
> user_r has a memory limit set in /etc/security/limits.conf.  This
> raises the 
> possibility that someone replaced sshd or a library it depends
> on.  I'll make 
> the system image available to anyone who wants to do forensics.  I am
> not 
> certain that the system was compromised at this stage.  But given
> that it 
> could have been compromised and that it was operating in a different
> way to 
> what I expected I think it's most reasonable to assume that it was.
> 
> Some people may wonder why I am posting this on the first of
> April.  Someone 
> sent an April 1st joke to a mailing list that had obfuscinated shell
> code and 
> my usual practice is to login to my Play Machine as user_r to run
> suspect 
> code.  This is what led me to discover the problem.  That said, there
> is 
> evidence that the system might have been running correctly yesterday.
> 
> When running such systems there have been a number of incidents of
> problems 
> discovered.  As long as the end result is improvement of knowledge
> about 
> computer security (both by the person running the system and the
> community) or 
> an improvement in SE Linux to make such attacks more difficult in
> future (which 
> I aim to implement by changes to policy and PAM/sshd code) it can be
> counted 
> as a win for us.  I think that this will end up achieving the aims
> of 
> education and software improvement.  So while it sucks a bit, the end
> result 
> should be positive.

I'm not clear that it is justified or desirable to modify sshd in this
manner.  The case of cron seems fundamentally different; effectively we
had crond emulate the entrypoint check that would have occurred if
crontab files were directly executed, between the context of the cron
job process and crontab file, since a crontab file is in a sense a
script and we perform a domain transition there.  This differs from
sshd using input from authorized_keys, which is already governed by a
MAC check on reading from the file (arguably your policy shouldn't
allow sshd to read other user home types).  sshd checking of DAC file
modes for authorized keys is understandable, given that DAC modes are
subject to user carelessness and to flawed or malicious applications
run by the user.  In contrast, MAC labels can only be changed in
accordance with the policy, which is administratively defined in the
first place; if you can change the label on the file, then chances are
you could do worse things.  And what would sshd check the file label
against?  file_contexts?  If so, then that wouldn't help with your
upgrade scenario.  We certainly don't want to hardcode a context in
sshd or create yet another contexts configuration file to manage.  We
could perform a userspace permission check, but would need to invent a
new class/permission for that purpose (allow sshd_t ssh_home_t:ssh
authorized_keys;), and again that would end up being defined in policy,
so a policy upgrade could just as easily undo it.
