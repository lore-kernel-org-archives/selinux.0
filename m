Subject: Re: matchpathcon regcomp return code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Johan Fischer <jfischer@cmcrc.com>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov
In-Reply-To: <1128620330.22129.76.camel@sgc.columbia.tresys.com>
References: <43436F35.4040204@cmcrc.com>
	 <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
	 <1128522566.22129.20.camel@sgc.columbia.tresys.com>
	 <1128522897.24059.152.camel@moss-spartans.epoch.ncsc.mil>
	 <1128620330.22129.76.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 14:42:24 -0400
Message-Id: <1128624144.15836.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-06 at 13:38 -0400, Christopher J. PeBenito wrote:
> We haven't added any precedence/order specifiers in the file contexts,
> since, the previous problem I mentioned was fixed by adding another more
> specific regex.  If we do want to add the optional specifiers, the
> question becomes how we want to use it for comparison?  Should it be
> used as the last comparison, like a tie-breaker, or as the first
> comparison, which would group regexes of the same priority?  Also, what
> happens if one regex has a precedence and the other doesn't?

Ok, let's defer that change until later and just focus on merging your
existing sort algorithm into matchpathcon_init.  BTW, is your sort
stable?  That was a problem we used to have when using qsort there; the
ordering of "equal" members in the array was not stable.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
