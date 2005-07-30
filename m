Message-ID: <42EBD15A.50401@tresys.com>
Date: Sat, 30 Jul 2005 15:13:30 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil> <Lynx.SEL.4.62.0507300018460.14594@thoron.boston.redhat.com>
In-Reply-To: <Lynx.SEL.4.62.0507300018460.14594@thoron.boston.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:

>The checkpolicy stuff doesn't compile for me:
>
>$ make
>cc -g -Wall -O2 -pipe -fno-strict-aliasing -I. -I/usr/include -o 
>checkpolicy.o -c checkpolicy.c
>checkpolicy.c: In function ‘cond_check_type_rules_list’:
>checkpolicy.c:288: error: ‘avtab_key_t’ has no member named 
>‘specified’
>checkpolicy.c:289: error: too few arguments to function ‘avtab_search’
>checkpolicy.c: In function ‘main’:
>checkpolicy.c:587: error: too few arguments to function 
>‘check_assertions’
>make: *** [checkpolicy.o] Error 1
>  
>
It looks like you are building against your system headers, building the 
entire selinux-usr repository with DESTDIR should work correctly

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
