Message-ID: <43BC1ECA.1070806@redhat.com>
Date: Wed, 04 Jan 2006 14:15:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policycoreutils latest diffs.
References: <43BAC4EA.8020106@redhat.com> <43BAB2D6.4030103@cornell.edu> <43BBF8C6.1070109@cornell.edu> <43BBFA8A.2040601@cornell.edu>
In-Reply-To: <43BBFA8A.2040601@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>>
>> Let's look at two cases of code that I don't understand:
> Here's another one from the user add:
>
>                (rc,exists) = semanage_user_exists_local(self.sh, k)
>                if not exists:
>                        (rc,exists) = semanage_user_exists(self.sh, k)
>                        if not exists:
>                                raise ValueError("SELinux user %s is 
> already defined." % name)
>
> This doesn't make sense, because you take the same action regardless 
> of whether the exist test fails locally, or on the final result (which 
> combines policy with local modifications). Hence, you might as well 
> skip the first one and go straight to the second one (which will 
> include the first one).
>
>
>
>
>
Ok, I might have misunderstood the symantics.  But Should the following 
checks be in place


delete
if does not exist local; error since you can not delete an object from 
the server?
Prevent the user from deleting SELinux User "root"

Add
if does exist: error

Modify:
If does not exist local; you are not allowed to modify, see above.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
