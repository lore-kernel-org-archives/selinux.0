Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07344
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 10:46:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA27846
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:45:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA27828
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:45:14 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: devfs change, trivial patches, netscape & x patches
Date: Tue, 27 Aug 2002 16:46:12 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>, bam@snoopy.apana.org.au
References: <Pine.GSO.4.33.0208270946320.11201-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0208270946320.11201-100000@raven>
MIME-Version: 1.0
Message-Id: <20020827144612.A22212355@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Aug 2002 16:01, Stephen Smalley wrote:
> These three patches have been merged and are available in the sourceforge
> CVS tree, with the following exceptions from triv.diff:
> 1) login.te:  remote_login_t, the domain of a login process spawned by
> rlogind, is only granted domain_trans() to unpriv_userdomain, not
> userdomain.

I forgot that one.

> 2) oav-update.te:  There was a spurious amavisd rule in this file, likely
> a cut-and-paste error.  Removed.

I've CC'd Brian, it's his policy.

> 3) global_macros.te:  daemon_base_domain() should not need to include
> init_t in the domain_auto_trans() rule, unless some of these daemons are
> truly started directly by init.  The separate type_transition init_t rule
> should be sufficient to deal with the reparenting issue when using
> SELinux as a dynamically loaded module, which isn't recommended anyway.

Some daemons are started from init though.  I'll make some changes.

> 4) sendmail.fc:  We don't want to remove the /etc/aliases entries or the
> sendmail executable entries for people running sendmail.

No, people running sendmail will still have mta.te and therefore get it from 
mta.fc.

> With regard to the netscape changes, note that netscape can still read
> files in the user home type for the .Xauthority file.  We need to place
> this file into its own type, with a separate domain for the xauth program.

Yes, that's on my to-do list.

The current policy prevents netscape from descending sub-directories of the 
home directory, which is better than nothing.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
