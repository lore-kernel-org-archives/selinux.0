From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: max barwell <maxb@paradise.net.nz>, SElinux list <SELinux@tycho.nsa.gov>
Subject: Re: a few questions about selinux, update on progress
Date: Tue, 15 Jul 2003 00:28:51 +1000
References: <1057807940.1029.2.camel@orac.lite.net.nz> <200307101451.29370.russell@coker.com.au> <1058168071.500.50.camel@orac.lite.net.nz>
In-Reply-To: <1058168071.500.50.camel@orac.lite.net.nz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307150028.52006.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Jul 2003 17:34, max barwell wrote:
> > It looks like you are running a daemon as part of the Razor spam catching
> > system.  You need to write a policy for this based on the daemon_domain()
> > macro.
>
> I was using razor, but I ditched it, I am using spamassassin, this gives
> me errors, and then get errors relating to procmail, I think this is
> because procmail is called from the spamassassin config, not sure
> though, because procmail does have a policy loaded.

It seems that you have spamassasin running as a daemon.  You need to write 
policy for it as discussed in my previous message, and grant it access to the 
user home directories too.

> > What is atalkd?  It's another daemon that needs policy.
>
> atalkd is the apple talk daemon, run by netatalk, as you mention further
> on I need to write a policy for netatalk.

OK.  It sounds like the smbd/nmbd type of operation that Samba uses.

> > I haven't dealt with cups.  Let's sort out the other things first.  BTW
> > Having non-standard device names such as /dev/par1 will cause you pain
> > with SE Linux...
>
> Yes I see cups is still a problem, unfortunately I need cups for my
> printer, a canon i320, I had to use the turboprint drivers to get this
> going, perhaps turboprint made the /dev/par1 devices, I am using a
> standard Debian sid install otherwise.

OK.  Edit lpd.fc to have /dev/par1 get type printer_t.

> > > Also I must have changed something unwittingly, because it worked in
> > > the beginning, the default context in /etc/security/default_contexts
> > > are not being honoured, because when sshing into this machine, you
> > > still get a choice of role, and can change role.
> >
> > If sshing gives you a choice of role then you must have sshd configured
> > to run /bin/login.
>
> no ssh is set /bin/false, so at a loss for this one

What do you mean by that?

> Ok now for my new problems, these are regarding users, if you have
> existing users do they have to have anything done to them, I added one
> of them to /etc/selinux/users because I wanted to specify multiple
> roles, but that's all I've done.

With the current setup if you don't add a user to the "users" file then they 
will be unable to change their password.  This can be a good or bad thing 
depending on your requirements.  ;)

> I tried to add a new user, suseradd jdoe, will add this user, but when I
> do sadminpasswd jdoe, it says
>
> passwd: Module is unknown
> Child returned an error.
>
> and these are the errors in /var/log/messages
>
> Jul 14 18:02:15 orac kernel:
> Jul 14 18:02:15 orac kernel: avc:  denied  { read } for  pid=768
> exe=/usr/bin/passwd path=/self dev=00:02 ino=2
> scontext=maxb:sysadm_r:sysadm_passwd_t tcontext=system_u:object_r:proc_t
> tclass=lnk_file

Normally it won't even have search access to proc_t:dir (/proc), so it can't 
access /proc/self.  Therefore the fact that it can get to /proc/self 
indicates that you are running in permissive mode, in which case SE Linux 
won't stop it from working.

The "Module is unknown" error seems to suggest a PAM configuration error.

> I have also attached my a new dmesg, which has alot less errors than the
> last time.

It seems that there is a Perl daemon running at boot which needs policy, is 
that part of Spamassasin?

For cups add the following rule:
allow cupsd_t sysctl_dev_t:file { getattr read };
Then change the type of /dev/par1 as discussed.

As for /dev/ttyS0, I am not sure whether we want to grant cups access to 
tty_device_t or change the type of the device node to printer_t.  
Suggestions?

You have su being run from an init.d script, this is a broken script.  Maybe 
it's an old version of Postgresql.

> I have set up alot of things using Linux before, ldap, samba, web
> servers, proxies etc, but am finding selinux about 1000 times more
> challenging, with most things you can generally find answers on the web,
> newsgroups etc, but I guess the small user base of selinux makes this
> different.

Speaking for myself I found SE Linux to be easier to get started with than 
Sendmail configuration, general Unix administration, Unix systems 
programming, ISP administration, and lots of other things I've done.

As you correctly note there are some issues related to the small user-base.  
Part of which is that there is not yet a complete SE distribution.

I think that once we get bootable CDs containing SE Linux and only packages of 
software that have SE policy then things will become a lot easier.

Also another issue is that as SE Linux is still relatively new there are a 
number of issues to be ironed out with applications.  Many applications have 
bugs which comprise minor security, reliability, or functionality issues on 
non-SE systems but which no-one has really noticed.  With SE Linux we force 
applications to perform only a specified set of operations, applications 
which do strange and unusual things may not work correctly with any sane 
policy and need to be fixed.

I have filed bug reports against many such applications and got them fixed.  
Things are improving, but there is still a long way to go.  We will only get 
there by having enough users so that it's likely that someone else will 
report the bug and get it fixed before it hits you.

One example of such bugs is programs that create a file in /tmp and then mv it 
to /etc or another directory.  This is a potential risk to the reliability of 
the system when /tmp is on a different file system, and also may have 
security issues if it does not correctly check to make sure that there's no 
race conditions, so is a bad thing to do in any case.  In SE Linux such an 
application may result in incorrectly labeled files under /etc and a lack of 
functionality.

This is a real pain for us now.  But when such bugs are fixed everyone will 
benefit.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
