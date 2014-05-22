Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4M7Wh7i020814
 for <selinux@tycho.nsa.gov>; Thu, 22 May 2014 03:32:43 -0400
Received: by mail-ee0-f43.google.com with SMTP id d17so2259914eek.16
 for <selinux@tycho.nsa.gov>; Thu, 22 May 2014 00:32:40 -0700 (PDT)
Message-ID: <1400743958.10370.0.camel@x220.localdomain>
Subject: Re: Significance of SELinux user and roles on objects.
From: Dominick Grift <dominick.grift@gmail.com>
To: dE <de.techno@gmail.com>
Date: Thu, 22 May 2014 09:32:38 +0200
In-Reply-To: <537D9F47.7020704@gmail.com>
References: <537AE191.7070403@gmail.com> <537B5BD3.4090507@tresys.com>
 <537D9F47.7020704@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-05-22 at 12:25 +0530, dE wrote:
> On 05/20/14 19:12, Christopher J. PeBenito wrote:
> > The kernel will create files with object_r regardless
> 
> Is this defined in the policy or is hard coded in the kernel?

Hard coded into the kernel

> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
