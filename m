Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hATAmFRb029908
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 05:48:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hATAlbp5025514
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 10:47:37 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hATAlat0025511
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 10:47:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Petre Rodan <petre.rodan@ravantivirus.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: policies for DJ Bernstein tools
Date: Sat, 29 Nov 2003 21:47:58 +1100
References: <20031128164612.GA32668@peter.rav.local>
In-Reply-To: <20031128164612.GA32668@peter.rav.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311292147.58963.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 29 Nov 2003 03:46, Petre Rodan <petre.rodan@ravantivirus.com> wrote:
> I have searched for selinux policies for daemontools, ucspi-tcp, publicfile
> and clockspeed. Failing to find them ment that I shoud try to create them.
> I'm not an expert in these matters, but I'm more than willing to try to
> become one ;)

I have added your changes to qmail.te and qmail.fc to my tree, it'll be on my 
site in a few minutes.  I have modified them slightly so you will want to 
check that they still do what you require.  I removed the user_home_t label 
for the qmail alias directory as I don't think that's an appropriate type.  
Maybe etc_qmail_t will work.

What is clockspeed?

I don't think that we want mua in it's current form.  It doesn't support 
running a mua from a console login.  It allows entering mua_t from staff_t 
and sysadm_t and allows writing to a pty from either.  This means that if you 
can exploit the mua program (changing the $EDITOR variable appropriately 
should do it) then someone as staff_r can read/write to the pty of sysadm_t, 
this permits them to take over a sysadm_t session by inserting key strokes in 
the buffer.

Any time you have a single domain that can talk to the pty's from multiple 
roles then it could be exploited to do some damage.  Currently we only allow 
this for newrole_t, system_chkpwd_t, and passwd_t (all of which can break the 
system entirely if they are exploited regardless of what we do).

What is publicfile?  Some sort of ftp-like service?

For the ucspi-tcp service, why does it have so much access to qmail files and 
programs?  Why not just domain_auto_trans() to the appropriate qmail 
domain(s)?

Also isn't ucspi-tcp is conceptually another version of inetd?  If that is a 
currect summary then perhaps the correct solution would be to macroise the 
inetd policy to support multiple versions of inetd and consider ucspi-tcp 
just another version of inetd (with a different set of ports that it is 
permitted to bind to).

What is svc?


Finally it would make things a little easier to manage if you used the macros 
more.  For example this:
allow svc_t svc_svc_t:dir { add_name read remove_name search getattr write };
Could be changed to this:
allow svc_t svc_svc_t:dir rw_dir_perms;

Using the macro makes it much easier to read the policy.  In this example the 
macro also adds ioctl and lock access, but I don't think that this does any 
harm with all the access that is already granted.  Similarly using can_exec() 
makes things easier to read.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
