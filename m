From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>, <SELinux@tycho.nsa.gov>
Subject: RE: definition of domain transition permission
Date: Tue, 4 Mar 2003 09:56:46 -0500
Message-ID: <000701c2e25e$4a2950a0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200303041447.JAA18952@moss-shockers.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Hence, if
> you want a graph of possible domain transitions, you need to look at
> the allow rules that grant process transition permission (plus the
> other allow rules that you listed if you also want to capture
> information about the entrypoint program).  

One point of clarification, isn't it the case that process transition,
program execute, and program entry as I list are all necessary and
required for a domain transition to occur.  For example, process
transition permission between two domains is never sufficient but always
required, correct?

Frank




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
