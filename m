Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76EcNrT012486
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 10:38:23 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76Ebgpu003601
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 14:37:48 GMT
Message-ID: <411397C9.2010606@redhat.com>
Date: Fri, 06 Aug 2004 10:38:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
   Russell Coker <russell@coker.com.au>, selinux-dev@tresys.com
Subject: Re: Now that SELinux supports booleans should we replace tunables
 with booleans?
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>	 <1091800968.8590.39.camel@moss-spartans.epoch.ncsc.mil>	 <411393AB.6020305@tresys.com> <1091802482.8590.62.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1091802482.8590.62.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2004-08-06 at 10:20, Joshua Brindle wrote:
>  
>
>>If they are going to be changed they should probably also be changed to 
>>match the get/set convention used by most other selinux apps.
>>    
>>
>
>I can see renaming change_bool to setsebool or something similar, and
>adding a new getsebool <boolean> that just displays the value of the
>specified boolean.  show_bools is a little different in that it shows
>all booleans and their values, so possibly listsebools.  toggle_sebool
>has no equivalent.
>  
>

show_bools should be getseboo -a.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
