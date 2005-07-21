Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LIKDgA028677
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:20:13 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LIEnBa000700
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:14:49 GMT
Message-ID: <42DFE632.1080001@tresys.com>
Date: Thu, 21 Jul 2005 14:15:14 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 3/6] Users
References: <1121967866.9844.32.camel@celtics.boston.redhat.com>
In-Reply-To: <1121967866.9844.32.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>The following patch is intended to replace
>genusers.c (but not yet). It provides functions 
>to add, delete and load users into a policydb object.
>It uses a structure (sepol_uinfo_t) as the
>higher level representation for a user, and
>takes out the parsing.
>
>libsepol-2.1-users.diff
>
>Disclaimer 1:
>The role list must be NULL terminated. 
>
>  
>
The libsemanage api I'm writing right now has num_roles, IMO better than 
null termination in that it's easier to make mistakes with null termination

struct semanage_user {
        char *name;             /* Key */
        struct semanage_role **roles;
        int num_roles;
        struct semanage_mls *mls;
}

>Disclaimer 2:
>Not sure MLS processing is correct - please
>take a look.
>  
>
I've been talking to the TCS guys while here about the right thing to do 
with MLS so the libsemanage api should be correct.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
