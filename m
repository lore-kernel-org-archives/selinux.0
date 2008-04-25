From: "Kim Lawson-Jenkins" <lawson@itd.nrl.navy.mil>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
References: <001f01c8a6f8$f42a9230$c301000a@PC05> <1209145717.26761.169.camel@moss-spartans.epoch.ncsc.mil>
Subject: RE: sepolgen-ifgen
Date: Fri, 25 Apr 2008 13:54:11 -0500
Message-ID: <000001c8a705$c02626e0$c301000a@PC05>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1209145717.26761.169.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for explanation and quick reply.

Kim

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Friday, April 25, 2008 12:49 PM
To: Kim Lawson-Jenkins
Cc: selinux@tycho.nsa.gov
Subject: Re: sepolgen-ifgen


On Fri, 2008-04-25 at 12:22 -0500, Kim Lawson-Jenkins wrote:
> Hi,
> 
>  
> 
> Can someone point me to some text on the Web that explains
> sepolgen-ifgen?  When running audit2allow I received an error "could
> not open interface info" and I found a post stating that using
> sepolgen-ifgen might help solve this particular problem, but then I
> couldn't find details about how to use sepolgen-ifgen.

You just run it when updating the policy headers (from
selinux-policy-devel) and it regenerates the interface info
in /var/lib/sepolgen.  That info is then used by audit2allow (if passed
-R) to try to match the audit messages against the interfaces so that it
can generate calls to interfaces rather than just raw allow rules.


-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
