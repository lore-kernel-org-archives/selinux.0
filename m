Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l04DXA3f003756
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 08:33:10 -0500
Received: from web51515.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l04DXtOg010067
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 13:33:55 GMT
Date: Thu, 4 Jan 2007 05:33:26 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Latest diffs
To: russell@coker.com.au, Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200701040905.40416.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <37187.99487.qm@web51515.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> allow_daemons_dump_core - Allow daemons to create corefiles in /
>
>I hope you aren't planning to make this be on by default.  The potential for 
>daemons creating files such as /.autorelabel is not nice.

True. Very few processes should have the ability (or need) to write to /.

>It would probably be better to have some other directory for core files,

I think this had been discussed...not sure where it went.
 
>> Fixes for slocate on MLS

Is slocate in anyone's security target? I was thinking that it was not due to
needing to be level aware.

>Isn't this just a bad idea?

Or maybe needless.

>desire the integrity protection offered by turning off locate?

locate offers no integrity protection. It also has dubious confidentiality since
it is likely not level aware.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
