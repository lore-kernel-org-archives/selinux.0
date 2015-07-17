Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6H6dEDh031692
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 02:39:14 -0400
Date: Fri, 17 Jul 2015 02:39:08 -0400 (EDT)
From: Robert Kuska <rkuska@redhat.com>
To: Jason Zaman <jason@perfinion.com>
Message-ID: <839397810.34677360.1437115148590.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150716221605.GB28538@meriadoc.Home>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
 <439836082.34025817.1437047775259.JavaMail.zimbra@redhat.com>
 <20150716221605.GB28538@meriadoc.Home>
Subject: Re: Python3 Support for Sepolgen module
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



----- Original Message -----
> From: "Jason Zaman" <jason@perfinion.com>
> To: "Robert Kuska" <rkuska@redhat.com>
> Cc: selinux@tycho.nsa.gov
> Sent: Friday, July 17, 2015 12:16:05 AM
> Subject: Re: Python3 Support for Sepolgen module
> 
> On Thu, Jul 16, 2015 at 07:56:15AM -0400, Robert Kuska wrote:
> > 
> > 
> > ----- Original Message -----
> > > From: "Robert Kuska" <rkuska@redhat.com>
> > > To: selinux@tycho.nsa.gov
> > > Sent: Thursday, July 16, 2015 1:48:10 PM
> > > 
> > > These patches aims to bring Python3 support to sepolgen module.
> > 
> > Refering to 11 patches I've sent.
> 
> I read through all these patches, they all looked pretty reasonable. I
> tested it on gentoo, there were no problems building or anything but I
> keep hitting policycoreutils py3 issues so actually using semanage
> doesnt fully work yet.
> 
> How much progress do you have on porting policycoreutils? There are a
> lot of mismatched tabs/spaces in it which are causing problems in
> python3 and I havent gotten further yet. I started looking at fixing up
> these but if you've already done it then there is no point in me
> re-doing it.

Sepolgen should be done.

There are still scripts which we already got ported and will be here for a review soon:
> $ rpm -ql policycoreutils-python | grep bin                                        [±master ●▴]
/usr/bin/audit2allow
/usr/bin/audit2why
/usr/bin/chcat
/usr/bin/sandbox
/usr/bin/semodule_package
/usr/sbin/semanage

Am I missing something? 
> 
> -- Jason
> 
> > > They're made from the patch I've sent earlier which was a little
> > > bit big for a single review so I cut it into smaller patches.
> > > 
> > > 
> > > _______________________________________________
> > > Selinux mailing list
> > > Selinux@tycho.nsa.gov
> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to
> > > Selinux-request@tycho.nsa.gov.
> > > 
> > 
> > Looks like I messed up the --compose option of git send-email.
> > 
> > 
> > 
> > --
> > Robert Kuska
> > {rkuska}
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.
> 


--
Robert Kuska
{rkuska}
