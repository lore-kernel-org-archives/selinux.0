Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r08DLCqx016529
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2013 08:21:12 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r08DL2Ur001063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2013 08:21:09 -0500
Received: from [10.34.4.104] (unused-4-104.brq.redhat.com [10.34.4.104])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r08DKolh026989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2013 08:21:01 -0500
Message-ID: <50EC1D32.3090607@redhat.com>
Date: Tue, 08 Jan 2013 14:20:50 +0100
From: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: setfscreatecon optimizations
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, there have been some attempts on the coreutils mailing list at 
optimizing cp copying by caching the selinux security context ( please 
see: http://lists.gnu.org/archive/html/coreutils/2013-01/msg00012.html ).
Would it be possible to perform some kind of caching inside 
setfscreatecon? For example not going through the whole process of 
setfscreatecon if the context to be set equals the current one?
Thanks,
Ondrej

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
