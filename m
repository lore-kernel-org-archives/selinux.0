Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1RLKeRb014270
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 16:20:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1RLKdQQ007285
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 21:20:39 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i1RLKRP0007090 for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 21:20:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   Mario Olimpio de Menezes <mario@curiango.ipen.br>
Subject: Re: accessing files under Linux and SELinux
Date: Sat, 28 Feb 2004 08:19:02 +1100
Cc: SELinux <selinux@tycho.nsa.gov>
References: <20040227143925.GA21866@curiango.ipen.br> <1077894411.26543.46.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1077894411.26543.46.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402280819.02757.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 28 Feb 2004 02:06, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> >   For example, I add a user with uid=gid=1000 to a system and then
> >   assign this user a system_r role. If I try to access /etc/shadow I'll
> >   be denied by the Linux checks and not SELinux checks.
>
> Very few domains have direct access to /etc/shadow in the current
> policy; not even sysadm_t has direct rw access to shadow_t.  But
> sysadm_t can transition to useradd_t via useradd, and useradd_t can
> write to /etc/shadow.

Also sysadm_t can run "vipw".

For most domains removing access to /etc/shadow was a deliberate policy change 
to protect this critical file.  For sysadm_t the removal of access was to 
avoid accidentally relabeling it.  If sysadm_t is granted access to 
replace /etc/shadow then by running "vi /etc/shadow" instead of "vipw -s" the 
administrator could accidentally remove the protection by giving the shadow 
file a label of etc_t!

Now I could have granted sysadm_t read access to shadow_t for a similar result 
(with the added benefit of allowing the administrator to grep it).  However 
in that case the administrator may discover that they can't write the file 
after loading it in their editor, this causes confusion, and may cause a copy 
of the data to be dropped in /etc/shadow.tmp or something similar.

The only problem domain at the moment in regard to shadow_t is radius_t.  Most 
(all?) Unix RADIUS servers by default will read /etc/shadow directly to 
authenticate local users.  All Unix RADIUS servers can be configured to use 
other sources of password data, but having a default policy that doesn't 
support the default operation of the server isn't going to work.  I would 
like to see RADIUS servers re-written such that on PAM systems they will use 
unix_chkpwd and unix_verify for all password access.  A RADIUS server that 
supports PAM will get this by default, but I don't think that PAM is designed 
to be thread-safe so threaded servers won't necessarily work this way.  
Although undocumented the unix_chkpwd interface is easy to use and the RADIUS 
servers could be adjusted to use it (and the interface can be documented).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
