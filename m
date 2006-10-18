Message-ID: <45360C37.6020308@tresys.com>
Date: Wed, 18 Oct 2006 07:12:55 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: I_am alone <stupid_kid_me@yahoo.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: SID/Context Mapping
References: <20061018011433.21838.qmail@web58114.mail.re3.yahoo.com>
In-Reply-To: <20061018011433.21838.qmail@web58114.mail.re3.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I_am alone wrote:
>
>
> Hi All,
>
>         I am new to the SELinux Enviorment. Just learning by doing a 
> Code Review.
>
> 1. What i cant figure out is Where does the SID/Security Context 
> Mapping Occur in the SELinux Source Code . I understand its in the 
> security server (According to Flask Architecture doc)......Hows does 
> it happen. (Examlpes of code part would help).... Is it dynamic 
> everytime the System Restarts ? Or is it Assigned when policy is 
> compiled .. (Compiled Object File contains SID-Context Mapped 
> Data.)........(Bec i put sme print statements to see how does the SID 
> Transition occurs at BPRM Loading ....seems like i get the same SID 4 
> same processes even i reboot the system .... )
>
>
Several sids are always going to be the same because the policy defines 
them in a specific order, they are called initial sids, you can look for 
them in the policy source. After the initial sids all sids are generated 
at runtime. In the kernel security/selinux/ss/sidtab.c is where the sids 
are initialized and managed. You'll note that the security server calls 
sidtab_context_to_sid, this searches for the sid associated with the 
context, if it is not present it will insert it into the sidtab.

You can also look at the security server code in libsepol which is 
largely the same as the kernel security server (in terms of 
functionality) but is easier to play with and learn from.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
