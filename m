Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07646
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 10:52:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA19324
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 15:50:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id PAA19320 for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 15:50:49 GMT
Received: from moss-shockers.ncsc.mil (moss-shockers [144.51.25.21])
	by epoch.ncsc.mil (8.9.3/8.9.3) with SMTP id KAA04469
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 10:52:50 -0500 (EST)
Message-Id: <200212031600.LAA26035@moss-shockers.ncsc.mil>
Date: Tue, 3 Dec 2002 11:00:14 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: get_ordered_sid_list
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>   num_sids = get_ordered_sid_list (login, 0, sidlist, &sidlistlen);
> 
> 
> the call returns 1 and the sid is
> 505   root:user_r:user_t
> 
> actual sids
> 504   root:sysadm_r:sysadm_t
> 505   root:user_r:user_t
> 
> Am I missing something obvious ?

get_ordered_sid_list only returns legal SIDs for the user that
are reachable from the specified from_sid (or the current SID
by default when from_sid is 0).  In the example policy, xdm_t
can only transition to unpriv_userdomain, so it can reach user_t
but not sysadm_t.

Note that there is a test program in libsecure (libsecure/test/get_user_sids)
that you can use to exercise these functions with a particular from SID
and username, e.g. 'get_user_sids system_u:system_r:xdm_t root' displays 
root:user_r:user_t.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
