Message-ID: <4051FB0A.8060909@tresys.com>
Date: Fri, 12 Mar 2004 13:01:46 -0500
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: Chad Hanson <chanson@tcs-sec.com>
CC: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Re: Process Transition
References: <791924EBDA572C4FA970D4A94AA95DA3115410@chaos.tcs.tcs-sec.com>
In-Reply-To: <791924EBDA572C4FA970D4A94AA95DA3115410@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luckily it doesn't have any effect on the computation of the access 
vector.  If the transition permission bit was _not_ set (and some other 
permission was set to make avd->allowed evaluate to non zero, i.e. the 
bug case), and the other conditions were true, the net effect is no 
different than if the code were correct.  A little extra code is run, 
but no access is granted or illegal transition permitted.

Nice find!  (It's also present in checkpolicy's version of services.c, 
where it also has no net effect).

Chad Hanson wrote:
> We found a piece of process transition code that should be updated to work
> as expected.
> 
> In ss/services.c context_struct_compute_av() the following should be
> changed:
> 
> 	if (tclass == SECCLASS_PROCESS &&
> bug >>	    avd->allowed && PROCESS__TRANSITION &&
> 	    scontext->role != tcontext->role) {
> 		for (ra = policydb.role_allow; ra; ra = ra->next) {
> 			if (scontext->role == ra->role &&
> 			    tcontext->role == ra->new_role)
> 				break;
> 		}
> 		if (!ra)
> 			avd->allowed = (avd->allowed) &
> ~(PROCESS__TRANSITION);
> 	}
> 
> it should be
> 
> 	if (tclass == SECCLASS_PROCESS &&
> 	    avd->allowed & PROCESS__TRANSITION &&
> 	    scontext->role != tcontext->role) {
> 
> -Chad
> _______________________________________________________________
> Chad Hanson				mailto:chanson@tcs-sec.com
> Trusted Computer Solutions		Phone: 217-384-0028 x12
> 121 W Goose Alley			Fax: 217-384-0288
> Urbana IL 61801
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
