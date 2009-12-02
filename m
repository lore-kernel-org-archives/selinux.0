Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB25hgBV002569
	for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2009 00:43:42 -0500
Received: from smtp104.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id nB25gYxZ006880
	for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2009 05:42:35 GMT
Message-ID: <4B15FE89.5000208@schaufler-ca.com>
Date: Tue, 01 Dec 2009 21:43:37 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>,
        russell@coker.com.au, selinux@tycho.nsa.gov,
        LSM <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] Dynamic port labeling V2
References: <1259616460.2444.9.camel@moss-stripedbass.epoch.ncsc.mil>	 <4B14A111.2000703@schaufler-ca.com>	 <1259679974.2365.29.camel@moss-terrapins.epoch.ncsc.mil>	 <200912020450.28965.russell@coker.com.au>	 <1259694891.2277.4.camel@moss-stripedbass.epoch.ncsc.mil>	 <4B159C82.6090408@redhat.com> <1259708829.8497.22.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1259708829.8497.22.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David P. Quigley wrote:
> On Tue, 2009-12-01 at 17:45 -0500, Daniel J Walsh wrote:
>   
>> On 12/01/2009 02:14 PM, Paul Nuzzi wrote:
>>     
>>> On Wed, 2009-12-02 at 04:50 +1100, Russell Coker wrote: 
>>>       
>>>> On Wed, 2 Dec 2009, "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
>>>>         
>>>>> 1) Where is it located?
>>>>> 2) Is your proposal to implement it as a new fs with a name something
>>>>> like portfs?
>>>>>           
>>>> If it's going to be generic to all LSM modules then we can't 
>>>> use /selinux/ports.  So I guess another filesystem is required.
>>>>
>>>>         
>>>>> 3) How does it get populated initially? Do you have a file for each port
>>>>> right off the bat? Do you only have files for ports with policy or whose
>>>>> permissions differ from the default?
>>>>>           
>>>> It seems to me that the majority of ports will not have discrete labels.  So 
>>>> out of the 65535 ports it would probably be uncommon to have more than 200 
>>>> labels.
>>>>
>>>> Some aspects of the programming will be easier if we have one file per port.  
>>>> But then changing the default label would require writing to more than 60,000 
>>>> files in the common cases.
>>>>
>>>> One possibility would be to have a default label for any port that doesn't 
>>>> have a specific label.  We could have a file per port that has a specific 
>>>> label (probably not much more than 1024 entries on typical systems) and then 
>>>> have a default label for the rest.
>>>>
>>>> Setting the port to the default label would be a matter of either unlinking 
>>>> the file which has the specific label or writing "".
>>>>         
>>> Yours ideas above have shown that there are a lot of ways ports could be
>>> represented through a file system interface but none of them seem to be
>>> a good fit for the present way portcon is implemented.  We still need a
>>> way to stack labels and ranges which can't be easily done with procfs,
>>> unless somebody can think of an intuitive interface.  Performance was
>>> one of the motivating factors for the patch.  It would be easier to use
>>> semange to dynamically relabel ports than to manipulate tons of procfs
>>> entries.  
>>>
>>>       
>>>>> 4) How do I assign a label to the port? You have an issue here that
>>>>> these files are objects themselves. You can't just label the file with
>>>>> what you want the port labeled because now you can't mediate access to
>>>>> these file objects outside of the label on the port itself.
>>>>>           
>>>> The files would have to have the labels as their contents.  The advantage of 
>>>> this is that the permissions needed to set the labels would be independent of 
>>>> what the labels are.
>>>>
>>>>         
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>       
>> You would also need /selinux/ports/udp and /selinux/ports/tcp correct, and I got my way
>>
>> /selinux/ports/tcp/in
>> /selinux/ports/tcp/out
>> /selinux/ports/udp
>>
>> 3*65000 ports.
>>     
>
> also what happens when other transport protocols come around like sctp
> for instance. now we need another 65k files for this as well.
>
>   

Ok, so it would appear that the notion of a fully populated
portfs has sufficient stumbling blocks to make it a non-starter.

A dynamically maintained version, with default values for unallocated
ports and memory based xattrs stored on request would still be viable.

Yes, it's more work. I'd rather see a generally useful scheme than an
SELinux specific one, if for no other reason than it makes the general
case harder to sell later on.

> Dave
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
