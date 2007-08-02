Message-ID: <46B20F0B.90601@manicmethod.com>
Date: Thu, 02 Aug 2007 13:06:19 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Paul Moore <paul.moore@hp.com>
Subject: Re: [PATCH] kernel: selinux: policy selectable handling of unknown
 classes and perms
References: <1185983352.3673.16.camel@localhost.localdomain>	 <1186065564.2434.12.camel@moss-spartans.epoch.ncsc.mil>	 <46B1F5D1.3020804@manicmethod.com> <1186068805.2434.40.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1186068805.2434.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-08-02 at 11:18 -0400, Joshua Brindle wrote:
>   
>
>>> So...is it worth it by itself?
>>>   
>>>       
>
> You didn't answer the question ;)
>
>   
Hrm..

I thought it was at least useful sometimes but actually objclass/perm 
discoverability that lets the object managers short circuit decisions 
when object classes aren't defined seems like it has alot more benefits. 
Really the object manager knows how to deal with a lack of policy 
knowledge about its object classes better than the security server does.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
