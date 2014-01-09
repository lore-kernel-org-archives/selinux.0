Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09MsYrX026708
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 17:54:34 -0500
Received: by mail-qe0-f49.google.com with SMTP id w4so987631qeb.8
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 14:54:32 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov, Dominick Grift <dominick.grift@gmail.com>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
Date: Thu, 09 Jan 2014 17:54:29 -0500
Message-ID: <1453694.LHeEgrvlzg@sifl>
In-Reply-To: <1389306084.15747.41.camel@x220.localdomain>
References: <52CF1A53.9080501@redhat.com>
 <1389306084.15747.41.camel@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, January 09, 2014 11:21:24 PM Dominick Grift wrote:
> Then leave the unlabeled isid for netlabel ( i think netlabel also uses
> the unlabeled isid )

While NetLabel uses the unlabeled initial sid, there are plenty of other 
places where it is used, the most obvious being almost all the initial object 
allocation functions in the kernel.  Were going to need to keep the unlabeled 
initial sid as "unlabeled_t" or similar for the foreseeable future.
 
-- 
paul moore
www.paul-moore.com
