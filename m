Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9SJlecs013279
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:47:40 -0400
Received: by mail-qa0-f51.google.com with SMTP id ii20so2371978qab.3
        for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 12:47:39 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        Laurent Bigonville <bigon@debian.org>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: avc_has_perm() returns -1 even when SELinux is in permissive mode
Date: Mon, 28 Oct 2013 15:47:36 -0400
Message-ID: <2460657.bCoIDJIr56@sifl>
In-Reply-To: <526EBA54.40301@tycho.nsa.gov>
References: <20131027144337.5b89c5a8@fornost.bigon.be> <526EB670.7070406@tycho.nsa.gov> <526EBA54.40301@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, October 28, 2013 03:26:12 PM Stephen Smalley wrote:
> Alternatively, we could go with this one to ensure that in the enforcing
> case, we get EACCES rather than EINVAL back in the original caller.

Unless there have been reports of applications not being able to deal with 
errors other than EACCESS, I'm in favor of not masking EINVAL in the enforcing 
case.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
