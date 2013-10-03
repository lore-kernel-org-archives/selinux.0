Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r93Kn9Xv013552
	for <selinux@tycho.nsa.gov>; Thu, 3 Oct 2013 16:49:09 -0400
Received: by mail-qe0-f43.google.com with SMTP id gh4so2195734qeb.2
        for <selinux@tycho.nsa.gov>; Thu, 03 Oct 2013 13:49:08 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Dave Jones <davej@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Kernel <linux-kernel@vger.kernel.org>, eparis@redhat.com,
        james.l.morris@oracle.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] conditionally reschedule while loading selinux policy.
Date: Thu, 03 Oct 2013 16:49:02 -0400
Message-ID: <1872708.6lkHAuRzGL@sifl>
In-Reply-To: <20131003204031.GA25515@redhat.com>
References: <20130916173036.GA17950@redhat.com> <2297933.rECKfqAcWT@sifl> <20131003204031.GA25515@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, October 03, 2013 04:40:31 PM Dave Jones wrote:
> I couldn't get a backtrace when I downgraded, and reupgraded my policy,
> but that said, I didn't when I tested that way on my first patch either.
> It wasn't until I got a newer policy that I saw the 2nd spew.
> I was planning on sitting on this until the next policy update just
> to confirm.

Okay, no problem.  Let me know how it goes.

Thanks,
-Paul

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
