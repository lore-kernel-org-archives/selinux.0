Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA29679
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 14:56:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0SJuQI06841
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 19:56:26 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h0SJuPf06835 for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 19:56:25 GMT
Message-Id: <200301282003.PAA01279@moss-shockers.ncsc.mil>
Date: Tue, 28 Jan 2003 15:03:50 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Performance Metrics
To: selinux@tycho.nsa.gov, jtusson@spawar.navy.mil
Cc: wsalamon@tislabs.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Does anyone know if there is any performance data for SELinux?  All I could
> find is the Webstone results that were part of LSM talk at the 2002 Usenix
> Security Symposium.

If I recall correctly, those results were the worst case scenario, with
gigabit ethernet.  At 100Mbps, there was negligible difference between
SELinux and vanilla Linux for the Webstone benchmark.  Of course, that
data is rather out-of-date; I think the benchmarks were run in April 2002
and only for the 2.5-based SELinux.  

As a historical note, the 2001 Freenix paper
(http://www.nsa.gov/selinux/freenix01-abs.html) included macro and
micro benchmark results for the original SELinux kernel patch.  That
was before the transition to LSM.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
