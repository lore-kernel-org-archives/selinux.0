Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11059
	for <selinux@tycho.nsa.gov>; Sat, 29 Jun 2002 11:44:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA19746
	for <selinux@tycho.nsa.gov>; Sat, 29 Jun 2002 15:42:33 GMT
Received: from web40019.mail.yahoo.com (web40019.mail.yahoo.com [66.218.78.59])
        by jazzband.ncsc.mil  with SMTP id PAA19742 for <selinux@tycho.nsa.gov>; Sat, 29 Jun 2002 15:42:32 GMT
Message-ID: <20020629154358.39848.qmail@web40019.mail.yahoo.com>
Date: Sat, 29 Jun 2002 08:43:58 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Major reduction in errors
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020629153319.9E302106@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Coker,

--- Russell Coker <russell@coker.com.au> wrote:
> On Sat, 29 Jun 2002 08:58, Brad Chapman wrote:
> >        I'm sorry to keep bothering you like this, sir, but I am still
> > getting floods of permission errors for everything. Attached is another
> > dmesg output.
> >
> > Should I continue tweaking coker.com.au/selinux/policy.tgz or investigate
> > coker.com.au/selinux/selinux-small?
> 
> I suggest investigating the policy that I am distributing (which fixes most 
> of the issues you are seeing), as well as the samba policy that has been 
> recently posted here.

        ACK.

> 
> avc:  denied  { read } for  pid=535 exe=/sbin/insmod path=/.devfsd dev=00:07 
> ino=2 scontext=system_u:system_r:insmod_t tcontext=system_u:object_r:devfs_t 
> tclass=chr_file
> 
> The above is because you are using an old version of devfsd, this bug was 
> fixed almost a year ago.

        I'm using devfsd version 1.3.24 and modutils version 2.4.14. Should I
upgrade my modutils to 2.4.16?

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
