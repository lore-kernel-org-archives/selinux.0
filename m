Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l62KZlWY031179
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 16:35:47 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l62KZkr0021234
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 20:35:46 GMT
Message-ID: <4689619E.7060200@redhat.com>
Date: Mon, 02 Jul 2007 16:35:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Allowing apache to read custom types
References: <1183387458.16330.15.camel@localhost.localdomain>
In-Reply-To: <1183387458.16330.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> I had a coworker ask about how to allow apache to read a custom type for
> a policy that he wrote. Essentially, the policy is not focused on web
> pages so it is not really ideal for the types to be generated from the
> apache templates. I couldn't find any interfaces to allow apache to read
> external types (I understand that these would be "reverse" interfaces -
> but it seems like the most convenient way).
>
> Am I just missing the best approach here?
>
> Karl
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   
We could add an attribute

apache_readable and an interface to define it.

read_file_pattern(httpd_t,  apache_readable, apache_readable)
read_file_pattern(httpd_sys_script_t,  apache_readable, apache_readable)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
