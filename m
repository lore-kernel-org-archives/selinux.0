Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA09271
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2001 10:22:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA28070
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2001 14:22:47 GMT
Received: from e1.ny.us.ibm.com ([32.97.182.101])
	by jazzband.ncsc.mil  with ESMTP id OAA28066
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2001 14:22:47 GMT
Received: from northrelay02.pok.ibm.com (northrelay02.pok.ibm.com [9.117.200.22])
	by e1.ny.us.ibm.com (8.9.3/8.9.3) with ESMTP id KAA155774
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2001 10:20:54 -0400
Received: from d01ml233.pok.ibm.com (d01ml233.pok.ibm.com [9.117.200.63])
	by northrelay02.pok.ibm.com (8.8.8m3/NCO v4.96) with ESMTP id KAA171766
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2001 10:17:02 -0400
Subject: Re: policy
To: selinux@tycho.nsa.gov
Message-ID: <OF91F9E67A.CC87EF75-ON85256A5E.0049C6D1@pok.ibm.com>
From: "Rajan Ravindran" <rajancr@us.ibm.com>
Date: Fri, 1 Jun 2001 10:22:30 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,
While I do relabel my file system, I'm getting some errors as

invalid context system_u:object_r:sysadm_netscape_rw_ti on line number 65

similar errors (by appending 'i' at the end of type field in the context)
at different line numbers.

some days before Hugo F.Martinez claimed the same kind of error, for that
Jon
Crowley replied as it could be a simple typo error. I verified with the
file_contexts in the specified line numbers, I don't see any 'i' at the
end.

Any idea what could be the problem.

Thanks,
Rajan.


Did you modify file_contexts?  It appears that is simply a typo... try
changing that line in file_contexts to the following, note the lack of
"i" on the end:

system_u:object_r:cron_log_t

Jon Crowley




"Hugo F. Martinez" wrote:
>
> Hi:
> Im  trying to relabel my file system but im getting this kind of errors
>
> ....
> ./set files: invalid context system_u:object_r:cron_log_ti on line
> number 368
> make: *** [relabel] Error 1
>
> I check the file_contexts but i cant see any clue of where the problem
>
> Thanks in advance.
>
> --
> You have received this message because you are subscribed to the selinux
list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
