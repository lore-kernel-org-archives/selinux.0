Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4EEhW1L017470
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 10:43:32 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4EEhVTh000454
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 14:43:31 GMT
Received: by fg-out-1718.google.com with SMTP id 16so2594985fgg.40
        for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 07:43:30 -0700 (PDT)
Date: Wed, 14 May 2008 16:42:43 +0200
From: Jan-Frode Myklebust <janfrode@tanso.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: RHEL5 initrc_t vs. unconfined_t
Message-ID: <20080514144243.GA21546@lc4eb8045376502.ibm.com>
References: <911f42990805131345o43ad62b5pd9aee31feb01e6a9@mail.gmail.com> <482AEBA8.7090604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <482AEBA8.7090604@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 14, 2008 at 09:39:52AM -0400, Daniel J Walsh wrote:
> The problem is exactly the opposite of what you are asking.
> unconfined_t transitions to very few domains currently while initrc_t
> transitions to many.  unconfined_t is a logged in user domain.  So I
> would not run init scripts as unconfined_t.

Please, please, pretty please, may I be allowed to run a critical filesystem
and high availability solution unconfined until the vendors of these implement
and certify them for selinux? ;-)

> The better answer is to fix the avc's that you are seeing when trying to
> run ifconfig from initrc.  What avc's are you seeing?

I haven't tried running in permissive, so there will likely be more than
these, but that's what I've got right now:

type=AVC msg=audit(1210760976.747:24): avc:  denied  { read write } for pid=4739 comm="ifconfig" path="socket:[17163]" dev=sockfs ino=17163 scontext=user_u:system_r:ifconfig_t:s0 tcontext=user_u:system_r:initrc_t:s0 tclass=unix_stream_socket
type=AVC msg=audit(1210758692.381:10): avc:  denied  { read } for pid=4137 comm="mount" path="eventpoll:[17363]" dev=eventpollfs ino=17363 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:system_r:initrc_t:s0 tclass=file
type=AVC msg=audit(1210758684.281:6): avc:  denied  { append } for pid=3763 comm="umount" path="/var/adm/ras/mmfs.log.2008.05.14.11.51.24.lagring2" dev=dm-2 ino=720912 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
type=AVC msg=audit(1210758692.378:9): avc:  denied  { relabelfrom } for pid=4136 comm="mount" scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem
type=AVC msg=audit(1210758692.381:10): avc:  denied  { read } for  pid=4137 comm="mount" path="eventpoll:[17360]" dev=eventpollfs ino=17360 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:system_r:initrc_t:s0 tclass=file



  -jf

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
