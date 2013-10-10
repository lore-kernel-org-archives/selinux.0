Message-ID: <5256F74A.4060005@tycho.nsa.gov>
Date: Thu, 10 Oct 2013 14:51:54 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: "Langland, Blake" <blangland@integrity-apps.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: MLS over loopback interface
References: <DA8D339A60101247B36E202899B1C93AA91986@CHUNEX01.integrity-apps.com> <CAFftDdoR+9KXqZzVSYbXHUTYTb=YBomgUQQpYwo87tjfR3O3cg@mail.gmail.com>
In-Reply-To: <CAFftDdoR+9KXqZzVSYbXHUTYTb=YBomgUQQpYwo87tjfR3O3cg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/10/2013 01:31 PM, William Roberts wrote:
> set it as:  s2,s3 (if you can even do that not sure if it works like cats)

No, can't do that with sensitivities.

> 
> 
> On Thu, Oct 10, 2013 at 1:12 PM, Langland, Blake <
> blangland@integrity-apps.com> wrote:
> 
>>  All,****
>>
>> ** **
>>
>> I have two web servers running on an SELinux machine, one running at s2
>> and one at s3. Both webservers have two webapps each that are attempting to
>> communicate over the loopback interface. The communication is strictly s2
>> <-> s2 and s3 <-> s3. The problem I am having is setting the MLS level of
>> the loopback interface. If I have it set below s3, the s3 webapps cannot
>> send over the interface; If I have it set higher than s2, the s2 webapps
>> cannot receive over the interface. Any suggestions?****
>>
>> ** **
>>
>> Thanks,****
>>
>> Blake****
>>
>> ** **
>>
> 
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
