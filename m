Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4EJkouF016365
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 15:46:50 -0400
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4EJkmwE007574
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 19:46:49 GMT
Received: by fk-out-0910.google.com with SMTP id 18so43166fks.2
        for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 12:46:47 -0700 (PDT)
Message-ID: <911f42990805141246r16c20dqf8effdc48b901dd1@mail.gmail.com>
Date: Wed, 14 May 2008 21:46:47 +0200
From: "Jan-Frode Myklebust" <janfrode@tanso.net>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: RHEL5 initrc_t vs. unconfined_t
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <482AFDFB.4080404@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <911f42990805131345o43ad62b5pd9aee31feb01e6a9@mail.gmail.com>
	 <482AEBA8.7090604@redhat.com>
	 <20080514144243.GA21546@lc4eb8045376502.ibm.com>
	 <482AFDFB.4080404@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 14, 2008 at 4:58 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>
> The one to be concerned about is mounting of the unlabeled_t file
> system.  This looks like you have a file system that SELinux does not
> know about?


Yes, GPFS doesn't support the selinux extended attributes, so the
filesystems has to be mounted with f.ex. "-o
"fscontext=user_u:object_r:httpd_var_run_t" for static labelling.


  -jf

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
