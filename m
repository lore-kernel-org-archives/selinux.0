Message-ID: <791924EBDA572C4FA970D4A94AA95DA3115410@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@tcs-sec.com>
To: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   "SE Linux (E-mail)"
	 <SELinux@tycho.nsa.gov>
Subject: Process Transition
Date: Thu, 11 Mar 2004 15:49:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


We found a piece of process transition code that should be updated to work
as expected.

In ss/services.c context_struct_compute_av() the following should be
changed:

	if (tclass == SECCLASS_PROCESS &&
bug >>	    avd->allowed && PROCESS__TRANSITION &&
	    scontext->role != tcontext->role) {
		for (ra = policydb.role_allow; ra; ra = ra->next) {
			if (scontext->role == ra->role &&
			    tcontext->role == ra->new_role)
				break;
		}
		if (!ra)
			avd->allowed = (avd->allowed) &
~(PROCESS__TRANSITION);
	}

it should be

	if (tclass == SECCLASS_PROCESS &&
	    avd->allowed & PROCESS__TRANSITION &&
	    scontext->role != tcontext->role) {

-Chad
_______________________________________________________________
Chad Hanson				mailto:chanson@tcs-sec.com
Trusted Computer Solutions		Phone: 217-384-0028 x12
121 W Goose Alley			Fax: 217-384-0288
Urbana IL 61801



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
