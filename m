Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2NHf0rs000585
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 13:41:00 -0400
Received: from web36614.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m2NHexQn017125
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 17:40:59 GMT
Date: Sun, 23 Mar 2008 10:40:57 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Removing DAC.
To: casey@schaufler-ca.com, cinthya aranguren <cinthya.aranguren@gmail.com>,
        selinux@tycho.nsa.gov
Cc: LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <613578.78683.qm@web36601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <404587.40497.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Casey Schaufler <casey@schaufler-ca.com> wrote:

> 
> --- cinthya aranguren <cinthya.aranguren@gmail.com> wrote:
> 
> > Hi,
> > 
> > Is there any way to avoid o remove DAC controls ? I'd like to have only one
> > security scheme in my system. I mean a pure SElinux system. not DAC + MAC.
> > only MAC.
> 
> No.
> 
> Well, not today.

I will add that if every process runs with CAP_DAC_OVERRIDE set
you can approach "no DAC", but I think you would probably have
to dig very deeply into the behavior of security cognizant
applications (sendmail comes to mind) and make sure that they
aren't explictly dropping that capability. I will let those
who work more closely with SELinux policy than I do describe
how capabilities possessed are related to an SELinux policy
and how that might impact the behavior of SELinux. You should
also note that SELinux takes what are traditionally DAC
attributes into account when making decisions and that if you
use MCS you are using a DAC mechanism within SELinux. I'm not
saying that's bad, just that it's there.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
