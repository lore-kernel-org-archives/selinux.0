Message-ID: <3F9AFDB0.1020406@diyab.net>
Date: Sat, 25 Oct 2003 18:48:16 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: lky <lky77@sjtu.edu.cn>
CC: SELINUX <SELinux@tycho.nsa.gov>
Subject: Re: question about su and passwd
References: <001401c39a74$ac06b370$5d38a8c0@lky>
In-Reply-To: <001401c39a74$ac06b370$5d38a8c0@lky>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

lky wrote:

> Hi, When I change the account with su I found the security context 
> didn't change( the 2 account have different contexts ). Should I use 
> aother command?
> Another problem is I couldn't change my passwd under enforced mode.When 
> I login as root and run "passwd" it said I coundn't do that while when I 
> login as another general user and run "passwd" it let me input my Unix 
> passwd but always fail. Who can tell me the reason? I have installed 
> 2.6-based SELinux and the patched utilities on redhat9.0.
> Thanks!

Su will only change your user id not your context.  To change your
context you have to use newrole and it's best to do that before running
su.  passwd, like most of the other user management tools, requires a
selinux specific version called spasswd.  There are some file labeling
issues which the normal passwd program can not handle and that is why
the modified version was made.  If you search the list archives you can
find out more information about that.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
