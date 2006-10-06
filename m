Message-ID: <452674C8.2040105@us.ibm.com>
Date: Fri, 06 Oct 2006 10:22:48 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Steve Grubb <sgrubb@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
Subject: Re: [RFC PATCH] newrole suid breakdown
References: <452432FA.1060009@us.ibm.com>	 <1160079125.2132.232.camel@moss-spartans.epoch.ncsc.mil>	 <45256F49.1070105@us.ibm.com>  <200610051748.06669.sgrubb@redhat.com> <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On the question of checking whether an app is suid, I don't see any way
> to do that in Linux unambiguously, since there is always the case where
> the caller was already in the same uid as the file.

Apparently, there is a way to check. Klaus showed me this yesterday, but 
he pointed out that it might not be accurate due to SELinux transitions. 
I have tried this, it doesn't seem like the context of the executable 
(for transitions) affects this value.

#include <stdio.h>

extern int __libc_enable_secure;

int main() {
	printf("%d\n", __libc_enable_secure);
}

If someone can also confirm this behavior, this could be the solution 
we're looking for. Not sure how acceptable it is though, as it is kinda 
hackish.

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
