From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: kayo <kayo@pyra.ca>
Subject: Re: spasswd.c
Date: Mon, 17 Feb 2003 22:09:19 +0100
Cc: SELinux@tycho.nsa.gov
References: <DTCOIKAKKNB3NWCMMKNXKJCDHTEAEFP3JRHWOJAF@ziplip.com> <200302162251.40417.russell@coker.com.au> <1045507488.3079.5.camel@smeagol>
In-Reply-To: <1045507488.3079.5.camel@smeagol>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302172209.19215.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Feb 2003 19:44, kayo wrote:
> Your little play machine rocks, but in my insomnia one night i will find
[...]
> i would like to see what you did and why and how

What I did was not particularly difficult by today's standards.  When I first 
put a SE play machine online it took significant effort and triggered some 
new developments in SE policy and utilities.  But now it's pretty much all 
merged.  Below is the only noteworthy policy change that I made against MY SE 
Linux policy tree for the play machine.  The NSA tree is slightly different, 
but I believe that all the changes that I've made recently are being accepted 
for the next NSA release.

So as of the next NSA release the policy difference between my SE play machine 
and a regular production server will be one line, and that line isn't really 
required.

Of course it's strongly recommended that you don't provide root access to 
hostile users on serious servers.  But the play machine is a good 
demonstration that you can fully rely on SE permissions.

diff -ru /usr/share/selinux/policy/default/macros/user_macros.te 
/usr/share/selinux/policy/current/macros/user_macros.te
--- /usr/share/selinux/policy/default/macros/user_macros.te     2003-02-16 
00:57:04.000000000 +0100
+++ /usr/share/selinux/policy/current/macros/user_macros.te     2003-02-17 
14:54:36.000000000 +0100
@@ -15,7 +15,7 @@
 undefine(`user_domain')
 define(`user_domain',`
 # Use capabilities
-allow $1_t self:capability { setgid chown fowner };
+dontaudit $1_t self:capability { setgid chown fowner };
 dontaudit $1_t self:capability { sys_nice fsetid };

 # Type for home directory.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
