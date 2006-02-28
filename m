Message-ID: <4404309B.9020001@redhat.com>
Date: Tue, 28 Feb 2006 06:14:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Desktop integration
References: <43DE6244.5010100@cornell.edu> <43DE6578.9050302@redhat.com> <4403E64B.6010804@cornell.edu>
In-Reply-To: <4403E64B.6010804@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>>
>>
>> 1. That a user can relabel to all of the customizable types.  In most 
>> policies he will not be allowed to .
> That's fair enough, but it can be checked...
>>
>> 2. That the only types he can relabel to are customizable.
>> For  example user_home_t is not necessarily customizable but a user 
>> could change a context to it.
>>
> I don't understand this one. Why is the user allowed to relabel to a 
> non-customizable type.
>
> Something's wrong with this - it appears to carry a risk that the file 
> will be automatically relabeled later, even after the user has made an 
> explicit request that it must be labeled user_home_t - that certainly 
> seems like a bad thing.
Usually the user would be changing a badly labeled file back to 
user_home_t in his home directory.  So if a user changes a context to a 
customizable type, he might want to later change the context back.   
user_home_t should not be a customizable type, because a user could 
create a file in his home dir and then mv it to /var/www/html for 
example.  We would not want that context to remain user_home_t.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
