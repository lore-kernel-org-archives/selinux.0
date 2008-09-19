Message-ID: <48D3A6F0.9020506@manicmethod.com>
Date: Fri, 19 Sep 2008 09:19:44 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: apol and linking
References: <200809192115.37850.russell@coker.com.au> <1221825516.25857.5.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1221825516.25857.5.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-09-19 at 21:15 +1000, Russell Coker wrote:
>> I have a policy problem that only seems to occur in a particular modular 
>> configuration.  It ends up with attribute A being allowed access to attribute 
>> B which grants something I don't desire.
>>
>> How can I determine what the attribute names are with apol?  When I use the 
>> policy.23 file the relevant data is gone.  Can I give it a base.pp and a set 
>> of modules and have it do the link itself?  If so how?
> 
> apol /etc/selinux/targeted/modules/active/base.pp /etc/selinux/targeted/modules/active/modules/*.pp
> 
> works for me.
> 

Or in the gui when you load a policy there are monolithic and modular options, modular lets you specify a base and a set of modules.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
