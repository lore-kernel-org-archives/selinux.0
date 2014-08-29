Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7TIKfZv016426
 for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2014 14:20:41 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so2687829qgd.9
 for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2014 11:20:45 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2] selinux: Permit bounded transitions under NO_NEW_PRIVS
 or NOSUID.
Date: Fri, 29 Aug 2014 14:20:41 -0400
Message-ID: <2638663.9d9W5DIUs4@sifl>
In-Reply-To: <54007C2A.1040504@tycho.nsa.gov>
References: <1407173809-3477-1-git-send-email-sds@tycho.nsa.gov>
 <35237187.pLesj1POuT@sifl> <54007C2A.1040504@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: SELinux-NSA <selinux@tycho.nsa.gov>, Andy Lutomirski <luto@amacapital.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, August 29, 2014 09:12:10 AM Stephen Smalley wrote:
> It runs fine on Fedora 20.  I am guessing you are running on rawhide /
> Fedora 21, and that this is a difference in your base policy.

Yep.  In general I test the SELinux next patches against Fedora Rawhide.

> Try this patch for selinux-testsuite on top of the current one.

That solved it, thanks.  The kernel patch is now merged upstream and in should 
be in the next linux-next tree.

-- 
paul moore
www.paul-moore.com
