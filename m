Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBDCUwIi002996
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 07:30:58 -0500 (EST)
Received: from oe-im1.bizmailsrvcs.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBDCT9Ux014030
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 12:29:12 GMT
Message-ID: <41BD8882.2030501@tresys.com>
Date: Mon, 13 Dec 2004 07:18:10 -0500
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: can_network patch.
References: <41741A2C.8040408@redhat.com> <1102698638.1628.148.camel@moss-spartans.epoch.ncsc.mil> <41B9E48A.8010204@redhat.com> <200412110511.12960.russell@coker.com.au>            <20041210191107.GA5059@jmh.mhn.de> <200412102139.iBALdhHh020525@turing-police.cc.vt.edu>
In-Reply-To: <200412102139.iBALdhHh020525@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 10 Dec 2004 20:11:07 +0100, Thomas Bleher said:
> 
> 
>>Or add a boolean to control the transition from the userdomain to
>>mozilla. Then we can have a locked down policy for people who just want
>>to securely browse the web. People who want all the bells and whistles
>>can turn the transition off at the cost of higher exposure.
> 
> 
> I could live with that.  However, before long we're in danger of getting lost
> in a maze of tiny little twisty booleans, all different... :)
> 

That is a good reason why the use of booleans and addition of 
conditional policy blocks needs to be considered very carefully. 
Another important reason is that even though a chunk of policy may be 
controlled by a conditional expression, from a pure policy analysis 
point of view, it must be considered that the conditional permissions 
are allowed (i.e., if the rule(s) are in the policy then it is 
_possible_ that they may be enabled).  In a perfect world, if the 
permissions are always going to be disabled for a particular instance 
then they shouldn't be in the policy at all.

That said, this issue was discussed before on the list 
(http://tinyurl.com/596gq) and there are practical accepted reasons for 
using booleans/conditionals as tunable mechanisms in some cases.  I 
would just echo your caution that we don't want to get "lost in a maze 
of tiny little twisty booleans".

David

-- 
__________________________________

David Caplan
dac@tresys.com
Tresys Technology, LLC

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
