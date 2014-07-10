Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6A8SYCM023204
 for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2014 04:28:34 -0400
Received: by mail-wg0-f51.google.com with SMTP id y10so3797307wgg.34
 for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2014 01:28:36 -0700 (PDT)
Message-ID: <1404980914.31209.12.camel@x220.localdomain>
Subject: Re: Suppress avc denial logs
From: Dominick Grift <dominick.grift@gmail.com>
To: Avijit Das <avijitnsec@live.com>
Date: Thu, 10 Jul 2014 10:28:34 +0200
In-Reply-To: <COL127-W52E861850BDAE28BD2F10FB10E0@phx.gbl>
References: <COL127-W52E861850BDAE28BD2F10FB10E0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2014-07-09 at 20:49 -0700, Avijit Das wrote:
> Hello, 
> 
> 
> Do we have any mechanism to silent those denial logs? There are many
> cases were we are observing denial logs but we cannot grant access for
> those denial logs. In those cases can we suppress those logs from
> dmesg ?
> 

Please see: http://selinuxproject.org/page/AVCRules#dontaudit_Rule

> 
> Thanks,
> Avijit 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
