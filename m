Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1F1lZ5J008837
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2007 20:47:35 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1F1mmEY003181
	for <selinux@tycho.nsa.gov>; Thu, 15 Feb 2007 01:48:48 GMT
Message-ID: <45D3BBF0.3030901@tresys.com>
Date: Wed, 14 Feb 2007 20:48:32 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Joy Latten <latten@austin.ibm.com>
CC: vyekkirala@TrustedCS.com, redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Subject: Re: ssh/xinetd/getpeercon???
References: <1171495601.2603.488.camel@faith.austin.ibm.com>
In-Reply-To: <1171495601.2603.488.camel@faith.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joy Latten wrote:
> I have been playing with the ssh-mls which gets called through xinetd
> when labeled networking is in use and am confused about what I am
> seeing. :-)
>
> My assumption is that when using this feature, the resulting ssh
> connection will have single mls level, which is the effective level of
> the issuer. 
>
> For example, if I am
> uid=500(ealuser) gid=500(ealuser) groups=10(wheel),500(ealuser)
> context=staff_u:staff_r:staff_t:s3-s9
>
> When I issue ssh -p 222 -l <user> <host>, I expect to see "s3" as my new
> mls level in the new ssh connection when I do an "id".
>
> With CIPSO, this happens.
> With labeled ipsec, I get "s3-s9".
>
> Debugging xinetd, I noticed that when using CIPSO, getpeercon() returns 
> "system_u:object_r:unlabeled_t:s3".
>
> When using labeled ipsec, getpeercon() returns
> "root:sysadm_r:sysadm_ssh_t:s3-s9".
>
> I always wondered if getpeercon() would someday lift its head and bite,
> I just wish it had not been on Valentine's Day. :-)
> I am concerned about the mls label being returned.
>
> So, my question is, how is this suppose to work?
> Does CIPSO, when given an mls range, like s3-s9, only pass
> the effective level through in ip options? If so, is this 
> what labeled ipsec should be doing? Should we be setting only the 
> effective level in the SA? If so, that could potentially create 
> even more SAs. Or should xinetd, when given a range, should only
> set the effective level for the new process? I kinda like this 
> solution best, that is, xinetd setting single effective level. But
> I don't know if that is correct resolution? 
>
>   
IMO the entire context should be passed, in CIPSO's case that should be 
the range, if your clearance is s9 on one machine why wouldn't it be on 
another that uses the same levels? I'd hate to see userland interpreting 
ranges like this, it will cause assumptions about the mls policy to be 
made in userspace. While CIPSO is done entirely in the kernel (i think?) 
the decision should still not be made outside the security server which 
is the only part of the system that understands what s2-s9 even means 
(consider a modified mls policy where the second part of the range is 
something other than clearance.

It is (again, IMO) entirely inappropriate for racoon or xinetd or the 
CIPSO code to interpret contexts, this issue keeps coming up and the 
answer should always be that the context is interpreted by the security 
server exclusively.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
