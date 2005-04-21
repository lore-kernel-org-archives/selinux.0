Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3M05q7C012933
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2005 20:05:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3LNw0VU005609
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2005 23:58:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: New policy for tripwire
Date: Fri, 22 Apr 2005 01:14:33 +1000
Cc: David Hampton <hampton-rh@rainbolthampton.net>, selinux@tycho.nsa.gov
References: <1110671445.7641.16.camel@hampton-pc.rainbolthampton.net>
In-Reply-To: <1110671445.7641.16.camel@hampton-pc.rainbolthampton.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dN8ZCnZjuRWCZpk"
Message-Id: <200504220114.37898.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_dN8ZCnZjuRWCZpk
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 13 March 2005 10:50, David Hampton <hampton-rh@rainbolthampton.net> 
wrote:
> This is written on an FC3 base system using the selinux-policy-strict-
> sources-1.22.1-2 policy from March 11th.  These are the first policies
> I've submitted so I'd appreciate any comments on how to write better
> policies.

Executable types in .fc files should be marked with --.  It makes setfiles run 
faster and also avoids bad policy being written when the executable gets 
replaced with a symlink or something else strange happens.

Labelling a binary in /usr/sbin as bin_t makes no sense.

I don't think that there's any need for so many domains.

Also tripwire domains probably don't make any sense.  If you are serious about 
tripwire then you should boot from removable media to run it.  Anyone who can 
crack a SE Linux system can surely sort out the tripwire database.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_dN8ZCnZjuRWCZpk
Content-Type: text/x-diff;
  charset="utf-8";
  name="tripwire.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tripwire.diff"

--- tripwire.fc.old	2005-04-22 01:10:16.000000000 +1000
+++ tripwire.fc	2005-04-22 01:10:52.000000000 +1000
@@ -1,9 +1,8 @@
 # tripwire
 /etc/tripwire(/.*)?			system_u:object_r:tripwire_etc_t
-/usr/sbin/siggen			system_u:object_r:siggen_exec_t
-/usr/sbin/tripwire			system_u:object_r:tripwire_exec_t
-/usr/sbin/tripwire-setup-keyfiles	system_u:object_r:bin_t
-/usr/sbin/twadmin			system_u:object_r:twadmin_exec_t
-/usr/sbin/twprint			system_u:object_r:twprint_exec_t
+/usr/sbin/siggen		--	system_u:object_r:siggen_exec_t
+/usr/sbin/tripwire		--	system_u:object_r:tripwire_exec_t
+/usr/sbin/twadmin		--	system_u:object_r:twadmin_exec_t
+/usr/sbin/twprint		--	system_u:object_r:twprint_exec_t
 /var/lib/tripwire(/.*)?			system_u:object_r:tripwire_var_lib_t
 /var/lib/tripwire/report(/.*)?		system_u:object_r:tripwire_report_t

--Boundary-00=_dN8ZCnZjuRWCZpk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
