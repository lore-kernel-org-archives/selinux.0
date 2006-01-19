Message-ID: <43D016A1.6010004@cornell.edu>
Date: Thu, 19 Jan 2006 15:45:53 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, selinuxdev <selinux-dev@tresys.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
In-Reply-To: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> - chance semanage_is_managed to use can_write instead of create_store
> for access check
>   
Why should semanage_is_managed do an access check?
How does the lack of access mean that the store isn't managed?
I see in seobject, both is_managed, and can_write are called now, 
meaning two access checks
(and shouldn't they be in the opposite order).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
