Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8TCdggH029829
	for <selinux@tycho.nsa.gov>; Sat, 29 Sep 2012 08:39:42 -0400
Message-ID: <5066EBED.3060609@hp.com>
Date: Sat, 29 Sep 2012 08:39:09 -0400
From: "Sutton, Harry (GSE)" <harry.sutton@hp.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: semanage: should -a imply -m?
References: <1348859914.2845.4.camel@localhost>
In-Reply-To: <1348859914.2845.4.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/28/2012 03:18 PM, Eric Paris wrote:
> What do others think about this?  Should we cause -a to act like -m or
> should it abort?  Should we force the -a ->  -m logic up to the caller?
> I guess I'm fine with either.  Is semanage -a enough like semodule -i
> and -m like -u that this would actually be expected behavior?
>
I'm inclined to think it should be the other way around, that is, -m 
should act like -a.

If you create a new rule using semanage -a that differs in multiple but 
potentially subtle ways from an existing entry you are unaware of, the 
result may not be at all what you wanted; in that case, the user should 
be warned that the record already exists. Maybe a compromise, to improve 
usability, would be to test for single vs multiple changes before 
throwing an error.

     /Harry

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
