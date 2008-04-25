Subject: Re: sepolgen-ifgen
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kim Lawson-Jenkins <lawson@itd.nrl.navy.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <001f01c8a6f8$f42a9230$c301000a@PC05>
References: <001f01c8a6f8$f42a9230$c301000a@PC05>
Content-Type: text/plain; charset=utf-8
Date: Fri, 25 Apr 2008 13:48:37 -0400
Message-Id: <1209145717.26761.169.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-04-25 at 12:22 -0500, Kim Lawson-Jenkins wrote:
> Hi,
> 
>  
> 
> Can someone point me to some text on the Web that explains
> sepolgen-ifgen?  When running audit2allow I received an error “could
> not open interface info” and I found a post stating that using
> sepolgen-ifgen might help solve this particular problem, but then I
> couldn’t find details about how to use sepolgen-ifgen.

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
