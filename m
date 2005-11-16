Message-ID: <437B42A9.7010407@cornell.edu>
Date: Wed, 16 Nov 2005 09:31:05 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Clear obsoleted objects
References: <437A7AD5.6040500@cornell.edu> <1132150739.3425.16.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1132150739.3425.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
> Thanks, merged as of libsemanage 1.3.55.
>   
I just found a bug ... should be using rtable->key_free(key), not free(key).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
