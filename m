Message-ID: <43BBD715.8070603@cornell.edu>
Date: Wed, 04 Jan 2006 09:09:25 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] [SETSEBOOL] Clone record on set/add/modify
References: <43BBD6C0.6020108@cornell.edu>
In-Reply-To: <43BBD6C0.6020108@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Hi, Steven pointed out (off-list) that libsemanage vs libsepol 
> behavior is inconsistent with respect to set/add/modify.
> In libsemanage, the object being added becomes "managed" by the 
> library, while this is not true in libsepol. We decided it was better 
> to have the client control the object passed in, and be responsible 
> for freeing it.
>
> This patch makes the appropriate changes (which include reversal of 
> some of the code from the other patches) to implement that.
> It also includes a bugfix for the error path of 
> database_policydb.c:list, pointed out by Russel Coker.
>
By the way, how does python handle this - does it manage memory 
management automatically, or do we still need to call the free 
functions.... because.. I don't see any free functions being called in 
the semanage tool - not even for the key.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
