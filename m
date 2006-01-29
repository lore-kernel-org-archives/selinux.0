Message-ID: <43DC1AE3.20104@cornell.edu>
Date: Sat, 28 Jan 2006 18:31:15 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [SEMANAGE,UTILS] Support seusers.system
References: <43DBC34E.9010100@cornell.edu> <43DC18C0.6050901@cornell.edu>
In-Reply-To: <43DC18C0.6050901@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Note to joshua:
>
> Those system dbases won't really be necessary after seusers.system, 
> and users_extra.system are added into the package format. Then we can 
> get rid of them, and implement this the same way as file contexts is 
> currently done (see that section in direct_api.c) - extract seusers 
> and users_extra directly into the final files (no .system written). 
> Then merge local modifications on top of that.... very easy patch.
Actually I suppose they're not needed now either - all we need to do is 
copy the .system file over the final file.
That just never occurred to me, I like instantiating the dbase, it's 
extremely easy to do :)

I don't think it's worth changing at this point though - we can fix when 
the corresponding sections are merged into the package format.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
