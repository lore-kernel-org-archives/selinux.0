Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6G7lttI005375
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 03:47:55 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6G7lsmS015955
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 07:47:54 GMT
Received: by an-out-0708.google.com with SMTP id d30so46799and.75
        for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 00:47:54 -0700 (PDT)
Message-ID: <dd18b0c30807160047r23d6f795ua8d16ee2534000ab@mail.gmail.com>
Date: Wed, 16 Jul 2008 07:47:54 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: russell@coker.com.au
Subject: Re: OpenMoko/JFFS2 sestatus difficulties
Cc: "KaiGai Kohei" <kaigai@ak.jp.nec.com>,
        "Willis Vandevanter" <vandevwa@jmu.edu>, selinux@tycho.nsa.gov,
        ynakam@hitachisoft.jp
In-Reply-To: <200807161714.35195.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com>
	 <487D46B5.9070608@ak.jp.nec.com>
	 <dd18b0c30807152013s2c21888ei73896ff2a51b67df@mail.gmail.com>
	 <200807161714.35195.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 16, 2008 at 7:14 AM, Russell Coker <russell@coker.com.au> wrote:
> On Wednesday 16 July 2008 13:13, "Justin Mattock" <justinmattock@gmail.com>
> wrote:
>> make sure fstab has it entry to mount SELinux, and do a ldd /sbin/init
>
> I think that in most situations any requirement for a SE Linux entry
> in /etc/fstab would be a bug.  NB I am not saying that no-one needs it,
> merely that if you need it then you probably need to fix something else.
>
> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Blog
>
> http://www.coker.com.au/sponsorship.html Sponsoring Free Software development
>

I always for some reason put that in fstab just as a good practice,
from what I remember like what you had said "you probably need to fix
something else".
maybe libselinux(older versions) was causing this. Also adding
libselinux in /etc/ld.so.conf was another step I used to make sure I
did as well.
regards;


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
