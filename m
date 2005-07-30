Date: Sat, 30 Jul 2005 00:20:00 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
In-Reply-To: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Lynx.SEL.4.62.0507300018460.14594@thoron.boston.redhat.com>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279723856-1316313081-1122697200=:14594"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279723856-1316313081-1122697200=:14594
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

The checkpolicy stuff doesn't compile for me:

$ make
cc -g -Wall -O2 -pipe -fno-strict-aliasing -I. -I/usr/include -o 
checkpolicy.o -c checkpolicy.c
checkpolicy.c: In function ‘cond_check_type_rules_list’:
checkpolicy.c:288: error: ‘avtab_key_t’ has no member named 
‘specified’
checkpolicy.c:289: error: too few arguments to function ‘avtab_search’
checkpolicy.c: In function ‘main’:
checkpolicy.c:587: error: too few arguments to function 
‘check_assertions’
make: *** [checkpolicy.o] Error 1



-- 
James Morris
<jmorris@redhat.com>

--279723856-1316313081-1122697200=:14594--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
