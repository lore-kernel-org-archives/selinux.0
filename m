Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OGsArT028643
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 12:54:10 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OGrMMZ020050
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 16:53:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: policy patch
Date: Wed, 25 Aug 2004 02:54:04 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
References: <200408241818.40064.russell@coker.com.au> <1093350182.1800.71.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1093350182.1800.71.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sK3KBnXYlJNICyT"
Message-Id: <200408250254.04694.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_sK3KBnXYlJNICyT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 24 Aug 2004 22:23, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Tue, 2004-08-24 at 04:18, Russell Coker wrote:
> > diff1 removes some unnecessary dontaudit lines from syslogd.te, if there
> > is to be one single domain accessing devpts_t:chr_file then syslogd_t is
> > not it, and if a log file gets type unlabeled_t then it's something we
> > want audited.
>
> Both rules were added by Dan, so please coordinate such changes with
> him.  The dontaudit rules for devpts_t:chr_file are for the targeted
> policy, which has no derived types for ptys or ttys; daemon restart will

In that case we should modify the daemon_core_rules() macro to solve it 
properly.  I've attached a patch which should fix this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_sK3KBnXYlJNICyT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/macros/global_macros.te	2004-08-24 16:01:30.000000000 +1000
+++ macros/global_macros.te	2004-08-25 02:52:43.000000000 +1000
@@ -292,6 +292,9 @@
 ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
 ')dnl end if automount.te
+ifdef(`targeted_policy', `
+dontaudit $1_t devpts_t:chr_file { read write };
+')dnl end if targeted_policy
 
 ')dnl end macro daemon_core_rules
 

--Boundary-00=_sK3KBnXYlJNICyT--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
