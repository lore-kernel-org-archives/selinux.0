Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7RK73wQ014887
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 16:07:03 -0400
Received: from smtp107.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7RK7257008340
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 20:07:03 GMT
Message-ID: <48B5B3DF.4080404@schaufler-ca.com>
Date: Wed, 27 Aug 2008 13:06:55 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Trent Jaeger <tjaeger@cse.psu.edu>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: Socket and inode label consistency
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu>	 <1219838254.5708.4.camel@moss-spartans.epoch.ncsc.mil>	 <200808271149.38256.paul.moore@hp.com>	 <E0F1193F-FE77-4B1D-87BA-3289AD37C385@cse.psu.edu> <1219861005.5708.137.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1219861005.5708.137.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> ...
>
> You may be right about setxattr not being viable due to it being an
> inode op.  setsockopt may be the right approach there if we need to
> support relabeling of sockets at all.
>
>   

Hum. fsetxattr() works for Smack. The only thing that I can't do
is switch from labeled domains to unlabeled ones. So long as I'm
living "within CIPSO" it works great. Paul did a very good job on
that. If the intent is to change the MLS value, which is very useful
for label-aware service providers like CMW style X11 server or a
mail server, there oughtn't be a problem.

Yes, it would be weird to change the label on a TCP connection
midstream, but not unheard of. If you need an example think of
what you might want to do with a diskless boot, or some of the
less sophisticated clustering schemes. For UDP examples should
be obvious to the casual observer, and a couple are cited above.

Or am I missing something (again)?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
