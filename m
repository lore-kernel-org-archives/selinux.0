Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8OD23R3018576
	for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2007 09:02:03 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8OD22D3014375
	for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2007 13:02:02 GMT
Message-ID: <46F7B51A.2020706@manicmethod.com>
Date: Mon, 24 Sep 2007 09:01:14 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov
Subject: Re: chcon -l permission
References: <FB39F4E77226B448BC1388D3BE4E00CD49A287@blums0008.bluelnk.net> <1190637842.15178.24.camel@gorn>
In-Reply-To: <1190637842.15178.24.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Sat, 2007-09-22 at 17:05 -0700, Clarkson, Mike R (US SSA) wrote:
>   
>> I have a java process running in a domain named frontgate_t, which reads
>> files and determines the correct classification/compartment level of the
>> file based upon its contents. The java process then relabels the file to
>> the correct level using "chcon -l ...". It can both upgrade or downgrade
>> the level of the file
>>
>> I'm getting file relabelfrom and relabelto denials in the audit log that
>> I can't get past. I've provided the allow rule indicated by audit2allow.
>> At first I thought this was an mls constraint issue. I expect that the
>> following mls privileges would be required:
>> 	mls_file_upgrade(frontgate_t)
>> 	mls_file_downgrade(frontgate_t)
>> 	mls_context_translate_all_levels(frontgate_t) (maybe needed??)
>>
>> I provided all of these, and then progressively added more and more mls
>> privileges until I had provided them all. Next, I gutted the mls file
>> that contains all of the mls constraints to once and for all convince
>> myself that this wasn't an mls constraint issue.
>>
>>     
Note: you can use audit2why to convince yourself of whether something is 
a TE or constraint issue without granting your application all MLS 
privileges.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
