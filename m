Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4K9xNRb017370
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 05:59:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4K9xKAR007993
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 09:59:20 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
        by jazzband.ncsc.mil  with SMTP id i4K9xJHn007990 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 09:59:20 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 20 May 2004 09:59:19 -0000
Received: from highfield ([192.168.0.223]:33138 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQkNW-00014D-5a
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 10:02:18 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQkHx-0007Oi-MP
	for selinux@tycho.nsa.gov; Thu, 20 May 2004 09:56:33 +0000
Date: Thu, 20 May 2004 09:56:33 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: something up with use of setfiles
Message-ID: <20040520095633.GM24597@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi, i just had to double-checked something, because this is rather odd.

when running make relabel, i'd expect the entire filesystem to be
relabelled, and it isn't: /usr/bin/kdm is not changed from its
context of lkcl_t:object_r:bin_t.

so, well, okay, i figured i'd do a manual setfiles, just like in
/etc/dpkg/postinst.d/setfiles.

okay, here we go, setfiles -q -s
/etc/selinux/file_contexts/file_contexts
it expects input, so type
/usr/bin/kdm
/usr/bin/kdm_greet
/usr/bin/kdm_config
^D

and voila, ls --context /usr/bin/kdm* shows NO CHANGE.
the context is UNCHANGED.

okay, so what about this, let's try...
setfiles -q -s
/etc/selinux/file_contexts/domain/xdm.te
/usr/bin/kdm
/usr/bin/kdm_greet
/usr/bin/kdm_config
^D

check it again... AH HA!

-rwxr-xr-x  root     root     system_u:object_r:xdm_exec_t   kdm
-rwxr-xr-x  root     root     lkcl:object_r:staff_home_dir_t kdm_config
-rwxr-xr-x  root     root     lkcl:object_r:staff_home_dir_t kdm_greet

ta-daa.  double-checking for kdm_config and kdm_greet in xdm.te, of
course, obviously, they're not there, well i can live with that.

okay, so let's have a look at the _contents_ of
file_contexts/file_contexts:

/root/.default_contexts --      system_u:object_r:default_context_t

uhn.... is that right?

i no unnerstand.


okay, taking a look at the /etc/selinux/Makefile, this section:

$(FC): $(FCFILES) domains/program domains/misc file_contexts/program
file_contexts/misc users
	@echo "Building file_contexts ..."
	@m4 $(FCFILES) > $@.tmp
	@grep -v "^/root" $@.tmp > $@.root
	@/usr/sbin/genhomedircon . $@.root  > $@
	@grep "^/root" $@.tmp >> $@
	@-rm $@.tmp $@.root

if i comment out the 2nd grep, i get a complete
file_contexts/file_contexts.

hm...

okedokeeyyy...  what about if i switch off the grep -v in the
first grep and switch on grep -v in the second?

	@grep "^/root" $@.tmp > $@.root
	@/usr/sbin/genhomedircon . $@.root  > $@
	@grep -v "^/root" $@.tmp >> $@
	@-rm $@.tmp $@.root

ah ha!  i get results!  i appear to get a list of err stuff that
looks familiar, but it doesn't have /root/.default_contexts anywhere
in it: is that right?

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
