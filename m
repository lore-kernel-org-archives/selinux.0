Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KAOJRb017436
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 06:24:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KALrB2012897
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 10:21:53 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
	by jazzswing.ncsc.mil  with SMTP id i4KALqwi012894
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 10:21:52 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 20 May 2004 10:24:15 -0000
Received: from highfield ([192.168.0.223]:33142 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQkle-00015I-3c
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 10:27:14 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQkgE-000565-6k
	for selinux@tycho.nsa.gov; Thu, 20 May 2004 10:21:38 +0000
Date: Thu, 20 May 2004 10:21:37 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: something up with use of setfiles
Message-ID: <20040520102137.GN24597@lkcl.net>
References: <20040520095633.GM24597@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040520095633.GM24597@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, i tracked the problem down, it is my fault.

the genhomedircon script was out-of-date, and instead of
sorting out macros and instead of outputting to stdout
it changed file_contexts in-place.

why was genhomedircon out-of-date?  because it wasn't
updated from the .deb i built.

why was that?  because i didn't actually examine very
carefully the debian packing .diff i had found.

oops.

so, it's fine: i manually installed genhomedircon (and setfiles
for good luck)

_now_ i have a chance of having a working system.

l.

p.s. don't try this at home.

On Thu, May 20, 2004 at 09:56:33AM +0000, Luke Kenneth Casson Leighton wrote:
> hi, i just had to double-checked something, because this is rather odd.
> 
> when running make relabel, i'd expect the entire filesystem to be
> relabelled, and it isn't: /usr/bin/kdm is not changed from its
> context of lkcl_t:object_r:bin_t.
> 
> so, well, okay, i figured i'd do a manual setfiles, just like in
> /etc/dpkg/postinst.d/setfiles.
> 
> okay, here we go, setfiles -q -s
> /etc/selinux/file_contexts/file_contexts
> it expects input, so type
> /usr/bin/kdm
> /usr/bin/kdm_greet
> /usr/bin/kdm_config
> ^D
> 
> and voila, ls --context /usr/bin/kdm* shows NO CHANGE.
> the context is UNCHANGED.
> 
> okay, so what about this, let's try...
> setfiles -q -s
> /etc/selinux/file_contexts/domain/xdm.te
> /usr/bin/kdm
> /usr/bin/kdm_greet
> /usr/bin/kdm_config
> ^D
> 
> check it again... AH HA!
> 
> -rwxr-xr-x  root     root     system_u:object_r:xdm_exec_t   kdm
> -rwxr-xr-x  root     root     lkcl:object_r:staff_home_dir_t kdm_config
> -rwxr-xr-x  root     root     lkcl:object_r:staff_home_dir_t kdm_greet
> 
> ta-daa.  double-checking for kdm_config and kdm_greet in xdm.te, of
> course, obviously, they're not there, well i can live with that.
> 
> okay, so let's have a look at the _contents_ of
> file_contexts/file_contexts:
> 
> /root/.default_contexts --      system_u:object_r:default_context_t
> 
> uhn.... is that right?
> 
> i no unnerstand.
> 
> 
> okay, taking a look at the /etc/selinux/Makefile, this section:
> 
> $(FC): $(FCFILES) domains/program domains/misc file_contexts/program
> file_contexts/misc users
> 	@echo "Building file_contexts ..."
> 	@m4 $(FCFILES) > $@.tmp
> 	@grep -v "^/root" $@.tmp > $@.root
> 	@/usr/sbin/genhomedircon . $@.root  > $@
> 	@grep "^/root" $@.tmp >> $@
> 	@-rm $@.tmp $@.root
> 
> if i comment out the 2nd grep, i get a complete
> file_contexts/file_contexts.
> 
> hm...
> 
> okedokeeyyy...  what about if i switch off the grep -v in the
> first grep and switch on grep -v in the second?
> 
> 	@grep "^/root" $@.tmp > $@.root
> 	@/usr/sbin/genhomedircon . $@.root  > $@
> 	@grep -v "^/root" $@.tmp >> $@
> 	@-rm $@.tmp $@.root
> 
> ah ha!  i get results!  i appear to get a list of err stuff that
> looks familiar, but it doesn't have /root/.default_contexts anywhere
> in it: is that right?
> 
> l.
> 
> -- 
> -- 
> expecting email to be received and understood is a bit like
> picking up the telephone and immediately dialing without
> checking for a dial-tone; speaking immediately without listening
> for either an answer or ring-tone; hanging up immediately and
> believing that you have actually started a conversation.
> --
> <a href="http://lkcl.net">      lkcl.net      </a> <br />
> <a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />
> 

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
