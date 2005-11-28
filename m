Subject: Re: Swigify libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437CBA8D.8050103@redhat.com>
References: <437CBA8D.8050103@redhat.com>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 14:22:50 -0500
Message-Id: <1133205770.348.215.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok, merged as of libselinux 1.27.23.  Also added the generated files as
in the libsemanage case to avoid requiring swig for building, IIUC.

I am a little concerned about the consistency issue, as noted by Joshua.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
