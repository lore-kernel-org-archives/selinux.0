Message-ID: <434699D7.9040307@cornell.edu>
Date: Fri, 07 Oct 2005 11:52:55 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-dev@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil> <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Ok, I've made a first cut at the changes to libsepol and updated it and
> checkpolicy to build again, and am starting to work through libsemanage.
> As an example of what to expect, the diff below to database_direct.[ch]
> was needed to get it to compile again.
>   
Ok...

On second thought that code was likely wrong to begin with, since Tresys 
put their modules in a special package container, and mark everything 
with a special magic, and use special functions to read everything.... 
I'll get it fixed later... not testing the direct case yet.

-    policydb = (policydb_t*) malloc(sizeof(policydb_t));
-    if (!policydb)
+    if (sepol_policydb_create(&policydb, SEPOL_POLICY_KERN))

Why do I get a feeling of deja-vu when I look at this code... :) I think 
I've already tried this once - I recall Karl convincing me it policydb 
shouldn't be opaque. Checkpolicy will be confusing to fix. By the way, 
is it really necessary to specify KERN type in the create() function. I 
thought you could detect the policy type, and mark it in the policydb 
object (rather than propagating it down from the caller).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
