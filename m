Subject: Re: Proposed patch for libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <41791827.6050709@redhat.com>
References: <41782BBA.9090101@redhat.com>
	 <1098451420.7614.43.camel@moss-spartans.epoch.ncsc.mil>
	 <41790F02.8070207@redhat.com>
	 <1098454526.7614.97.camel@moss-spartans.epoch.ncsc.mil>
	 <41791827.6050709@redhat.com>
Content-Type: text/plain
Message-Id: <1098455400.7614.112.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 22 Oct 2004 10:30:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-22 at 10:24, Daniel J Walsh wrote:
> That seems like a good idea.  But are are these different flags going to 
> require different Access Controls?

We won't know until someone comes up with a second flag ;)
I suppose we would start with a single permission for setting the flags
at all, and then split it if necessary later.  Of course, this takes us
back to the endianness issue; you'll want to convert to a standard
endianness for storage of the flags and convert back upon reading; see
the libsepol code for reading and writing binary policies and note the
use of cpu_to_le32 and le32_to_cpu (defined in src/private.h).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
