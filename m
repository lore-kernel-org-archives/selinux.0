Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9HJDTNF007363
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 15:13:29 -0400
Received: from flower.research.telcordia.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9HJC9DM025118
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 19:12:09 GMT
Received: from [127.0.0.1] (ar12-209.research.telcordia.com [192.4.12.209])
	by flower.research.telcordia.com (8.14.2/8.14.2) with ESMTP id m9HJDgSG026993
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 15:13:43 -0400 (EDT)
Message-ID: <48F8E3D4.50800@research.telcordia.com>
Date: Fri, 17 Oct 2008 15:13:24 -0400
From: Sanjai Narain <narain@research.telcordia.com>
MIME-Version: 1.0
CC: selinux@tycho.nsa.gov
Subject: Re: Protecting against inadvertent file copy
References: <48F798BB.6070602@rubix.com>	 <1224186793.9247.139.camel@moss-spartans.epoch.ncsc.mil>	 <1224186905.9247.141.camel@moss-spartans.epoch.ncsc.mil>	 <48F85ECC.108@rubix.com>	 <1224245613.18694.26.camel@moss-spartans.epoch.ncsc.mil>	 <48F89EBE.6020800@rubix.com>	 <1224253435.19562.23.camel@moss-spartans.epoch.ncsc.mil>	 <48F8ABBC.9060808@rubix.com>	 <1224256522.19562.54.camel@moss-spartans.epoch.ncsc.mil>	 <48F8B58C.9040609@research.telcordia.com> <1224263695.19562.89.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1224263695.19562.89.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Steve: Thanks very much! Best regards. -- Sanjai

Stephen Smalley wrote:
> On Fri, 2008-10-17 at 11:55 -0400, Sanjai Narain wrote:
>   
>> Hello: I am just getting started with SELinux, and would very much 
>> appreciate an answer to the following question:
>>
>> Suppose there is a directory ftp_dir. If one wants to allow ftp of one's 
>> file to the outside world, one places it in ftp_dir. Suppose there is 
>> also a directory private_dir. One wants to prevent copying of any file 
>> in that directory into ftp_dir. In particular, one wants to say "do not 
>> allow cp from private_dir to ftp_dir". How would one go about expressing 
>> this in SELinux?
>>     
>
> By labeling the two directories with two different types, and defining
> the roles/domains such that no domain can both read from private_dir and
> write to ftp_dir.  If you want to be strict about it, you'd further have
> to ensure that there is no path by which information from private_dir
> can eventually flow to ftp_dir, e.g. by copying it first into some
> shared directory and then from there to ftp_dir.  apol will show
> information flow paths among types.
>  
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
