Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA06698
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 08:00:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA23606
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 11:58:27 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA23602 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 11:58:25 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: shadow_t
Date: Mon, 19 Aug 2002 13:59:48 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208190737120.14458-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0208190737120.14458-100000@raven>
MIME-Version: 1.0
Message-Id: <20020819115948.E34EA846C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Aug 2002 13:38, Stephen Smalley wrote:
> On Sat, 17 Aug 2002, Russell Coker wrote:
> > I've got shadow_t working correctly with my policy.
> >
> > I have changed the spasswd.c program to relabel the /etc/passwd and
> > /etc/shadow files after running /usr/bin/passwd, and I made a
> > file_type_auto_trans() rule to have them default to shadow_t (which
> > unfortunately gives a momentary situation where /etc/passwd will be
> > unreadable).  It would also be unfortunate if there was a power outage at
> > that moment...
> >
> > So I'm thinking of having a program run from a boot script to fix the
> > type of /etc/passwd.
> >
> > Also I've got vipw and adduser also working with shadow_t...
> >
> > This isn't ideal, but the code for the chsh/chfn/vipw/etc programs is
> > really ugly and I'm afraid of causing more problems than I fix if I
> > change them.
>
> Can you clarify what you mean by the latter statements, i.e. have you
> created wrapper programs for vipw and adduser to relabel /etc/passwd from
> shadow_t to etc_t after completion, or have you patched these programs?

I have created wrapper programs for vipw and adduser that relabel 
/etc/passwd, that's why I think it's not ideal.

I have not modified the source, mainly because I needed to get something 
working properly for my Linux Kongress tutorial and I didn't have time.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
