Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <rwashington@crucialsecurity.com>
Subject: Re: http domain
Date: Thu, 12 Sep 2002 21:06:19 +0200
References: <DPEPJAJGOCGHICPODIHPGEFGCBAA.rwashington@crucialsecurity.com>
In-Reply-To: <DPEPJAJGOCGHICPODIHPGEFGCBAA.rwashington@crucialsecurity.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200209122106.19445.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As you are replying to a public message, and you don't appear to be discussing 
anything remotely secret I'll reply to the list.  I hope you don't mind.

On Thu, 12 Sep 2002 20:49, Ryan Washington wrote:
> if i were to do anything serious and configure the http domain
> specifically, which file(s) should i change? i can't seem to locate any
> user friendly documentation anywhere.

True.  The documentation is not as user friendly as it should be.  Things are 
improving, but slowly.  There's plenty of work to do in base functionality 
yet which keeps people from writing documentation.

> With the domains, are they set up to lock down directories? such as http.
> can you isolate it so that http only sees/uses the necessary directories?

The general aim of the policy is to lock things down as much as possible.  The 
httpd_t domain however needs to do lots of things and generally gets more 
access than you want, in my tree it gets read access to all of the user home 
directories!!!  Ideally this should be changed to only allow it access to 
files/directories that the user specifies.  However I haven't developed 
suitable methods for managing this yet.

In my SE policy Apache is only granted read access to home directories, which 
is a big improvement over a typical configuration of non-SE Linux!

> also, where can i get documentation to make a domain? i checked out the
> website, but everything starts jumbling together after a few days of
> reading. which paper is the best for a new guy trying to build a new
> domain? thanks again,

Just copy a domain that is similar and do ":%s/oldname/newname/g", that's what 
I do.

Also make sure you copy a domain that is simple and new.  Some of the earlier 
domains are a bit crufty and really should be tidied up.


Russell Coker


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
