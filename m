Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA00287
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:52:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA28055
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 19:52:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA28051
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 19:52:00 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Major reduction in errors
Date: Thu, 27 Jun 2002 15:52:19 -0400
Cc: selinux@tycho.nsa.gov
References: <20020627193625.27977.qmail@web40015.mail.yahoo.com>
In-Reply-To: <20020627193625.27977.qmail@web40015.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020627195219.DA7037CFE@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 15:36, Brad Chapman wrote:
> --- Russell Coker <russell@coker.com.au> wrote:
> > avc:  denied  { read } for  pid=12 exe=/sbin/devfsd path=/.devfsd
> > dev=00:07 ino=2 scontext=system_u:system_r:devfsd_t
> > tcontext=system_u:object_r:devfs_t tclass=chr_file
> >
> > You need the following in the devfs_contexts file:
> > devfscon /.devfsd               system_u:object_r:devfs_control_t
>
>         This causes a syntax error when I attempt to compile the policy.

In that case you're using too old a version of the selinux-small code base to 
work with this.  Put in a rule to allow devfsd_t to read from 
devfs_t:chr_file until you can upgrade.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
