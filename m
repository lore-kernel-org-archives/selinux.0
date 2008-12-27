Message-ID: <707f057d0812270525t1f6fa095i9ace0cc6e4d3bd6e@mail.gmail.com>
Date: Sat, 27 Dec 2008 21:25:19 +0800
From: "xing li" <lixing.1006@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: Where can i find the source code of Userspace Packages with modifications for SELinux?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_33850_18767367.1230384319611"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_33850_18767367.1230384319611
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello every one,

I known that linux distributions have modify some userspace packages in
order to support selinux,such as:

   - SysVinit - load initial policy
   - pam - set security context for user sessions, preserve security context
   on /etc/shadow, check SELinux permissions
   - util-linux - preserve security contexts on /etc/shadow, check SELinux
   permissions
   - openssh - set security context for user sessions
   - vixie-cron - set security context for cron jobs, check permission
   - at - similar to vixie-cron
   - sudo - set security context
   - shadow-utils - preserve security context on /etc/shadow
   - libuser - preserve security context on /etc/shadow, check permission
   - passwd - preserve security context on /etc/shadow, check permission
   - logrotate - preserve security context on logs
   - coreutils - get and set process and file security contexts
   - findutils - find files with specific security contexts or display them
   - procps - display process contexts
   - psmisc - display process contexts

http://userspace.selinuxproject.org/trac/wiki/Userland
and i am interested how the userspace packages be motified?
and where can i find the relevant the source code of these?

------=_Part_33850_18767367.1230384319611
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello every one,</div>
<div>&nbsp;</div>
<div>I known that linux distributions have modify some userspace packages in order to support selinux,such as:</div>
<ul>
<li>SysVinit - load initial policy 
<li>pam - set security context for user sessions, preserve security context on /etc/shadow, check SELinux permissions 
<li>util-linux - preserve security contexts on /etc/shadow, check SELinux permissions 
<li>openssh - set security context for user sessions 
<li>vixie-cron - set security context for cron jobs, check permission 
<li>at - similar to vixie-cron 
<li>sudo - set security context 
<li>shadow-utils - preserve security context on /etc/shadow 
<li>libuser - preserve security context on /etc/shadow, check permission 
<li>passwd - preserve security context on /etc/shadow, check permission 
<li>logrotate - preserve security context on logs 
<li>coreutils - get and set process and file security contexts 
<li>findutils - find files with specific security contexts or display them 
<li>procps - display process contexts 
<li>psmisc - display process contexts </li></li></li></li></li></li></li></li></li></li></li></li></li></li></li></ul>
<div><a href="http://userspace.selinuxproject.org/trac/wiki/Userland">http://userspace.selinuxproject.org/trac/wiki/Userland</a></div>
<div>and i am interested how the userspace packages be motified? </div>
<div>and where can i find the relevant the source code of these?&nbsp;</div>
<div>&nbsp;</div>

------=_Part_33850_18767367.1230384319611--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
