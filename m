In-Reply-To: <48B5B3DF.4080404@schaufler-ca.com>
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu>	 <1219838254.5708.4.camel@moss-spartans.epoch.ncsc.mil>	 <200808271149.38256.paul.moore@hp.com>	 <E0F1193F-FE77-4B1D-87BA-3289AD37C385@cse.psu.edu> <1219861005.5708.137.camel@moss-spartans.epoch.ncsc.mil> <48B5B3DF.4080404@schaufler-ca.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A385C00-E89F-43D3-8ACA-E7B27AC97B5E@cse.psu.edu>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
From: Trent Jaeger <tjaeger@cse.psu.edu>
Subject: Re: Socket and inode label consistency
Date: Wed, 27 Aug 2008 17:38:59 -0400
To: Casey Schaufler <casey@schaufler-ca.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 27, 2008, at 4:06 PM, Casey Schaufler wrote:

> Stephen Smalley wrote:
>> ...
>>
>> You may be right about setxattr not being viable due to it being an
>> inode op.  setsockopt may be the right approach there if we need to
>> support relabeling of sockets at all.
>>
>>
>
> Hum. fsetxattr() works for Smack. The only thing that I can't do
> is switch from labeled domains to unlabeled ones. So long as I'm
> living "within CIPSO" it works great. Paul did a very good job on
> that. If the intent is to change the MLS value, which is very useful
> for label-aware service providers like CMW style X11 server or a
> mail server, there oughtn't be a problem.
>
> Yes, it would be weird to change the label on a TCP connection
> midstream, but not unheard of. If you need an example think of
> what you might want to do with a diskless boot, or some of the
> less sophisticated clustering schemes. For UDP examples should
> be obvious to the casual observer, and a couple are cited above.
>
> Or am I missing something (again)?

It sets the socket's inode's security context, but not the sock's  
context.  The former is used to authorize access to the socket api.   
The latter is what is used to authorize packet access (e.g., labeled  
ipsec and seclabel).  So, you end up with the two being different  
which is a potential problem.

Regards,
Trent.
----------------------------------------------
Trent Jaeger, Associate Professor
Pennsylvania State University, CSE Dept
346A IST Bldg, University Park, PA 16802
Email: tjaeger@cse.psu.edu
Ph: (814) 865-1042, Fax: (814) 865-3176





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
