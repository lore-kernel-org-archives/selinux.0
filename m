Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76Ef0rT012511
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 10:41:00 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76EeJpu003796
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 14:40:25 GMT
Message-ID: <41139870.9090203@redhat.com>
Date: Fri, 06 Aug 2004 10:40:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   selinux-dev@tresys.com
Subject: Re: Now that SELinux supports booleans should we replace tunables
 with booleans?
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil> <1091802227.8590.58.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1091802227.8590.58.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2004-08-02 at 14:53, Stephen Smalley wrote:
>  
>
>>Of the remaining base tunables from tunable.tun, I believe that either
>>they are not amenable to the use of policy booleans (i.e. affect type
>>declarations or role-based statements) or they would activate many
>>additional rules when enabled and it would thus bloat the policy to make
>>them runtime conditionals.  However, I'm open to reconsidering some of
>>the latter cases, and even to re-thinking how we approach some of the
>>former cases to allow us to leverage booleans to some degree.
>>    
>>
>
>BTW, I was hoping for a bit more discussion about which tunables should
>remain as compile-time tunables, and which ones should be runtime
>booleans.  I've converted about half of the base tunables and all of the
>named and apache tunables to booleans.  There are still at least some
>tunables that I can envision admins wanting to be able to change as
>booleans, but would require further reworking of the policy to split out
>the parts that cannot be made conditional, and there may be some
>booleans I've created that would be better to keep as static tunables. 
>Comments are welcome.
>
>  
>
I have not studied the booleans that closely.  But I it seems to me that 
booleans are something
that Admins would like to work with, versus tunables being something 
that distributions are going
to make decisions on.  Of course it is not that clean.  The  best thing 
about booleans is that the source
code is not required.

I think there are several tunables that can be removed.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
