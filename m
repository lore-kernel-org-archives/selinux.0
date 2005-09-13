Message-ID: <43274F67.9010808@cornell.edu>
Date: Tue, 13 Sep 2005 18:15:03 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>, dwalsh@redhat.com,
   jbrindle@tresys.com
Subject: Re: [ SEMANAGE ] Introduce record table
References: <43256F48.7060909@cornell.edu>  <43258D48.80702@cornell.edu> <1126640602.29303.224.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126640602.29303.224.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>(*key_free) prototype in src/record_file.h returns int, but the
>implementations return void.  I assume void is correct.
>  
>
void is correct - the free function should not fail.

>Is there any concern about future namespace collision for the
>dbase*/record* types, even though they are private to the library?  What
>about when you start providing real implementations that have to bring
>in external headers that may have conflicts?
>  
>
Yes, I am concerned about namespace collision, since I run into it all 
the time. However, I think it should be possible to eliminate it 
completely. In particular, specific record types should *never* be 
defined in headers. They're to be used in implementations only, and only 
in files that manipulate one type of record.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
