Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4GG6EDE028434
	for <selinux@tycho.nsa.gov>; Sat, 16 May 2009 12:06:14 -0400
Received: from mho-02-ewr.mailhop.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4GG6JpR011406
	for <selinux@tycho.nsa.gov>; Sat, 16 May 2009 16:06:19 GMT
Cc: dwalsh@redhat.com, method@manicmethod.com,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, russell@coker.com.au,
        SE-Linux <selinux@tycho.nsa.gov>
Message-Id: <86170769-8CD9-4A99-9C14-624611280E55@nall.com>
From: Joe Nall <joe@nall.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
In-Reply-To: <4A07B36C.1080305@ak.jp.nec.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: daemons and MCS categories
Date: Sat, 16 May 2009 11:05:56 -0500
References: <200605220930.05483.russell@coker.com.au> <1148910738.14262.67.camel@sgc.columbia.tresys.com> <49EC1F11.6040003@ak.jp.nec.com> <49ED29CC.6080507@ak.jp.nec.com> <49EED77F.5060407@ak.jp.nec.com> <4A07B36C.1080305@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On May 11, 2009, at 12:11 AM, KaiGai Kohei wrote:

> Are anyone interested in the daemon process with mcs categories?
>
> My proposition tries to cover general daemon processes, but my
> major concern is apache/httpd performing without any categories.
> If we focus on the apache/httpd, we can add the following policy
> within the mod_selinux.pp, and it enables to run httpd_t with
> mcs categories.
>
>  optional_policy(`
>      init_ranged_daemon_domain(httpd_t,httpd_exec_t,s0 -  
> mcs_systemhigh)
>  ')
>
> The mod_selinux.so is an apache/httpd module which enables to
> change its own security context prior to launching contents
> handler. We can set up the module to drop all the categories
> for unauthorized http clients, and rest of requests to perform
> with appropriate categories.
>
> The above rule will be available only when mod_selinux is installed.
> I don't think it gives any impact for existing stuffs.
>
> Any comments?

FWIW, we run apache 1.3 out of xinetd at multiple contexts using  
labeled networking. HTTP performance is surprisingly good. HTTPS  
performance is unacceptable, so we are using an HTTPS reverse proxy in  
a DMZ for single level network services to the 'enterprise'.

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
