Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA02867
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:39:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA24747
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 20:38:00 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA24743
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 20:37:59 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: addition for xdm.te
Date: Thu, 21 Mar 2002 21:39:10 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203211437180.19336-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203211437180.19336-100000@raven>
MIME-Version: 1.0
Message-Id: <20020321203910.9FC6D48E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
