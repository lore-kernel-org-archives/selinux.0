From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: max barwell <maxb@paradise.net.nz>, SELinux@tycho.nsa.gov
Subject: Re: a few questions about selinux
Date: Thu, 10 Jul 2003 14:51:29 +1000
References: <1057807940.1029.2.camel@orac.lite.net.nz>
In-Reply-To: <1057807940.1029.2.camel@orac.lite.net.nz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307101451.29370.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jul 2003 13:32, max barwell wrote:
> I have just started using selinux and find it very interesting, I also
> saw Russel Cokers interview at The Age and was pleased to note that
> selinux is being adopted by the "smarter linux users".

;)

> I notice I get alot of avc denied errors on boot, and wondered if they
> were normal, I have attached my dmesg output, so if someone could please
> look at that.

/etc/ld.so.cache has the wrong type, it's context should be 
system_u:object_r:ld_so_cache_t (it's etc_t on your system).

insmod is being run before /var is mounted (a common occurance, many modules 
may be loaded early in the boot process, and the file system module for the 
/var file system may be a module), in my latest policy tree I have the 
following:
dontaudit insmod_t file_t:dir search;

For mounting the /tmp file system add the following to your policy (I'll add 
it to my tree too):
allow mount_t tmp_t:dir mounton;

Not sure about the route lines, I'll have to look into that.

For ntpdate add the following to your policy (I've just added it to my tree):
allow ntpd_t self:process setsched;

What is ttya0?

For /dev/xconsole the best thing to do is to remove it from /etc/syslog.conf 
and remove it from /etc/init.d/sysklogd.

It looks like you are running a daemon as part of the Razor spam catching 
system.  You need to write a policy for this based on the daemon_domain() 
macro.

For gpm change this:
file_type_auto_trans(gpm_t, device_t, gpmctl_t, fifo_file)
To this:
file_type_auto_trans(gpm_t, device_t, gpmctl_t, { sock_file fifo_file })

miniserv.pl looks like another daemon that needs a policy.

What is atalkd?  It's another daemon that needs policy.

For apache add the following:
tmp_domain(httpd)

Fetchmail needs policy.

/dev/tty3 is not labeled.  At a guess you had a user with context 
user:foo_r:foo_t who logged in on /dev/tty3, then you loaded a new policy 
with no foo_t defined.  NB  The current Debian setup does not have the 
terminal device relabeled on logout, this is something we have to fix.  
However the same bad result would be achieved if you loaded the new policy 
while the user was logged in.

I haven't dealt with cups.  Let's sort out the other things first.  BTW  
Having non-standard device names such as /dev/par1 will cause you pain with 
SE Linux...

> psidfile_init : contexts did not exist, initialisation failed, error 2
>
> and
>
> id: can't get process context
>
> are these serious?

They correspond to errors reported in the dmesg.  Solve the dmesg problems and 
they will go away.

> Also I must have changed something unwittingly, because it worked in the
> beginning, the default context in /etc/security/default_contexts are not
> being honoured, because when sshing into this machine, you still get a
> choice of role, and can change role.

If sshing gives you a choice of role then you must have sshd configured to run 
/bin/login.

> A couple more things, are there policies for apache php modules, and/or
> netatalk, or are these things you have to write yourself. I also can't
> start X, being told a number of things depending on role and user.

There is no policy for netatalk, look to the samba policy for ideas.

php should mostly just work when run via the Apache shared objects.  If you 
run it as a cgi-bin script then there is policy, not sure whether it works.

> As sysadm_r there are errors about xauth and Xauthority being denied,
> and as user_r i get an error about /dev/tty0 not existing.

After most of the errors discussed above are fixed, please tell us about the 
details of these.

Also please CC me on messages related to Debian.  Messages about 
Debian/unstable tend to be delayed on the list as the mailing list software 
thinks that they are unsubscribe requests...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
