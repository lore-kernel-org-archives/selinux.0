Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n74Cj2q9023306
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 08:45:02 -0400
Received: from goalkeeper.city-fan.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n74Cjwh1028471
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 12:45:59 GMT
Message-ID: <4A782D39.5040101@city-fan.org>
Date: Tue, 04 Aug 2009 13:44:41 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Just a quick thought.
References: <4A781970.7000106@redhat.com>
In-Reply-To: <4A781970.7000106@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/08/09 12:20, Daniel J Walsh wrote:
> Now that we have labelling equivalence should we just add a
>
> /lib64 /lib
> /usr/lib64 /usr/lib
> /usr/local/lib64 /usr/local/lib
>
> Seems we could simplify policy and prevent many mistakes.  Might speed up regex matching a little bit.

It would also remove the need for the /lib(64)? style regexes 
altogether, which are unfortunately close to the start of the pathname 
and cause these patterns to score poorly when being considered as a 
possible match for a filename.

> grep 64 /etc/selinux/targeted/contexts/files/file_contexts | wc
>      259     735   18694
>
>
> If were were more aggressive
>
> /usr/local /usr

That looks sane.

> /opt /usr

Don't agree with that one. /opt tends to fill with things like 
/opt/appname and only then the regular structure underneath there with 
/bin, /man etc.

Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
