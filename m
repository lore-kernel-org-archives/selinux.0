Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7JDmvZE011719
	for <selinux@tycho.nsa.gov>; Sat, 19 Aug 2006 09:48:57 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7JDmSj1001188
	for <selinux@tycho.nsa.gov>; Sat, 19 Aug 2006 13:48:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: refpoliy issues
Date: Sat, 19 Aug 2006 23:48:45 +1000
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
References: <1155863972.7443.36.camel@wintermute.xmldesign.de> <1155910539.14126.17.camel@sgc.columbia.tresys.com> <1155916251.14563.5.camel@wintermute.xmldesign.de>
In-Reply-To: <1155916251.14563.5.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200608192348.48603.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 19 August 2006 01:50, Erich Schubert <erich@debian.org> wrote:
> > > - cron needs to su for certain cronjobs
> >
> > Can you be more specific?
>
> Amavisd-new for example. /etc/cron.daily/* support, because these files
> don't have cron syntax, but are plain shell scripts.
> But I had the impression that adding su for system_crond_t is the clean
> way, so it wouldn't really matter which of the jobs in there uses su...

I think that start-stop-daemon is a better program to use for this.  The 
procedure in Red Hat distributions is to use the runuser program (Red Hat's 
nearest equivalent to start-stop-daemon) for such things.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
