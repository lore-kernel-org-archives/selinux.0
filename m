Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09F9a4n007639
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 10:09:36 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l09FAOeY015469
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 15:10:25 GMT
Message-ID: <45A3B05E.50707@tresys.com>
Date: Tue, 09 Jan 2007 10:10:22 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] allow semodule -i to accept list of modules
References: <1168292627.14203.2.camel@localhost.localdomain> <45A31548.8030807@tresys.com> <45A3A7F3.20904@mentalrootkit.com>
In-Reply-To: <45A3A7F3.20904@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Joshua Brindle wrote:
>> Karl MacMillan wrote:
>>> The following patch allows semodule to handle a list of modules for
>>> installation (i.e., semodule -i *.pp now works).
>>>
>>>   
>> Hrm, while the current syntax isn't ideal I don't think its the best 
>> idea to change it abruptly. maybe you could make -I use the rest of 
>> the arguments or something otherwise this will break any number of 
>> rpm's, portage, the refpolicy makefiles and so on.
>>
> 
> I don't see how this could cause breakage as it doesn't change how any 
> currently valid option sequence is processed. Instead, it makes invalid 
> syntax valid (if you look closely at the patch, you can see that I am 
> actually changing a fatal error path - so what I describe is guaranteed 
> to be true).
> 
> I prefer this approach because I think it is the least surprising. I 
> constantly try the syntax this patch allows only to remember that it 
> doesn't work.
> 

oops, you are right.. do you think having 2 distinct syntaxes for the 
same argument will be less surprising than splitting them up?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
