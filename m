Message-ID: <440C6DE2.1070705@redhat.com>
Date: Mon, 06 Mar 2006 12:14:10 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Desktop integration
References: <43DE6244.5010100@cornell.edu> <43DE6578.9050302@redhat.com> <4403E64B.6010804@cornell.edu> <4404309B.9020001@redhat.com> <44047CFC.3040009@cornell.edu>
In-Reply-To: <44047CFC.3040009@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>>>>
>>>> 2. That the only types he can relabel to are customizable.
>>>> For  example user_home_t is not necessarily customizable but a user 
>>>> could change a context to it.
>>>>
>>> I don't understand this one. Why is the user allowed to relabel to a 
>>> non-customizable type.
>>>
>>> Something's wrong with this - it appears to carry a risk that the 
>>> file will be automatically relabeled later, even after the user has 
>>> made an explicit request that it must be labeled user_home_t - that 
>>> certainly seems like a bad thing.
>> Usually the user would be changing a badly labeled file back to 
>> user_home_t in his home directory.  So if a user changes a context to 
>> a customizable type, he might want to later change the context back.   
> Customizable types won't prevent you from changing the context back - 
> they'll just prevent restorecon from changing its type.
>> user_home_t should not be a customizable type, because a user could 
>> create a file in his home dir and then mv it to /var/www/html for 
>> example.  We would not want that context to remain user_home_t.
> Why not? I don't like it when restorecon tries to be extra smart.
> The user should make an explicit request to expose his files to the 
> web (via chcon), rather than  relying on automated relabeling with 
> restorecon, which seems like it should be used for a completely 
> different purpose.
Because the user does not understand.  He creates a cgi script in his 
home directory or /tmp and then mv's it to /var/www/cgi-bin or 
/var/www/html.  In his mind the act of moving it to /var/www/html is the 
act of sharing it.  So
having him figure out that the context should be httpd_sys_content_t is 
just a burden.  Similarly if he moves a local copy of
resolv.conf from his homedir to /etc. and runs restorecon it will not work.


I guess having the list of customizable types plus "Default" would 
work.  Default running or executing the equivalent of restorecon.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
