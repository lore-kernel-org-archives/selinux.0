Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4PBGjvQ013071
	for <selinux@tycho.nsa.gov>; Mon, 25 May 2009 07:16:46 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4PBGd9e026751
	for <selinux@tycho.nsa.gov>; Mon, 25 May 2009 11:16:40 GMT
Message-ID: <4A1A7DF6.8080706@redhat.com>
Date: Mon, 25 May 2009 07:16:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Nigel Rumens <wooky@btconnect.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux and sctp
References: <4A191AAC.4000500@btconnect.com>
In-Reply-To: <4A191AAC.4000500@btconnect.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/24/2009 06:00 AM, Nigel Rumens wrote:
> Hi,
>
> Does selinux understand sctp?
>
> When I run (for example)
>
> sctp_darn -H 0 -P 9876 -l
>
> It results in an avc denial message which tells me the target object is
> of type None[rawip_socket]
>
> Also semanage port -l shows only udp and tcp
>
> Machine tested on was F11 (fully updated) - I also tried it F10 with the
> same results
>
> Thanks
> wooky
>
> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
Well it treats it as a rawip, I am not that familiar with the sctp 
protocol, if you believe we should do more to handle it you probably 
need to discuss with the SELinux developers on the SELinux developers 
mail list

selinux@tycho.nsa.gov

http://www.nsa.gov/research/selinux/subscribe.shtml

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
