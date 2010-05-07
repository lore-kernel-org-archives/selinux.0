Subject: Re: Broken pipe Error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: waqar afridi <afridi.waqar@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <y2n78aaeffc1005052324g38e6173pc71674e3a523e670@mail.gmail.com>
References: <y2n78aaeffc1005052324g38e6173pc71674e3a523e670@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 07 May 2010 09:43:33 -0400
Message-Id: <1273239813.20596.9.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-05-06 at 11:24 +0500, waqar afridi wrote:
> Hello All
> 
> I am trying to Cross compile checkmodules for arm architecture but
> whenever I do, I get the Following Error
> 
> #make checkmodule
> 
> bison -y -d policy_parse.y
> make: *** [y.tab.c] Broken pipe
>  
> btw I have also tried yacc but results were the Same, Any Idea?
> 
> Thanx in Advance...

Do you have GNU m4 installed?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
