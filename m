Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NKgmrT021218
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 16:42:48 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NKg2AS029696
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 20:42:03 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id B797ABF8A
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 21:42:46 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 25198-05 for <selinux@tycho.nsa.gov>;
	Mon, 23 Aug 2004 21:42:44 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 4755FBF88
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 21:42:44 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzLpM-0003Tz-8J
	for selinux@tycho.nsa.gov; Mon, 23 Aug 2004 21:54:04 +0100
Date: Mon, 23 Aug 2004 21:54:04 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: kde 3.3's kdm creating /var/run/xdmctl
Message-ID: <20040823205404.GC7540@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

this is a bit of an issue.

if /var/run/xdmctl gets accidentally deleted, kde sessions will not be
able to do a shutdown or restart from the logout menu.

the reason is because xdm_t doesn't have permission to recreate
the /var/run/xdmctl directory.

the suggestion of doing touch /var/run/xdmctl/.keep will simply
stop kdm from rm'ing /var/run/xdmctl, but if the directory
ever happens to _successfully_ be deleted (permissive mode
for example) ...

also i find that on creation of this directory, its permission
is set to var_run_t not xdm_var_run_t.

i'm not entirely sure what to do.

at the moment as a preliminary measure i've added permissions
for xdm_t to create, access and delete sockets in both var_run_t
_and_ xdm_var_run_t in order to deal with the mess.

help? 

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
