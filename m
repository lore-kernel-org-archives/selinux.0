Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA24196
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 07:57:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA06508
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 11:55:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA06504
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 11:55:36 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id EEE1A92457
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 21:57:13 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id DC4965953
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 13:57:05 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fwd: Re: addition for xdm.te
Date: Tue, 16 Apr 2002 13:57:05 +0200
MIME-Version: 1.0
Message-Id: <20020416115705.DC4965953@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I currently have the following in my policy Makefile:
POLICYFILES = security_classes initial_sids access_vectors
ifeq ($(MLS),y)
POLICYFILES += mls
endif
POLICYFILES += tmp/macro_used_flags.te tmp/program_used_flags.te tmp/all.te 
rbacPOLICYFILES += users
POLICYFILES += constraints
POLICYFILES += initial_sid_contexts fs_contexts devfs_contexts net_contexts

tmp/program_used_flags.te: domains/program/* domains/program
        ( cd domains/program/ ; for n in * ; do echo "define(\`$$n')"; done ) 
>
$@

tmp/macro_used_flags.te: macros/program/* macros/program
        ( cd macros/program/ ; for n in * ; do echo "define(\`macro_$$n')"; 
done ) > $@

So now a policy file that needs dpkg can check for ifdef(`dpkg.te' and a 
policy file that needs the GPG macros to be defines can check for 
ifdef(`gpg_macros.te', ...

----------  Forwarded Message  ----------

Subject: Re: addition for xdm.te
Date: Thu, 21 Mar 2002 21:39:10 +0100
From: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Cc: SE Linux <selinux@tycho.nsa.gov>

On Thu, 21 Mar 2002 20:41, Stephen Smalley wrote:
> On Thu, 21 Mar 2002, Russell Coker wrote:
> > I think it makes more sense to have all the xdm policy in the xdm file.
> > Then someone who doesn't use a xdm type program can remove the file and
> > everything else will be fine.
>
> This isn't as straightforward as it might appear.  Consider the
> xdm-related rules in user_macros.te and netscape_macros.te.  We can
> relocate those rules to xdm.te through the use of type attributes (to
> cover all user domains and all netscape domains), but you then have a
> little piece of the netscape policy in the xdm.te file.  Perhaps that is
> more acceptable than having a little piece of the xdm policy in the
> netscape_macros.te file.

What if you have some shell code such as the following to generate m4 macro
definitions:
( cd domains/program/ ; for n in * ; do echo "define(\`$n')"; done )

Then in netscape.te you can have:
ifdef(`xdm.te', `...

Or in xdm.te you can have:
ifdef(`netscape.te', `...

While we're at it we could use similar m4 code to use those generated macros
in file_contexts to make it adapt to the policy files you have installed.

It may be almost as straightforward as it appears!  ;)

--
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

-------------------------------------------------------

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
