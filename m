Date: Mon, 13 Aug 2001 08:09:16 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Senior <slax@ksni.net>
cc: SELinux@tycho.nsa.gov
Subject: Re: problems with checkpolicy.conf and make initinstall
In-Reply-To: <3B740922.1B1A497@ksni.net>
Message-ID: <Pine.SOL.3.95.1010813080840.13872B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This is a known bug - see the patch I posted on May 7th at
http://marc.theaimsgroup.com/?l=selinux&m=98926011507312&w=2.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



On Fri, 10 Aug 2001, Ryan Senior wrote:

> When I execute the command make initinstall I recieve this error.
> 
> ./checkpolicy:  loading policy configuration from
> /usr/src/slinux/policy/initpolicy.conf
> error in the statement ending on line 1054 (token ';'): unknown class
> filesystem used in rule
> 
> I think that the following code is the code it is having difficulty with
> 
> #
> # Allow each file type to be associated with
> # the default file system type.
> #
> allow file_type fs_t:filesystem associate;
> 
> 
> Is this a known error?  Is there an easy way to fix it?
> I'm running Red Hat 7.1.
> 
> Thanks,
> Ryan
> 
> 
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
