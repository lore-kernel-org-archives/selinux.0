Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AFoGjo016095
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 11:50:16 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7AFoELC027134
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 15:50:14 GMT
Message-ID: <46BC8913.20905@redhat.com>
Date: Fri, 10 Aug 2007 11:49:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: selinux@tycho.nsa.gov
Subject: Re: java.if
References: <FB39F4E77226B448BC1388D3BE4E00CD01FB787D@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01FB787D@blums0008.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Clarkson, Mike R (US SSA) wrote:
> I have a number of domains in which I run java programs. I generally
> enter these domains using a script, and then execute_no_trans the java
> executable. So I found I kept replicating the following allow rules in
> these various domains:
>
> require {type java_exec_t;}
> allow weblogic_t java_exec_t:file {getattr read execute
> execute_no_trans};
>
> I looked for an interface to use in java.if, but didn't find one. I
> added one myself so I could eliminate the above rule in each of these
> domains, but I was surprised not to find an existing interface to use.
> This seems like it would be a common issue that other policy creators
> would run into as well, or am I just missing something?
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   
Yes there should be an java_exec method.  One problem though is java 
requires execmem execstack and usually other
domains do not have this context.   So what we really need is a way to 
clone a type.  So

java_clone_exec(abc_t) 

Would end up with a new domain, that was the same as  abc_t but added 
execmem and execstack. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
