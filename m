From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux@tycho.nsa.gov
Subject: Re: root login with enforcing on
Date: Thu, 30 Oct 2003 09:10:10 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310300910.10860.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 25 Oct 2003 06:32, Stephen Smalley wrote:
> On Fri, 2003-10-24 at 15:55, Kratzer, James R. wrote:
> > When I login as root with enforce set to 1, root does not have permission
> > to access the "/root/.bash_profile" file.  What rule should I add to
> > allow root access to that file?  Thanks.
>
> In your case, you are likely looking for something like:
> file_type_auto_trans(staff_t, sysadm_home_dir_t, sysadm_home_t)
> to allow staff_t to fully access /root and make sure that any newly
> created files in /root are placed into sysadm_home_t.

In addition to that other rules would need to be added to allow staff_gpg_t 
and other domains from staff_r to access that directory.

> But in this case, rather than adding rules, I suspect that the right
> solution is changing the types on /root.  With the introduction of the

The issue here is whether staff_r is a slightly priviledged role that can be 
used for regular Unix tasks, or whether it is a cut-down administration role.

With the current policy it is a user role with the possibility of 
transitioning to sysadm_r and it can also see more processes in "ps".  As 
such a user who is authorised for staff_r may not be authorised for sysadm_r 
even if they have the root password.

If /root is given staff_home_dir_t and if the root account is authorised for 
sysadm_r logins at the console (it is by default), then preventing a user 
with UID==0 and staff_r access from getting sysadm_r will be extremely 
difficult.  I don't think that this is a desirable situation.

Also if policy allows staff_r to write to /root then a compromised sshd could 
be used to write to all files under /root, including .bash_login, .ssh/
rc, .ssh/authorized_keys, etc.  This would mean that if sshd is compromised 
then it would not be safe to loggin in at the console to fix it.

I think that the best solution to this issue is to require running newrole 
after logging in as "root" via ssh.

> staff_r role as the default role for administrators (and the only one
> in which they can directly login via ssh), you likely want to just
> change the /root entries in your policy/file_contexts/types.fc file
> to use staff_home_t and staff_home_dir_t instead of sysadm_home*t
> and relabel (or relabel the directory and files via chcon).  This
> requires some other changes to make sure that staff_home*t is properly
> protected against tampering, but this should be done anyway, e.g. the
> conditional in user_macros.te for privhome should also be applied to
> staff, and it isn't clear to me why so many program domains need
> write access to staff_home_dir_t.  But once this has been done,
> staff_home*t should be useable for /root, and sysadm_home*t serves no
> purpose at all.

Many program domains need access to any home directory that is to be used for 
general Unix access (IE reading email, running IRC, etc).  If we consider 
staff_r to be a cut-down version of sysadm_r then we don't want to permit 
such access.

Maybe we should have an extra role, so we have one role for "more privs than 
user_r and ability to newrole to sysadm_r" and another for "less privs than 
sysadm_r and less access to general Unix stuff"?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
