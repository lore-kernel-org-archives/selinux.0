From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Add version option to newrole
Date: Fri, 10 Feb 2006 11:51:17 -0200
Cc: Selinux@tycho.nsa.gov, Steve G <linux_4ever@yahoo.com>
References: <200602081445.14747.glommer@br.ibm.com> <1139515788.3452.37.camel@moss-spartans.epoch.ncsc.mil> <1139515974.3452.41.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1139515974.3452.41.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602101151.17945.glommer@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Em Quinta 09 Fevereiro 2006 18:12, Stephen Smalley escreveu:
> On Thu, 2006-02-09 at 15:09 -0500, Stephen Smalley wrote:
> > At present, your patch causes newrole to display the version number of
> > the entire collection (policycoreutils), not an individual version tied
> > to the newrole program itself.  Thus, I think it should display the
> > PACKAGE string as well (already defined) as part of the message, e.g.:
> > 	printf("%s:  %s version %s\n", argv[0], PACKAGE, VERSION);
> > yielding output like:
> > 	newrole:  policycoreutils version 1.29.20

argv[0] will display the complete path of the command being called. I think 
this is not what we want. 

> > Otherwise, the patch seems sane and suitable for the other utilities as
> > well.  A few of the utilities appear to have their own version string at
> > present, but I think you can just drop that as no one is maintaining
> > that - only the top-level VERSION for the entire collection is
> > meaningful.
>
> Also, using -v is ambiguous, as it often means to run a program under a
> verbose mode (extra output), and several utilities are using -v in that
> way, so use -V and/or --version instead.

Sure this is confusing. A lot of programs use -v for version (see GNU 
Binutils), some don't use a shortopt at all (see GNU coreutils), and some use 
the suggested -V (see GNU zip). I'll cope with your suggestion and use -V 

I'll send a new version of newrole's implementation together with the manpage 
patch soon, and patches for the other programs as soon as I can too.

glauber.
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
