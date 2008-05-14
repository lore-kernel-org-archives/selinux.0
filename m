Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4EMWFaZ012186
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 18:32:15 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4EMWEJk012478
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 22:32:14 GMT
Received: by ug-out-1314.google.com with SMTP id m3so1238735ugc.15
        for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 15:32:13 -0700 (PDT)
Date: Thu, 15 May 2008 00:31:29 +0200
From: Jan-Frode Myklebust <janfrode@tanso.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: RHEL5 initrc_t vs. unconfined_t
Message-ID: <20080514223129.GA29418@lc4eb8045376502.ibm.com>
References: <911f42990805131345o43ad62b5pd9aee31feb01e6a9@mail.gmail.com> <482AEBA8.7090604@redhat.com> <20080514144243.GA21546@lc4eb8045376502.ibm.com> <482AFDFB.4080404@redhat.com> <911f42990805141246r16c20dqf8effdc48b901dd1@mail.gmail.com> <482B6434.4050300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <482B6434.4050300@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 14, 2008 at 06:14:12PM -0400, Daniel J Walsh wrote:
> |
> | Yes, GPFS doesn't support the selinux extended attributes, so the
> | filesystems has to be mounted with f.ex. "-o
> | "fscontext=user_u:object_r:httpd_var_run_t" for static labelling.
> |

> The other ones are just leaked file descriptors and can be ignored.

So what about the mount/umount and everything else GPFS might want to
do in the lifetime of the system. I have no way of guessing all things
it might want to do that could possibly be denied in a transitioning
domain. Is my only option to manually start the fs from an interactive
shell to get it running as unconfined ?


  -jf

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
