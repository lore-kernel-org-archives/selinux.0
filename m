Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA22341
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 09:19:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA07113
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 13:18:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA07109 for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 13:18:09 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: selinux question
Date: Tue, 23 Jul 2002 15:19:32 +0200
References: <20020717025148.GA25379@snoopy.apana.org.au>
In-Reply-To: <20020717025148.GA25379@snoopy.apana.org.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020723131932.EE9B4116C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Jul 2002 04:51, you wrote:
> one thing I am still not clear on, how does selinux know to deny this:
> >chsid system_u:object_r:user_netscape_rw_t ~/untrusted
>
> /home/bam/untrusted: Permission denied
>
> but not this:
> >chsid bam:object_r:user_netscape_rw_t ~/untrusted
>
> Jul 17 12:43:32 scrooge kernel: avc:  denied  { relabelto } for pid=3569
> exe=/usr/bin/chsid path=/bam/untrusted dev=03:09 ino=423537
> scontext=bam:user_r:user_t tcontext=system_u:object_r:user_netscape_rw_t
> tclass=dir
>
> ?
>
> The rule seems to be the same in both cases.
>
> allow user_t user_netscape_rw_t:{ dir file lnk_file } relabelto;

I'm not sure.

I've run into a similar issue, some scripts such as dh_installdocs call "cp 
-a" which tries to do such a chsid and fails.  I think that "cp -a" should 
not preserve sids to avoid breaking compatability in such situations.  
Generally when "cp -a" is called you don't even want to preserve the UID, 
just the mode.

What do you think?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
