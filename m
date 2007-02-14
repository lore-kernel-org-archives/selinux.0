Message-ID: <45D37249.8080602@mentalrootkit.com>
Date: Wed, 14 Feb 2007 15:34:17 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: vin@netwosix.org, SELinux@tycho.nsa.gov
Subject: Re: SELinux and LFS
References: <1171474739.27788.17.camel@desk.netwosix.org>	 <1171476502.20576.35.camel@sgc.columbia.tresys.com> <1171477036.20576.37.camel@sgc.columbia.tresys.com>
In-Reply-To: <1171477036.20576.37.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2007-02-14 at 18:08 +0000, Christopher J. PeBenito wrote:
>> You need a patched init to load the policy.
> 
> To be clearer, init does the initial policy load when the system boots.
> It doesn't load the policy at any other time.
> 

It is also possible to do the policy load from an initial ramdisk. The 
key is that init needs to somehow end up with the correct context.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
