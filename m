Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0J9ZE7X031713
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 04:35:14 -0500
Received: from yx-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0J9ZC0X024595
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 09:35:13 GMT
Received: by yx-out-1718.google.com with SMTP id 3so1077307yxi.84
        for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 01:35:12 -0800 (PST)
Message-ID: <4974494D.8040104@gmail.com>
Date: Mon, 19 Jan 2009 01:35:09 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: netstat -Z
References: <200901181932.37457.russell@coker.com.au> <497434CA.1070104@ak.jp.nec.com>
In-Reply-To: <497434CA.1070104@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Russell Coker wrote:
>> The command "netstat -Z -t" will show two entries for a localhost 
>> connection and thus show the context of each end of the socket.
>>
>> The command "netstat -Z -x" seems to only show a single entry for the 
>> connection which will be from the server end.
>>
>> http://wiki.postgresql.org/wiki/SEPostgreSQL
>>
>> The above wiki page mentions "netstat -Z" and my personal 
>> interpretation of this was that I could use "netstat -Z" to find the 
>> context of a client end of a socket.  But it seems that I can only 
>> get the server end.
>>
>> Is this what is desired?
>
> Please note that the above wiki entry is on "postgresql.org".
> It assumes PostgreSQL folds (not SELinux specialist) as audiences.
> The purpose of description about "netstat -Z" is to make clear
> the fact security context can be assigned to various kind of
> objects (like socket), except for filesystem also.
>
> Thanks,
Well; it's nice issuing:
ps auxZ to achieve some stats,
as opposed to ps au*;
In any case -Z would be nice to see,

regards;

Justin P. Mattock
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
