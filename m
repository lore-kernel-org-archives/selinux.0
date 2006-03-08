In-Reply-To: <440F520C.8080604@cornell.edu>
References: <4404BA44.8000503@cornell.edu> <440F2E61.4070905@cornell.edu> <A98716CB-BC6B-4EFE-B480-2B31C8D6FACD@nall.com> <440F520C.8080604@cornell.edu>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B3F5B17C-05F6-4697-88A9-7935404D6AA6@nall.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
From: Joe Nall <joe@nall.com>
Subject: Re: Desktop Integration Take 2
Date: Wed, 8 Mar 2006 16:50:10 -0600
To: Ivan Gyurdiev <ivg2@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mar 8, 2006, at 3:52 PM, Ivan Gyurdiev wrote:

>
>>>> - Have a file controlled by libsetrans which maps mls ranges to  
>>>> (unicode?) translated strings
>>>>     (setrans.conf)
>>>>
>>>> - Require the mappings above to be 1:1.
>> ...
>>
>> The work I'm doing on better MLS inverse bit handing (rel country1/ 
>> country2 ...) in libsetrans supports mapping label fragments  
>> (individual categories and category ranges) in addition to the  
>> current 1:1 mapping.
> It was my understanding that the range should be treated as a whole  
> for maximum generality, and we shouldn't unroll and translate  
> individual categories [ at least for the purposes of nautilus ].  
> That way you could have a coded clearance label like:  
> NSASecretProject, that unrolls to the actual categories [ say  
> NDA_1, NDA_3, Programmer, NSA, Security, Confidential, ProjectX ],  
> without listing them all individually.

This doesn't scale in some (not all) environments. See below.

>> With 256 bits, 1:1 MLS mappings are not practical because the  
>> number of potential combinations is so great. I hope to have a  
>> patch for review at by the end of next week.
> My comment said they should be 1:1, not onto.
> (i.e. I don't expect the setrans file to define a translation for  
> each and every bit combination. In fact, I though I could ignore  
> the unspecified ones, and not provide access to them via the  
> Nautilus GUI. They'd still be available for use, but they wouldn't  
> be exposed via nautilus if they're not in the setrans file).

I agree that you can ignore the categories with unspecified mappings.  
I want to define a translation for 238 countries and combinations  
thereof (billions and billions to quote Carl Sagan) in the  
setrans.conf file. In order to keep the size finite, I have to have  
mappings that combine in addition to the current one name to many  
categories mappings. I'll send you an image of what our current label  
chooser looks like off list. If the selection mechanism supports a  
plugin, we can replace a simple picker with something more complex  
when warranted.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
