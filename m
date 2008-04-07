Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m37N6pOw003033
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 19:06:51 -0400
Received: from web36603.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m37N6pZK015623
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 23:06:51 GMT
Date: Mon, 7 Apr 2008 16:05:11 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: mcstransd
To: Stephen Smalley <sds@tycho.nsa.gov>, russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1207583914.21223.29.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <85213.40548.qm@web36603.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> 
> On Mon, 2008-04-07 at 15:13 +1100, Russell Coker wrote:
> > Is there a plan for a mlstransd daemon?  If there is no plan for a
> different 
> > daemon for translating MLS contexts then this should be renamed to
> senstransd 
> > or something similar.
> 
> We're looking into getting the MITRE label encoding library released so
> that it can be used as the core of a mlstransd.

Oh my. I do hope that you will have spoken with people
who have worked professionally with that code prior to
committing to that plan. During the CMW days the MITRE
label encoding facility raised much concern with its
level of complexity. There were also concerns raised
about the code on 2 of the 3 B1 evaluations that used
it. You may decide to use it anyway, but do be careful.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
