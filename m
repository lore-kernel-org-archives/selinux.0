Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7N35prT015514
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 23:05:52 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7N35nV1017117
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 03:05:50 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: deleting all files in /var/log
Date: Mon, 23 Aug 2004 13:05:47 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040822174424.GE13842@lkcl.net>
In-Reply-To: <20040822174424.GE13842@lkcl.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_L8VKBYSpATqgU/k"
Message-Id: <200408231305.47042.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_L8VKBYSpATqgU/k
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 23 Aug 2004 03:44, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> has anyone tried this?
>
> because i have... and things like /var/log/dmesg cannot be recreated
> under the present selinux policy, which bans initrc_t from write and
> add_name permissions to /var/log.

That's bizarre.  On my machine initrc_t doesn't get any access to 
var_log_t:dir so I wonder how it gets to do anything to the file.

The attached patch fixes it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_L8VKBYSpATqgU/k
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/initrc.te	2004-08-21 13:19:06.000000000 +1000
+++ domains/program/initrc.te	2004-08-23 13:04:33.000000000 +1000
@@ -139,6 +139,7 @@
 
 # Update /var/log/wtmp and /var/log/dmesg.
 allow initrc_t wtmp_t:file { setattr rw_file_perms };
+allow initrc_t var_log_t:dir rw_dir_perms;
 allow initrc_t var_log_t:file { setattr rw_file_perms };
 allow initrc_t lastlog_t:file { setattr rw_file_perms };
 

--Boundary-00=_L8VKBYSpATqgU/k--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
