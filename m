Message-ID: <3F9DBDFA.908@diyab.net>
Date: Mon, 27 Oct 2003 19:53:14 -0500
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: lky <lky77@sjtu.edu.cn>, SELINUX <SELinux@tycho.nsa.gov>
Subject: Re: question about su and passwd
References: <001401c39a74$ac06b370$5d38a8c0@lky>	 <3F9AFDB0.1020406@diyab.net> <1067268199.18818.59.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1067268199.18818.59.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> On Sat, 2003-10-25 at 18:48, Diyab wrote:
> 
>>passwd, like most of the other user management tools, requires a
>>selinux specific version called spasswd.  There are some file labeling
>>issues which the normal passwd program can not handle and that is why
>>the modified version was made.  If you search the list archives you can
>>find out more information about that.
> 
> 
> The spasswd wrappers were replaced with direct patches to the base
> programs by Dan Walsh when the code was ported to the new SELinux API.
> This allows the files to be directly created in the right context and
> eliminates the window where the passwd file is in a more restrictive
> context than necessary.
> 

Ah, my apoligies.  I have not had the opportunity to upgrade to the 
newer releases yet and I was not aware of the change.  Thanks for 
pointing this out Stephen.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
