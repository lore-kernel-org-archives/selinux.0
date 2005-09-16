Date: Fri, 16 Sep 2005 14:55:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
Message-ID: <20050916135547.GD9092@lkcl.net>
References: <4327521D.5020605@cornell.edu> <1126652637.30915.18.camel@twoface.columbia.tresys.com> <432799F0.7060706@cornell.edu> <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil> <432823F0.3030803@tresys.com> <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil> <43283772.7070603@tresys.com> <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil> <432842D4.3070905@tresys.com> <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 14, 2005 at 11:38:45AM -0400, Stephen Smalley wrote:
> On Wed, 2005-09-14 at 11:33 -0400, Joshua Brindle wrote:
> > Omitting it isn't my concern if it is really for debugging, I do not 
> > think that we should try to use the debug system for error reporting to 
> > the originating function if it is going to be a debug system.
> 
> I was thinking that unifying them would be ideal, and the callbacks can
> decide how they want to filter the results.  Just requires that the
> callbacks be provided with a level indicator in addition to the other
> arguments that indicates whether it is debug info only or error info.
> Not unlike syslog(3) or printk(9).
 
 okay.

 exactly how much complexity are we getting into, here, because if it's
 getting ... "large" then i would strongly recommend looking at the
 debugging infrastructure utilised in FreeDCE (actually DCE 1.1) and
 samba:

 #define RPC_DBG_FUNCTIONALITY_AREA_1 1
 #define RPC_DBG_FUNCTIONALITY_AREA_2 2
 #define RPC_DBG_MEMORY_DEBUGGING_FOR_LIBSEPOL 3
 #define RPC_DBG_WEIRD_STUFF_A 4
 #define RPC_DBG_MAX 4

 #define CRITICALL_LEVEL 0
 #define INFORMATIONAL_LEVEL 10

 RPC_DBG_PRINTF(RPC_DBG_MEMORY_DEBUGGING_FOR_LIBSEPOL,
			 INFORMATIONAL_LEVEL,
              ("theactualdebugprintfstuff %s\n", error_msg));


 then you have an array of debug levels:

 static rpc_g_dbg_levels[RPC_DBG_MAX]

 and when you start an application, you start it with an argument
 as follows:

 --debug "0-1=0,3=10"

 then the RPC_DBG_PRINTF uses its two arguments to check the array of
 debug levels to find out if you should print out the message.


 the reason why DCE/RPC and samba utilise this type of debugging system
 is... well... FreeDCE has about SIXTY separate #defines for different
 debugging purposes.

 if all of that information was splattered across your console, it'd be
 utterly useless.

 so the above cuts out the crap you don't want.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
