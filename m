Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87DtxmT018196
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 09:55:59 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l87DtvvO001626
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:55:57 GMT
Received: by an-out-0708.google.com with SMTP id c38so89878ana
        for <selinux@tycho.nsa.gov>; Fri, 07 Sep 2007 06:55:43 -0700 (PDT)
Message-ID: <46E15844.9070401@gmail.com>
Date: Fri, 07 Sep 2007 08:55:16 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Labelling a new port
References: <f8f6300f0709060943q2393d380p356d86605cf9444f@mail.gmail.com> <7312DE97-0B10-4674-AD51-0EBD7875A4FA@sf-net.com>
In-Reply-To: <7312DE97-0B10-4674-AD51-0EBD7875A4FA@sf-net.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Also look at the Thursday, May 31st, 2007 entry at http://danwalsh.livejournal.com/

Stefan Schulze Frielinghaus wrote:
> You can add ports via semange e.g. "semanage port -a -t 
> memcached_port_t -p tcp 11211"
>
> see semanage(8) for more details
>
> PS: you need to declare the type in your policy before executing the 
> command. look at modules/kernel/corenetwork.te for some examples
>
> On 06.09.2007, at 18:43, Konstantin Ryabitsev wrote:
>
>> Hello, all:
>>
>> I'm trying to write a policy for memcached, but I'm not sure how I'd
>> declare a new memcached_port_t (11211/tcp). Any pointers?
>>
>> TIA!
>>
>> Cheers,
>> -- 
>> Konstantin Ryabitsev
>> Montréal, Québec
>>
>> -- 
>> fedora-selinux-list mailing list
>> fedora-selinux-list@redhat.com
>> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
>
>
> -- 
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
