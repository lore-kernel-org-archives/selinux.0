Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7RMrRe6012124
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 18:53:27 -0400
Received: from smtp108.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7RMrP57018443
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 22:53:25 GMT
Message-ID: <48B5DADF.9060005@schaufler-ca.com>
Date: Wed, 27 Aug 2008 15:53:19 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Trent Jaeger <tjaeger@cse.psu.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: Socket and inode label consistency
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu>	 <1219838254.5708.4.camel@moss-spartans.epoch.ncsc.mil>	 <200808271149.38256.paul.moore@hp.com>	 <E0F1193F-FE77-4B1D-87BA-3289AD37C385@cse.psu.edu> <1219861005.5708.137.camel@moss-spartans.epoch.ncsc.mil> <48B5B3DF.4080404@schaufler-ca.com> <4A385C00-E89F-43D3-8ACA-E7B27AC97B5E@cse.psu.edu>
In-Reply-To: <4A385C00-E89F-43D3-8ACA-E7B27AC97B5E@cse.psu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trent Jaeger wrote:
>
> On Aug 27, 2008, at 4:06 PM, Casey Schaufler wrote:
>
>> Stephen Smalley wrote:
>>> ...
>>>
>>> You may be right about setxattr not being viable due to it being an
>>> inode op.  setsockopt may be the right approach there if we need to
>>> support relabeling of sockets at all.
>>>
>>>
>>
>> Hum. fsetxattr() works for Smack. The only thing that I can't do
>> is switch from labeled domains to unlabeled ones. So long as I'm
>> living "within CIPSO" it works great. Paul did a very good job on
>> that. If the intent is to change the MLS value, which is very useful
>> for label-aware service providers like CMW style X11 server or a
>> mail server, there oughtn't be a problem.
>>
>> Yes, it would be weird to change the label on a TCP connection
>> midstream, but not unheard of. If you need an example think of
>> what you might want to do with a diskless boot, or some of the
>> less sophisticated clustering schemes. For UDP examples should
>> be obvious to the casual observer, and a couple are cited above.
>>
>> Or am I missing something (again)?
>
> It sets the socket's inode's security context, but not the sock's context.

Would I be going too far out on a limb to suggest you change the code
so that it changes both? I know that SELinux would require work
to figure out what context to put on the sock based on the context
of the task, socket inode, sock, port and address family, still
that shouldn't be an insurmountable obstacle. Especially if you
limit changes to the MLS portion of the label.

Paul points out some edge case conditions for TCP that might make
really supporting that protocol iffy. True enough. I wouldn't see
changing labels on a TCP connection showing up in any but very low
level system sort of uses where you need to be extraordinarily
careful in any case. I don't see those dangers as a real stopper.

> The former is used to authorize access to the socket api.  The latter 
> is what is used to authorize packet access (e.g., labeled ipsec and 
> seclabel).  So, you end up with the two being different which is a 
> potential problem.
>
> Regards,
> Trent.
> ----------------------------------------------
> Trent Jaeger, Associate Professor
> Pennsylvania State University, CSE Dept
> 346A IST Bldg, University Park, PA 16802
> Email: tjaeger@cse.psu.edu
> Ph: (814) 865-1042, Fax: (814) 865-3176
>
>
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
