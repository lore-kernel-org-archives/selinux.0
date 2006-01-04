Message-ID: <43BBFEB1.4000903@redhat.com>
Date: Wed, 04 Jan 2006 11:58:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Seuser mls validation
References: <43BA42A6.5020609@cornell.edu>  <43BA498C.60102@cornell.edu> <1136382518.27632.221.camel@moss-spartans.epoch.ncsc.mil> <43BBBB8E.8030208@cornell.edu>
In-Reply-To: <43BBBB8E.8030208@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>> Is the semanage diff here obsoleted by Dan's latest policycoreutils
>> patch?  
> Yes, just use Dan's copy...
>> Also, the first hunk looks odd to me - what is it doing?
>>   
> No clue - that's why I was deleting it :)
> It just caused python interpreter errors.
>
Yes use mine.  The self.dict stuff was an original implementation that 
didn't get fully removed.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
