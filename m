Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA21288
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 06:00:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA04789
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 09:59:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA04785
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 09:59:19 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Frank Mayer <mayerf@tresys.com>
Subject: Re: policy_src_t
Date: Tue, 23 Jul 2002 11:59:54 +0200
Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0207220745520.4503-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0207220745520.4503-100000@raven>
MIME-Version: 1.0
Message-Id: <20020723095954.920417CC4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 Jul 2002 13:50, Stephen Smalley wrote:
> On Fri, 19 Jul 2002, Frank Mayer wrote:
> > Is the type policy_src_t being used?  It doesn't appear so.  We're trying
> > to update our tools to work with the recent policy syntax changes, as
> > well as create a policy for our tools themselves.  We need to read,
> > modify, and re-install a policy in an operational system.  As previously
> > indicated, that requires an installed policy.conf (we'll submit a
> > proposed patch to the makefile to do this next week).
> >
> > In addition, for now we also need a known location for the policy source
> > make directory.  It seems logical that this directory would also have
> > policy_src_t.  If there are no specific plans to use this type, then
> > we'll be glad to submit a proposed use.  If there are plans, we'd like to
> > hear what they are so we can make our tools work within those plans.
> > Thanks
>
> The policy/file_contexts/types.fc file specifies the policy_src_t type for
> /etc/selinux, /usr/lib/selinux, and /usr/share/selinux.  I think that
> these entries are based on Russell Coker's SE-Debian package, which
> installs the policy sources, unlike the existing upstream SELinux.

Yes, my package uses the type, but doesn't do anything exciting with it.

If you want to change the policy to allow a certain domain write access to 
the policy then that's an option you have.  I have not felt the need to make 
such things into the default policy.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
