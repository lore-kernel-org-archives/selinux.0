Message-ID: <46BBAE00.7050600@manicmethod.com>
Date: Thu, 09 Aug 2007 20:14:56 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        dwalsh@redhat.com
Subject: Re: [PATCH] selinuxfs to globally disable dontaudit rules
References: <1186696737.20393.10.camel@localhost.localdomain> <Pine.LNX.4.64.0708091525410.30691@us.intercode.com.au>
In-Reply-To: <Pine.LNX.4.64.0708091525410.30691@us.intercode.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Thu, 9 Aug 2007, Eric Paris wrote:
>
>   
>> Currently to disable dontaudit rules best you can do it to load the
>> enableaudit.pp base policy.  Which still doesn't remove the dontaudit
>> rules from modules.
>>     
>
> Are we sure this can't be done in userspace?  Like, mangle all the 
> existing policy and reload it?
>
>   
I agree, the infrastructure is certainly in place to do it, just add 
something in the sepol_handle that says dontaudits should be discarded, 
then make an interface in libsemanage that uses that and rebuild the policy.

If noone beats me to it I will see if my conclusions about it being 
fairly simple are accurate this weekend :)




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
