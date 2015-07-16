Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GMGHvg004419
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 18:16:17 -0400
Received: by wgkl9 with SMTP id l9so68853360wgk.1
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 15:16:09 -0700 (PDT)
Date: Fri, 17 Jul 2015 02:16:05 +0400
From: Jason Zaman <jason@perfinion.com>
To: Robert Kuska <rkuska@redhat.com>
Subject: Re: Python3 Support for Sepolgen module
Message-ID: <20150716221605.GB28538@meriadoc.Home>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
 <439836082.34025817.1437047775259.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <439836082.34025817.1437047775259.JavaMail.zimbra@redhat.com>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 16, 2015 at 07:56:15AM -0400, Robert Kuska wrote:
> 
> 
> ----- Original Message -----
> > From: "Robert Kuska" <rkuska@redhat.com>
> > To: selinux@tycho.nsa.gov
> > Sent: Thursday, July 16, 2015 1:48:10 PM
> > 
> > These patches aims to bring Python3 support to sepolgen module.
> 
> Refering to 11 patches I've sent.

I read through all these patches, they all looked pretty reasonable. I
tested it on gentoo, there were no problems building or anything but I
keep hitting policycoreutils py3 issues so actually using semanage
doesnt fully work yet.

How much progress do you have on porting policycoreutils? There are a
lot of mismatched tabs/spaces in it which are causing problems in
python3 and I havent gotten further yet. I started looking at fixing up
these but if you've already done it then there is no point in me
re-doing it.

-- Jason

> > They're made from the patch I've sent earlier which was a little
> > bit big for a single review so I cut it into smaller patches.
> > 
> > 
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.
> > 
> 
> Looks like I messed up the --compose option of git send-email.
> 
> 
> 
> --
> Robert Kuska
> {rkuska}
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
