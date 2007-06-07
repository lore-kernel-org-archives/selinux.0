Message-ID: <4667ABFD.2070703@ak.jp.nec.com>
Date: Thu, 07 Jun 2007 15:55:57 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joe Nall <joe@nall.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
 interface)
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com> <200706060745.31980.paul.moore@hp.com> <4666ED96.8080508@kaigai.gr.jp> <200706061342.15348.paul.moore@hp.com>
In-Reply-To: <200706061342.15348.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>  >> Is it different from Paul's idea, isn't it?
>>  >>
>>  >> > In my understanding, he intends to associate a domain's context
>>  >> > directly with network interfaces and/or network addresses.
>>  >
>>  > Yes, that is correct.  It is similar to how existing trusted OSs provide
>>  > connection/packet labels for unlabeled hosts/networks.
>>
>> Is it possible to apply onto TE label, not only MLS label?
>>
>> Domain transition via packet class is a bit hard to understand.
>> It's preferable, if we can configure the fallbacked client context
>> directly, as follows:
>>     192.168.1.0/24 --> system_u:system_r:sepgsql_client_t
>>     192.168.2.0/24 -->
>> system_u:system_r:sepgsql_trusted_client_t:SystemLow-SystemHigh
> 
> That is exactly what I am intending to implement;  the system administrator
> would specify a interface/address/netmask that would match to a _full_ 
> SELinux context as you have described above.

Good. It will be more straightforward approach than server's domain
transition.
BTW, do you have a plan how to configure the association between them?

> Now, using a type which is 
> obviously specific to sepostgres (sepgsql_client_t) may not be the best 
> choice for a system-wide value, but you could set it to a more generic type 
> and the individual label-aware applications could transition to a more 
> specific type as appropriate (much like you described in your other email).

OK, I agreed.
If a system-wide fallbacked context is defined, we can use it as a source
of domain transition for its necessity.

Thanks,
--
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
