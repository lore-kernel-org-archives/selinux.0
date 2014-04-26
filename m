Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3QEHtw4015778
 for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2014 10:17:55 -0400
Received: by mail-ee0-f48.google.com with SMTP id b57so3495867eek.21
 for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2014 07:17:54 -0700 (PDT)
Message-ID: <1398521872.16991.22.camel@x220.localdomain>
Subject: Re: Why is SELINUXTYPE policy specific?
From: Dominick Grift <dominick.grift@gmail.com>
To: dE <de.techno@gmail.com>
Date: Sat, 26 Apr 2014 16:17:52 +0200
In-Reply-To: <535B5AEE.2020806@gmail.com>
References: <5353BC31.3070404@gmail.com>
 <CAPzO=Nzkn13La7VDcFjCah8CGmhW7R6Vm+zoMFR80DhPNgD3wg@mail.gmail.com>
 <5355F720.7010605@gmail.com> <5356664E.7050309@tycho.nsa.gov>
 <535B5AEE.2020806@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2014-04-26 at 12:36 +0530, dE wrote:

> 
> So I dont understand the purpose of SELINUXTYPE. Can someone please explain?

It allows one to have more than a single policy installed at any given
time, which in turn enables one to relatively easily switch between
policies.
