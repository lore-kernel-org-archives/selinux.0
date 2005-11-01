Message-ID: <43670528.8050701@cornell.edu>
Date: Tue, 01 Nov 2005 01:03:20 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [ SEMANAGE ] Some seusers mapping validation
References: <4366EE1B.1060303@cornell.edu> <4366F160.2070005@cornell.edu> <4367044C.1000501@cornell.edu>
In-Reply-To: <4367044C.1000501@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> +extern int semanage_seuser_validate(
> +	semanage_handle_t* handle);
>   
Doh... will be exported by the map wildcard...
Should I get rid of wildcards?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
