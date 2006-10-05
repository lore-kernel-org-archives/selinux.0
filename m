From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC PATCH] newrole suid breakdown
Date: Fri, 6 Oct 2006 09:15:11 +1000
Cc: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, jdesai@us.ibm.com
References: <452432FA.1060009@us.ibm.com> <45250F35.6030204@redhat.com>
In-Reply-To: <45250F35.6030204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610060915.15441.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 05 October 2006 23:57, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Does the code continue to work correctly if I compile in AUDIT_LOG_PRIV
> and NAMESPACE_PRIV but run it without the setuid bit and as a normal
> user.  IE, We want the option to only set this setuid when in an MLS
> environment.  This is not required for targeted or strict policy machines.

Who does "we" mean in this context?

I would like to have newrole work with namespaces in a strict policy 
environment!

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
