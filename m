Message-ID: <45BF5AE3.6030602@mentalrootkit.com>
Date: Tue, 30 Jan 2007 09:49:07 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: Karl MacMillan <kmacmill@redhat.com>, linux-audit@redhat.com,
        ewalsh@tycho.nsa.gov, Steve G <linux_4ever@yahoo.com>,
        selinux@tycho.nsa.gov
Subject: Re: missing avc message field names
References: <20070129185542.32977.qmail@web51502.mail.yahoo.com> <200701291556.37235.sgrubb@redhat.com> <45BE6410.9050604@redhat.com> <200701291749.21897.sgrubb@redhat.com>
In-Reply-To: <200701291749.21897.sgrubb@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Grubb wrote:
> On Monday 29 January 2007 16:16, Karl MacMillan wrote:
>> Steve Grubb wrote:

<snip>

>> All of these messages serve exactly the same purpose - splitting them would
>> be a pain for any app that wants to process them (not to mention dealing
>> with backwards compatibility).
> 
> You already have that problem. AUDIT_AVC and AUDIT_USER_AVC.
> 

Yes, but adding even more message types makes the problem worse. More 
importantly, what does splitting AVC messages even more accomplish? In 
fact, I would rather that AUDIT_AVC and AUDIT_USER_AVC were not split.

>> For example, the policy generation tools that I am working on could
>> process these X messages because they are AVC messages and I only
>> require the core fields to be present (i.e., source / target types,
>> granted / denied, class, and permissions). If they were split out I
>> would a) have to process more message types and b) track which versions
>> of the audit subsystem contain which message types.
> 
> You already have them split out...or did you totally skip AUDIT_USER_AVC? So, 
> you already have to solve the problem so why not generalize the solution? The 
> parsing API should be able to help with this. If you tell it to get all the 
> different types and they don't exist, you don't get a hit except the ones 
> that do exist.
> 

You keep talking about the future - which doesn't yet exist.

So today, if you add a message type I would have to somehow determine 
which audit version I was dealing with so that I didn't pass an invalid 
record type to ausearch (because it bails). Definitely problematic.

Using the audit library would be better if it ignores invalid record 
types, but it still requires tool updates.

>>   If we ever want to have binary audit records, we need to think of these
>>
>>> audit messages as if they were database tables - each type normalized.
>>> This is, I think, where we are ultimately heading.
>> What problems do binary audit records solve?
> 
> Speed and compression. People doing serious auditing have very large files. 
> Compression is extremely important. Also when dealing with large files, any 
> performance trick you can find helps immensely.
> 

gzip or bzip2 compression is not sufficient? Is audit searching 
performance the most important consideration?

Look, I'm not against binary logs, I'm just trying to point out that I 
think that the transition will not be as easy as you seem to suggest.

>> The biggest issue, of course, is that it would prevent the use of any
>> tools that process the files as text (grep, tail, awk, seaudit,
>> setroubleshoot, etc., etc.). 
> 
> ausearch -m all --raw | grep anything you want
> 

tail -f happens to be my favorite counter example, but I am certain 
there are other useful tricks for monitoring logs that will break. Not 
to mention the number of log monitoring and aggregation tools that 
assume text logs.

>> Some can be moved over to the audit library, but it is still useful to use
>> grep, tail, and other shell tools to search logs. I know that you discourage
>> that practice, but I believe that it is (and will remain) useful.
> 
> What happens when the file format changes - zlib compression for example?
> 

zcat :) Seriously, what you seem to be suggesting is that the presence 
of the audit library will make it possible to arbitrarily change the 
audit log format. I believe that the library is not sufficient - 
changing the format will continue to cause breakage and frustration. I'm 
concerned about that as someone that writes applications that are 
consumers of the audit system.

>>>> If all of these keywords in the data dictionary have to be unique, I'm
>>>> wondering if it might be useful to use a 3-tuple instead of a
>>>> (name,value) pair.
>>> I just don't see audit growing that much bigger. Of course, I may be
>>> wrong.
>> Why? I hope there will be a growing list of selinux object managers
> 
> I doubt there very many security related pieces of information that is not 
> already in the dictionary. There are a finite number of security objects and 
> their attributes.
> 

Almost by definition a userspace object manager adds new security 
critical objects. See Eamon's example.

>> And what about third-party tools that are security critical?
> 
> They have the TRUSTED_APP message type and they can put anything in that they 
> want. I consider that one completely freestyle.
> 

Why is it acceptable to have arbitrary name/value pairs in that message 
type and not in others?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
