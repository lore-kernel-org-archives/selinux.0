Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4KApXI4008714
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 06:51:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4KApAQj000132
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 10:51:10 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4KAp7xS000127
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 10:51:08 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: grin@tolna.net
Subject: Re: Policy for exim and/ or tiger?
Date: Tue, 20 May 2003 20:49:40 +1000
Cc: selinux@tycho.nsa.gov
References: <200305152349.28038.tk-selinux@datas-world.de> <20030520080652.GW32563@narya.grin.hu>
In-Reply-To: <20030520080652.GW32563@narya.grin.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305202049.40285.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 May 2003 18:06, Peter Gervai wrote:
> Hello,
>
> On Thu, May 15, 2003 at 11:49:26PM +0200, Torsten Knodt wrote:
> > has someone a policy for the exim mta and/ or the tiger script?
>
> I have a still evolving exim policy at
>
> http://narya.grin.hu/selinux/policy/

> # not strictly required
> #file_type_auto_trans(exim_t, etc_t, etc_exim_t)
I would change that comment to "not desired for normal operation".  Allowing 
the mail server to create arbitary files in /etc allows it to prevent 
password changes by using the temporary file names that /bin/passwd uses.  
Allowing it to write to it's own config files means that if someone breaks it 
then they can make sure that whatever they do survives a reboot.

> # Write to /var/spool/mail and /var/spool/mqueue.

Either the above comment is wrong or you are missing a file contexts entry for 
/var/spool/mqueue.  If exim does use /var/spool/mqueue then I recommend that 
you use type mqueue_spool_t for it so that you can convert a Sendmail system 
to Exim without too much pain.

> allow exim_t exim_var_run_t:dir rw_dir_perms;
> allow exim_t exim_var_run_t:file rw_file_perms;

The above should be taken care of by daemon_domain().

> I have policy for pine, I mean, it's something like a policy but looks like
> a horrible rape on selinux for me, since it contains plenty of horrible
> permissions granted. I wonder whether it can be made working without
> these...

For the "fd use" rules in the pine policy, you should probably use "privfd" 
instead of listing getty_t and sshd_t separately.  Otherwise you'll find that 
your policy breaks on rlogin or other services you didn't plan on.

The pine policy has references to user_home_t and user_home_dir_t, these 
prevent it from being used on systems with multiple user roles.

Having a single domain for a program that is run from multiple user domains is 
OK for a domain such as ifconfig_t that is only run from privileged domains.  
It's usable for pppd_t (but even then it becomes painful).  For something 
like pine it just becomes a really bad idea and results in pine having more 
privs not less!

If you add support for multiple user roles into the pine policy then you will 
grant pine the ability to write to different types of file that the calling 
program would not be permitted to write to.  Doing this properly would best 
be done through macros to give a user_pine_t, a staff_pine_t, etc.

What is the aim of the pine policy anyway?  To grant pine some access that 
user_t is not given?  Or to lock down pine because it's got a bad history?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
