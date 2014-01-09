Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09EpMPt026030
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 09:51:22 -0500
Received: by mail-wi0-f172.google.com with SMTP id en1so7029486wid.5
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 06:51:11 -0800 (PST)
Message-ID: <1389279068.15411.6.camel@x220.localdomain>
Subject: Re: [RFC] CIL and Source Policy Integration
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Thu, 09 Jan 2014 15:51:08 +0100
In-Reply-To: <1389274525.14773.32.camel@x220.localdomain>
References: <52CDB8AC.4090504@tresys.com>
 <1389274525.14773.32.camel@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-01-09 at 14:35 +0100, Dominick Grift wrote:
> On Wed, 2014-01-08 at 15:44 -0500, Steve Lawrence wrote:
> 
> > Thanks, and we look forward to receive your feedback.
> 
> I played with this a bit this morning. Followed all steps.

When one runs semodule -B, things start to break because of the login
mappings that disappear, and as a consequence the home dir contexts also
disappear.

It removes the login mappings, and the content of user home directories
end up with type default_t

Most of the issues are due to: "cp
-r /etc/selinux/targeted/{contexts,seusers,setrans.conf} /etc/selinux/cil-test/"

It should work without that step (either that or i am overlooking
things)
