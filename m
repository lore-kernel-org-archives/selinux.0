Message-ID: <466811C0.7080400@kaigai.gr.jp>
Date: Thu, 07 Jun 2007 23:10:08 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joe Nall <joe@nall.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
 interface)
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com> <4667ABFD.2070703@ak.jp.nec.com> <4667B6E3.1010000@ak.jp.nec.com> <200706070751.19644.paul.moore@hp.com>
In-Reply-To: <200706070751.19644.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> One more point is here.
>> How should be handled a connection come from unlabeled network, without any
>> fallbacked context? Two ways are considerable for me. One is that
>> getpeercon() really returns -ENOPROTOOPT, the other is returning an initial
>> context newly defined for this purpose.
> 
> My personal opinion is that the current getpeercon() behavior of 
> returning -ENOPROTOOPT when a peer label is not present is probably the best 
> solution as it allows per-application handling of this particular case.  
> Earlier in the thread Stephen mentioned that Eamon had developed a way to 
> handle this for X using a domain specific fallback label and that approach 
> seems to make the most sense to me.

OK, I agree your opinion.
SE-PostgreSQL also follows Eamon's solution for the final fallbacked context,
to avoid unnecessary confusion.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
