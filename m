Message-ID: <46F0065B.1060101@manicmethod.com>
Date: Tue, 18 Sep 2007 13:09:47 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Change default error handling in libselinux matchpathcon to use
 syslog instead of stderr.
References: <46EFF028.4040500@redhat.com>
In-Reply-To: <46EFF028.4040500@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Current behavior causes problems with network applications.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=273081
>   

Wait, what?

I don't think it is an improvement to call the command line matchpathcon 
applications and have the logs go somewhere not visible by the user. IMO 
we should take the same approach libsemanage and libsepol did where the 
logging callbacks can be overridden by specific users of the library but 
for the command line applications the output still goes to stderr.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
