Message-ID: <43580DBB.2010207@cornell.edu>
Date: Thu, 20 Oct 2005 17:35:55 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Remove unused relay functions
References: <43580ADB.1060003@cornell.edu>
In-Reply-To: <43580ADB.1060003@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> What I don't like very much is that accessing the functions directly 
> via the dbase interfaces assumes binary compatibility between the 
> sepol and semanage record (currently true), while in the previous 
> versions I had convert() functions to change between the two. I've put 
> a warning - not sure if I'll do anything about it.
Well, the warning was skipped in this patch, but it will be in the next one:

        switch (arg->mode) {

                /* WARNING:
                 * This assumes binary compatibility between
                 * the source and target key/record type. This is currently
                 * true, but may change in the future (?) */

                case MODE_SET:
                        if (dtable->set(handle, dbase, rkey, record) < 0)
                                goto err;
                        break;

                default:
                case MODE_MODIFY:
                        if (dtable->modify(handle, dbase, rkey, record) < 0)
                                goto err;
                        break;
        }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
