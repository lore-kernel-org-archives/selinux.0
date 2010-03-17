Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2HKEwhu018299
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 16:14:58 -0400
Received: from mail-pz0-f204.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2HKEbGs008632
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 20:14:37 GMT
Received: by pzk42 with SMTP id 42so1069029pzk.32
        for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 13:14:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dd18b0c31003161804i5275304cl13256077080946c4@mail.gmail.com>
References: <dd18b0c31003161804i5275304cl13256077080946c4@mail.gmail.com>
Date: Wed, 17 Mar 2010 16:14:56 -0400
Message-ID: <7e0fb38c1003171314v6d1ab81fv6ac7a9556dfddd1@mail.gmail.com>
Subject: Re: new: loads of audit messgs
From: Eric Paris <eparis@parisplace.org>
To: Justin Mattock <justinmattock@gmail.com>
Cc: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

#define AUDIT_USER_AVC          1107    /* We filter this differently */

So some userspace object manager is denying something ?dbus?

not sure what to tell you since you only get part of the message....

-Eric

On Tue, Mar 16, 2010 at 9:04 PM, Justin Mattock <justinmattock@gmail.com> wrote:
> this is new:
> (log message is showing loads of these,but I don't see this getting in
> the way of anything).
>
>  type=1107 audit(1268786484.482:3): user pid=1277 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
> msg=''
> [    8.482858] type=1107 audit(1268786484.482:4): user pid=1277 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
> msg=''
> [    8.514268] type=1107 audit(1268786484.514:5): user pid=1277 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
> msg=''
> [    8.514803] type=1107 audit(1268786484.514:6): user pid=1277 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
> msg=''
> [    8.515396] type=1107 audit(1268786484.515:7): user pid=1277 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
> msg=''
> [    8.515891] type=1107 audit(1268786484.515:8): user pid=1277 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:initrc_t:s0
> msg=''
>
> I'll have a look tomorrow to see if this is kernel, and/or policy
> only change I did was update libc,kernel(add ima integrity)
> and add fcron/logrotate with pam support.
>
> any ideas?
>
> --
> Justin P. Mattock
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
